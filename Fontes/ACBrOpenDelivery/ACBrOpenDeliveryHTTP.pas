unit ACBrOpenDeliveryHTTP;

interface

uses
  ACBrJSON,
  ACBrOpenDeliverySchemaClasses,
  Classes,
  SysUtils;

type
  TACBrRestMethodType = (mtGet, mtPost, mtPut, mtDelete, mtPatch);
  TACBrOpenDeliveryHTTPResponse = class;

  EACBrOpenDeliveryHTTPException = class;

  TACBrOpenDeliveryHTTPRequest = class
  protected
    FRequestId: string;
    FQuery: TStrings;
    FFormUrlEncoded: TStrings;
    FHeaders: TStrings;
    FUsername: string;
    FPassword: string;
    FToken: string;
    FMethodType: TACBrRestMethodType;
    FTimeOut: Integer;
    FAccept: string;
    FContentType: string;
    FBaseURL: string;
    FResource: string;
    FBody: string;

  public
    function POST: TACBrOpenDeliveryHTTPRequest;
    function PUT: TACBrOpenDeliveryHTTPRequest;
    function GET: TACBrOpenDeliveryHTTPRequest;
    function DELETE: TACBrOpenDeliveryHTTPRequest;
    function PATCH: TACBrOpenDeliveryHTTPRequest;

    function BaseURL(const AValue: string) : TACBrOpenDeliveryHTTPRequest;
    function Resource(const AValue: string) : TACBrOpenDeliveryHTTPRequest;
    function TimeOut(const AValue: Integer): TACBrOpenDeliveryHTTPRequest;

    function ContentType(const AValue: string): TACBrOpenDeliveryHTTPRequest;
    function BasicAuth(AUsername, APassword: string): TACBrOpenDeliveryHTTPRequest;
    function Token(const AValue: string): TACBrOpenDeliveryHTTPRequest;

    function AddOrSetHeader(const AName, AValue: string): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetHeader(const AName: string; const AValue: Integer): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetHeader(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetQuery(const AName, AValue: string): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetQuery(const AName: string; const AValue: Integer): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetQuery(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetUrlEncoded(const AName, AValue: string): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetUrlEncoded(const AName: string; const AValue: Integer): TACBrOpenDeliveryHTTPRequest; overload;
    function AddOrSetUrlEncoded(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest; overload;

    function Body(const AValue: TACBrJSON; AOwner: Boolean = True): TACBrOpenDeliveryHTTPRequest; overload;
    function Body(const AValue: string): TACBrOpenDeliveryHTTPRequest; overload;

    function Send: TACBrOpenDeliveryHTTPResponse; virtual; abstract;
    procedure Clear; virtual;

    constructor Create(const ARequestId: string = ''); virtual;
    destructor Destroy; override;
    class function New(const ARequestId: string = ''): TACBrOpenDeliveryHTTPRequest;
  end;

  TACBrOpenDeliveryHTTPResponse = class
  protected
    FStatusCode: Integer;
    FStatusText: string;
    FBodyText: string;
    FJSONObject: TACBrJSONObject;
    FJSONArray: TACBrJSONArray;
    FHeaders: TStrings;

  public
    function StatusCode: Integer;
    function StatusText: string;
    function GetContent: string;
    function GetJSONObject: TACBrJSONObject;
    function GetJSONArray: TACBrJSONArray;

    function HeaderAsString(AName: String): string;
    function HeaderAsInteger(AName: String): Integer;
    function HeaderAsFloat(AName: String): Double;

    destructor Destroy; override;
  end;

  EACBrOpenDeliveryHTTPException = class(Exception)
  private
    FError: TACBrOpenDeliverySchemaError;
    function GetStatus: Integer;
    function GetTitle: string;

  public
    property Status: Integer read GetStatus;
    property Title: string read GetTitle;

    constructor Create(const AStatus: Integer; const AMessage: string); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ EACBrOpenDeliveryHTTPException }

uses
  ACBrOpenDeliveryHTTPSynapse;

constructor EACBrOpenDeliveryHTTPException.Create(const AStatus: Integer; const AMessage: string);
begin
  inherited Create(AMessage);
  FError := TACBrOpenDeliverySchemaError.Create;
  FError.Status := AStatus;
  FError.Title := AMessage;
end;

destructor EACBrOpenDeliveryHTTPException.Destroy;
begin
  FError.Free;
  inherited;
end;

function EACBrOpenDeliveryHTTPException.GetStatus: Integer;
begin
  Result := FError.Status;
end;

function EACBrOpenDeliveryHTTPException.GetTitle: string;
begin
  Result := FError.Title;
end;

{ TACBrOpenDeliveryHTTPRequest }

function TACBrOpenDeliveryHTTPRequest.AddOrSetHeader(const AName, AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FHeaders.Values[AName] := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetHeader(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  AddOrSetHeader(AName, FloatToStr(AValue));
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetHeader(const AName: string; const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  AddOrSetHeader(AName, IntToStr(AValue));
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetQuery(const AName: string; const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  AddOrSetQuery(AName, IntToStr(AValue));
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetQuery(const AName, AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FQuery.Values[AName] := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetQuery(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  AddOrSetQuery(AName, FloatToStr(AValue));
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetUrlEncoded(const AName, AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FFormUrlEncoded.Values[AName] := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetUrlEncoded(const AName: string; const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  AddOrSetUrlEncoded(AName, IntToStr(AValue));
end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetUrlEncoded(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  AddOrSetUrlEncoded(AName, FloatToStr(AValue));
end;

function TACBrOpenDeliveryHTTPRequest.BaseURL(const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FBaseURL := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.BasicAuth(AUsername, APassword: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FUsername := AUsername;
  FPassword := APassword;
end;

function TACBrOpenDeliveryHTTPRequest.Body(const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FBody := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.Body(const AValue: TACBrJSON; AOwner: Boolean): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FBody := AValue.ToJSON;
  if AOwner then
    FreeAndNil(AValue);
end;

procedure TACBrOpenDeliveryHTTPRequest.Clear;
begin
  FHeaders.Clear;
  FQuery.Clear;
  FBody := EmptyStr;
  FFormUrlEncoded.Clear;
end;

function TACBrOpenDeliveryHTTPRequest.ContentType(const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FContentType := AValue;
end;

constructor TACBrOpenDeliveryHTTPRequest.Create(const ARequestId: string);
begin
  FRequestId := ARequestId;
  FQuery := TStringList.Create;
  FFormUrlEncoded := TStringList.Create;
  FHeaders := TStringList.Create;
  FMethodType := mtGet;
  FTimeOut := 60000;
  FContentType := 'application/json';
  FAccept := 'application/json';
end;

function TACBrOpenDeliveryHTTPRequest.DELETE: TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FMethodType := mtDelete;
end;

destructor TACBrOpenDeliveryHTTPRequest.Destroy;
begin
  FQuery.Free;
  FHeaders.Free;
  FFormUrlEncoded.Free;
  inherited;
end;

function TACBrOpenDeliveryHTTPRequest.GET: TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FMethodType := mtGet;
end;

class function TACBrOpenDeliveryHTTPRequest.New(const ARequestId: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := TACBrOpenDeliveryHTTPRequestSynapse.New(ARequestId);
end;

function TACBrOpenDeliveryHTTPRequest.PATCH: TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FMethodType := mtPatch;
end;

function TACBrOpenDeliveryHTTPRequest.POST: TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FMethodType := mtPost;
end;

function TACBrOpenDeliveryHTTPRequest.PUT: TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FMethodType := mtPut;
end;

function TACBrOpenDeliveryHTTPRequest.Resource(const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FResource := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.TimeOut(const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FTimeOut := AValue;
end;

function TACBrOpenDeliveryHTTPRequest.Token(const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin
  Result := Self;
  FToken := AValue;
end;

{ TACBrOpenDeliveryHTTPResponse }

destructor TACBrOpenDeliveryHTTPResponse.Destroy;
begin
  FreeAndNil(FJSONArray);
  FreeAndNil(FJSONObject);
  FreeAndNil(FHeaders);
  inherited;
end;

function TACBrOpenDeliveryHTTPResponse.GetContent: string;
begin
  Result := FBodyText;
end;

function TACBrOpenDeliveryHTTPResponse.GetJSONArray: TACBrJSONArray;
begin
  if not Assigned(FJSONArray) then
    FJSONArray := TACBrJSONArray.Parse(GetContent);
  Result := FJSONArray;
end;

function TACBrOpenDeliveryHTTPResponse.GetJSONObject: TACBrJSONObject;
begin
  if not Assigned(FJSONObject) then
    FJSONObject := TACBrJSONObject.Parse(GetContent);
  Result := FJSONObject;
end;

function TACBrOpenDeliveryHTTPResponse.HeaderAsFloat(AName: String): Double;
begin
  Result := StrToFloat(FHeaders.Values[AName]);
end;

function TACBrOpenDeliveryHTTPResponse.HeaderAsInteger(AName: String): Integer;
begin
  Result := StrToInt(FHeaders.Values[AName]);
end;

function TACBrOpenDeliveryHTTPResponse.HeaderAsString(AName: String): string;
begin
  Result := FHeaders.Values[AName];
end;

function TACBrOpenDeliveryHTTPResponse.StatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TACBrOpenDeliveryHTTPResponse.StatusText: string;
begin
  Result := FStatusText;
end;

end.

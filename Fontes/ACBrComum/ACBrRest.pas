unit ACBrRest;

interface

uses
  ACBrJSON,
  SysUtils,
  Classes;

type
  TACBrRestMethodType = (mtGet, mtPost, mtPut, mtDelete, mtPatch);
  TACBrRestResponse = class;

  TACBrRestRequest = class
  protected
    FRequestId: String;
    FQuery: TStrings;
    FFormUrlEncoded: TStrings;
    FHeaders: TStrings;
    FUsername: String;
    FPassword: String;
    FToken: String;
    FMethodType: TACBrRestMethodType;
    FTimeOut: Integer;
    FAccept: String;
    FContentType: string;
    FBaseURL: string;
    FResource: string;
    FBody: string;

  public
    function POST: TACBrRestRequest;
    function PUT: TACBrRestRequest;
    function GET: TACBrRestRequest;
    function DELETE: TACBrRestRequest;
    function PATCH: TACBrRestRequest;

    function BaseURL(AValue: String) : TACBrRestRequest;
    function Resource(AValue: String) : TACBrRestRequest;
    function TimeOut(AValue: Integer): TACBrRestRequest;

    function ContentType(AValue: String): TACBrRestRequest;
    function BasicAuth(AUsername, APassword: String): TACBrRestRequest;
    function Token(AValue: String): TACBrRestRequest;

    function AddOrSetHeader(AName, AValue: String): TACBrRestRequest; overload;
    function AddOrSetHeader(AName: String; AValue: Integer): TACBrRestRequest; overload;
    function AddOrSetHeader(AName: String; AValue: Double): TACBrRestRequest; overload;
    function AddOrSetQuery(AName, AValue: String): TACBrRestRequest; overload;
    function AddOrSetQuery(AName: String; AValue: Integer): TACBrRestRequest; overload;
    function AddOrSetQuery(AName: String; AValue: Double): TACBrRestRequest; overload;
    function AddOrSetUrlEncoded(AName, AValue: String): TACBrRestRequest; overload;
    function AddOrSetUrlEncoded(AName: String; AValue: Integer): TACBrRestRequest; overload;
    function AddOrSetUrlEncoded(AName: String; AValue: Double): TACBrRestRequest; overload;

    function Body(AValue: TACBrJSON; AOwner: Boolean = True ): TACBrRestRequest; overload;
    function Body(AValue: string): TACBrRestRequest; overload;

    function Send: TACBrRestResponse; virtual; abstract;
    procedure Clear; virtual;

    constructor Create(ARequestId: String = ''); virtual;
    destructor Destroy; override;
    class function New(ARequestId: String = ''): TACBrRestRequest;
  end;

  TACBrRestResponse = class
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

implementation

uses
  ACBrRestSynapse;

{ TACBrRestRequest }

function TACBrRestRequest.AddOrSetHeader(AName: String; AValue: Double): TACBrRestRequest;
begin
  Result := Self;
  AddOrSetHeader(AName, FloatToStr(AValue));
end;

function TACBrRestRequest.AddOrSetHeader(AName: String; AValue: Integer): TACBrRestRequest;
begin
  Result := Self;
  AddOrSetHeader(AName, IntToStr(AValue));
end;

function TACBrRestRequest.AddOrSetHeader(AName, AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FHeaders.Values[AName] := AValue;
end;

function TACBrRestRequest.AddOrSetQuery(AName: String; AValue: Double): TACBrRestRequest;
begin
  Result := Self;
  AddOrSetQuery(AName, FloatToStr(AValue));
end;

function TACBrRestRequest.AddOrSetQuery(AName: String; AValue: Integer): TACBrRestRequest;
begin
  Result := Self;
  AddOrSetQuery(AName, IntToStr(AValue));
end;

function TACBrRestRequest.AddOrSetQuery(AName, AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FQuery.Values[AName] := AValue;
end;

function TACBrRestRequest.AddOrSetUrlEncoded(AName, AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FFormUrlEncoded.Values[AName] := AValue;
end;

function TACBrRestRequest.AddOrSetUrlEncoded(AName: String; AValue: Integer): TACBrRestRequest;
begin
  Result := Self;
  AddOrSetUrlEncoded(AName, IntToStr(AValue));
end;

function TACBrRestRequest.AddOrSetUrlEncoded(AName: String; AValue: Double): TACBrRestRequest;
begin
  Result := Self;
  AddOrSetUrlEncoded(AName, FloatToStr(AValue));
end;

function TACBrRestRequest.BaseURL(AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FBaseURL := AValue;
end;

function TACBrRestRequest.BasicAuth(AUsername, APassword: String): TACBrRestRequest;
begin
  Result := Self;
  FUsername := AUsername;
  FPassword := APassword;
end;

function TACBrRestRequest.Body(AValue: string): TACBrRestRequest;
begin
  Result := Self;
  FBody := AValue;
end;

function TACBrRestRequest.Body(AValue: TACBrJSON; AOwner: Boolean): TACBrRestRequest;
begin
  Result := Self;
  FBody := AValue.ToJSON;
  if AOwner then
    FreeAndNil(AValue);
end;

procedure TACBrRestRequest.Clear;
begin
  FHeaders.Clear;
  FQuery.Clear;
  FBody := EmptyStr;
  FFormUrlEncoded.Clear;
end;

function TACBrRestRequest.ContentType(AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FContentType := AValue;
end;

constructor TACBrRestRequest.Create(ARequestId: String = '');
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

function TACBrRestRequest.DELETE: TACBrRestRequest;
begin
  Result := Self;
  FMethodType := mtDelete;
end;

destructor TACBrRestRequest.Destroy;
begin
  FQuery.Free;
  FHeaders.Free;
  FFormUrlEncoded.Free;
  inherited;
end;

function TACBrRestRequest.GET: TACBrRestRequest;
begin
  Result := Self;
  FMethodType := mtGet;
end;

class function TACBrRestRequest.New(ARequestId: String): TACBrRestRequest;
begin
  Result := TACBrRestRequestSynapse.Create(ARequestId);
end;

function TACBrRestRequest.PATCH: TACBrRestRequest;
begin
  Result := Self;
  FMethodType := mtPatch;
end;

function TACBrRestRequest.POST: TACBrRestRequest;
begin
  Result := Self;
  FMethodType := mtPost;
end;

function TACBrRestRequest.PUT: TACBrRestRequest;
begin
  Result := Self;
  FMethodType := mtPut;
end;

function TACBrRestRequest.Resource(AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FResource := AValue;
end;

function TACBrRestRequest.TimeOut(AValue: Integer): TACBrRestRequest;
begin
  Result := Self;
  FTimeOut := AValue;
end;

function TACBrRestRequest.Token(AValue: String): TACBrRestRequest;
begin
  Result := Self;
  FToken := AValue;
end;

{ TACBrRestResponse }

destructor TACBrRestResponse.Destroy;
begin
  FreeAndNil(FJSONArray);
  FreeAndNil(FJSONObject);
  FreeAndNil(FHeaders);
  inherited;
end;

function TACBrRestResponse.GetJSONArray: TACBrJSONArray;
begin
  if not Assigned(FJSONArray) then
    FJSONArray := TACBrJSONArray.Parse(GetContent);
  Result := FJSONArray;
end;

function TACBrRestResponse.GetJSONObject: TACBrJSONObject;
begin
  if not Assigned(FJSONObject) then
    FJSONObject := TACBrJSONObject.Parse(GetContent);
  result := FJSONObject;
end;

function TACBrRestResponse.GetContent: string;
begin
  Result := FBodyText;
end;

function TACBrRestResponse.HeaderAsFloat(AName: String): Double;
begin
  Result := StrToFloat(FHeaders.Values[AName]);
end;

function TACBrRestResponse.HeaderAsInteger(AName: String): Integer;
begin
  Result := StrToInt(FHeaders.Values[AName]);
end;

function TACBrRestResponse.HeaderAsString(AName: String): string;
begin
  Result := FHeaders.Values[AName];
end;

function TACBrRestResponse.StatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TACBrRestResponse.StatusText: string;
begin
  Result := FStatusText;
end;

end.

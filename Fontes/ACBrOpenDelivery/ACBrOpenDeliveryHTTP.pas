unit ACBrOpenDeliveryHTTP;

interface

uses
  ACBrJSON,
  ACBrOpenDeliverySchemaClasses,
  Classes,
  SysUtils;

type
  TACBrRestMethodType = (mtGet, mtPost, mtPut, mtDelete, mtPatch);
  TACBrRestResponse = class;

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

    function Send: TACBrRestResponse; virtual; abstract;
    procedure Clear; virtual;

    constructor Create(const ARequestId: string = ''); virtual;
    destructor Destroy; override;
    class function New(const ARequestId: string = ''): TACBrOpenDeliveryHTTPRequest;
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

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetHeader(const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetHeader(const AName: string;
  const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetQuery(const AName: string;
  const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetQuery(const AName,
  AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetQuery(const AName: string;
  const AValue: Double): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetUrlEncoded(const AName,
  AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetUrlEncoded(
  const AName: string;
  const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.AddOrSetUrlEncoded(
  const AName: string; const AValue: Double): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.BaseURL(
  const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.BasicAuth(AUsername,
  APassword: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.Body(
  const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.Body(const AValue: TACBrJSON;
  AOwner: Boolean): TACBrOpenDeliveryHTTPRequest;
begin

end;

procedure TACBrOpenDeliveryHTTPRequest.Clear;
begin

end;

function TACBrOpenDeliveryHTTPRequest.ContentType(
  const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

constructor TACBrOpenDeliveryHTTPRequest.Create(const ARequestId: string);
begin

end;

function TACBrOpenDeliveryHTTPRequest.DELETE: TACBrOpenDeliveryHTTPRequest;
begin

end;

destructor TACBrOpenDeliveryHTTPRequest.Destroy;
begin

  inherited;
end;

function TACBrOpenDeliveryHTTPRequest.GET: TACBrOpenDeliveryHTTPRequest;
begin

end;

class function TACBrOpenDeliveryHTTPRequest.New(
  const ARequestId: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.PATCH: TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.POST: TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.PUT: TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.Resource(
  const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.TimeOut(
  const AValue: Integer): TACBrOpenDeliveryHTTPRequest;
begin

end;

function TACBrOpenDeliveryHTTPRequest.Token(
  const AValue: string): TACBrOpenDeliveryHTTPRequest;
begin

end;

end.

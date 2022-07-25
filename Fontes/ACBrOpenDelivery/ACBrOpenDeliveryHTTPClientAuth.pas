unit ACBrOpenDeliveryHTTPClientAuth;

interface

uses
  ACBrOpenDeliveryHTTP,
  ACBrOpenDeliverySchemaClasses,
  ACBrJSON,
  SysUtils,
  Classes;

type
  TACBrOpenDeliveryHTTPClientAuth = class
  private
    FBaseUrl: string;
    FResource: string;
    FClientId: string;
    FClientSecret: string;
    FHTTP: TACBrOpenDeliveryHTTPRequest;

  public
    constructor Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
    destructor Destroy; override;

    function BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
    function Resource(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
    function ClientId(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
    function ClientSecret(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;

    function Token: TACBrOpenDeliverySchemaAccessToken;
  end;

implementation

{ TACBrOpenDeliveryHTTPClientAuth }

function TACBrOpenDeliveryHTTPClientAuth.BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
begin
  Result := Self;
  FBaseUrl := AValue;
end;

function TACBrOpenDeliveryHTTPClientAuth.ClientId(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
begin
  Result := Self;
  FClientId := AValue;
end;

function TACBrOpenDeliveryHTTPClientAuth.ClientSecret(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
begin
  Result := Self;
  FClientSecret := AValue;
end;

constructor TACBrOpenDeliveryHTTPClientAuth.Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
begin
  FHTTP := AHTTPRequest;
  FResource := 'oauth/token';
end;

destructor TACBrOpenDeliveryHTTPClientAuth.Destroy;
begin
  FHTTP.Free;
  inherited;
end;

function TACBrOpenDeliveryHTTPClientAuth.Resource(const AValue: string): TACBrOpenDeliveryHTTPClientAuth;
begin
  Result := Self;
  FResource := AValue;
end;

function TACBrOpenDeliveryHTTPClientAuth.Token: TACBrOpenDeliverySchemaAccessToken;
var
  LJSON: TACBrJSONObject;
  LIssuedAt: TDateTime;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  Result := TACBrOpenDeliverySchemaAccessToken.Create;
  try
    LIssuedAt := Now;
    FHTTP
      .POST
      .BaseURL(FBaseUrl)
      .Resource(FResource)
      .AddOrSetUrlEncoded('grant_type', 'client_credentials')
      .AddOrSetUrlEncoded('client_id', FClientId)
      .AddOrSetUrlEncoded('client_secret', FClientSecret);

    LResponse := FHTTP.Send;
    try
      LJSON := LResponse.GetJSONObject;
      Result.AsJSON := LJSON.ToJSON;
      Result.expiresAt := LIssuedAt + Result.expiresIn;
    finally
      LResponse.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

end.

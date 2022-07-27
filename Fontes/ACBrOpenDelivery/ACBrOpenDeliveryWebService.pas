unit ACBrOpenDeliveryWebService;

interface

uses
  ACBrBase,
  ACBrJSON,
  ACBrOpenDeliverySchemaClasses,
  ACBrOpenDeliveryHTTP,
  ACBrOpenDeliveryHTTPClientDetails,
  SysUtils;

type
  TACBrOpenDeliveryAuth = class;

  TACBrOpenDeliveryWebServices = class
  private
    FOwner: TACBrComponent;
    FAuth: TACBrOpenDeliveryAuth;
    function GetAuth: TACBrOpenDeliveryAuth;
  public
    constructor Create(AOwner: TACBrComponent);
    destructor Destroy; override;

    property Auth: TACBrOpenDeliveryAuth read GetAuth;
  end;

  TACBrOpenDeliveryWebService = class
  protected
    FOwner: TACBrComponent;
    FRequest: TACBrOpenDeliveryHTTPRequest;
    FResponse: TACBrOpenDeliveryHTTPResponse;

    procedure InicializarServico;
    procedure FinalizarServico;
    procedure DefinirDadosMsg; virtual;
    procedure DefinirRecurso; virtual;
    procedure SalvarEnvio;
    procedure EnviarDados;
    function TratarResposta: Boolean; virtual;
    procedure SalvarResposta;
  public
    constructor Create(AOwner: TACBrComponent);
    destructor Destroy; override;

    function Executar: Boolean;
    procedure Clear; virtual;
  end;

  TACBrOpenDeliveryAuth = class(TACBrOpenDeliveryWebService)
  private
    FAccessToken: TACBrOpenDeliverySchemaAccessToken;
    FIssuedAt: TDateTime;
    function GetAccessToken: TACBrOpenDeliverySchemaAccessToken;
  protected
    procedure DefinirDadosMsg; override;
    procedure DefinirRecurso; override;
    function TratarResposta: Boolean; override;

  public
    destructor Destroy; override;
    property AccessToken: TACBrOpenDeliverySchemaAccessToken read GetAccessToken;
  end;

  TACBrOpenDeliveryDetails = class(TACBrOpenDeliveryWebService)
  private
    FOrder: TACBrOpenDeliverySchemaOrder;

    function GetOrder: TACBrOpenDeliverySchemaOrder;
  protected
    procedure DefinirRecurso; override;
    function TratarResposta: Boolean; override;
  public

    property Order: TACBrOpenDeliverySchemaOrder read GetOrder;
  end;

implementation

uses
  ACBrOpenDelivery;

function GetACBrOpenDelivery(AACBrComponent: TACBrComponent): TACBrOpenDelivery;
begin
  Result := TACBrOpenDelivery(AACBrComponent);
end;

function GetToken(AACBrComponent: TACBrComponent): string;
begin
  Result := GetACBrOpenDelivery(AACBrComponent).GetToken;
end;

{ TACBrOpenDeliveryDetails }

procedure TACBrOpenDeliveryDetails.DefinirRecurso;
var
  LResource: string;
begin
  LResource := Format('v1/orders/%s', [Order.id]);
  FRequest.Resource(LResource);
end;

function TACBrOpenDeliveryDetails.GetOrder: TACBrOpenDeliverySchemaOrder;
begin
  if not Assigned(FOrder) then
    FOrder := TACBrOpenDeliverySchemaOrder.Create;
  Result := FOrder;
end;

function TACBrOpenDeliveryDetails.TratarResposta: Boolean;
var
  LJSON: TACBrJSONObject;
begin
  LJSON := FResponse.GetJSONObject;
  Order.Clear;
  Order.AsJSON := LJSON.ToJSON;
  Result := True;
end;

{ TACBrOpenDeliveryWebService }

procedure TACBrOpenDeliveryWebService.Clear;
begin

end;

constructor TACBrOpenDeliveryWebService.Create(AOwner: TACBrComponent);
begin
  FOwner := AOwner;
end;

procedure TACBrOpenDeliveryWebService.DefinirDadosMsg;
begin
end;

procedure TACBrOpenDeliveryWebService.DefinirRecurso;
begin

end;

destructor TACBrOpenDeliveryWebService.Destroy;
begin
  FreeAndNil(FRequest);
  FreeAndNil(FResponse);
  inherited;
end;

function TACBrOpenDeliveryWebService.Executar: Boolean;
begin
  InicializarServico;
  try
    DefinirRecurso;
    DefinirDadosMsg;
    SalvarEnvio;
    try
      EnviarDados;
      try
        Result := TratarResposta;
      finally
        SalvarResposta;
      end;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  finally
    FinalizarServico;
  end;
end;

procedure TACBrOpenDeliveryWebService.EnviarDados;
begin
  FreeAndNil(FResponse);
  FResponse := FRequest.Send;
end;

procedure TACBrOpenDeliveryWebService.FinalizarServico;
begin
end;

procedure TACBrOpenDeliveryWebService.InicializarServico;
var
  LComponent: TACBrOpenDelivery;
begin
  LComponent := GetACBrOpenDelivery(FOwner);
  if not Assigned(FRequest) then
    FRequest := TACBrOpenDeliveryHTTPRequest.Create;
  FRequest
    .BaseURL(LComponent.BaseUrl)
    .TimeOut(LComponent.TimeOut)
    .ProxyHost(LComponent.Proxy.Host)
    .ProxyPort(LComponent.Proxy.Port)
    .ProxyUser(LComponent.Proxy.User)
    .ProxyPass(LComponent.Proxy.Pass)
    .Token(LComponent.GetToken);
end;

procedure TACBrOpenDeliveryWebService.SalvarEnvio;
begin

end;

procedure TACBrOpenDeliveryWebService.SalvarResposta;
begin

end;

function TACBrOpenDeliveryWebService.TratarResposta: Boolean;
begin
  raise Exception.Create('Not Implemented.');
end;

{ TACBrOpenDeliveryAuth }

procedure TACBrOpenDeliveryAuth.DefinirDadosMsg;
var
  LComponent: TACBrOpenDelivery;
begin
  LComponent := GetACBrOpenDelivery(FOwner);
  FIssuedAt := Now;
  FRequest
    .AddOrSetUrlEncoded('grant_type', 'client_credentials')
    .AddOrSetUrlEncoded('client_id', LComponent.Credenciais.ClientId)
    .AddOrSetUrlEncoded('client_secret', LComponent.Credenciais.ClientSecret);
end;

procedure TACBrOpenDeliveryAuth.DefinirRecurso;
begin
  FRequest
    .POST
    .Resource('oauth/token');
end;

destructor TACBrOpenDeliveryAuth.Destroy;
begin
  FAccessToken.Free;
  inherited;
end;

function TACBrOpenDeliveryAuth.GetAccessToken: TACBrOpenDeliverySchemaAccessToken;
begin
  if not Assigned(FAccessToken) then
    FAccessToken := TACBrOpenDeliverySchemaAccessToken.Create;
  Result := FAccessToken;
end;

function TACBrOpenDeliveryAuth.TratarResposta: Boolean;
var
  LJSON: TACBrJSONObject;
begin
  LJSON := FResponse.GetJSONObject;
  AccessToken.AsJSON := LJSON.ToJSON;
  AccessToken.expiresAt := FIssuedAt + AccessToken.expiresIn;
  Result := True;
end;

{ TACBrOpenDeliveryWebServices }

constructor TACBrOpenDeliveryWebServices.Create(AOwner: TACBrComponent);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TACBrOpenDeliveryWebServices.Destroy;
begin
  FAuth.Free;
  inherited;
end;

function TACBrOpenDeliveryWebServices.GetAuth: TACBrOpenDeliveryAuth;
begin
  if not Assigned(FAuth) then
    FAuth := TACBrOpenDeliveryAuth.Create(FOwner);
  Result := FAuth;
end;

end.

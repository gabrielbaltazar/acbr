unit ACBrOpenDeliveryWebService;

interface

uses
  ACBrBase,
  ACBrJSON,
  ACBrOpenDeliverySchemaClasses,
  ACBrOpenDeliveryException,
  ACBrOpenDeliveryHTTP,
  ACBrOpenDeliveryHTTPClientDetails,
  ACBrUtil.Strings,
  pcnConversaoOD,
  SysUtils;

type
  TACBrOpenDeliveryAuth = class;
  TACBrOpenDeliveryPolling = class;

  TACBrOpenDeliveryWebServices = class
  private
    FOwner: TACBrComponent;
    FAuth: TACBrOpenDeliveryAuth;
    FPolling: TACBrOpenDeliveryPolling;
    function GetAuth: TACBrOpenDeliveryAuth;
    function GetPolling: TACBrOpenDeliveryPolling;
  public
    constructor Create(AOwner: TACBrComponent);
    destructor Destroy; override;

    property Auth: TACBrOpenDeliveryAuth read GetAuth;
    property Polling: TACBrOpenDeliveryPolling read GetPolling;
  end;

  TACBrOpenDeliveryWebService = class
  protected
    FOwner: TACBrComponent;
    FRequest: TACBrOpenDeliveryHTTPRequest;
    FResponse: TACBrOpenDeliveryHTTPResponse;
    FUseAuth: Boolean;

    procedure InicializarServico;
    procedure FinalizarServico;
    procedure DefinirDadosMsg; virtual;
    procedure DefinirRecurso; virtual;
    procedure SalvarEnvio;
    procedure EnviarDados;
    function TratarResposta: Boolean; virtual;
    procedure SalvarResposta;

    procedure FazerLog(const AMsg: string); virtual;
    procedure GerarException(const AMsg: string; AErro: Exception = nil); virtual;
    function GerarMsgLog: string; virtual;
    function GerarMsgErro(AErro: Exception): string; virtual;
  public
    constructor Create(AOwner: TACBrComponent); virtual;
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
    constructor Create(AOwner: TACBrComponent); override;
    destructor Destroy; override;
    property AccessToken: TACBrOpenDeliverySchemaAccessToken read GetAccessToken;
  end;

  TACBrOpenDeliveryPolling = class(TACBrOpenDeliveryWebService)
  private
    FEventType: TACBrODEventTypeArray;
    FXPollingMerchants: TSplitResult;
    FEvents: TACBrOpenDeliverySchemaEventCollection;
  protected
    procedure DefinirDadosMsg; override;
    procedure DefinirRecurso; override;
    function TratarResposta: Boolean; override;
  public
    constructor Create(AOwner: TACBrComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
    function AddEventType(const AValue: TACBrODEventType): TACBrOpenDeliveryPolling;
    function AddMerchantId(const AValue: string): TACBrOpenDeliveryPolling;

    property EventType: TACBrODEventTypeArray read FEventType write FEventType;
    property XPollingMerchants: TSplitResult read FXPollingMerchants write FXPollingMerchants;
    property Events: TACBrOpenDeliverySchemaEventCollection read FEvents write FEvents;
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
  FUseAuth := True;
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
var
  LMsgErro: string;
begin
  FazerLog('Inicio ' + ClassName);
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
        FazerLog(GerarMsgLog);
        SalvarResposta;
      end;
    except
      on E: Exception do
      begin
        Result := False;
        LMsgErro := GerarMsgErro(E);
        GerarException(LMsgErro, E);
      end;
    end;
  finally
    FinalizarServico;
  end;
end;

procedure TACBrOpenDeliveryWebService.EnviarDados;
var
  LError: TACBrOpenDeliverySchemaError;
  LJSONObject: TACBrJSONObject;
  LStatus: Integer;
  LTitle: string;
begin
  FreeAndNil(FResponse);
  FResponse := FRequest.Send;
  if FResponse.StatusCode >= 400 then
  begin
    LStatus := FResponse.StatusCode;
    LTitle := FResponse.StatusText;
    LJSONObject := FResponse.GetJSONObject;
    if Assigned(LJSONObject) then
    begin
      LError := TACBrOpenDeliverySchemaError.Create;
      try
        LError.AsJSON := LJSONObject.ToJSON;
        LStatus := LError.Status;
        LTitle := LError.Title;
      finally
        LError.Free;
      end;
    end;

    raise EACBrOpenDeliveryHTTPException.Create(LStatus, LTitle);
  end;
end;

procedure TACBrOpenDeliveryWebService.FazerLog(const AMsg: string);
var
  LTratado: Boolean;
begin
  if (AMsg <> '') then
    GetACBrOpenDelivery(FOwner).FazerLog(AMsg, LTratado);
end;

procedure TACBrOpenDeliveryWebService.FinalizarServico;
begin
end;

procedure TACBrOpenDeliveryWebService.GerarException(const AMsg: string; AErro: Exception);
begin
  GetACBrOpenDelivery(FOwner).GerarException(AMsg, AErro);
end;

function TACBrOpenDeliveryWebService.GerarMsgErro(AErro: Exception): string;
begin
  Result := '';
end;

function TACBrOpenDeliveryWebService.GerarMsgLog: string;
begin
  Result := '';
end;

procedure TACBrOpenDeliveryWebService.InicializarServico;
var
  LComponent: TACBrOpenDelivery;
begin
  LComponent := GetACBrOpenDelivery(FOwner);
  if not Assigned(FRequest) then
    FRequest := TACBrOpenDeliveryHTTPRequest.New;
  FRequest
    .OnHTTPEnvio(LComponent.OnHTTPEnviar)
    .OnHTTPResposta(LComponent.OnHTTPRetornar)
    .BaseURL(LComponent.BaseUrl)
    .TimeOut(LComponent.TimeOut)
    .ProxyHost(LComponent.Proxy.Host)
    .ProxyPort(LComponent.Proxy.Port)
    .ProxyUser(LComponent.Proxy.User)
    .ProxyPass(LComponent.Proxy.Pass);

  if FUseAuth then
    FRequest.Token(LComponent.GetToken);
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

constructor TACBrOpenDeliveryAuth.Create(AOwner: TACBrComponent);
begin
  inherited Create(AOwner);
  FUseAuth := False;
end;

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
var
  LComponent: TACBrOpenDelivery;
begin
  LComponent := GetACBrOpenDelivery(FOwner);
  FRequest
    .POST
    .Resource(LComponent.Resources.Authentication);
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
  AccessToken.Clear;
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
  FPolling.Free;
  inherited;
end;

function TACBrOpenDeliveryWebServices.GetAuth: TACBrOpenDeliveryAuth;
begin
  if not Assigned(FAuth) then
    FAuth := TACBrOpenDeliveryAuth.Create(FOwner);
  Result := FAuth;
end;

function TACBrOpenDeliveryWebServices.GetPolling: TACBrOpenDeliveryPolling;
begin
  if not Assigned(FPolling) then
    FPolling := TACBrOpenDeliveryPolling.Create(FOwner);
  Result := FPolling;
end;

{ TACBrOpenDeliveryPolling }

function TACBrOpenDeliveryPolling.AddEventType(const AValue: TACBrODEventType): TACBrOpenDeliveryPolling;
begin
  Result := Self;
  SetLength(FEventType, Length(FEventType) + 1);
  FEventType[Length(FEventType) - 1] := AValue;
end;

function TACBrOpenDeliveryPolling.AddMerchantId(const AValue: string): TACBrOpenDeliveryPolling;
begin
  Result := Self;
  SetLength(FXPollingMerchants, Length(XPollingMerchants) + 1);
  FXPollingMerchants[Length(XPollingMerchants) - 1] := AValue;
end;

procedure TACBrOpenDeliveryPolling.Clear;
begin
  inherited;
  FXPollingMerchants := [];
  FEventType := [];
end;

constructor TACBrOpenDeliveryPolling.Create(AOwner: TACBrComponent);
begin
  inherited Create(AOwner);
  FEvents := TACBrOpenDeliverySchemaEventCollection.Create('');
end;

procedure TACBrOpenDeliveryPolling.DefinirDadosMsg;
var
  LStrParam: string;
  I: Integer;
begin
  LStrParam := '';
  for I := 0 to Pred(Length(FXPollingMerchants)) do
  begin
    if I > 0 then
      LStrParam := LStrParam + ',';
    LStrParam := LStrParam + FXPollingMerchants[I];
  end;

  if LStrParam <> '' then
    FRequest.AddOrSetHeader('x-polling-merchants', LStrParam);

  LStrParam := '';
  for I := 0 to Pred(Length(FEventType)) do
  begin
    if I > 0 then
      LStrParam := LStrParam + ',';
    LStrParam := LStrParam + EventTypeToStr(FEventType[I]);
  end;

  if LStrParam <> '' then
    FRequest.AddOrSetQuery('eventType', LStrParam);
end;

procedure TACBrOpenDeliveryPolling.DefinirRecurso;
var
  LComponent: TACBrOpenDelivery;
begin
  LComponent := GetACBrOpenDelivery(FOwner);
  FRequest
    .GET
    .Resource(LComponent.Resources.EventPolling);
end;

destructor TACBrOpenDeliveryPolling.Destroy;
begin
  FEvents.Free;
  inherited;
end;

function TACBrOpenDeliveryPolling.TratarResposta: Boolean;
var
  LJSON: TACBrJSONArray;
begin
  LJSON := FResponse.GetJSONArray;
  Events.Clear;
  Events.AsJSON := LJSON.ToJSON;
  Result := True;
end;

end.

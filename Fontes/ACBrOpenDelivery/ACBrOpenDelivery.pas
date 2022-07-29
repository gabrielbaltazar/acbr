unit ACBrOpenDelivery;

interface

uses
  ACBrBase,
  ACBrOpenDeliverySchemaClasses,
  ACBrOpenDeliveryException,
  ACBrOpenDeliveryWebService,
  ACBrOpenDeliveryHTTP,
  Classes,
  SysUtils;

type
  TACBrOpenDeliveryCredential = class;
  TACBrOpenDeliveryProxy = class;
  TACBrOpenDeliveryResources = class;

  TOnTokenGet = procedure(AClientId: string; var AToken: string; var AExpiresAt: TDateTime) of object;
  TOnTokenSave = procedure(AClientId, AToken: string; AExpiresAt: TDateTime) of object;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrOpenDelivery = class(TACBrComponent)
  private
    FTimeOut: Integer;
    FProxy: TACBrOpenDeliveryProxy;
    FCredenciais: TACBrOpenDeliveryCredential;
    FBaseUrl: string;
    FWebServices: TACBrOpenDeliveryWebServices;
    FOnGerarLog: TACBrGravarLog;
    FOnHTTPEnviar: TACBrOpenDeliveryOnHTTPEnviar;
    FOnHTTPRetornar: TACBrOpenDeliveryOnHTTPRetornar;
    FResources: TACBrOpenDeliveryResources;
    FOnTokenGet: TOnTokenGet;
    FOnTokenSave: TOnTokenSave;
    function GetWebServices: TACBrOpenDeliveryWebServices;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetToken: string;
    procedure FazerLog(const AMsg: String; out ATratado: Boolean);
    procedure GerarException(const AMsg: String; AErro: Exception = nil);

    property WebServices: TACBrOpenDeliveryWebServices read GetWebServices;
  published
    property BaseUrl: string read FBaseUrl write FBaseUrl;
    property Credenciais: TACBrOpenDeliveryCredential read FCredenciais write FCredenciais;
    property Proxy: TACBrOpenDeliveryProxy read FProxy write FProxy;
    property Resources: TACBrOpenDeliveryResources read FResources write FResources;
    property TimeOut: Integer read FTimeOut write FTimeOut;

    property OnGerarLog: TACBrGravarLog read FOnGerarLog write FOnGerarLog;
    property OnHTTPEnviar: TACBrOpenDeliveryOnHTTPEnviar read FOnHTTPEnviar write FOnHTTPEnviar;
    property OnHTTPRetornar: TACBrOpenDeliveryOnHTTPRetornar read FOnHTTPRetornar write FOnHTTPRetornar;
    property OnTokenGet: TOnTokenGet read FOnTokenGet write FOnTokenGet;
    property OnTokenSave: TOnTokenSave read FOnTokenSave write FOnTokenSave;
  end;

  TACBrOpenDeliveryCredential = class(TPersistent)
  private
    FClientId: string;
    FClientSecret: string;
  public
    constructor Create;
    procedure Clear;
    procedure Assign(ASource: TACBrOpenDeliveryCredential); reintroduce;
  published
    property ClientId: string read FClientId write FClientId;
    property ClientSecret: string read FClientSecret write FClientSecret;
  end;

  TACBrOpenDeliveryProxy = class(TPersistent)
  private
    FPort: string;
    FPass: string;
    FHost: string;
    FUser: string;
  public
    constructor Create;
    procedure Clear;
    procedure Assign(ASource: TACBrOpenDeliveryProxy); reintroduce;
  published
    property Host: string read FHost write FHost;
    property Port: string read FPort write FPort;
    property User: string read FUser write FUser;
    property Pass: string read FPass write FPass;
  end;

  TACBrOpenDeliveryResources = class(TPersistent)
  private
    FAuthentication: string;
    FMerchantUpdate: string;
    FMerchantStatus: string;
    FEventPolling: string;
    FEventAcknowledgment: string;
    FOrderDetails: string;
    FOrderConfirm: string;
    FOrderReadyForPickup: string;
    FOrderDispatch: string;
    FOrderRequestCancellation: string;
    FOrderAcceptCancellation: string;
    FOrderDenyCancellation: string;
  public
    constructor Create;
    procedure Clear;
    procedure Assign(ASource: TACBrOpenDeliveryResources); reintroduce;
  published
    property Authentication: string read FAuthentication write FAuthentication;
    property MerchantUpdate: string read FMerchantUpdate write FMerchantUpdate;
    property MerchantStatus: string read FMerchantStatus write FMerchantStatus;
    property EventPolling: string read FEventPolling write FEventPolling;
    property EventAcknowledgment: string read FEventAcknowledgment write FEventAcknowledgment;
    property OrderDetails: string read FOrderDetails write FOrderDetails;
    property OrderConfirm: string read FOrderConfirm write FOrderConfirm;
    property OrderReadyForPickup: string read FOrderReadyForPickup write FOrderReadyForPickup;
    property OrderDispatch: string read FOrderDispatch write FOrderDispatch;
    property OrderRequestCancellation: string read FOrderRequestCancellation write FOrderRequestCancellation;
    property OrderAcceptCancellation: string read FOrderAcceptCancellation write FOrderAcceptCancellation;
    property OrderDenyCancellation: string read FOrderDenyCancellation write FOrderDenyCancellation;
  end;

implementation

const
  CHttpTimeOutDef = 90000;
  CEndPointAuthentication = 'oauth/token';
  CEndPointMerchantUpdate = 'merchantUpdate';
  CEndPointMerchantStatus = 'merchantStatus';
  CEndPointEventPolling = 'events:polling';
  CEndPointEventAcknowledgment = 'events/acknowledgment';
  CEndPointOrderDetails = 'orders/{orderId}';
  CEndPointOrderConfirm = 'orders/{orderId}/confirm';
  CEndPointOrderReadyForPickup = 'orders/{orderId}/readyForPickup';
  CEndPointOrderDispatch = 'orders/{orderId}/dispatch';
  CEndPointOrderRequestCancellation = 'orders/{orderId}/requestCancellation';
  CEndPointOrderAcceptCancellation = 'orders/{orderId}/acceptCancellation';
  CEndPointOrderDenyCancellation = 'orders/{orderId}/denyCancellation';

{ TACBrOpenDeliveryProxy }

procedure TACBrOpenDeliveryProxy.Assign(ASource: TACBrOpenDeliveryProxy);
begin
  FHost := ASource.Host;
  FPass := ASource.Pass;
  FPort := ASource.Port;
  FUser := ASource.User;
end;

procedure TACBrOpenDeliveryProxy.Clear;
begin
  FHost := '';
  FPass := '';
  FPort := '';
  FUser := '';
end;

constructor TACBrOpenDeliveryProxy.Create;
begin
  inherited Create;
  Clear;
end;

{ TACBrOpenDelivery }

constructor TACBrOpenDelivery.Create(AOwner: TComponent);
begin
  inherited;
  FCredenciais := TACBrOpenDeliveryCredential.Create;
  FProxy := TACBrOpenDeliveryProxy.Create;
  FResources := TACBrOpenDeliveryResources.Create;
  FTimeOut := CHttpTimeOutDef;
end;

destructor TACBrOpenDelivery.Destroy;
begin
  FCredenciais.Free;
  FProxy.Free;
  FResources.Free;
  FWebServices.Free;
  inherited;
end;

procedure TACBrOpenDelivery.FazerLog(const AMsg: String; out ATratado: Boolean);
begin
  ATratado := False;
  if (AMsg <> '') then
  begin
    if Assigned(OnGerarLog) then
      OnGerarLog(AMsg, ATratado);
  end;
end;

procedure TACBrOpenDelivery.GerarException(const AMsg: String; AErro: Exception);
var
  LTratado: Boolean;
  LMsgErro: string;
begin
  LMsgErro := AMsg;
  if Assigned(AErro) then
    LMsgErro := LMsgErro + sLineBreak + AErro.Message;

  LTratado := False;
  FazerLog('ERRO: ' + LMsgErro, LTratado);
  if not LTratado then
    raise EACBrOpenDeliveryException.CreateDef(LMsgErro);
end;

function TACBrOpenDelivery.GetToken: string;
var
  LToken: string;
  LExpiresAt: TDateTime;
  LIsValidToken: Boolean;
begin
  LToken := '';
  LExpiresAt := 0;
  LIsValidToken := WebServices.Auth.AccessToken.IsValid;
  if not LIsValidToken then
  begin
    if Assigned(FOnTokenGet) then
    begin
      FOnTokenGet(Credenciais.ClientId, LToken, LExpiresAt);
      WebServices.Auth.AccessToken.accessToken := LToken;
      WebServices.Auth.AccessToken.expiresAt := LExpiresAt;
      LIsValidToken := WebServices.Auth.AccessToken.IsValid;
    end;
  end;

  if not LIsValidToken then
  begin
    WebServices.Auth.Executar;
    LToken := WebServices.Auth.AccessToken.accessToken;
    LExpiresAt := WebServices.Auth.AccessToken.expiresAt;
    if Assigned(FOnTokenSave) then
      FOnTokenSave(Credenciais.ClientId, LToken, LExpiresAt);
  end;

  Result := WebServices.Auth.AccessToken.accessToken;
end;

function TACBrOpenDelivery.GetWebServices: TACBrOpenDeliveryWebServices;
begin
  if not Assigned(FWebServices) then
    FWebServices := TACBrOpenDeliveryWebServices.Create(Self);
  Result := FWebServices;
end;

{ TACBrOpenDeliveryCredential }

procedure TACBrOpenDeliveryCredential.Assign(ASource: TACBrOpenDeliveryCredential);
begin
  FClientId := ASource.ClientId;
  FClientSecret := ASource.ClientSecret;
end;

procedure TACBrOpenDeliveryCredential.Clear;
begin
  FClientId := '';
  FClientSecret := '';
end;

constructor TACBrOpenDeliveryCredential.Create;
begin
  inherited Create;
  Clear;
end;

{ TACBrOpenDeliveryResources }

procedure TACBrOpenDeliveryResources.Assign(ASource: TACBrOpenDeliveryResources);
begin
  FAuthentication := ASource.Authentication;
  FMerchantUpdate := ASource.MerchantUpdate;
  FMerchantStatus := ASource.MerchantStatus;
  FEventPolling := ASource.EventPolling;
  FEventAcknowledgment := ASource.EventAcknowledgment;
  FOrderDetails := ASource.OrderDetails;
  FOrderConfirm := ASource.OrderConfirm;
  FOrderDispatch := ASource.OrderDispatch;
  FOrderReadyForPickup := ASource.OrderReadyForPickup;
  FOrderDenyCancellation := ASource.OrderDenyCancellation;
  FOrderAcceptCancellation := ASource.OrderAcceptCancellation;
  FOrderRequestCancellation := ASource.OrderRequestCancellation;
end;

procedure TACBrOpenDeliveryResources.Clear;
begin
  FAuthentication := '';
  FMerchantUpdate := '';
  FMerchantStatus := '';
  FEventPolling := '';
  FEventAcknowledgment := '';
  FOrderDetails := '';
  FOrderConfirm := '';
  FOrderDispatch := '';
  FOrderReadyForPickup := '';
  FOrderDenyCancellation := '';
  FOrderAcceptCancellation := '';
  FOrderRequestCancellation := '';
end;

constructor TACBrOpenDeliveryResources.Create;
begin
  inherited Create;
  FAuthentication := CEndPointAuthentication;
  FMerchantUpdate := CEndPointMerchantUpdate;
  FMerchantStatus := CEndPointMerchantStatus;
  FEventPolling := CEndPointEventPolling;
  FEventAcknowledgment := CEndPointEventAcknowledgment;
  FOrderDetails := CEndPointOrderDetails;
  FOrderConfirm := CEndPointOrderConfirm;
  FOrderDispatch := CEndPointOrderDispatch;
  FOrderReadyForPickup := CEndPointOrderReadyForPickup;
  FOrderRequestCancellation := CEndPointOrderRequestCancellation;
  FOrderAcceptCancellation := CEndPointOrderAcceptCancellation;
  FOrderDenyCancellation := CEndPointOrderDenyCancellation;
end;

end.

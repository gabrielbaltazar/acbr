unit ACBrOpenDelivery;

interface

uses
  ACBrBase,
  ACBrOpenDeliveryWebService,
  Classes,
  SysUtils;

type
  TACBrOpenDeliveryCredential = class;
  TACBrOpenDeliveryProxy = class;

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
    function GetWebServices: TACBrOpenDeliveryWebServices;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetToken: string;

    property WebServices: TACBrOpenDeliveryWebServices read GetWebServices;
  published
    property BaseUrl: string read FBaseUrl write FBaseUrl;
    property Credenciais: TACBrOpenDeliveryCredential read FCredenciais write FCredenciais;
    property Proxy: TACBrOpenDeliveryProxy read FProxy write FProxy;
    property TimeOut: Integer read FTimeOut write FTimeOut;
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

implementation

const
  CHttpTimeOutDef = 90000;

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
  FTimeOut := CHttpTimeOutDef;
end;

destructor TACBrOpenDelivery.Destroy;
begin
  FCredenciais.Free;
  FProxy.Free;
  FWebServices.Free;
  inherited;
end;

function TACBrOpenDelivery.GetToken: string;
begin
  WebServices.Auth.Executar;
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

end.

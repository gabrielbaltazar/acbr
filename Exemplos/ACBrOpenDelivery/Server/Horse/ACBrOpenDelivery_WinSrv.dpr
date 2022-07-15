program ACBrOpenDelivery_WinSrv;

{$R *.dres}

uses
  Vcl.Forms,
  GBWinService.Setup.Interfaces,
  SrvOD.View.Main in 'SrvOD.View.Main.pas' {frmMain},
  SrvOD.Controller in 'SrvOD.Controller.pas',
  SrvOD.Controller.Merchant in 'SrvOD.Controller.Merchant.pas',
  SrvOD.Middlewares in 'Middlewares\SrvOD.Middlewares.pas';

{$R *.res}

begin
  CreateServer;

  WinServiceSetup
    .ServiceName('ACBrOpenDelivery')
    .ServiceTitle('ACBr OpenDelivery')
    .ServiceDetail('Serviço OpenDelivery Hook')
    .OnStart(StartServer)
    .OnStop(StopServer);

  if not WinServiceSetup.RunAsService then
    WinServiceSetup.CreateForm(TfrmMain, frmMain);
end.

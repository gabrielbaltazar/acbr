program ACBrOpenDelivery_DemoVCL;

uses
  Vcl.Forms,
  UntMain in 'UntMain.pas' {FMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.

program ACBrOpenDelivery_DemoVCL;

uses
  Vcl.Forms,
  UntMain in 'UntMain.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.

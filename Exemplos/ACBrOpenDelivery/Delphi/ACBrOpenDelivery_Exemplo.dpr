program ACBrOpenDelivery_Exemplo;

uses
  Vcl.Forms,
  frm_ACBrOpenDelivery in 'frm_ACBrOpenDelivery.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

program ACROpenDelivery_FMXSimpleSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {FMain},
  ACBrOpenDeliveryEvents in '..\..\..\..\Fontes\ACBrOpenDelivery\ACBrOpenDeliveryEvents.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.

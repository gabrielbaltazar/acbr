program ACBrOpenDelivery_Srv;

{$APPTYPE CONSOLE}

{$R *.res}

{$R *.dres}

uses
  Horse,
  Horse.CORS,
  System.SysUtils,
  SrvOD.Controller.Merchant in 'SrvOD.Controller.Merchant.pas',
  SrvOD.Middlewares in 'Middlewares\SrvOD.Middlewares.pas';

begin
  {$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse
    .Use(CORS)
    .Use(HorseACBrJSON)
    .Use(HorseODError);

  SrvOD.Controller.Merchant.Registry;

  THorse.Listen(9050,
    procedure(Horse: THorse)
    begin
      System.Writeln('Running...');
      System.Readln;
    end);
end.

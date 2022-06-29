program ACBrOpenDelivery_Srv;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils,
  ACBrOpenDeliverySchema in '..\..\..\..\Fontes\ACBrOpenDelivery\ACBrOpenDeliverySchema.pas',
  ACBrOpenDeliverySchemaClasses in '..\..\..\..\Fontes\ACBrOpenDelivery\ACBrOpenDeliverySchemaClasses.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

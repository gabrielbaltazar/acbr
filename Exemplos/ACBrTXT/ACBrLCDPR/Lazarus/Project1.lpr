program Project1;

{$MODE Delphi}

uses
  Forms, Interfaces,
  Unit2 in 'Unit2.pas' {Form2};

{.$R *.res}

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

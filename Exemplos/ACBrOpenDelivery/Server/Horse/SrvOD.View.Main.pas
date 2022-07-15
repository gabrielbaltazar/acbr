unit SrvOD.View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  GBWinService.Setup.Interfaces,
  SrvOD.Controller;

type
  TfrmMain = class(TForm)
    btnInstall: TButton;
    btnUninstall: TButton;
    btnStartServer: TButton;
    btnStopServer: TButton;
    procedure btnInstallClick(Sender: TObject);
    procedure btnUninstallClick(Sender: TObject);
    procedure btnStartServerClick(Sender: TObject);
    procedure btnStopServerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnInstallClick(Sender: TObject);
begin
  InstallService;
end;

procedure TfrmMain.btnStartServerClick(Sender: TObject);
begin
  StartServer;
end;

procedure TfrmMain.btnStopServerClick(Sender: TObject);
begin
  StopServer;
end;

procedure TfrmMain.btnUninstallClick(Sender: TObject);
begin
  UninstallService;
end;

end.

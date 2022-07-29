unit frm_ACBrOpenDelivery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  IniFiles,
  ACBrBase,
  ACBrOpenDeliveryHTTP,
  ACBrOpenDelivery;

type
  TForm1 = class(TForm)
    pgcOpenDelivery: TPageControl;
    tsLog: TTabSheet;
    mmoLogRequest: TMemo;
    mmoLogResponse: TMemo;
    tsConfig: TTabSheet;
    ACBrOpenDelivery1: TACBrOpenDelivery;
    Label48: TLabel;
    edtClientId: TEdit;
    Label1: TLabel;
    edtClientSecret: TEdit;
    Label2: TLabel;
    edtBaseUrl: TEdit;
    btnGetToken: TButton;
    tsPolling: TTabSheet;
    Label3: TLabel;
    edtPollingMerchantId: TEdit;
    btnPollingAddMerchantId: TButton;
    mmoPolling: TMemo;
    btnPolling: TButton;
    procedure ACBrOpenDelivery1HTTPEnviar(
      ALogEnvio: TACBrOpenDeliveryHTTPLogEnvio);
    procedure ACBrOpenDelivery1HTTPRetornar(
      ALogResposta: TACBrOpenDeliveryHTTPLogResposta);
    procedure btnGetTokenClick(Sender: TObject);
    procedure ACBrOpenDelivery1TokenGet(AClientId: string;
      var AToken: string; var AExpiresAt: TDateTime);
    procedure ACBrOpenDelivery1TokenSave(AClientId, AToken: string;
      AExpiresAt: TDateTime);
    procedure btnPollingClick(Sender: TObject);
    procedure btnPollingAddMerchantIdClick(Sender: TObject);
  private
    procedure ConfigurarComponente;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ACBrOpenDelivery1HTTPEnviar(ALogEnvio: TACBrOpenDeliveryHTTPLogEnvio);
begin
  mmoLogRequest.Lines.Add('Id: ' + ALogEnvio.Id);
  mmoLogRequest.Lines.Add('Start: ' + FormatDateTime('hh:mm:ss', ALogEnvio.Data));
  mmoLogRequest.Lines.Add('Url: ' + ALogEnvio.URL);
  mmoLogRequest.Lines.Add('Method: ' + ALogEnvio.Method);
  mmoLogRequest.Lines.Add('Body: ' + ALogEnvio.Body);
end;

procedure TForm1.ACBrOpenDelivery1HTTPRetornar(ALogResposta: TACBrOpenDeliveryHTTPLogResposta);
begin
  mmoLogResponse.Lines.Add('Id: ' + ALogResposta.Id);
  mmoLogResponse.Lines.Add('Start: ' + FormatDateTime('hh:mm:ss', ALogResposta.Data));
  mmoLogResponse.Lines.Add('Url: ' + ALogResposta.URL);
  mmoLogResponse.Lines.Add('Status: ' + IntToStr(ALogResposta.Status));
  mmoLogResponse.Lines.Add('Body: ' + ALogResposta.Body);
end;

procedure TForm1.ACBrOpenDelivery1TokenGet(AClientId: string; var AToken: string; var AExpiresAt: TDateTime);
var
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'OpenDeliveryDemo.ini');
  try
    AToken := LIniFile.ReadString(AClientId, 'TOKEN', '');
    AExpiresAt := StrToDateTimeDef(LIniFile.ReadString(AClientId, 'EXPIRES_AT', ''), 0);
  finally
    LIniFile.Free;
  end;
end;

procedure TForm1.ACBrOpenDelivery1TokenSave(AClientId, AToken: string; AExpiresAt: TDateTime);
var
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'OpenDeliveryDemo.ini');
  try
    LIniFile.WriteString(AClientId, 'TOKEN', AToken);
    LIniFile.WriteString(AClientId, 'EXPIRES_AT', DateTimeToStr(AExpiresAt));
  finally
    LIniFile.Free;
  end;
end;

procedure TForm1.btnGetTokenClick(Sender: TObject);
var
  LToken: string;
begin
  ConfigurarComponente;
  LToken := ACBrOpenDelivery1.GetToken;
  ShowMessage(LToken);
end;

procedure TForm1.btnPollingAddMerchantIdClick(Sender: TObject);
begin
  ACBrOpenDelivery1.WebServices.Polling
    .AddMerchantId(edtPollingMerchantId.Text);
end;

procedure TForm1.btnPollingClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.Polling.Executar;
  mmoPolling.Lines.Text := ACBrOpenDelivery1.WebServices.Polling.Events.AsJSON;


end;

procedure TForm1.ConfigurarComponente;
begin
  ACBrOpenDelivery1.BaseUrl := edtBaseUrl.Text;
  ACBrOpenDelivery1.Credenciais.ClientId := edtClientId.Text;
  ACBrOpenDelivery1.Credenciais.ClientSecret := edtClientSecret.Text;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.

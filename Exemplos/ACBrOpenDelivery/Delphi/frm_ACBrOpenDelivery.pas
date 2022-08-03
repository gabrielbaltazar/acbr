unit frm_ACBrOpenDelivery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  IniFiles,
  pcnConversaoOD,
  ACBrBase,
  ACBrOpenDeliveryHTTP,
  ACBrOpenDelivery, Vcl.Menus, Vcl.ExtCtrls;

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
    pmLog: TPopupMenu;
    Clear1: TMenuItem;
    edtPollingAddEventId: TEdit;
    Label4: TLabel;
    btnPollingAck: TButton;
    tsOrder: TTabSheet;
    Label5: TLabel;
    edtOrderOrderId: TEdit;
    btnOrderGetDetails: TButton;
    mmoOrder: TMemo;
    edtPollingOrderId: TEdit;
    Label6: TLabel;
    btnOrderConfirm: TButton;
    btnOrderDispatch: TButton;
    btnOrderReadyForPickup: TButton;
    btnOrderRequestCancellation: TButton;
    btnOrderAcceptCancellation: TButton;
    btnOrderDenyCancellation: TButton;
    Label7: TLabel;
    edtOrderReason: TEdit;
    tsMerchantUpdate: TTabSheet;
    pnlLink: TPanel;
    Label8: TLabel;
    Panel1: TPanel;
    Label9: TLabel;
    Panel2: TPanel;
    Label10: TLabel;
    rgUpdateType: TRadioGroup;
    Label11: TLabel;
    edtMerchantUpdateId: TEdit;
    chkMerchantStatus: TCheckBox;
    rgUpdateEntity: TRadioGroup;
    btnMerchantUpdate: TButton;
    procedure ACBrOpenDelivery1HTTPEnviar(ALogEnvio: TACBrOpenDeliveryHTTPLogEnvio);
    procedure ACBrOpenDelivery1HTTPRetornar(ALogResposta: TACBrOpenDeliveryHTTPLogResposta);
    procedure btnGetTokenClick(Sender: TObject);
    procedure ACBrOpenDelivery1TokenGet(AClientId: string; var AToken: string; var AExpiresAt: TDateTime);
    procedure ACBrOpenDelivery1TokenSave(AClientId, AToken: string; AExpiresAt: TDateTime);
    procedure btnPollingClick(Sender: TObject);
    procedure btnPollingAddMerchantIdClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure btnOrderGetDetailsClick(Sender: TObject);
    procedure btnPollingAckClick(Sender: TObject);
    procedure btnOrderConfirmClick(Sender: TObject);
    procedure btnOrderDispatchClick(Sender: TObject);
    procedure btnOrderReadyForPickupClick(Sender: TObject);
    procedure btnOrderRequestCancellationClick(Sender: TObject);
    procedure btnOrderAcceptCancellationClick(Sender: TObject);
    procedure btnOrderDenyCancellationClick(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure btnMerchantUpdateClick(Sender: TObject);
  private
    procedure OpenLink(ALabel: TLabel);
    procedure ConfigurarComponente;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Winapi.ShellAPI;

{$R *.dfm}

procedure TForm1.ACBrOpenDelivery1HTTPEnviar(ALogEnvio: TACBrOpenDeliveryHTTPLogEnvio);
begin
  mmoLogRequest.Lines.Add('Id: ' + ALogEnvio.Id);
  mmoLogRequest.Lines.Add('Start: ' + FormatDateTime('hh:mm:ss', ALogEnvio.Data));
  mmoLogRequest.Lines.Add('Url: ' + ALogEnvio.URL);
  mmoLogRequest.Lines.Add('Method: ' + ALogEnvio.Method);
  mmoLogRequest.Lines.Add('Headers: ' + ALogEnvio.Headers.Text);
  mmoLogRequest.Lines.Add('Body: ' + ALogEnvio.Body);
end;

procedure TForm1.ACBrOpenDelivery1HTTPRetornar(ALogResposta: TACBrOpenDeliveryHTTPLogResposta);
begin
  mmoLogResponse.Lines.Add('Id: ' + ALogResposta.Id);
  mmoLogResponse.Lines.Add('Start: ' + FormatDateTime('hh:mm:ss', ALogResposta.Data));
  mmoLogResponse.Lines.Add('Url: ' + ALogResposta.URL);
  mmoLogResponse.Lines.Add('Status: ' + IntToStr(ALogResposta.Status));
  mmoLogResponse.Lines.Add('Headers: ' + ALogResposta.Headers.Text);
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

procedure TForm1.btnMerchantUpdateClick(Sender: TObject);
var
  LUpdateType: TACBrODMerchantUpdateType;
  LUpdateEntity: TACBrODMerchantUpdateEntity;
  LStatus: TACBrODStatus;
begin
  ConfigurarComponente;
  LUpdateType := TACBrODMerchantUpdateType(rgUpdateType.ItemIndex);
  LUpdateEntity := TACBrODMerchantUpdateEntity(rgUpdateEntity.ItemIndex);
  LStatus := sAvailable;
  if not chkMerchantStatus.Checked then
    LStatus := sUnavailable;

  ACBrOpenDelivery1.WebServices.MerchantUpdate.UpdateType := LUpdateType;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.EntityType := LUpdateEntity;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Merchant.id := edtMerchantUpdateId.Text;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Merchant.status := LStatus;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Executar;
  ShowMessage('Atualizado!');
end;

procedure TForm1.btnOrderAcceptCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderAcceptCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderAcceptCancellation.Executar;
end;

procedure TForm1.btnOrderConfirmClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderConfirm.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderConfirm.Reason := 'Free field for more information about the order confirmation';
  ACBrOpenDelivery1.WebServices.OrderConfirm.OrderExternalCode := '';
  ACBrOpenDelivery1.WebServices.OrderConfirm.CreatedAt := Now;

  ACBrOpenDelivery1.WebServices.OrderConfirm.Executar;
end;

procedure TForm1.btnOrderDenyCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Reason := edtOrderReason.Text;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Code := dccOutForDelivery;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Executar;
end;

procedure TForm1.btnOrderDispatchClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDispatch.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDispatch.Executar;
end;

procedure TForm1.btnOrderGetDetailsClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDetails.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDetails.Executar;

  mmoOrder.Lines.Clear;
  with ACBrOpenDelivery1.WebServices.OrderDetails do
  begin
    mmoOrder.Lines.Add('DisplayId: ' + Order.displayId);
    mmoOrder.Lines.Add('Customer Name: ' + Order.customer.name);
    mmoOrder.Lines.Add('Total: ' + CurrToStr(Order.total.orderAmount.value));
  end;
end;

procedure TForm1.btnOrderReadyForPickupClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderReadyForPickup.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderReadyForPickup.Executar;
end;

procedure TForm1.btnOrderRequestCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Reason := edtOrderReason.Text;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Code := crcUnavailableItem;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Mode := crmAuto;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Executar;
end;

procedure TForm1.btnPollingAckClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events.New;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events[0].Id := edtPollingAddEventId.Text;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events[0].OrderId := edtPollingOrderId.Text;

  ACBrOpenDelivery1.WebServices.Acknowledgment.Executar;
  ShowMessage(IntToStr(ACBrOpenDelivery1.WebServices.Acknowledgment.StatusCode));
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

procedure TForm1.Clear1Click(Sender: TObject);
begin
  mmoLogRequest.Lines.Clear;
  mmoLogResponse.Lines.Clear;
end;

procedure TForm1.ConfigurarComponente;
begin
  ACBrOpenDelivery1.MarketPlace.BaseUrl := edtBaseUrl.Text;
  ACBrOpenDelivery1.MarketPlace.Credenciais.ClientId := edtClientId.Text;
  ACBrOpenDelivery1.MarketPlace.Credenciais.ClientSecret := edtClientSecret.Text;
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
  OpenLink(Sender as TLabel);
end;

procedure TForm1.OpenLink(ALabel: TLabel);
begin
  ShellExecute(Handle, 'open', PWideChar(ALabel.Caption), nil, nil, SW_SHOWMAXIMIZED);
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.

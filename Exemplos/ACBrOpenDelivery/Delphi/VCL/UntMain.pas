unit UntMain;

interface

uses
  ACBrBase,
  ACBrOpenDelivery,
  ACBrOpenDeliveryHTTP,
  pcnConversaoOD,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  Vcl.Menus,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.ShellAPI,
  Winapi.Windows;

type
  TFMain = class(TForm)
    ACBrOpenDelivery1: TACBrOpenDelivery;
    pnlTop: TPanel;
    pnlGeral: TPanel;
    tabGeral: TPageControl;
    tbiConfiguracoes: TTabSheet;
    tbiPolling: TTabSheet;
    tbiOrder: TTabSheet;
    tbiMerchant: TTabSheet;
    tbiLog: TTabSheet;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    pmLog: TPopupMenu;
    Label2: TLabel;
    edtBaseUrl: TEdit;
    Label48: TLabel;
    edtClientId: TEdit;
    Label3: TLabel;
    edtClientSecret: TEdit;
    btnGetToken: TButton;
    Panel1: TPanel;
    Label9: TLabel;
    Label4: TLabel;
    edtPollingMerchantId: TEdit;
    btnPollingAddMerchantId: TButton;
    btnPolling: TButton;
    Label5: TLabel;
    edtPollingAddEventId: TEdit;
    btnPollingAck: TButton;
    Label6: TLabel;
    edtPollingOrderId: TEdit;
    mmoPolling: TMemo;
    Panel2: TPanel;
    Label10: TLabel;
    Label7: TLabel;
    edtOrderOrderId: TEdit;
    btnOrderGetDetails: TButton;
    btnOrderConfirm: TButton;
    btnOrderDispatch: TButton;
    btnOrderReadyForPickup: TButton;
    Label8: TLabel;
    edtOrderReason: TEdit;
    btnOrderRequestCancellation: TButton;
    btnOrderAcceptCancellation: TButton;
    btnOrderDenyCancellation: TButton;
    mmoOrder: TMemo;
    pnlLink: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    edtMerchantUpdateId: TEdit;
    chkMerchantStatus: TCheckBox;
    btnMerchantUpdate: TButton;
    rgUpdateType: TRadioGroup;
    rgUpdateEntity: TRadioGroup;
    mmoLogRequest: TMemo;
    mmoLogResponse: TMemo;
    Clear1: TMenuItem;
    procedure btnGetTokenClick(Sender: TObject);
    procedure btnMerchantUpdateClick(Sender: TObject);
    procedure btnOrderAcceptCancellationClick(Sender: TObject);
    procedure btnOrderConfirmClick(Sender: TObject);
    procedure btnOrderDenyCancellationClick(Sender: TObject);
    procedure btnOrderDispatchClick(Sender: TObject);
    procedure btnOrderGetDetailsClick(Sender: TObject);
    procedure btnOrderReadyForPickupClick(Sender: TObject);
    procedure btnOrderRequestCancellationClick(Sender: TObject);
    procedure btnPollingAckClick(Sender: TObject);
    procedure btnPollingAddMerchantIdClick(Sender: TObject);
    procedure btnPollingClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
      procedure OpenLink(ALabel: TLabel);
      procedure ConfigurarComponente;
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.btnGetTokenClick(Sender: TObject);
var
  LToken: string;
begin
  ConfigurarComponente;
  LToken := ACBrOpenDelivery1.GetToken;
  ShowMessage(LToken);
end;

procedure TFMain.btnMerchantUpdateClick(Sender: TObject);
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
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Merchant.Id := edtMerchantUpdateId.Text;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Merchant.Status := LStatus;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Executar;

  ShowMessage('Atualizado!');
end;

procedure TFMain.btnOrderAcceptCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderAcceptCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderAcceptCancellation.Executar;
end;

procedure TFMain.btnOrderConfirmClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderConfirm.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderConfirm.Reason := 'Free field for more information about the order confirmation';
  ACBrOpenDelivery1.WebServices.OrderConfirm.OrderExternalCode := '';
  ACBrOpenDelivery1.WebServices.OrderConfirm.CreatedAt := Now;

  ACBrOpenDelivery1.WebServices.OrderConfirm.Executar;
end;

procedure TFMain.btnOrderDenyCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Reason := edtOrderReason.Text;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Code := dccOutForDelivery;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Executar;
end;

procedure TFMain.btnOrderDispatchClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDispatch.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDispatch.Executar;
end;

procedure TFMain.btnOrderGetDetailsClick(Sender: TObject);
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

  // ACBrOpenDelivery1.WebServices.OrderDetails.
end;

procedure TFMain.btnOrderReadyForPickupClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderReadyForPickup.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderReadyForPickup.Executar;
end;

procedure TFMain.btnOrderRequestCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Reason := edtOrderReason.Text;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Code := crcUnavailableItem;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Mode := crmAuto;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Executar;
end;

procedure TFMain.btnPollingAckClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events.New;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events[0].Id := edtPollingAddEventId.Text;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events[0].OrderId := edtPollingOrderId.Text;

  ACBrOpenDelivery1.WebServices.Acknowledgment.Executar;
  ShowMessage(IntToStr(ACBrOpenDelivery1.WebServices.Acknowledgment.StatusCode));
end;

procedure TFMain.btnPollingAddMerchantIdClick(Sender: TObject);
begin
  ACBrOpenDelivery1.WebServices.Polling
    .AddMerchantId(edtPollingMerchantId.Text);
end;

procedure TFMain.btnPollingClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.Polling.Executar;
  mmoPolling.Lines.Text := ACBrOpenDelivery1.WebServices.Polling.Events.AsJSON;
end;

procedure TFMain.Clear1Click(Sender: TObject);
begin
  mmoLogRequest.Lines.Clear;
  mmoLogResponse.Lines.Clear;
end;

{ TFMain }

procedure TFMain.ConfigurarComponente;
begin
  ACBrOpenDelivery1.MarketPlace.BaseUrl                  := edtBaseUrl.Text;
  ACBrOpenDelivery1.MarketPlace.Credenciais.ClientId     := edtClientId.Text;
  ACBrOpenDelivery1.MarketPlace.Credenciais.ClientSecret := edtClientSecret.Text;
end;

procedure TFMain.Label10Click(Sender: TObject);
begin
  OpenLink(Sender as TLabel);
end;

procedure TFMain.Label11Click(Sender: TObject);
begin
  OpenLink(Sender as TLabel);
end;

procedure TFMain.Label9Click(Sender: TObject);
begin
  OpenLink(Sender as TLabel);
end;

procedure TFMain.OpenLink(ALabel: TLabel);
begin
  ShellExecute(Handle, 'open', PWideChar(ALabel.Caption), nil, nil, SW_SHOWMAXIMIZED);
end;

end.

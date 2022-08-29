unit UntMain;

interface

uses
  ACBrBase,
  ACBrOpenDelivery,
  ACBrOpenDeliveryHTTP,
  pcnConversaoOD,
  REST.Json,
  System.Json,

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
  Winapi.Windows,
  Vcl.Grids, Data.DB, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask;

type
  TFMain = class(TForm)
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
    ACBrOpenDelivery1: TACBrOpenDelivery;
    pgPolling: TPageControl;
    tabPolling: TTabSheet;
    tbJSONPolling: TTabSheet;
    mmoPolling: TMemo;
    DBGrid1: TDBGrid;
    pgOrder: TPageControl;
    tbItems: TTabSheet;
    tbOptions: TTabSheet;
    tbPayments: TTabSheet;
    TabSheet4: TTabSheet;
    tbJSONOrder: TTabSheet;
    mmoOrder: TMemo;
    pnlCustomer: TPanel;
    Shape1: TShape;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lblCusomerName: TDBText;
    lblCusomerDocument: TDBText;
    lblCusomerPhone: TDBText;
    Panel3: TPanel;
    Shape2: TShape;
    Label17: TLabel;
    lblItemsPriceValue: TDBText;
    lblItemsPriceCurr: TDBText;
    Panel4: TPanel;
    Shape3: TShape;
    Label18: TLabel;
    lblothersFeesValue: TDBText;
    lblothersFeesCurr: TDBText;
    Panel5: TPanel;
    Shape4: TShape;
    Label19: TLabel;
    lblDiscountValue: TDBText;
    lblDiscountCurr: TDBText;
    Panel6: TPanel;
    Shape5: TShape;
    Label20: TLabel;
    lblorderAmountValue: TDBText;
    lblorderAmountCurr: TDBText;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtMerchantIDOrder: TDBEdit;
    edtMerchantNameOrder: TDBEdit;
    edtID: TDBEdit;
    edtType: TDBEdit;
    edtDisplayId: TDBEdit;
    edtCreateAt: TDBEdit;
    edtOrderTiming: TDBEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    lblDeliveryStreet: TLabel;
    lblDeliveryNumber: TLabel;
    lblDeliveryCity: TLabel;
    lblDeliveryPostalCode: TLabel;
    lblDeliveryDistrict: TLabel;
    lblDeliveryState: TLabel;
    lblDeliveryComplement: TLabel;
    Label35: TLabel;
    lblPaymentsPending: TLabel;
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

uses
  UntDM;

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
  LUpdateType:   TACBrODMerchantUpdateType;
  LUpdateEntity: TACBrODMerchantUpdateEntity;
  LStatus:       TACBrODStatus;
begin
  ConfigurarComponente;
  LUpdateType   := TACBrODMerchantUpdateType(rgUpdateType.ItemIndex);
  LUpdateEntity := TACBrODMerchantUpdateEntity(rgUpdateEntity.ItemIndex);
  LStatus       := sAvailable;
  if not chkMerchantStatus.Checked then
    LStatus := sUnavailable;

  ACBrOpenDelivery1.WebServices.MerchantUpdate.UpdateType      := LUpdateType;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.EntityType      := LUpdateEntity;
  ACBrOpenDelivery1.WebServices.MerchantUpdate.Merchant.Id     := edtMerchantUpdateId.Text;
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
  ACBrOpenDelivery1.WebServices.OrderConfirm.OrderId           := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderConfirm.Reason            := 'Free field for more information about the order confirmation';
  ACBrOpenDelivery1.WebServices.OrderConfirm.OrderExternalCode := '';
  ACBrOpenDelivery1.WebServices.OrderConfirm.CreatedAt         := Now;

  ACBrOpenDelivery1.WebServices.OrderConfirm.Executar;
end;

procedure TFMain.btnOrderDenyCancellationClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Reason  := edtOrderReason.Text;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Code    := dccOutForDelivery;
  ACBrOpenDelivery1.WebServices.OrderDenyCancellation.Executar;
end;

procedure TFMain.btnOrderDispatchClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDispatch.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDispatch.Executar;
end;

procedure TFMain.btnOrderGetDetailsClick(Sender: TObject);
//begin
//  ConfigurarComponente;
//  ACBrOpenDelivery1.WebServices.OrderDetails.OrderId := edtOrderOrderId.Text;
//  ACBrOpenDelivery1.WebServices.OrderDetails.Executar;
//
//  mmoOrder.Lines.Clear;
//  with ACBrOpenDelivery1.WebServices.OrderDetails do
//  begin
//    mmoOrder.Lines.Add('DisplayId: ' + Order.displayId);
//    mmoOrder.Lines.Add('Customer Name: ' + Order.customer.name);
//    mmoOrder.Lines.Add('Total: ' + CurrToStr(Order.total.orderAmount.value));
//  end;
//
//  // ACBrOpenDelivery1.WebServices.OrderDetails.

var
  I: Integer;
begin
    {$REGION 'Cabecalho Pedido'}
    (*
    {
        "uniqueId": "f0269d26-6872-4c2a-9e8a-f3d6f5e55aaa",
        "id": "f0269d26-6872-4c2a-9e8a-f3d6f5e55aaa",
        "type": "DELIVERY",
        "displayId": "0808221308",
        "createdAt": "2022-08-08T13:08:01.119423Z",
        "orderTiming": "INSTANT",
        "merchant": {
            "id": "14417282000131-7cf42549-aff0-4bfd-a33b-83f4c08ff441",
            "name": "GET IT Restaurante e Pizzaria"
        },
    *)
    {$ENDREGION}
    {$REGION 'Items'}
    (*
        "items": [
            {
                "id": "ea45a60e-14c3-4fb0-8713-093b02014579",
                "index": 0,
                "name": "X-Burger",
                "externalCode": "0101",
                "unit": "UNIT",
                "quantity": 0,
                "specialInstructions": "Remover mostarda",
                "unitPrice": {
                    "value": 0.0,
                    "currency": null
                },
                "optionsPrice": null,
                "totalPrice": {
                    "value": 10.0,
                    "currency": "BRL"
                },
                "options": [
                    {
                        "id": "02a3c52f-3fd4-456b-a2c6-157ae38df7b6",
                        "name": "Coca-Cola",
                        "externalCode": "COC",
                        "unit": "UNIT",
                        "quantity": 0,
                        "unitPrice": {
                            "value": 0.0,
                            "currency": null
                        },
                        "totalPrice": {
                            "value": 0.0,
                            "currency": "BRL"
                        },
                        "specialInstructions": ""
                    }
                ]
            }
        ],
    *)
    {$ENDREGION}
    {$REGION 'otherFees'}
    (*
        "otherFees": [
            {
                "name": "MARKETPLACE",
                "type": "SERVICE_FEE",
                "receivedBy": "MARKETPLACE",
                "receiverDocument": "95320052000151",
                "price": {
                    "value": 3.0,
                    "currency": "BRL"
                },
                "observation": "Order 0808221308 Fee"
            }
        ],
    *)
    {$ENDREGION'}
    {$REGION 'discounts'}
    (*
        "discounts": [],
    *)
    {$ENDREGION}
    {$REGION 'total'}
    (*
        "total": {
            "itemsPrice": {
                "value": 10.0,
                "currency": "BRL"
            },
            "otherFees": {
                "value": 3.0,
                "currency": "BRL"
            },
            "discount": {
                "value": 0.0,
                "currency": "BRL"
            },
            "orderAmount": {
                "value": 10.0,
                "currency": "BRL"
            }
        },
    *)
    {$ENDREGION}
    {$REGION 'payments'}
    (*
        "payments": {
            "prepaid": 10.0,
            "pending": 0.0,
            "methods": [
                {
                    "value": 10.0,
                    "currency": "BRL",
                    "method": "CREDIT",
                    "methodInfo": "VISA",
                    "type": "PREPAID",
                    "changeFor": 0.0
                }
            ]
        },
    *)
    {$ENDREGION}
    {$REGION 'customer'}
    (*
        "customer": {
            "id": "7cf42549-aff0-4bfd-a33b-83f4c08ff441",
            "phone": {
                "number": "11910588280",
                "extension": "0101"
            },
            "documentNumber": "28896497094",
            "name": "GET IT Restaurante e Pizzaria",
            "ordersCountOnMerchant": 8
        },
    *)
    {$ENDREGION}
    {$REGION 'delivery'}
    (*
        "delivery": {
            "deliveredBy": "MARKETPLACE",
            "deliveryAddress": {
                "country": "BR",
                "street": "Rua Cel. Irineu de Castro",
                "formattedAddress": null,
                "number": "43",
                "city": "S?o Paulo",
                "postalCode": "03333-050",
                "coordinates": {
                    "latitude": -23.5481,
                    "longitude": -23.5481
                },
                "district": "Vila Carrao",
                "state": "SP",
                "complement": "S?o Paulo",
                "deliveryDateTime": "0001-01-01T00:00:00"
            },
            "estimatedDeliveryDateTime": "2022-08-08T13:38:01.2791544Z"
        },
        "takeout": {
            "mode": null,
            "takeoutDateTime": null
        },
        "schedule": {
            "scheduleDateTime": "0001-01-01T00:00:00"
        },
        "indoor": {
            "mode": null,
            "indoorDeliveryDateTime": "0001-01-01T00:00:00",
            "table": null
        },
        "extraInfo": "Pedido Teste"
    }
    *)
    {$ENDREGION}

  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.OrderDetails.OrderId := edtOrderOrderId.Text;
  ACBrOpenDelivery1.WebServices.OrderDetails.Executar;

  DM.ResetClientDataSet(DM.cdsOrder);
  DM.ResetClientDataSet(DM.cdsCustomer);
  DM.ResetClientDataSet(DM.cdsItems);
  DM.ResetClientDataSet(DM.cdsOptions);
  DM.ResetClientDataSet(DM.cdsPayments);

  mmoOrder.Lines.Clear;
  mmoOrder.Lines.Add(TJson.Format(TJSONObject.ParseJSONValue(ACBrOpenDelivery1.WebServices.OrderDetails.Order.AsJSON) as TJSONValue));
  with ACBrOpenDelivery1.WebServices.OrderDetails do
  begin
    mmoOrder.Lines.Add('DisplayId: ' + Order.displayId);
    mmoOrder.Lines.Add('Customer Name: ' + Order.customer.name);
    mmoOrder.Lines.Add('Total: ' + CurrToStr(Order.total.orderAmount.value));

    DM.cdsOrder.Append;
    DM.cdsOrderID.AsString := Order.merchant.id;
    DM.cdsOrdermerchantID.AsString := Order.merchant.id;
    DM.cdsOrdermerchantName.AsString := Order.merchant.name;
    DM.cdsOrdertype.AsString := ServiceTypeToStr(Order.&type);
    DM.cdsOrderdisplayID.AsString := Order.displayId;
    DM.cdsOrdercreatedAt.AsDateTime := Order.createdAt;
    DM.cdsOrderorderTiming.AsString := Order.orderTiming;

    //Customer
    DM.cdsCustomer.Append;
    DM.cdsCustomerID.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.customer.id;
    DM.cdsCustomerphoneNumber.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.customer.phone.number;
    DM.cdsCustomerdocumentNumber.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.customer.documentNumber;
    DM.cdsCustomername.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.customer.name;
    DM.cdsCustomer.Post;

    DM.cdsOrder.Post;
    //Total
    lblItemsPriceValue.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.itemsPrice.value.ToString;
    lblItemsPriceCurr.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.itemsPrice.currency;

    lblothersFeesValue.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.otherFees.value.ToString;
    lblothersFeesCurr.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.otherFees.currency;

    lblDiscountValue.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.discount.value.ToString;
    lblDiscountCurr.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.discount.currency;

    lblorderAmountValue.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.orderAmount.value.ToString;
    lblorderAmountCurr.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.total.orderAmount.currency;

    //Delivery
    lblDeliveryStreet.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.street;
    lblDeliveryNumber.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.number;
    lblDeliveryCity.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.city;
    lblDeliveryPostalCode.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.postalCode;
    lblDeliveryDistrict.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.district;
    lblDeliveryState.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.state;
    lblDeliveryComplement.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.delivery.deliveryAddress.complement;

    //Fill Itens
    for I := 0 to Pred(ACBrOpenDelivery1.WebServices.OrderDetails.Order.items.Count) do
    begin
      DM.cdsItems.Append;

      DM.cdsItemsID.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].id;
      DM.cdsItemsIndex.AsInteger := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].index;
      DM.cdsItemsName.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].name;
      DM.cdsItemsexternalCode.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].externalCode;
      DM.cdsItemsUnit.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].&unit;
      DM.cdsItemsQuantity.AsFloat := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].quantity;
      DM.cdsItemsspecialInstructions.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].specialInstructions;
      DM.cdsItemsunitPriceValue.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].unitPrice.value;
      DM.cdsItemsunitPriceCurrency.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].unitPrice.currency;
      DM.cdsItemsoptionsPrice.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].optionsPrice.value;
      DM.cdsItemstotalPriceValue.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].totalPrice.value;
      DM.cdsItemstotalPriceCurrency.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].totalPrice.currency;

      DM.cdsItems.Post;
    end;

    //Fill Options
    for I := 0 to Pred(ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[0].options.Count) do
    begin
      DM.cdsOptions.Append;

      DM.cdsOptionsID.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].id;
      DM.cdsOptionsName.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].name;
      DM.cdsOptionsexternalCode.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].externalCode;
      DM.cdsOptionsUnit.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].&unit;
      DM.cdsOptionsQuantity.AsFloat := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].quantity;
      DM.cdsOptionsunitPriceValue.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].unitPrice.value;
      DM.cdsOptionsunitPriceCurrency.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].unitPrice.currency;
      DM.cdsOptionstotalPriceValue.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].totalPrice.value;
      DM.cdsOptionstotalPriceCurrency.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].totalPrice.currency;
      DM.cdsOptionsspecialInstructions.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.items[I].options[I].specialInstructions;

      DM.cdsOptions.Post;
    end;

    //Paymentsd
    lblPaymentsPending.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.prepaid.ToString;
    lblPaymentsPending.Caption := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.pending.ToString;
    for I := 0 to Pred(ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods.Count) do
    begin
      DM.cdsPayments.Append;
      DM.cdsPaymentsprepaid.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.prepaid;
      DM.cdsPaymentspending.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.pending;
      DM.cdsPaymentsmethodsValue.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods[I].value;
      DM.cdsPaymentsmethodsCurrency.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods[I].currency;
      DM.cdsPaymentsmethodsMethod.AsString := PaymentMethodToStr(ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods[I].method);
      DM.cdsPaymentsmethodsMethodInfo.AsString := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods[I].methodInfo;
      DM.cdsPaymentsmethodsType.AsString := PaymentTypeToStr(ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods[I].&type);
      DM.cdsPaymentsmethodsChangeFor.AsCurrency := ACBrOpenDelivery1.WebServices.OrderDetails.Order.payments.methods[I].value;

      DM.cdsPayments.Post;
    end;
  end;

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
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Reason  := edtOrderReason.Text;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Code    := crcUnavailableItem;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Mode    := crmAuto;
  ACBrOpenDelivery1.WebServices.OrderRequestCancellation.Executar;
end;

procedure TFMain.btnPollingAckClick(Sender: TObject);
begin
  ConfigurarComponente;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events.New;
  ACBrOpenDelivery1.WebServices.Acknowledgment.Events[0].Id      := edtPollingAddEventId.Text;
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
var
  I:         Integer;
  LStrEvent: string;
begin
  // ConfigurarComponente;
  // ACBrOpenDelivery1.WebServices.Polling.Executar;
  // mmoPolling.Lines.Text := ACBrOpenDelivery1.WebServices.Polling.Events.AsJSON;


  // var
  // I: Integer;
  // LStrEvent: string;
  // begin
  {$REGION '<JSON Exemplo Retorno EVENTS>'}
  (*
    [
    {
    "eventId": "db37e591-f9e9-4f8b-8503-e4a0a8409e67",
    "eventType": "CREATED",
    "orderId": "f0269d26-6872-4c2a-9e8a-f3d6f5e55aaa",
    "orderURL": "https:\/\/sandbox.myhubdelivery.io\/orders\/api\/v1\/f0269d26-6872-4c2a-9e8a-f3d6f5e55aaa",
    "createdAt": "2022-08-08T13:08:03.000Z",
    "sourceAppId": "0babcbcf2d5c4c69a9d1b6677cb4f593"
    }
    ]
  *)
  {$ENDREGION}
  try
    Screen.Cursor := crHourGlass;
    try
      ConfigurarComponente;
      ACBrOpenDelivery1.WebServices.Polling.Executar;

      edtPollingAddEventId.Text := ACBrOpenDelivery1.WebServices.Polling.Events[0].EventId;
      edtPollingOrderId.Text    := ACBrOpenDelivery1.WebServices.Polling.Events[0].OrderId;
      edtOrderOrderId.Text      := ACBrOpenDelivery1.WebServices.Polling.Events[0].OrderId;

      mmoPolling.Lines.Text := TJson.Format(TJSONObject.ParseJSONValue(ACBrOpenDelivery1.WebServices.Polling.Events.AsJSON) as TJSONValue);

      DM.ResetClientDataSet(DM.cdsPolling);

      for I := 0 to Pred(ACBrOpenDelivery1.WebServices.Polling.Events.Count) do
      begin
        LStrEvent                 := EventTypeToStr(ACBrOpenDelivery1.WebServices.Polling.Events[I].EventType);

        DM.cdsPolling.Append;
        DM.cdsPollingeventID.AsString := ACBrOpenDelivery1.WebServices.Polling.Events[I].EventId;
        DM.cdsPollingeventType.AsString := LStrEvent;
        DM.cdsPollingorderID.AsString := ACBrOpenDelivery1.WebServices.Polling.Events[I].OrderId;
        DM.cdsPollingorderURL.AsString := ACBrOpenDelivery1.WebServices.Polling.Events[I].OrderURL;
        DM.cdsPollingcreatedAt.AsDateTime := ACBrOpenDelivery1.WebServices.Polling.Events[I].CreatedAt;

        //  FormatDateTime('YYYY-MM-DD hh:mm:ss', ACBrOpenDelivery1.WebServices.Polling.Events[I].CreatedAt);
        DM.cdsPollingsourceAppID.AsString := ACBrOpenDelivery1.WebServices.Polling.Events[I].SourceAppId;
        DM.cdsPolling.Post;
      end;
    except
      Screen.Cursor := crDefault;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

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

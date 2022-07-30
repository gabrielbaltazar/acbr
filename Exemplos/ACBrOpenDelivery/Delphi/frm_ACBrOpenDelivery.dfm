object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 552
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pgcOpenDelivery: TPageControl
    Left = 0
    Top = 0
    Width = 827
    Height = 552
    ActivePage = tsPolling
    Align = alClient
    TabOrder = 0
    object tsConfig: TTabSheet
      Caption = 'Configura'#231#245'es'
      ImageIndex = 1
      object Label48: TLabel
        Left = 16
        Top = 72
        Width = 45
        Height = 15
        Caption = 'Client ID'
      end
      object Label1: TLabel
        Left = 335
        Top = 72
        Width = 66
        Height = 15
        Caption = 'Client Secret'
      end
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 48
        Height = 15
        Caption = 'Base URL'
      end
      object edtClientId: TEdit
        Left = 16
        Top = 93
        Width = 313
        Height = 23
        TabOrder = 0
        Text = 'd01e2f0b3d91468db3e9613f37c416d8'
      end
      object edtClientSecret: TEdit
        Left = 335
        Top = 93
        Width = 313
        Height = 23
        PasswordChar = '*'
        TabOrder = 1
        Text = 'Q7@%^12Lnvh9'
      end
      object edtBaseUrl: TEdit
        Left = 16
        Top = 37
        Width = 406
        Height = 23
        TabOrder = 2
        Text = 'https://sandbox.myhubdelivery.io'
      end
      object btnGetToken: TButton
        Left = 654
        Top = 92
        Width = 75
        Height = 25
        Caption = 'Token'
        TabOrder = 3
        OnClick = btnGetTokenClick
      end
    end
    object tsPolling: TTabSheet
      Caption = 'Polling'
      ImageIndex = 2
      object Label3: TLabel
        Left = 24
        Top = 24
        Width = 65
        Height = 15
        Caption = 'Merchant ID'
      end
      object Label4: TLabel
        Left = 24
        Top = 96
        Width = 43
        Height = 15
        Caption = 'Event ID'
      end
      object Label6: TLabel
        Left = 24
        Top = 152
        Width = 44
        Height = 15
        Caption = 'Order ID'
      end
      object edtPollingMerchantId: TEdit
        Left = 24
        Top = 45
        Width = 225
        Height = 23
        TabOrder = 0
      end
      object btnPollingAddMerchantId: TButton
        Left = 255
        Top = 44
        Width = 130
        Height = 25
        Caption = 'Add Merchant Id'
        TabOrder = 1
        OnClick = btnPollingAddMerchantIdClick
      end
      object mmoPolling: TMemo
        Left = 24
        Top = 312
        Width = 713
        Height = 185
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object btnPolling: TButton
        Left = 439
        Top = 44
        Width = 130
        Height = 25
        Caption = 'Polling'
        TabOrder = 3
        OnClick = btnPollingClick
      end
      object edtPollingAddEventId: TEdit
        Left = 24
        Top = 117
        Width = 225
        Height = 23
        TabOrder = 4
      end
      object btnPollingAck: TButton
        Left = 255
        Top = 116
        Width = 130
        Height = 25
        Caption = 'Acknowledgment'
        TabOrder = 5
        OnClick = btnPollingAckClick
      end
      object edtPollingOrderId: TEdit
        Left = 24
        Top = 173
        Width = 225
        Height = 23
        TabOrder = 6
      end
    end
    object tsOrder: TTabSheet
      Caption = 'Order'
      ImageIndex = 3
      object Label5: TLabel
        Left = 16
        Top = 24
        Width = 44
        Height = 15
        Caption = 'Order ID'
      end
      object Label7: TLabel
        Left = 16
        Top = 96
        Width = 38
        Height = 15
        Caption = 'Reason'
      end
      object edtOrderOrderId: TEdit
        Left = 16
        Top = 45
        Width = 249
        Height = 23
        TabOrder = 0
      end
      object btnOrderGetDetails: TButton
        Left = 271
        Top = 44
        Width = 122
        Height = 25
        Caption = 'Get Order Details'
        TabOrder = 1
        OnClick = btnOrderGetDetailsClick
      end
      object mmoOrder: TMemo
        Left = 16
        Top = 320
        Width = 617
        Height = 185
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object btnOrderConfirm: TButton
        Left = 399
        Top = 44
        Width = 130
        Height = 25
        Caption = 'Confirm'
        TabOrder = 3
        OnClick = btnOrderConfirmClick
      end
      object btnOrderDispatch: TButton
        Left = 535
        Top = 44
        Width = 130
        Height = 25
        Caption = 'Dispatch'
        TabOrder = 4
        OnClick = btnOrderDispatchClick
      end
      object btnOrderReadyForPickup: TButton
        Left = 671
        Top = 44
        Width = 130
        Height = 25
        Caption = 'Ready For Pickup'
        TabOrder = 5
        OnClick = btnOrderReadyForPickupClick
      end
      object btnOrderRequestCancellation: TButton
        Left = 399
        Top = 116
        Width = 130
        Height = 25
        Caption = 'Request Cancellation'
        TabOrder = 6
        OnClick = btnOrderRequestCancellationClick
      end
      object btnOrderAcceptCancellation: TButton
        Left = 535
        Top = 116
        Width = 130
        Height = 25
        Caption = 'Accept Cancellation'
        TabOrder = 7
        OnClick = btnOrderAcceptCancellationClick
      end
      object btnOrderDenyCancellation: TButton
        Left = 671
        Top = 116
        Width = 130
        Height = 25
        Caption = 'Deny Cancellation'
        TabOrder = 8
        OnClick = btnOrderDenyCancellationClick
      end
      object edtOrderReason: TEdit
        Left = 16
        Top = 117
        Width = 249
        Height = 23
        TabOrder = 9
        Text = 'Texto livre indicando motivo da opera'#231#227'o'
      end
    end
    object tsLog: TTabSheet
      Caption = 'Log'
      object mmoLogRequest: TMemo
        Left = 0
        Top = 0
        Width = 819
        Height = 225
        Align = alTop
        PopupMenu = pmLog
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object mmoLogResponse: TMemo
        Left = 0
        Top = 225
        Width = 819
        Height = 297
        Align = alClient
        PopupMenu = pmLog
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
  end
  object ACBrOpenDelivery1: TACBrOpenDelivery
    Resources.Authentication = 'license-manager/api/v1/oauth/token'
    Resources.MerchantUpdate = 'merchantUpdate'
    Resources.MerchantStatus = 'merchantStatus'
    Resources.EventPolling = 'orders/api/v1/events:polling'
    Resources.EventAcknowledgment = 'orders/api/v1/events/acknowledgment'
    Resources.OrderDetails = 'orders/api/v1/{orderId}'
    Resources.OrderConfirm = 'orders/api/v1/{orderId}/confirm'
    Resources.OrderReadyForPickup = 'orders/api/v1/{orderId}/readyForPickup'
    Resources.OrderDispatch = 'orders/api/v1/{orderId}/dispatch'
    Resources.OrderRequestCancellation = 'orders/api/v1/{orderId}/requestCancellation'
    Resources.OrderAcceptCancellation = 'orders/api/v1/{orderId}/acceptCancellation'
    Resources.OrderDenyCancellation = 'orders/api/v1/{orderId}/denyCancellation'
    TimeOut = 90000
    OnHTTPEnviar = ACBrOpenDelivery1HTTPEnviar
    OnHTTPRetornar = ACBrOpenDelivery1HTTPRetornar
    OnTokenGet = ACBrOpenDelivery1TokenGet
    OnTokenSave = ACBrOpenDelivery1TokenSave
    Left = 208
  end
  object pmLog: TPopupMenu
    Left = 256
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
  end
end

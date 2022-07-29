object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 552
  ClientWidth = 783
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
    Width = 783
    Height = 552
    ActivePage = tsPolling
    Align = alClient
    TabOrder = 0
    object tsConfig: TTabSheet
      Caption = 'Configura'#231#245'es'
      ImageIndex = 1
      DesignSize = (
        775
        522)
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
        Text = 'aed8c1fc054c46a895cc4926da52f6f8'
      end
      object edtClientSecret: TEdit
        Left = 335
        Top = 93
        Width = 313
        Height = 23
        PasswordChar = '*'
        TabOrder = 1
        Text = '$%ivY@ennlWR'
      end
      object edtBaseUrl: TEdit
        Left = 16
        Top = 37
        Width = 362
        Height = 23
        Anchors = [akLeft, akTop, akRight]
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
      DesignSize = (
        775
        522)
      object Label3: TLabel
        Left = 24
        Top = 24
        Width = 65
        Height = 15
        Caption = 'Merchant ID'
      end
      object edtPollingMerchantId: TEdit
        Left = 24
        Top = 45
        Width = 225
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object btnPollingAddMerchantId: TButton
        Left = 255
        Top = 44
        Width = 130
        Height = 25
        Caption = 'Add MerchantId'
        TabOrder = 1
        OnClick = btnPollingAddMerchantIdClick
      end
      object mmoPolling: TMemo
        Left = 24
        Top = 312
        Width = 617
        Height = 185
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
    end
    object tsLog: TTabSheet
      Caption = 'Log'
      object mmoLogRequest: TMemo
        Left = 0
        Top = 0
        Width = 775
        Height = 225
        Align = alTop
        TabOrder = 0
      end
      object mmoLogResponse: TMemo
        Left = 0
        Top = 225
        Width = 775
        Height = 297
        Align = alClient
        TabOrder = 1
      end
    end
  end
  object ACBrOpenDelivery1: TACBrOpenDelivery
    Resources.Authentication = 'license-manager/api/v1/oauth/token'
    Resources.MerchantUpdate = 'merchantUpdate'
    Resources.MerchantStatus = 'merchantStatus'
    Resources.EventPolling = 'orders/api/v1/events:polling'
    Resources.EventAcknowledgment = 'events/acknowledgment'
    Resources.OrderDetails = 'orders/{orderId}'
    Resources.OrderConfirm = 'orders/{orderId}/confirm'
    Resources.OrderReadyForPickup = 'orders/{orderId}/readyForPickup'
    Resources.OrderDispatch = 'orders/{orderId}/dispatch'
    Resources.OrderRequestCancellation = 'orders/{orderId}/requestCancellation'
    Resources.OrderAcceptCancellation = 'orders/{orderId}/acceptCancellation'
    Resources.OrderDenyCancellation = 'orders/{orderId}/denyCancellation'
    TimeOut = 90000
    OnHTTPEnviar = ACBrOpenDelivery1HTTPEnviar
    OnHTTPRetornar = ACBrOpenDelivery1HTTPRetornar
    OnTokenGet = ACBrOpenDelivery1TokenGet
    OnTokenSave = ACBrOpenDelivery1TokenSave
    Left = 208
  end
end

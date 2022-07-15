object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 268
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object btnInstall: TButton
    Left = 144
    Top = 80
    Width = 137
    Height = 25
    Caption = 'Instalar Servi'#231'o'
    TabOrder = 0
    OnClick = btnInstallClick
  end
  object btnUninstall: TButton
    Left = 144
    Top = 120
    Width = 137
    Height = 25
    Caption = 'Desinstalar Servi'#231'o'
    TabOrder = 1
    OnClick = btnUninstallClick
  end
  object btnStartServer: TButton
    Left = 144
    Top = 160
    Width = 137
    Height = 25
    Caption = 'Iniciar Servi'#231'o'
    TabOrder = 2
    OnClick = btnStartServerClick
  end
  object btnStopServer: TButton
    Left = 144
    Top = 200
    Width = 137
    Height = 25
    Caption = 'Parar Servi'#231'o'
    TabOrder = 3
    OnClick = btnStopServerClick
  end
end

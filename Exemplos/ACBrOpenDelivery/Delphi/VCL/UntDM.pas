unit UntDM;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Datasnap.DBClient;

type
  TDM = class(TDataModule)
    cdsPolling: TClientDataSet;
    dtsPolling: TDataSource;
    cdsPollingeventID: TStringField;
    cdsPollingeventType: TStringField;
    cdsPollingorderID: TStringField;
    cdsPollingorderURL: TStringField;
    cdsPollingcreatedAt: TDateTimeField;
    cdsPollingsourceAppID: TStringField;
    cdsOrder: TClientDataSet;
    dtsOrder: TDataSource;
    cdsOrderuniqueID: TStringField;
    cdsOrderID: TStringField;
    cdsOrdertype: TStringField;
    cdsOrderdisplayID: TStringField;
    cdsOrdercreatedAt: TDateTimeField;
    cdsOrderorderTiming: TStringField;
    cdsOrdermerchantID: TStringField;
    cdsOrdermerchantName: TStringField;
    private
      { Private declarations }
    public
      { Public declarations }
      procedure ResetClientDataSet(AClientDataSet: TClientDataSet);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

procedure TDM.ResetClientDataSet(AClientDataSet: TClientDataSet);
begin
  AClientDataSet.CreateDataSet;
  if not (AClientDataSet.Active) then
    AClientDataSet.Active := True;
  if not (AClientDataSet.IsEmpty) then
    AClientDataSet.EmptyDataSet;
end;

end.

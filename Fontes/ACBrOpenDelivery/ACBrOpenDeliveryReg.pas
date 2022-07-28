{$I ACBr.inc}

unit ACBrOpenDeliveryReg;

interface

uses
  Classes,
  ACBrOpenDelivery;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ACBrOpenDelivery', [TACBrOpenDelivery]);
end;

end.

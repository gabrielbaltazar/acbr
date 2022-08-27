unit ACBrOpenDeliveryEvents;

interface

uses
  ACBrOpenDeliverySchemaClasses;

type
  TACBrOpenDeliveryOnEventStatus = procedure(AEvent: TACBrOpenDeliverySchemaEvent;
    var Ack: Boolean) of object;

  TACBrOpenDeliveryOnEventOrder = procedure(AEvent: TACBrOpenDeliverySchemaEvent;
    AOrder: TACBrOpenDeliverySchemaOrder; var Ack: Boolean) of object;

  TOnTokenGet = procedure(AClientId: string; var AToken: string; var AExpiresAt: TDateTime) of object;
  TOnTokenSave = procedure(AClientId, AToken: string; AExpiresAt: TDateTime) of object;

implementation

end.

unit ACBrOpenDeliverySchemaClassesTest;

{$I ACBr.inc}

interface

uses
  ACBrTests.Util,
  ACBrOpenDeliverySchema,
  ACBrOpenDeliverySchemaClasses,
  ACBrUtil,
  Classes,
  SysUtils;

type
  TTestAddress = class(TTestCase)
  private
    FJSON: String;
    FSchema: TACBrOpenDeliverySchemaAddress;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure AtribuirELerValores;
    procedure AtribuirLerReatribuirEComparar;

  end;

implementation

{ TTestAddress }

procedure TTestAddress.AtribuirLerReatribuirEComparar;
begin
  FSchema.AsJSON := FJSON;
  FJSON := FSchema.AsJSON;
  FreeAndNil(FSchema);

  FSchema := TACBrOpenDeliverySchemaAddress.Create;
  FSchema.AsJSON := FJSON;

  CheckEquals('BR', FSchema.country);
  CheckEquals('BR-SP', FSchema.state);
  CheckEquals('São Paulo', FSchema.city);
  CheckEquals('Moema', FSchema.district);
  CheckEquals('Plaza Avenue', FSchema.street);
  CheckEquals('100', FSchema.number);
  CheckEquals('20111-000', FSchema.postalCode);
  CheckEquals('BL 02 AP 31', FSchema.complement);
  CheckEquals('Yellow House', FSchema.reference);
  CheckEquals('-23,54809', FloatToStr(FSchema.latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.longitude));
end;

procedure TTestAddress.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaAddress.Create;
  FJSON := ACBrStr(
    '{' +
      '"country": "BR",' +
      '"state": "BR-SP",' +
      '"city": "São Paulo",' +
      '"district": "Moema",' +
      '"street": "Plaza Avenue",' +
      '"number": "100",' +
      '"postalCode": "20111-000",' +
      '"complement": "BL 02 AP 31",' +
      '"reference": "Yellow House",' +
      '"latitude": -23.54809,' +
      '"longitude": -46.63638' +
    '}');
end;

procedure TTestAddress.TearDown;
begin
  FSchema.Free;
  inherited;
end;

procedure TTestAddress.AtribuirELerValores;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('BR', FSchema.country);
  CheckEquals('BR-SP', FSchema.state);
  CheckEquals('São Paulo', FSchema.city);
  CheckEquals('Moema', FSchema.district);
  CheckEquals('Plaza Avenue', FSchema.street);
  CheckEquals('100', FSchema.number);
  CheckEquals('20111-000', FSchema.postalCode);
  CheckEquals('BL 02 AP 31', FSchema.complement);
  CheckEquals('Yellow House', FSchema.reference);
  CheckEquals('-23,54809', FloatToStr(FSchema.latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.longitude));
end;

initialization
  _RegisterTest('ACBrOpenDelivery.Schema.Address', TTestAddress);

end.

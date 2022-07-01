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
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaAddress;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJson;
  end;

  TTestImage = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaImage;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestContactPhone = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaContactPhone;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestPrice = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaPrice;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

implementation

{ TTestAddress }

procedure TTestAddress.ObjectToJson;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('BR', FJSONObject.AsString['country']);
  CheckEquals('BR-SP', FJSONObject.AsString['state']);
  CheckEquals('São Paulo', FJSONObject.AsString['city']);
  CheckEquals('Moema', FJSONObject.AsString['district']);
  CheckEquals('Plaza Avenue', FJSONObject.AsString['street']);
  CheckEquals('100', FJSONObject.AsString['number']);
  CheckEquals('20111-000', FJSONObject.AsString['postalCode']);
  CheckEquals('BL 02 AP 31', FJSONObject.AsString['complement']);
  CheckEquals('Yellow House', FJSONObject.AsString['reference']);
  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsFloat['latitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsFloat['longitude']));
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
  FJSONObject.Free;
  inherited;
end;

procedure TTestAddress.JSONToObject;
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

{ TTestContactPhone }

procedure TTestContactPhone.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('1234567', FSchema.whatsappNumber);
  CheckEquals('7654321', FSchema.commercialNumber);
end;

procedure TTestContactPhone.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('1234567', FJSONObject.AsString['whatsappNumber']);
  CheckEquals('7654321', FJSONObject.AsString['commercialNumber']);
end;

procedure TTestContactPhone.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaContactPhone.Create;
  FJSON := ACBrStr(
    '{' +
      '"whatsappNumber": "1234567",' +
      '"commercialNumber": "7654321"' +
    '}');
end;

procedure TTestContactPhone.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestPrice }

procedure TTestPrice.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('15,5', FloatToStr(FSchema.value));
  CheckEquals('BRL', FSchema.currency);
end;

procedure TTestPrice.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('15,5', FloatToStr(FJSONObject.AsFloat['value']));
  CheckEquals('BRL', FJSONObject.AsString['currency']);
end;

procedure TTestPrice.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaPrice.Create;
  FJSON := ACBrStr(
    '{' +
      '"value": 15.5,' +
      '"currency": "BRL"' +
    '}');
end;

procedure TTestPrice.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestImage }

procedure TTestImage.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('https://food-company.com/image.jpg', FSchema.URL);
  CheckEquals('96b41025', FSchema.CRC_32);
end;

procedure TTestImage.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('https://food-company.com/image.jpg', FJSONObject.AsString['URL']);
  CheckEquals('96b41025', FJSONObject.AsString['CRC-32']);
end;

procedure TTestImage.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaImage.Create;
  FJSON := ACBrStr(
    '{' +
      '"URL": "https://food-company.com/image.jpg",' +
      '"CRC-32": "96b41025"' +
    '}');
end;

procedure TTestImage.TearDown;
begin
  inherited;
  FSchema.Free;
  FJSONObject.Free;
end;

initialization
  _RegisterTest('ACBrOpenDelivery.Schema.Address', TTestAddress);
  _RegisterTest('ACBrOpenDelivery.Schema.ContactPhone', TTestContactPhone);
  _RegisterTest('ACBrOpenDelivery.Schema.Image', TTestImage);
  _RegisterTest('ACBrOpenDelivery.Schema.Price', TTestPrice);

end.

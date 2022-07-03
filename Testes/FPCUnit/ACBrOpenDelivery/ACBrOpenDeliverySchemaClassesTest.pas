unit ACBrOpenDeliverySchemaClassesTest;

{$I ACBr.inc}

interface

uses
  ACBrTests.Util,
  ACBrOpenDeliverySchema,
  ACBrOpenDeliverySchemaClasses,
  ACBrUtil,
  pcnConversaoOD,
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

  TTestBasicInfo = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaBasicInfo;

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

  TTestGeoCoordinate = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaGeoCoordinate;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestGeoRadius = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaGeoRadius;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
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

  TTestPolygon = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaPolygon;

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

  TTestRadius = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaRadius;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestServiceArea = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaServiceArea;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestTimePeriod = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaTimePeriod;

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

{ TTestBasicInfo }

procedure TTestBasicInfo.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('Pizza Plaza', FSchema.name);
  CheckEquals('22815773000169', FSchema.document);
  CheckEquals('Food Company', FSchema.corporateName);
  CheckEquals('Food company specializing in pizzas.', FSchema.description);
  CheckEquals('90', FloatToStr(FSchema.averageTicket));
  CheckEquals('20', IntToStr(FSchema.averagePreparationTime));
  CheckEquals('BRL', FSchema.minOrderValue.&currency);
  CheckEquals('40', FloatToStr(FSchema.minOrderValue.value));
  CheckEquals('RESTAURANT', MerchantTypeToStr(FSchema.merchantType));
  CheckEquals(3, Length(FSchema.merchantCategories));
  CheckEquals('PIZZA', MerchantCategoriesToStr(FSchema.merchantCategories[0]));
  CheckEquals('FAMILY_MEALS', MerchantCategoriesToStr(FSchema.merchantCategories[1]));
  CheckEquals('PREMIUM', MerchantCategoriesToStr(FSchema.merchantCategories[2]));
  CheckEquals('BR', FSchema.address.country);
  CheckEquals('BR-SP', FSchema.address.state);
  CheckEquals('São Paulo', FSchema.address.city);
  CheckEquals('Moema', FSchema.address.district);
  CheckEquals('Plaza Avenue', FSchema.address.street);
  CheckEquals('100', FSchema.address.number);
  CheckEquals('20111-000', FSchema.address.postalCode);
  CheckEquals('BL 02 AP 31', FSchema.address.complement);
  CheckEquals('Yellow House', FSchema.address.reference);
  CheckEquals('-23,54809', FloatToStr(FSchema.address.latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.address.longitude));
  CheckEquals(2, Length(FSchema.contactEmails));
  CheckEquals('food@company.com', FSchema.contactEmails[0]);
  CheckEquals('food@acbr.com', FSchema.contactEmails[1]);

  CheckEquals('11999999999', FSchema.contactPhones.commercialNumber);
  CheckEquals('11998888888', FSchema.contactPhones.whatsappNumber);

  CheckEquals('https://food-company.com/image.jpg', FSchema.logoImage.URL);
  CheckEquals('96b41025', FSchema.logoImage.CRC_32);

  CheckEquals('https://food-company.com/image.jpg', FSchema.bannerImage.URL);
  CheckEquals('96b41025', FSchema.bannerImage.CRC_32);

  CheckEquals('2019-08-24 14:15:22', FormatDateTime('yyyy-MM-dd hh:mm:ss', FSchema.createdAt));
end;

procedure TTestBasicInfo.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('Pizza Plaza', FJSONObject.AsString['name']);
  CheckEquals('22815773000169', FJSONObject.AsString['document']);
  CheckEquals('Food Company', FJSONObject.AsString['corporateName']);
  CheckEquals('Food company specializing in pizzas.', FJSONObject.AsString['description']);
  CheckEquals('90', FloatToStr(FJSONObject.AsFloat['averageTicket']));
  CheckEquals('20', IntToStr(FJSONObject.AsInteger['averagePreparationTime']));
  CheckEquals('BRL', FJSONObject.AsJSONContext['minOrderValue'].AsString['currency']);
  CheckEquals('40', FloatToStr(FSchema.minOrderValue.value));
  CheckEquals('RESTAURANT', FJSONObject.AsString['merchantType']);
  CheckEquals(3, FJSONObject.AsJSONArray['merchantCategories'].Count);
  CheckEquals('PIZZA', FJSONObject.AsJSONArray['merchantCategories'].Items[0]);
  CheckEquals('FAMILY_MEALS', FJSONObject.AsJSONArray['merchantCategories'].Items[1]);
  CheckEquals('PREMIUM', FJSONObject.AsJSONArray['merchantCategories'].Items[2]);
  CheckEquals('BR', FJSONObject.AsJSONContext['address'].AsString['country']);
  CheckEquals('BR-SP', FJSONObject.AsJSONContext['address'].AsString['state']);
  CheckEquals('São Paulo', FJSONObject.AsJSONContext['address'].AsString['city']);
  CheckEquals('Moema', FJSONObject.AsJSONContext['address'].AsString['district']);
  CheckEquals('Plaza Avenue', FJSONObject.AsJSONContext['address'].AsString['street']);
  CheckEquals('100', FJSONObject.AsJSONContext['address'].AsString['number']);
  CheckEquals('20111-000', FJSONObject.AsJSONContext['address'].AsString['postalCode']);
  CheckEquals('BL 02 AP 31', FJSONObject.AsJSONContext['address'].AsString['complement']);
  CheckEquals('Yellow House', FJSONObject.AsJSONContext['address'].AsString['reference']);
  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsJSONContext['address'].AsFloat['latitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsJSONContext['address'].AsFloat['longitude']));
  CheckEquals(2, FJSONObject.AsJSONArray['contactEmails'].Count);
  CheckEquals('food@company.com', FJSONObject.AsJSONArray['contactEmails'].Items[0]);
  CheckEquals('food@acbr.com', FJSONObject.AsJSONArray['contactEmails'].Items[1]);

  CheckEquals('11999999999', FJSONObject.AsJSONContext['contactPhones'].AsString['commercialNumber']);
  CheckEquals('11998888888', FJSONObject.AsJSONContext['contactPhones'].AsString['whatsappNumber']);

  CheckEquals('https://food-company.com/image.jpg', FJSONObject.AsJSONContext['logoImage'].AsString['URL']);
  CheckEquals('96b41025', FJSONObject.AsJSONContext['logoImage'].AsString['CRC-32']);

  CheckEquals('https://food-company.com/image.jpg', FJSONObject.AsJSONContext['bannerImage'].AsString['URL']);
  CheckEquals('96b41025', FJSONObject.AsJSONContext['bannerImage'].AsString['CRC-32']);

  CheckEquals('2019-08-24 14:15:22', FormatDateTime('yyyy-MM-dd hh:mm:ss', FJSONObject.AsISODate['createdAt']));
end;

procedure TTestBasicInfo.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaBasicInfo.Create;
  FJSON := ACBrStr(
    '{' +
      '"name": "Pizza Plaza",' +
      '"document": "22815773000169",' +
      '"corporateName": "Food Company",' +
      '"description": "Food company specializing in pizzas.",' +
      '"averageTicket": 90,' +
      '"averagePreparationTime": 20,' +
      '"minOrderValue": {' +
        '"value": 40,' +
        '"currency": "BRL"' +
      '},' +
      '"merchantType": "RESTAURANT",' +
      '"merchantCategories": [' +
        '"PIZZA",' +
        '"FAMILY_MEALS",' +
        '"PREMIUM"' +
      '],' +
      '"address": {' +
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
      '},' +
      '"contactEmails": [' +
        '"food@company.com",' +
        '"food@acbr.com"' +
      '],' +
      '"contactPhones": {' +
        '"commercialNumber": "11999999999",' +
        '"whatsappNumber": "11998888888"' +
      '},' +
      '"logoImage": {' +
        '"URL": "https://food-company.com/image.jpg",' +
        '"CRC-32": "96b41025"' +
      '},' +
      '"bannerImage": {' +
        '"URL": "https://food-company.com/image.jpg",' +
        '"CRC-32": "96b41025"' +
      '},' +
      '"createdAt": "2019-08-24T14:15:22Z"}');
end;

procedure TTestBasicInfo.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestRadius }

procedure TTestRadius.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals(1, FSchema.size);
  CheckEquals(5, FSchema.estimateDeliveryTime);
  CheckEquals('BRL', FSchema.price.currency);
  CheckEquals('50,5', FloatToStr(FSchema.price.value));
end;

procedure TTestRadius.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals(1, FJSONObject.AsInteger['size']);
  CheckEquals(5, FJSONObject.AsInteger['estimateDeliveryTime']);
  CheckEquals('BRL', FJSONObject.AsJSONContext['price'].AsString['currency']);
  CheckEquals('50,5', FloatToStr(FJSONObject.AsJSONContext['price'].AsFloat['value']));
end;

procedure TTestRadius.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaRadius.Create;
  FJSON := ACBrStr(
    '{' +
      '"size": 1,' +
      '"price": {' +
        '"value": 50.5,' +
        '"currency": "BRL"' +
      '},' +
      '"estimateDeliveryTime": 5' +
    '}');
end;

procedure TTestRadius.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestGeoRadius }

procedure TTestGeoRadius.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('-23,54809', FloatToStr(FSchema.geoMidpointLatitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.geoMidpointLongitude));
  CheckEquals(2, FSchema.radius.Count);
  CheckEquals(3, FSchema.radius[0].size);
  CheckEquals('5', FloatToStr(FSchema.radius[0].price.value));
  CheckEquals('BRL', FSchema.radius[0].price.&currency);
  CheckEquals(2, FSchema.radius[0].estimateDeliveryTime);

  CheckEquals(4, FSchema.radius[1].size);
  CheckEquals('6', FloatToStr(FSchema.radius[1].price.value));
  CheckEquals('US$', FSchema.radius[1].price.&currency);
  CheckEquals(8, FSchema.radius[1].estimateDeliveryTime);
end;

procedure TTestGeoRadius.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsFloat['geoMidpointLatitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsFloat['geoMidpointLongitude']));
  CheckEquals(2, FJSONObject.AsJSONArray['radius'].Count);
  CheckEquals(3, FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[0].AsInteger['size']);
  CheckEquals(2, FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[0].AsInteger['estimateDeliveryTime']);
  CheckEquals('BRL', FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[0].AsJSONContext['price'].AsString['currency']);
  CheckEquals(5, FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[0].AsJSONContext['price'].AsInteger['value']);

  CheckEquals(4, FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[1].AsInteger['size']);
  CheckEquals(8, FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[1].AsInteger['estimateDeliveryTime']);
  CheckEquals('US$', FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[1].AsJSONContext['price'].AsString['currency']);
  CheckEquals(6, FJSONObject.AsJSONArray['radius'].ItemAsJSONObject[1].AsJSONContext['price'].AsInteger['value']);
end;

procedure TTestGeoRadius.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaGeoRadius.Create;
  FJSON := ACBrStr(
    '{' +
      '"geoMidpointLatitude": -23.54809,' +
      '"geoMidpointLongitude": -46.63638,' +
      '"radius": [' +
        '{' +
          '"size": 3,' +
          '"price": {' +
            '"value": 5,' +
            '"currency": "BRL"' +
          '},' +
          '"estimateDeliveryTime": 2' +
        '},' +
        '{' +
          '"size": 4,' +
          '"price": {' +
            '"value": 6,' +
            '"currency": "US$"' +
          '},' +
          '"estimateDeliveryTime": 8' +
        '}' +
      ']' +
    '}');
end;

procedure TTestGeoRadius.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestGeoCoordinate }

procedure TTestGeoCoordinate.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('-23,54809', FloatToStr(FSchema.latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.longitude));
end;

procedure TTestGeoCoordinate.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsFloat['latitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsFloat['longitude']));
end;

procedure TTestGeoCoordinate.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaGeoCoordinate.Create;
  FJSON := ACBrStr(
    '{' +
      '"latitude": -23.54809,' +
      '"longitude": -46.63638' +
    '}');
end;

procedure TTestGeoCoordinate.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestPolygon }

procedure TTestPolygon.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals(3, FSchema.estimateDeliveryTime);
  CheckEquals(1, FSchema.geoCoordinates.Count);
  CheckEquals('-23,54809', FloatToStr(FSchema.geoCoordinates[0].latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.geoCoordinates[0].longitude));
  CheckEquals('BRL', FSchema.price.&currency);
  CheckEquals('5', FloatToStr(FSchema.price.value));
end;

procedure TTestPolygon.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals(3, FJSONObject.AsInteger['estimateDeliveryTime']);
  CheckEquals(1, FJSONObject.AsJSONArray['geoCoordinates'].Count);
  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsJSONArray['geoCoordinates'].ItemAsJSONObject[0].AsFloat['latitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsJSONArray['geoCoordinates'].ItemAsJSONObject[0].AsFloat['longitude']));
  CheckEquals('BRL', FJSONObject.AsJSONContext['price'].AsString['currency']);
  CheckEquals('5', FloatToStr(FJSONObject.AsJSONContext['price'].AsFloat['value']));
end;

procedure TTestPolygon.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaPolygon.Create;
  FJSON := ACBrStr(
    '{' +
      '"geoCoordinates": [{' +
        '"latitude": -23.54809,' +
        '"longitude": -46.63638' +
      '}],' +
      '"price": {' +
        '"value": 5,' +
        '"currency": "BRL"' +
      '},' +
        '"estimateDeliveryTime": 3' +
    '}');
end;

procedure TTestPolygon.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestServiceArea }

procedure TTestServiceArea.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('01339e6d-520b-429e-bc7c-dcfd2df42278', FSchema.id);
  CheckEquals(1, FSchema.polygon.Count);
  CheckEquals(3, FSchema.polygon[0].estimateDeliveryTime);
  CheckEquals(1, FSchema.polygon[0].geoCoordinates.Count);
  CheckEquals('-23,54809', FloatToStr(FSchema.polygon[0].geoCoordinates[0].latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.polygon[0].geoCoordinates[0].longitude));
  CheckEquals('BRL', FSchema.polygon[0].price.&currency);
  CheckEquals('5', FloatToStr(FSchema.polygon[0].price.value));

  CheckEquals('-23,54809', FloatToStr(FSchema.geoRadius.geoMidpointLatitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.geoRadius.geoMidpointLongitude));
  CheckEquals(1, FSchema.geoRadius.radius.Count);
  CheckEquals(0, FSchema.geoRadius.radius[0].size);
  CheckEquals('0', FloatToStr(FSchema.geoRadius.radius[0].price.value));
  CheckEquals('', FSchema.geoRadius.radius[0].price.&currency);
  CheckEquals(0, FSchema.geoRadius.radius[0].estimateDeliveryTime);
end;

procedure TTestServiceArea.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('01339e6d-520b-429e-bc7c-dcfd2df42278', FJSONObject.AsString['id']);
  CheckEquals(1, FJSONObject.AsJSONArray['polygon'].Count);

  CheckEquals(3, FJSONObject.AsJSONArray['polygon'].ItemAsJSONObject[0].AsInteger['estimateDeliveryTime']);
  CheckEquals(1, FJSONObject.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONArray['geoCoordinates'].Count);
  CheckEquals('BRL', FJSONObject.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONContext['price'].AsString['currency']);
  CheckEquals('5', FloatToStr(FJSONObject.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONContext['price'].AsFloat['value']));
  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONArray['geoCoordinates'].ItemAsJSONObject[0].AsFloat['latitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONArray['geoCoordinates'].ItemAsJSONObject[0].AsFloat['longitude']));


  CheckEquals('-23,54809', FloatToStr(FJSONObject.AsJSONContext['geoRadius'].AsFloat['geoMidpointLatitude']));
  CheckEquals('-46,63638', FloatToStr(FJSONObject.AsJSONContext['geoRadius'].AsFloat['geoMidpointLongitude']));
  CheckEquals(1, FJSONObject.AsJSONContext['geoRadius'].AsJSONArray['radius'].Count);
  CheckEquals(0, FJSONObject.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsInteger['size']);
  CheckEquals('0', FloatToStr(FJSONObject.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsJSONContext['price'].AsFloat['value']));
  CheckEquals('', FJSONObject.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsJSONContext['price'].AsString['currency']);
  CheckEquals(0, FJSONObject.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsInteger['estimateDeliveryTime']);
end;

procedure TTestServiceArea.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaServiceArea.Create;
  FJSON := ACBrStr(
    '{' +
      '"id": "01339e6d-520b-429e-bc7c-dcfd2df42278",' +
      '"polygon": [{' +
        '"geoCoordinates": [{' +
          '"latitude": -23.54809,' +
          '"longitude": -46.63638' +
        '}],' +
        '"price": {' +
          '"value": 5,' +
          '"currency": "BRL"' +
        '},' +
        '"estimateDeliveryTime": 3' +
      '}],' +
      '"geoRadius": {' +
        '"geoMidpointLatitude": -23.54809,' +
        '"geoMidpointLongitude": -46.63638,' +
        '"radius": [{' +
          '"size": 0,' +
          '"price": {},' +
          '"estimateDeliveryTime": 0' +
        '}]' +
      '}' +
    '}');
end;

procedure TTestServiceArea.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestTimePeriod }

procedure TTestTimePeriod.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('10:01:02', FormatDateTime('hh:mm:ss', FSchema.startTime));
  CheckEquals('18:01:02', FormatDateTime('hh:mm:ss', FSchema.endTime));
end;

procedure TTestTimePeriod.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);
  CheckEquals('10:01:02', FormatDateTime('hh:mm:ss', FSchema.startTime));
  CheckEquals('18:01:02', FormatDateTime('hh:mm:ss', FSchema.endTime));
end;

procedure TTestTimePeriod.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaTimePeriod.Create;
  FJSON := ACBrStr(
    '{' +
      '"startTime": "10:01:02.000Z",' +
      '"endTime": "18:01:02.000Z"' +
    '}');
end;

procedure TTestTimePeriod.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

initialization
  _RegisterTest('ACBrOpenDelivery.Schema.Address', TTestAddress);
  _RegisterTest('ACBrOpenDelivery.Schema.BasicInfo', TTestBasicInfo);
  _RegisterTest('ACBrOpenDelivery.Schema.ContactPhone', TTestContactPhone);
  _RegisterTest('ACBrOpenDelivery.Schema.GeoCordinate', TTestGeoCoordinate);
  _RegisterTest('ACBrOpenDelivery.Schema.GeoRadius', TTestGeoRadius);
  _RegisterTest('ACBrOpenDelivery.Schema.Image', TTestImage);
  _RegisterTest('ACBrOpenDelivery.Schema.Polygon', TTestPolygon);
  _RegisterTest('ACBrOpenDelivery.Schema.Price', TTestPrice);
  _RegisterTest('ACBrOpenDelivery.Schema.Radius', TTestRadius);
  _RegisterTest('ACBrOpenDelivery.Schema.ServiceArea', TTestServiceArea);
  _RegisterTest('ACBrOpenDelivery.Schema.TimePeriod', TTestTimePeriod);
end.

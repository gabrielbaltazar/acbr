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

  TTestAvailability = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaAvailability;

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

  TTestCategory = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaCategory;

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

  TTestHolidayHour = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaHolidayHour;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestHour = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaHour;

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

  TTestItem = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaItem;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestItemOffer = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaItemOffer;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestMenu = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaMenu;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestNutritionalInfo = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaNutritionalInfo;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestOption = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaOption;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure JSONToObject;
    procedure ObjectToJSON;
  end;

  TTestOptionGroup = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaOptionGroup;

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

  TTestService = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaService;

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

  TTestServiceHour = class(TTestCase)
  private
    FJSON: String;
    FJSONObject: TACBrJSONObject;
    FSchema: TACBrOpenDeliverySchemaServiceHour;

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

  CheckEquals('2019-08-24 14:15:22', FormatDateTime('yyyy-MM-dd hh:mm:ss', FJSONObject.AsISODateTime['createdAt']));
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

{ TTestHour }

procedure TTestHour.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals(7, Length(FSchema.dayOfWeek));
  CheckEquals('MONDAY', DayOfWeekToStr(FSchema.dayOfWeek[0]));
  CheckEquals('SUNDAY', DayOfWeekToStr(FSchema.dayOfWeek[6]));
  CheckEquals('10:01:02', FormatDateTime('hh:mm:ss', FSchema.timePeriods.startTime));
  CheckEquals('18:01:02', FormatDateTime('hh:mm:ss', FSchema.timePeriods.endTime));
end;

procedure TTestHour.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);
  CheckEquals(7, FJSONObject.AsJSONArray['dayOfWeek'].Count);
  CheckEquals('MONDAY', FJSONObject.AsJSONArray['dayOfWeek'].Items[0]);
  CheckEquals('SUNDAY', FJSONObject.AsJSONArray['dayOfWeek'].Items[6]);
  CheckEquals('10:01:02', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:01:02', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONContext['timePeriods'].AsISOTime['endTime']));
end;

procedure TTestHour.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaHour.Create;
  FJSON := ACBrStr(
    '{' +
      '"dayOfWeek": [' +
        '"MONDAY",' +
        '"TUESDAY",' +
        '"WEDNESDAY",' +
        '"THURSDAY",' +
        '"FRIDAY",' +
        '"SATURDAY",' +
        '"SUNDAY"' +
      '],' +
      '"timePeriods": {' +
        '"startTime": "10:01:02.000Z",' +
        '"endTime": "18:01:02.000Z"' +
      '}' +
    '}');
end;

procedure TTestHour.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestHolidayHour }

procedure TTestHolidayHour.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('2021-07-04', FormatDateTime('yyyy-MM-dd', FSchema.date));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FSchema.timePeriods.startTime));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FSchema.timePeriods.endTime));
end;

procedure TTestHolidayHour.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);
  CheckEquals('2021-07-04', FormatDateTime('yyyy-MM-dd', FJSONObject.AsISODateTime['date']));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONContext['timePeriods'].AsISOTime['endTime']));
end;

procedure TTestHolidayHour.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaHolidayHour.Create;
  FJSON := ACBrStr(
    '{' +
      '"date": "2021-07-04",' +
      '"timePeriods": {' +
        '"startTime": "10:00:00.000Z",' +
        '"endTime": "18:00:00.000Z"' +
      '}' +
    '}');
end;

procedure TTestHolidayHour.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestServiceHour }

procedure TTestServiceHour.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('fb093d8c-2ca5-40fb-afcf-472fbdae81cc', FSchema.id);
  CheckEquals(1, FSchema.weekHours.Count);
  CheckEquals(2, Length(FSchema.weekHours[0].dayOfWeek));
  CheckEquals('MONDAY', DayOfWeekToStr(FSchema.weekHours[0].dayOfWeek[0]));
  CheckEquals('SUNDAY', DayOfWeekToStr(FSchema.weekHours[0].dayOfWeek[1]));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FSchema.weekHours[0].timePeriods.startTime));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FSchema.weekHours[0].timePeriods.endTime));

  CheckEquals(1, FSchema.holidayHours.Count);
  CheckEquals('2021-07-04', FormatDateTime('yyyy-MM-dd', FSchema.holidayHours[0].date));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FSchema.holidayHours[0].timePeriods.startTime));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FSchema.holidayHours[0].timePeriods.endTime));
end;

procedure TTestServiceHour.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);
  CheckEquals('fb093d8c-2ca5-40fb-afcf-472fbdae81cc', FJSONObject.AsString['id']);
  CheckEquals(1, FJSONObject.AsJSONArray['weekHours'].Count);
  CheckEquals(2, FJSONObject.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Count);
  CheckEquals('MONDAY', FJSONObject.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Items[0]);
  CheckEquals('SUNDAY', FJSONObject.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Items[1]);
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['endTime']));

  CheckEquals(1, FJSONObject.AsJSONArray['holidayHours'].Count);
  CheckEquals('2021-07-04', FormatDateTime('yyyy-MM-dd', FJSONObject.AsJSONArray['holidayHours'].ItemAsJSONObject[0].AsISODate['date']));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONArray['holidayHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONArray['holidayHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['endTime']));
end;

procedure TTestServiceHour.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaServiceHour.Create;
  FJSON := ACBrStr(
    '{' +
      '"id": "fb093d8c-2ca5-40fb-afcf-472fbdae81cc",' +
      '"weekHours": [{' +
        '"dayOfWeek": ["MONDAY", "SUNDAY"],' +
        '"timePeriods": {' +
          '"startTime": "10:00:00.000Z",' +
          '"endTime": "18:00:00.000Z"' +
        '}' +
      '}],' +
      '"holidayHours": [{' +
        '"date": "2021-07-04",' +
        '"timePeriods": {' +
          '"startTime": "10:00:00.000Z",' +
          '"endTime": "18:00:00.000Z"' +
        '}' +
      '}]' +
    '}');
end;

procedure TTestServiceHour.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestService }

procedure TTestService.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('f078e8e2-3044-4eec-b4a8-8359810de123', FSchema.id);
  CheckEquals('AVAILABLE', StatusToStr(FSchema.status));
  CheckEquals('DELIVERY', ServiceTypeToStr(FSchema.serviceType));
  CheckEquals('f627ccdc-6789-456f-a782-148538d5035b', FSchema.menuId);

  CheckEquals('01339e6d-520b-429e-bc7c-dcfd2df42278', FSchema.serviceArea.id);
  CheckEquals(1, FSchema.serviceArea.polygon.Count);
  CheckEquals(1, FSchema.serviceArea.polygon[0].estimateDeliveryTime);
  CheckEquals(1, FSchema.serviceArea.polygon[0].geoCoordinates.Count);
  CheckEquals('-23,54809', FloatToStr(FSchema.serviceArea.polygon[0].geoCoordinates[0].latitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.serviceArea.polygon[0].geoCoordinates[0].longitude));
  CheckEquals('BRL', FSchema.serviceArea.polygon[0].price.&currency);
  CheckEquals('5', FloatToStr(FSchema.serviceArea.polygon[0].price.value));

  CheckEquals('-23,54809', FloatToStr(FSchema.serviceArea.geoRadius.geoMidpointLatitude));
  CheckEquals('-46,63638', FloatToStr(FSchema.serviceArea.geoRadius.geoMidpointLongitude));
  CheckEquals(1, FSchema.serviceArea.geoRadius.radius.Count);
  CheckEquals(1, FSchema.serviceArea.geoRadius.radius[0].size);
  CheckEquals('5', FloatToStr(FSchema.serviceArea.geoRadius.radius[0].price.value));
  CheckEquals('BRL', FSchema.serviceArea.geoRadius.radius[0].price.&currency);
  CheckEquals(1, FSchema.serviceArea.geoRadius.radius[0].estimateDeliveryTime);

  // Service Hours
  CheckEquals('fb093d8c-2ca5-40fb-afcf-472fbdae81cc', FSchema.serviceHours.id);
  CheckEquals(1, FSchema.serviceHours.weekHours.Count);
  CheckEquals(7, Length(FSchema.serviceHours.weekHours[0].dayOfWeek));
  CheckEquals('MONDAY', DayOfWeekToStr(FSchema.serviceHours.weekHours[0].dayOfWeek[0]));
  CheckEquals('TUESDAY', DayOfWeekToStr(FSchema.serviceHours.weekHours[0].dayOfWeek[1]));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FSchema.serviceHours.weekHours[0].timePeriods.startTime));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FSchema.serviceHours.weekHours[0].timePeriods.endTime));

  CheckEquals(1, FSchema.serviceHours.holidayHours.Count);
  CheckEquals('2021-04-07', FormatDateTime('yyyy-MM-dd', FSchema.serviceHours.holidayHours[0].date));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FSchema.serviceHours.holidayHours[0].timePeriods.startTime));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FSchema.serviceHours.holidayHours[0].timePeriods.endTime));
end;

procedure TTestService.ObjectToJSON;
var
  LJSON: TACBrJSONObject;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('f078e8e2-3044-4eec-b4a8-8359810de123', FJSONObject.AsString['id']);
  CheckEquals('AVAILABLE', FJSONObject.AsString['status']);
  CheckEquals('DELIVERY', FJSONObject.AsString['serviceType']);
  CheckEquals('f627ccdc-6789-456f-a782-148538d5035b', FJSONObject.AsString['menuId']);

  // Service Area
  LJSON := FJSONObject.AsJSONContext['serviceArea'];
  CheckEquals('01339e6d-520b-429e-bc7c-dcfd2df42278', LJSON.AsString['id']);
  CheckEquals(1, LJSON.AsJSONArray['polygon'].Count);

  CheckEquals(1, LJSON.AsJSONArray['polygon'].ItemAsJSONObject[0].AsInteger['estimateDeliveryTime']);
  CheckEquals(1, LJSON.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONArray['geoCoordinates'].Count);
  CheckEquals('BRL', LJSON.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONContext['price'].AsString['currency']);
  CheckEquals('5', FloatToStr(LJSON.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONContext['price'].AsFloat['value']));
  CheckEquals('-23,54809', FloatToStr(LJSON.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONArray['geoCoordinates'].ItemAsJSONObject[0].AsFloat['latitude']));
  CheckEquals('-46,63638', FloatToStr(LJSON.AsJSONArray['polygon'].ItemAsJSONObject[0].AsJSONArray['geoCoordinates'].ItemAsJSONObject[0].AsFloat['longitude']));

  CheckEquals('-23,54809', FloatToStr(LJSON.AsJSONContext['geoRadius'].AsFloat['geoMidpointLatitude']));
  CheckEquals('-46,63638', FloatToStr(LJSON.AsJSONContext['geoRadius'].AsFloat['geoMidpointLongitude']));
  CheckEquals(1, LJSON.AsJSONContext['geoRadius'].AsJSONArray['radius'].Count);
  CheckEquals(1, LJSON.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsInteger['size']);
  CheckEquals('5', FloatToStr(LJSON.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsJSONContext['price'].AsFloat['value']));
  CheckEquals('BRL', LJSON.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsJSONContext['price'].AsString['currency']);
  CheckEquals(1, LJSON.AsJSONContext['geoRadius'].AsJSONArray['radius'].ItemAsJSONObject[0].AsInteger['estimateDeliveryTime']);

  // Service Hours
  LJSON := FJSONObject.AsJSONContext['serviceHours'];
  CheckEquals('fb093d8c-2ca5-40fb-afcf-472fbdae81cc', LJSON.AsString['id']);
  CheckEquals(1, LJSON.AsJSONArray['weekHours'].Count);
  CheckEquals(7, LJSON.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Count);
  CheckEquals('MONDAY', LJSON.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Items[0]);
  CheckEquals('TUESDAY', LJSON.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Items[1]);
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', LJSON.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', LJSON.AsJSONArray['weekHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['endTime']));

  CheckEquals(1, LJSON.AsJSONArray['holidayHours'].Count);
  CheckEquals('2021-04-07', FormatDateTime('yyyy-MM-dd', LJSON.AsJSONArray['holidayHours'].ItemAsJSONObject[0].AsISODate['date']));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', LJSON.AsJSONArray['holidayHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', LJSON.AsJSONArray['holidayHours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['endTime']));
end;

procedure TTestService.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaService.Create;
  FJSON := ACBrStr(
    '{' +
    '    "id": "f078e8e2-3044-4eec-b4a8-8359810de123",' +
    '    "status": "AVAILABLE",' +
    '    "serviceType": "DELIVERY",' +
    '    "menuId": "f627ccdc-6789-456f-a782-148538d5035b",' +
    '    "serviceArea": {' +
    '        "id": "01339e6d-520b-429e-bc7c-dcfd2df42278",' +
    '        "polygon": [{' +
    '                "geoCoordinates": [{' +
    '                        "latitude": -23.54809,' +
    '                        "longitude": -46.63638' +
    '                    }' +
    '                ],' +
    '                "price": {' +
    '                    "value": 5,' +
    '                    "currency": "BRL"' +
    '                },' +
    '                "estimateDeliveryTime": 1' +
    '            }' +
    '        ],' +
    '        "geoRadius": {' +
    '            "geoMidpointLatitude": -23.54809,' +
    '            "geoMidpointLongitude": -46.63638,' +
    '            "radius": [{' +
    '                    "size": 1,' +
    '                    "price": {' +
    '                        "value": 5,' +
    '                        "currency": "BRL"' +
    '                    },' +
    '                    "estimateDeliveryTime": 1' +
    '                }' +
    '            ]' +
    '        }' +
    '    },' +
    '    "serviceHours": {' +
    '        "id": "fb093d8c-2ca5-40fb-afcf-472fbdae81cc",' +
    '        "weekHours": [{' +
    '                "dayOfWeek": [' +
    '                    "MONDAY",' +
    '                    "TUESDAY",' +
    '                    "WEDNESDAY",' +
    '                    "THURSDAY",' +
    '                    "FRIDAY",' +
    '                    "SATURDAY",' +
    '                    "SUNDAY"' +
    '                ],' +
    '                "timePeriods": {' +
    '                    "startTime": "10:00:00.000Z",' +
    '                    "endTime": "18:00:00.000Z"' +
    '                }' +
    '            }' +
    '        ],' +
    '        "holidayHours": [{' +
    '                "date": "2021-04-07",' +
    '                "timePeriods": {' +
    '                    "startTime": "10:00:00.000Z",' +
    '                    "endTime": "18:00:00.000Z"' +
    '                }' +
    '            }' +
    '        ]' +
    '    }' +
    '}');
end;

procedure TTestService.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestMenu }

procedure TTestMenu.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('f627ccdc-6789-456f-a782-148538d5035b', FSchema.id);
  CheckEquals('Pizzas', FSchema.name);
  CheckEquals('Pizza menu', FSchema.description);
  CheckEquals('123', FSchema.externalCode);
  CheckEquals('Lorem Ipsum is simply dummy text of the printing and typesetting industry.', FSchema.disclaimer);
  CheckEquals('http://example.com', FSchema.disclaimerUrl);
  CheckEquals(2, Length(FSchema.categoryId));
  CheckEquals('92fad022-2c28-4239-a026-989f5b555cb7', FSchema.categoryId[0]);
  CheckEquals('6bb71850-1d40-49f9-8046-b13e068c0cca', FSchema.categoryId[1]);
end;

procedure TTestMenu.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('f627ccdc-6789-456f-a782-148538d5035b', FJSONObject.AsString['id']);
  CheckEquals('Pizzas', FJSONObject.AsString['name']);
  CheckEquals('Pizza menu', FJSONObject.AsString['description']);
  CheckEquals('123', FJSONObject.AsString['externalCode']);
  CheckEquals('Lorem Ipsum is simply dummy text of the printing and typesetting industry.', FJSONObject.AsString['disclaimer']);
  CheckEquals('http://example.com', FJSONObject.AsString['disclaimerUrl']);
  CheckEquals(2, FJSONObject.AsJSONArray['categoryId'].Count);
  CheckEquals('92fad022-2c28-4239-a026-989f5b555cb7', FJSONObject.AsJSONArray['categoryId'].Items[0]);
  CheckEquals('6bb71850-1d40-49f9-8046-b13e068c0cca', FJSONObject.AsJSONArray['categoryId'].Items[1]);
end;

procedure TTestMenu.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaMenu.Create;
  FJSON := ACBrStr(
    '{' +
    '    "id": "f627ccdc-6789-456f-a782-148538d5035b",' +
    '    "name": "Pizzas",' +
    '    "description": "Pizza menu",' +
    '    "externalCode": "123",' +
    '    "disclaimer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",' +
    '    "disclaimerURL": "http://example.com",' +
    '    "categoryId": [' +
    '        "92fad022-2c28-4239-a026-989f5b555cb7",' +
    '        "6bb71850-1d40-49f9-8046-b13e068c0cca"' +
    '    ]' +
    '}');
end;

procedure TTestMenu.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestCategory }

procedure TTestCategory.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('92fad022-2c28-4239-a026-989f5b555cb7', FSchema.id);
  CheckEquals(2, FSchema.index);
  CheckEquals('Salted Pizza', FSchema.name);
  CheckEquals('Salted pizza flavors.', FSchema.description);
  CheckEquals('13', FSchema.externalCode);
  CheckEquals('AVAILABLE', StatusToStr(FSchema.status));
  CheckEquals('https://food-company.com/category1.png', FSchema.image.URL);
  CheckEquals('09345UIHF98', FSchema.image.CRC_32);
  CheckEquals(1, Length(FSchema.availabilityId));
  CheckEquals(1, Length(FSchema.itemOfferId));
  CheckEquals('11d063c4-73a7-4f87-a0eb-71636cc02029', FSchema.availabilityId[0]);
  CheckEquals('f080cfb3-5c4a-4eb7-907d-2de3bbb5dfb9', FSchema.itemOfferId[0]);
end;

procedure TTestCategory.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('92fad022-2c28-4239-a026-989f5b555cb7', FJSONObject.AsString['id']);
  CheckEquals(2, FJSONObject.AsInteger['index']);
  CheckEquals('Salted Pizza', FJSONObject.AsString['name']);
  CheckEquals('Salted pizza flavors.', FJSONObject.AsString['description']);
  CheckEquals('13', FJSONObject.AsString['externalCode']);
  CheckEquals('AVAILABLE', FJSONObject.AsString['status']);
  CheckEquals('https://food-company.com/category1.png', FJSONObject.AsJSONContext['image'].AsString['URL']);
  CheckEquals('09345UIHF98', FJSONObject.AsJSONContext['image'].AsString['CRC-32']);
  CheckEquals(1, FJSONObject.AsJSONArray['availabilityId'].Count);
  CheckEquals(1, FJSONObject.AsJSONArray['itemOfferId'].Count);
  CheckEquals('11d063c4-73a7-4f87-a0eb-71636cc02029', FJSONObject.AsJSONArray['availabilityId'].Items[0]);
  CheckEquals('f080cfb3-5c4a-4eb7-907d-2de3bbb5dfb9', FJSONObject.AsJSONArray['itemOfferId'].Items[0]);
end;

procedure TTestCategory.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaCategory.Create;
  FJSON := ACBrStr(
    '{' +
    '    "id": "92fad022-2c28-4239-a026-989f5b555cb7",' +
    '    "index": 2,' +
    '    "name": "Salted Pizza",' +
    '    "description": "Salted pizza flavors.",' +
    '    "image": {' +
    '        "URL": "https://food-company.com/category1.png",' +
    '        "CRC-32": "09345UIHF98"' +
    '    },' +
    '    "externalCode": "13",' +
    '    "status": "AVAILABLE",' +
    '    "availabilityId": [' +
    '        "11d063c4-73a7-4f87-a0eb-71636cc02029"' +
    '    ],' +
    '    "itemOfferId": [' +
    '        "f080cfb3-5c4a-4eb7-907d-2de3bbb5dfb9"' +
    '    ]' +
    '}');
end;

procedure TTestCategory.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestItemOffer }

procedure TTestItemOffer.JSONToObject;
begin
  FSchema.AsJSON := FJSON;

  CheckEquals('f080cfb3-5c4a-4eb7-907d-2de3bbb5dfb9', FSchema.id);
  CheckEquals('732bd31e-77fc-47ee-88ee-a0437f97b198', FSchema.itemId);
  CheckEquals(1, FSchema.index);
  CheckEquals('43', FloatToStr(FSchema.price.value));
  CheckEquals('BRL', FSchema.price.&currency);
  CheckEquals(1, Length(FSchema.availabilityId));
  CheckEquals(1, Length(FSchema.optionGroupsId));
  CheckEquals('11d063c4-73a7-4f87-a0eb-71636cc02029', FSchema.availabilityId[0]);
  CheckEquals('fe67e551-f42f-499a-8afb-0ed893c71fa3', FSchema.optionGroupsId[0]);
end;

procedure TTestItemOffer.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('f080cfb3-5c4a-4eb7-907d-2de3bbb5dfb9', FJSONObject.AsString['id']);
  CheckEquals('732bd31e-77fc-47ee-88ee-a0437f97b198', FJSONObject.AsString['itemId']);
  CheckEquals(1, FJSONObject.AsInteger['index']);
  CheckEquals('43', FloatToStr(FJSONObject.AsJSONContext['price'].AsFloat['value']));
  CheckEquals('BRL', FJSONObject.AsJSONContext['price'].AsString['currency']);
  CheckEquals(1, FJSONObject.AsJSONArray['availabilityId'].Count);
  CheckEquals(1, FJSONObject.AsJSONArray['optionGroupsId'].Count);
  CheckEquals('11d063c4-73a7-4f87-a0eb-71636cc02029', FJSONObject.AsJSONArray['availabilityId'].Items[0]);
  CheckEquals('fe67e551-f42f-499a-8afb-0ed893c71fa3', FJSONObject.AsJSONArray['optionGroupsId'].Items[0]);
end;

procedure TTestItemOffer.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaItemOffer.Create;
  FJSON := ACBrStr(
    '{' +
    '    "id": "f080cfb3-5c4a-4eb7-907d-2de3bbb5dfb9",' +
    '    "itemId": "732bd31e-77fc-47ee-88ee-a0437f97b198",' +
    '    "index": 1,' +
    '    "price": {' +
    '        "value": 43,' +
    '        "originalValue": 43,' +
    '        "currency": "BRL"' +
    '    },' +
    '    "availabilityId": [' +
    '        "11d063c4-73a7-4f87-a0eb-71636cc02029"' +
    '    ],' +
    '    "optionGroupsId": [' +
    '        "fe67e551-f42f-499a-8afb-0ed893c71fa3"' +
    '    ]' +
    '}');
end;

procedure TTestItemOffer.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestNutritionalInfo }

procedure TTestNutritionalInfo.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('Contains preservatives', FSchema.description);
  CheckEquals('2000 Cal', FSchema.calories);
  CheckEquals(1, Length(FSchema.allergen));
  CheckEquals(1, Length(FSchema.additives));
  CheckEquals(1, Length(FSchema.suitableDiet));
  CheckEquals('GLUTEN', AllergenToStr(FSchema.allergen[0]));
  CheckEquals('teste', FSchema.additives[0]);
  CheckEquals('GLUTEN_FREE', SuitableDietToStr(FSchema.suitableDiet[0]));
  CheckFalse(FSchema.isAlcoholic);
end;

procedure TTestNutritionalInfo.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('Contains preservatives', FJSONObject.AsString['description']);
  CheckEquals('2000 Cal', FJSONObject.AsString['calories']);
  CheckEquals(1, FJSONObject.AsJSONArray['allergen'].Count);
  CheckEquals(1, FJSONObject.AsJSONArray['additives'].Count);
  CheckEquals(1, FJSONObject.AsJSONArray['suitableDiet'].Count);
  CheckEquals('GLUTEN', FJSONObject.AsJSONArray['allergen'].Items[0]);
  CheckEquals('teste', FJSONObject.AsJSONArray['additives'].Items[0]);
  CheckEquals('GLUTEN_FREE', FJSONObject.AsJSONArray['suitableDiet'].Items[0]);
  CheckFalse(FSchema.isAlcoholic);
end;

procedure TTestNutritionalInfo.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaNutritionalInfo.Create;
  FJSON := ACBrStr(
    '{' +
      '"description": "Contains preservatives",' +
      '"calories": "2000 Cal",' +
      '"allergen": [' +
      ' "GLUTEN"' +
      '],' +
      '"additives": [' +
      ' "teste"' +
      '],' +
      '"suitableDiet": [' +
      ' "GLUTEN_FREE"' +
      ']' +
    '}');
end;

procedure TTestNutritionalInfo.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestItem }

procedure TTestItem.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('7e507cab-7235-4f75-a0c2-e955fb2f2048', FSchema.id);
  CheckEquals('1/2 Mozzarella', FSchema.name);
  CheckEquals('Delicious mozzarella pizza.', FSchema.description);
  CheckEquals('24', FSchema.externalCode);
  CheckEquals('unit', FSchema.&unit);
  CheckEquals('https://www.food-place.com/images/mozzarella.png', FSchema.image.URL);
  CheckEquals('09345UIHF98', FSchema.image.CRC_32);
  CheckEquals('Contains preservatives', FSchema.nutritionalInfo.description);
  CheckEquals('2500 Cal', FSchema.nutritionalInfo.calories);
end;

procedure TTestItem.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('7e507cab-7235-4f75-a0c2-e955fb2f2048', FJSONObject.AsString['id']);
  CheckEquals('1/2 Mozzarella', FJSONObject.AsString['name']);
  CheckEquals('Delicious mozzarella pizza.', FJSONObject.AsString['description']);
  CheckEquals('24', FJSONObject.AsString['externalCode']);
  CheckEquals('unit', FJSONObject.AsString['unit']);
  CheckEquals('09345UIHF98', FJSONObject.AsJSONContext['image'].AsString['CRC-32']);
  CheckEquals('https://www.food-place.com/images/mozzarella.png', FJSONObject.AsJSONContext['image'].AsString['URL']);
  CheckEquals('Contains preservatives', FJSONObject.AsJSONContext['nutritionalInfo'].AsString['description']);
  CheckEquals('2500 Cal', FJSONObject.AsJSONContext['nutritionalInfo'].AsString['calories']);
end;

procedure TTestItem.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaItem.Create;
  FJSON := ACBrStr(
    '{' +
      '"id": "7e507cab-7235-4f75-a0c2-e955fb2f2048",' +
      '"name": "1/2 Mozzarella",' +
      '"description": "Delicious mozzarella pizza.",' +
      '"externalCode": "24",' +
      '"image": {' +
        '"URL": "https://www.food-place.com/images/mozzarella.png",' +
        '"CRC-32": "09345UIHF98"' +
      '},' +
      '"nutritionalInfo": {' +
        '"description": "Contains preservatives",' +
        '"calories": "2500 Cal",' +
        '"allergen": [' +
          '"GLUTEN",' +
          '"LACTOSE"' +
        ']' +
      '},' +
      '"unit": "unit"' +
    '}');
end;

procedure TTestItem.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestOption }

procedure TTestOption.JSONToObject;
begin
  FSchema.AsJSON := FJSON;
  CheckEquals('e5232f14-430c-4a94-8ff6-289d5a16a87b', FSchema.id);
  CheckEquals('7e507cab-7235-4f75-a0c2-e955fb2f2048', FSchema.itemId);
  CheckEquals(1, FSchema.index);
  CheckEquals('43', FloatToStr(FSchema.price.value));
  CheckEquals('BRL', FSchema.price.&currency);
  CheckEquals(1, FSchema.maxPermitted);
end;

procedure TTestOption.ObjectToJSON;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FJSON);

  CheckEquals('e5232f14-430c-4a94-8ff6-289d5a16a87b', FJSONObject.AsString['id']);
  CheckEquals('7e507cab-7235-4f75-a0c2-e955fb2f2048', FJSONObject.AsString['itemId']);
  CheckEquals(1, FJSONObject.AsInteger['index']);
  CheckEquals('43', FloatToStr(FJSONObject.AsJSONContext['price'].AsFloat['value']));
  CheckEquals('BRL', FJSONObject.AsJSONContext['price'].AsString['currency']);
  CheckEquals(1, FJSONObject.AsInteger['maxPermitted']);
end;

procedure TTestOption.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaOption.Create;
  FJSON := ACBrStr(
    '{' +
      '"id": "e5232f14-430c-4a94-8ff6-289d5a16a87b",' +
      '"itemId": "7e507cab-7235-4f75-a0c2-e955fb2f2048",' +
      '"index": 1,' +
      '"price": {' +
        '"value": 43,' +
        '"originalValue": 43,' +
        '"currency": "BRL"' +
      '},' +
      '"maxPermitted": 1' +
    '}');
end;

procedure TTestOption.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;

end;

{ TTestOptionGroup }

procedure TTestOptionGroup.JSONToObject;
begin
  FSchema.AsJSON := FJSON;

  CheckEquals('fe67e551-f42f-499a-8afb-0ed893c71fa3', FSchema.id);
  CheckEquals(0, FSchema.index);
  CheckEquals('Choose your salted pizza flavor', FSchema.name);
  CheckEquals('Choose your salted pizza flavor.', FSchema.description);
  CheckEquals('12', FSchema.externalCode);
  CheckEquals('AVAILABLE', StatusToStr(FSchema.status));
  CheckEquals(2, FSchema.minPermitted);
  CheckEquals(2, FSchema.maxPermitted);
  CheckEquals(2, FSchema.options.Count);
  CheckEquals('e5232f14-430c-4a94-8ff6-289d5a16a87a', FSchema.options[0].id);
  CheckEquals('502ecf11-0509-48ed-b63c-6211c48fd9b9', FSchema.options[0].itemId);
  CheckEquals(0, FSchema.options[0].index);
  CheckEquals('50', FloatToStr(FSchema.options[0].price.value));
  CheckEquals('BRL', FSchema.options[0].price.&currency);
  CheckEquals(1, FSchema.options[0].maxPermitted);

  CheckEquals('e5232f14-430c-4a94-8ff6-289d5a16a87b', FSchema.options[1].id);
  CheckEquals('7e507cab-7235-4f75-a0c2-e955fb2f2048', FSchema.options[1].itemId);
  CheckEquals(1, FSchema.options[1].index);
  CheckEquals('43', FloatToStr(FSchema.options[1].price.value));
  CheckEquals('BRL', FSchema.options[1].price.&currency);
  CheckEquals(1, FSchema.options[1].maxPermitted);
end;

procedure TTestOptionGroup.ObjectToJSON;
var
  LJSONObject: TACBrJSONObject;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('fe67e551-f42f-499a-8afb-0ed893c71fa3', FJSONObject.AsString['id']);
  CheckEquals(0, FJSONObject.AsInteger['index']);
  CheckEquals('Choose your salted pizza flavor', FJSONObject.AsString['name']);
  CheckEquals('Choose your salted pizza flavor.', FJSONObject.AsString['description']);
  CheckEquals('12', FJSONObject.AsString['externalCode']);
  CheckEquals('AVAILABLE', FJSONObject.AsString['status']);
  CheckEquals(2, FJSONObject.AsInteger['minPermitted']);
  CheckEquals(2, FJSONObject.AsInteger['maxPermitted']);
  CheckEquals(2, FJSONObject.AsJSONArray['options'].Count);

  LJSONObject := FJSONObject.AsJSONArray['options'].ItemAsJSONObject[0];
  CheckEquals('e5232f14-430c-4a94-8ff6-289d5a16a87a', LJSONObject.AsString['id']);
  CheckEquals('502ecf11-0509-48ed-b63c-6211c48fd9b9', LJSONObject.AsString['itemId']);
  CheckEquals(0, LJSONObject.AsInteger['index']);
  CheckEquals('50', FloatToStr(LJSONObject.AsJSONContext['price'].AsFloat['value']));
  CheckEquals('BRL', LJSONObject.AsJSONContext['price'].AsString['currency']);
  CheckEquals(1, LJSONObject.AsInteger['maxPermitted']);

  LJSONObject := FJSONObject.AsJSONArray['options'].ItemAsJSONObject[1];
  CheckEquals('e5232f14-430c-4a94-8ff6-289d5a16a87b', LJSONObject.AsString['id']);
  CheckEquals('7e507cab-7235-4f75-a0c2-e955fb2f2048', LJSONObject.AsString['itemId']);
  CheckEquals(1, LJSONObject.AsInteger['index']);
  CheckEquals('43', FloatToStr(LJSONObject.AsJSONContext['price'].AsFloat['value']));
  CheckEquals('BRL', LJSONObject.AsJSONContext['price'].AsString['currency']);
  CheckEquals(1, LJSONObject.AsInteger['maxPermitted']);
end;

procedure TTestOptionGroup.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaOptionGroup.Create;
  FJSON := ACBrStr(
    '{' +
      '"id": "fe67e551-f42f-499a-8afb-0ed893c71fa3",' +
      '"index": 0,' +
      '"name": "Choose your salted pizza flavor",' +
      '"description": "Choose your salted pizza flavor.",' +
      '"externalCode": "12",' +
      '"status": "AVAILABLE",' +
      '"minPermitted": 2,' +
      '"maxPermitted": 2,' +
      '"options": [{' +
        '"id": "e5232f14-430c-4a94-8ff6-289d5a16a87a",' +
        '"itemId": "502ecf11-0509-48ed-b63c-6211c48fd9b9",' +
        '"index": 0,' +
        '"price": {' +
          '"value": 50,' +
          '"originalValue": 50,' +
          '"currency": "BRL"' +
        '},' +
        '"maxPermitted": 1' +
      '},' +
      '{' +
        '"id": "e5232f14-430c-4a94-8ff6-289d5a16a87b",' +
        '"itemId": "7e507cab-7235-4f75-a0c2-e955fb2f2048",' +
        '"index": 1,' +
        '"price": {' +
          '"value": 43,' +
          '"originalValue": 43,' +
          '"currency": "BRL"' +
        '},' +
        '"maxPermitted": 1' +
      '}]' +
    '}');
end;

procedure TTestOptionGroup.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

{ TTestAvailability }

procedure TTestAvailability.JSONToObject;
begin
  FSchema.AsJSON := FJSON;

  CheckEquals('11d063c4-73a7-4f87-a0eb-71636cc02029', FSchema.id);
  CheckEquals('2021-05-01', FormatDateTime('yyyy-MM-dd', FSchema.startDate));
  CheckEquals('2021-05-30', FormatDateTime('yyyy-MM-dd', FSchema.endDate));
  CheckEquals(1, FSchema.hours.Count);
  CheckEquals(7, Length(FSchema.hours[0].dayOfWeek));
  CheckEquals('MONDAY', DayOfWeekToStr(FSchema.hours[0].dayOfWeek[0]));
  CheckEquals('SUNDAY', DayOfWeekToStr(FSchema.hours[0].dayOfWeek[6]));
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FSchema.hours[0].timePeriods.startTime));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FSchema.hours[0].timePeriods.endTime));
end;

procedure TTestAvailability.ObjectToJson;
begin
  FSchema.AsJSON := FJSON;
  FJSONObject := TACBrJSONObject.Parse(FSchema.AsJSON);

  CheckEquals('11d063c4-73a7-4f87-a0eb-71636cc02029', FJSONObject.AsString['id']);
  CheckEquals('2021-05-01', FormatDateTime('yyyy-MM-dd', FJSONObject.AsISODate['startDate']));
  CheckEquals('2021-05-30', FormatDateTime('yyyy-MM-dd', FJSONObject.AsISODate['endDate']));
  CheckEquals(1, FJSONObject.AsJSONArray['hours'].Count);
  CheckEquals(7, FJSONObject.AsJSONArray['hours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Count);
  CheckEquals('MONDAY', FJSONObject.AsJSONArray['hours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Items[0]);
  CheckEquals('SUNDAY', FJSONObject.AsJSONArray['hours'].ItemAsJSONObject[0].AsJSONArray['dayOfWeek'].Items[6]);
  CheckEquals('10:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONArray['hours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['startTime']));
  CheckEquals('18:00:00', FormatDateTime('hh:mm:ss', FJSONObject.AsJSONArray['hours'].ItemAsJSONObject[0].AsJSONContext['timePeriods'].AsISOTime['endTime']));

end;

procedure TTestAvailability.SetUp;
begin
  inherited;
  FSchema := TACBrOpenDeliverySchemaAvailability.Create;
  FJSON := ACBrStr(
    '{' +
    '  "id": "11d063c4-73a7-4f87-a0eb-71636cc02029",' +
    '  "startDate": "2021-05-01", ' +
    '  "endDate": "2021-05-30",' +
    '  "hours": [' +
    '    {' +
    '      "dayOfWeek": [' +
    '        "MONDAY",' +
    '        "TUESDAY",' +
    '        "WEDNESDAY",' +
    '        "THURSDAY",' +
    '        "FRIDAY",' +
    '        "SATURDAY",' +
    '        "SUNDAY"' +
    '      ],' +
    '      "timePeriods": {' +
    '        "startTime": "10:00:00.000Z",' +
    '        "endTime": "18:00:00.000Z"' +
    '      }' +
    '    }' +
    '  ]' +
    '}');
end;

procedure TTestAvailability.TearDown;
begin
  FSchema.Free;
  FJSONObject.Free;
  inherited;
end;

initialization
  _RegisterTest('ACBrOpenDelivery.Schema.Address', TTestAddress);
  _RegisterTest('ACBrOpenDelivery.Schema.Availability', TTestAvailability);
  _RegisterTest('ACBrOpenDelivery.Schema.BasicInfo', TTestBasicInfo);
  _RegisterTest('ACBrOpenDelivery.Schema.Category', TTestCategory);
  _RegisterTest('ACBrOpenDelivery.Schema.ContactPhone', TTestContactPhone);
  _RegisterTest('ACBrOpenDelivery.Schema.GeoCordinate', TTestGeoCoordinate);
  _RegisterTest('ACBrOpenDelivery.Schema.GeoRadius', TTestGeoRadius);
  _RegisterTest('ACBrOpenDelivery.Schema.HolidayHour', TTestHolidayHour);
  _RegisterTest('ACBrOpenDelivery.Schema.Hour', TTestHour);
  _RegisterTest('ACBrOpenDelivery.Schema.Image', TTestImage);
  _RegisterTest('ACBrOpenDelivery.Schema.Item', TTestItem);
  _RegisterTest('ACBrOpenDelivery.Schema.ItemOffer', TTestItemOffer);
  _RegisterTest('ACBrOpenDelivery.Schema.Menu', TTestMenu);
  _RegisterTest('ACBrOpenDelivery.Schema.NutritionalInfo', TTestNutritionalInfo);
  _RegisterTest('ACBrOpenDelivery.Schema.Option', TTestOption);
  _RegisterTest('ACBrOpenDelivery.Schema.OptionGroup', TTestOptionGroup);
  _RegisterTest('ACBrOpenDelivery.Schema.Polygon', TTestPolygon);
  _RegisterTest('ACBrOpenDelivery.Schema.Price', TTestPrice);
  _RegisterTest('ACBrOpenDelivery.Schema.Radius', TTestRadius);
  _RegisterTest('ACBrOpenDelivery.Schema.Service', TTestService);
  _RegisterTest('ACBrOpenDelivery.Schema.ServiceArea', TTestServiceArea);
  _RegisterTest('ACBrOpenDelivery.Schema.ServiceHour', TTestServiceHour);
  _RegisterTest('ACBrOpenDelivery.Schema.TimePeriod', TTestTimePeriod);
end.

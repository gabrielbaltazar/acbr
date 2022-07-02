unit ACBrOpenDeliverySchemaClasses;

interface

uses
  ACBrOpenDeliverySchema,
  ACBrBase,
  ACBrJSON,
  ACBrUtil.Strings,
  pcnConversaoOD,
  SysUtils;

type
  TACBrOpenDeliverySchemaAddress = class;
  TACBrOpenDeliverySchemaBasicInfo = class;
  TACBrOpenDeliverySchemaContactPhone = class;
  TACBrOpenDeliverySchemaImage = class;
  TACBrOpenDeliverySchemaPrice = class;
  TACBrOpenDeliverySchemaRadiusCollection = class;

  TACBrOpenDeliverySchemaAddress = class(TACBrOpenDeliverySchema)
  private
    Fdistrict: string;
    Flatitude: Double;
    Fstreet: String;
    FpostalCode: String;
    Fstate: String;
    Fcomplement: String;
    Fnumber: String;
    Fcountry: String;
    Fcity: String;
    Freference: String;
    Flongitude: Double;

  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property country: String read Fcountry write Fcountry;
    property state: String read Fstate write Fstate;
    property city: String read Fcity write Fcity;
    property district: string read Fdistrict write Fdistrict;
    property street: String read Fstreet write Fstreet;
    property number: String read Fnumber write Fnumber;
    property postalCode: String read FpostalCode write FpostalCode;
    property complement: String read Fcomplement write Fcomplement;
    property reference: String read Freference write Freference;
    property latitude: Double read Flatitude write Flatitude;
    property longitude: Double read Flongitude write Flongitude;
  end;

  TACBrOpenDeliverySchemaBasicInfo = class(TACBrOpenDeliverySchema)
  private
    Fname: String;
    Fdocument: String;
    FcorporateName: String;
    Fdescription: string;
    FaverageTicket: Double;
    FaveragePreparationTime: Integer;
    FminOrderValue: TACBrOpenDeliverySchemaPrice;
    FmerchantType: TACBrODMerchantType;
    FmerchantCategories: TACBrODMerchantCategoriesArray;
    Faddress: TACBrOpenDeliverySchemaAddress;
    FcontactEmails: TSplitResult;
    FcontactPhones: TACBrOpenDeliverySchemaContactPhone;
    FlogoImage: TACBrOpenDeliverySchemaImage;
    FbannerImage: TACBrOpenDeliverySchemaImage;
    FcreatedAt: TDateTime;

  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    property name: String read Fname write Fname;
    property document: String read Fdocument write Fdocument;
    property corporateName: String read FcorporateName write FcorporateName;
    property description: string read Fdescription write Fdescription;
    property averageTicket: Double read FaverageTicket write FaverageTicket;
    property averagePreparationTime: Integer read FaveragePreparationTime write FaveragePreparationTime;
    property minOrderValue: TACBrOpenDeliverySchemaPrice read FminOrderValue write FminOrderValue;
    property merchantType: TACBrODMerchantType read FmerchantType write FmerchantType;
    property merchantCategories: TACBrODMerchantCategoriesArray read FmerchantCategories write FmerchantCategories;
    property address: TACBrOpenDeliverySchemaAddress read Faddress write Faddress;
    property contactEmails: TSplitResult read FcontactEmails write FcontactEmails;
    property contactPhones: TACBrOpenDeliverySchemaContactPhone read FcontactPhones write FcontactPhones;
    property logoImage: TACBrOpenDeliverySchemaImage read FlogoImage write FlogoImage;
    property bannerImage: TACBrOpenDeliverySchemaImage read FbannerImage write FbannerImage;
    property createdAt: TDateTime read FcreatedAt write FcreatedAt;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaContactPhone = class(TACBrOpenDeliverySchema)
  private
    FcommercialNumber: String;
    FwhatsappNumber: string;

  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property commercialNumber: String read FcommercialNumber write FcommercialNumber;
    property whatsappNumber: string read FwhatsappNumber write FwhatsappNumber;
  end;

  TACBrOpenDeliverySchemaGeoRadius = class(TACBrOpenDeliverySchema)
  private
    FgeoMidpointLatitude: Double;
    FgeoMidpointLongitude: Double;
    Fradius: TACBrOpenDeliverySchemaRadiusCollection;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property geoMidpointLatitude: Double read FgeoMidpointLatitude write FgeoMidpointLatitude;
    property geoMidpointLongitude: Double read FgeoMidpointLongitude write FgeoMidpointLongitude;
    property radius: TACBrOpenDeliverySchemaRadiusCollection read Fradius write Fradius;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaImage = class(TACBrOpenDeliverySchema)
  private
    FURL: String;
    FCRC_32: String;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    property URL: String read FURL write FURL;
    property CRC_32: String read FCRC_32 write FCRC_32;
  end;

  TACBrOpenDeliverySchemaPrice = class(TACBrOpenDeliverySchema)
  private
    Fvalue: Currency;
    Fcurrency: String;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property value: Currency read Fvalue write Fvalue;
    property &currency: String read Fcurrency write Fcurrency;
  end;

  TACBrOpenDeliverySchemaRadius = class(TACBrOpenDeliverySchema)
  private
    Fsize: Integer;
    FestimateDeliveryTime: Integer;
    Fprice: TACBrOpenDeliverySchemaPrice;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

  public
    property size: Integer read Fsize write Fsize;
    property price: TACBrOpenDeliverySchemaPrice read Fprice write Fprice;
    property estimateDeliveryTime: Integer read FestimateDeliveryTime write FestimateDeliveryTime;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaRadiusCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaRadius;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaRadius);
  public
    function New: TACBrOpenDeliverySchemaRadius;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaRadius read GetItem write SetItem; default;
  end;

implementation

{ TACBrOpenDeliverySchemaBasicInfo }

procedure TACBrOpenDeliverySchemaBasicInfo.Clear;
begin
  Fname := '';
  Fdocument := '';
  FcorporateName := '';
  Fdescription := '';
  FaverageTicket := 0;
  FaveragePreparationTime := 0;
  FcreatedAt := 0;
  FmerchantCategories := [];
  FcontactEmails := [];

  FminOrderValue.Clear;
  Faddress.Clear;
  FcontactPhones.Clear;
  FlogoImage.Clear;
  FbannerImage.Clear;
end;

constructor TACBrOpenDeliverySchemaBasicInfo.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FminOrderValue := TACBrOpenDeliverySchemaPrice.Create('minOrderValue');
  Faddress := TACBrOpenDeliverySchemaAddress.Create('address');
  FcontactPhones := TACBrOpenDeliverySchemaContactPhone.Create('contactPhones');
  FlogoImage := TACBrOpenDeliverySchemaImage.Create('logoImage');
  FbannerImage := TACBrOpenDeliverySchemaImage.Create('bannerImage');
end;

destructor TACBrOpenDeliverySchemaBasicInfo.Destroy;
begin
  FminOrderValue.Free;
  Faddress.Free;
  FcontactPhones.Free;
  FlogoImage.Free;
  FbannerImage.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaBasicInfo.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LCategories: TSplitResult;
  LStrMerchantType: string;
  I: Integer;
begin
  AJson
    .Value('name', Fname)
    .Value('document', Fdocument)
    .Value('corporateName', FcorporateName)
    .Value('description', Fdescription)
    .Value('averageTicket', FaverageTicket)
    .Value('averagePreparationTime', FaveragePreparationTime)
    .Value('merchantCategories', LCategories)
    .Value('contactEmails', FcontactEmails)
    .ValueISODate('createdAt', FcreatedAt);

  FmerchantType := StrToMerchantType(AJson.AsString['merchantType']);
  FminOrderValue.DoReadFromJSon(AJSon.AsJSONContext['minOrderValue']);
  Faddress.DoReadFromJSon(AJSon.AsJSONContext['address']);
  FcontactPhones.DoReadFromJSon(AJSon.AsJSONContext['contactPhones']);
  FlogoImage.DoReadFromJSon(AJSon.AsJSONContext['logoImage']);
  FbannerImage.DoReadFromJSon(AJSon.AsJSONContext['bannerImage']);

  SetLength(FmerchantCategories, Length(LCategories));
  for I := 0 to Pred(Length(LCategories)) do
    FmerchantCategories[I] := StrToMerchantCategories(LCategories[I]);
end;

procedure TACBrOpenDeliverySchemaBasicInfo.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .AddPair('name', Fname)
    .AddPair('document', Fdocument)
    .AddPair('corporateName', FcorporateName)
    .AddPair('description', Fdescription)
    .AddPair('averageTicket', FaverageTicket)
    .AddPair('averagePreparationTime', FaveragePreparationTime)
    .AddPairJSONString('minOrderValue', FminOrderValue.AsJSON)
    .AddPair('merchantType', MerchantTypeToStr(FmerchantType))
    .AddPair('merchantCategories', MerchantCategoriesToArray(FmerchantCategories))
    .AddPairJSONString('address', Faddress.AsJSON)
    .AddPair('contactEmails', FcontactEmails)
    .AddPairJSONString('contactPhones', FcontactPhones.AsJSON)
    .AddPairJSONString('logoImage', FlogoImage.AsJSON)
    .AddPairJSONString('bannerImage', FbannerImage.AsJSON)
    .AddPairISODate('createdAt', FcreatedAt);
end;

function TACBrOpenDeliverySchemaBasicInfo.IsEmpty: Boolean;
begin
  Result :=
    (Fname = '') and
    (Fdocument = '') and
    (FcorporateName = '') and
    (Fdescription = '') and
    (FaverageTicket = 0) and
    (FaveragePreparationTime = 0) and
    (FcreatedAt = 0) and
    (Length(FmerchantCategories) = 0) and
    (Length(FcontactEmails) = 0) and
    (FminOrderValue.IsEmpty) and
    (Faddress.IsEmpty) and
    (FcontactPhones.IsEmpty) and
    (FlogoImage.IsEmpty) and
    (FbannerImage.IsEmpty);
end;

{ TACBrOpenDeliverySchemaAddress }

procedure TACBrOpenDeliverySchemaAddress.Clear;
begin
  Fdistrict := '';
  Fstreet := '';
  FpostalCode := '';
  Fstate := '';
  Fcomplement := '';
  Fnumber := '';
  Fcountry := '';
  Fcity := '';
  Freference := '';
  Flatitude := 0;
  Flongitude := 0;
end;

procedure TACBrOpenDeliverySchemaAddress.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .Value('country', Fcountry)
    .Value('state', Fstate)
    .Value('city', Fcity)
    .Value('district', Fdistrict)
    .Value('street', Fstreet)
    .Value('number', Fnumber)
    .Value('postalCode', FpostalCode)
    .Value('complement', Fcomplement)
    .Value('reference', Freference)
    .Value('latitude', Flatitude)
    .Value('longitude', Flongitude);
end;

procedure TACBrOpenDeliverySchemaAddress.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('country', Fcountry)
    .AddPair('state', Fstate)
    .AddPair('city', Fcity)
    .AddPair('district', Fdistrict)
    .AddPair('street', Fstreet)
    .AddPair('number', Fnumber)
    .AddPair('postalCode', FpostalCode)
    .AddPair('complement', Fcomplement)
    .AddPair('reference', Freference)
    .AddPair('latitude', Flatitude)
    .AddPair('longitude', Flongitude)
end;

function TACBrOpenDeliverySchemaAddress.IsEmpty: Boolean;
begin
  Result := (Fdistrict = '') and
            (Fstreet = '') and
            (FpostalCode = '') and
            (Fstate = '') and
            (Fcomplement = '') and
            (Fnumber = '') and
            (Fcountry = '') and
            (Fcity = '') and
            (Freference = '') and
            (Flatitude = 0) and
            (Flongitude = 0);
end;

{ TACBrOpenDeliverySchemaContactPhone }

procedure TACBrOpenDeliverySchemaContactPhone.Clear;
begin
  FwhatsappNumber := '';
  FcommercialNumber := '';
end;

procedure TACBrOpenDeliverySchemaContactPhone.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .Value('whatsappNumber', FwhatsappNumber)
    .Value('commercialNumber', FcommercialNumber);
end;

procedure TACBrOpenDeliverySchemaContactPhone.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('whatsappNumber', FwhatsappNumber)
    .AddPair('commercialNumber', FcommercialNumber);
end;

function TACBrOpenDeliverySchemaContactPhone.IsEmpty: Boolean;
begin
  Result := (FwhatsappNumber = '') and (FcommercialNumber = '');
end;

{ TACBrOpenDeliverySchemaPrice }

procedure TACBrOpenDeliverySchemaPrice.Clear;
begin
  Fvalue := 0;
  Fcurrency := '';
end;

procedure TACBrOpenDeliverySchemaPrice.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .Value('value', Fvalue)
    .Value('currency', FCurrency);
end;

procedure TACBrOpenDeliverySchemaPrice.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .AddPair('value', Fvalue)
    .AddPair('currency', FCurrency);
end;

function TACBrOpenDeliverySchemaPrice.IsEmpty: Boolean;
begin
  Result := (Fvalue = 0) and (FCurrency = '');
end;

{ TACBrOpenDeliverySchemaImage }

procedure TACBrOpenDeliverySchemaImage.Clear;
begin
  FURL := '';
  FCRC_32 := '';
end;

procedure TACBrOpenDeliverySchemaImage.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .Value('URL', FURL)
    .Value('CRC-32', FCRC_32);
end;

procedure TACBrOpenDeliverySchemaImage.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .AddPair('URL', FURL)
    .AddPair('CRC-32', FCRC_32);
end;

function TACBrOpenDeliverySchemaImage.IsEmpty: Boolean;
begin
  Result := (FURL = '') and (FCRC_32 = '');
end;

{ TACBrOpenDeliverySchemaRadius }

procedure TACBrOpenDeliverySchemaRadius.Clear;
begin
  Fsize := 0;
  FestimateDeliveryTime := 0;
  Fprice.Clear;
end;

constructor TACBrOpenDeliverySchemaRadius.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fprice := TACBrOpenDeliverySchemaPrice.Create('price');
end;

destructor TACBrOpenDeliverySchemaRadius.Destroy;
begin
  Fprice.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaRadius.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .Value('size', Fsize)
    .Value('estimateDeliveryTime', FestimateDeliveryTime);

  Fprice.DoReadFromJSon(AJSon.AsJSONContext['price']);
end;

procedure TACBrOpenDeliverySchemaRadius.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  I: Integer;
begin
  AJson
    .AddPair('size', Fsize)
    .AddPairJSONString('price', Fprice.AsJSON)
    .AddPair('estimateDeliveryTime', FestimateDeliveryTime);
end;

function TACBrOpenDeliverySchemaRadius.IsEmpty: Boolean;
begin
  Result := (Fsize = 0) and (FestimateDeliveryTime = 0) and (Fprice.IsEmpty);
end;

{ TACBrOpenDeliverySchemaRadiusCollection }

function TACBrOpenDeliverySchemaRadiusCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaRadius;
begin
  Result := TACBrOpenDeliverySchemaRadius(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaRadiusCollection.New: TACBrOpenDeliverySchemaRadius;
begin
  Result := TACBrOpenDeliverySchemaRadius.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaRadiusCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaRadius);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaGeoRadius }

procedure TACBrOpenDeliverySchemaGeoRadius.Clear;
begin
  inherited;
  FgeoMidpointLatitude := 0;
  FgeoMidpointLongitude := 0;
  Fradius.Clear;
end;

constructor TACBrOpenDeliverySchemaGeoRadius.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fradius := TACBrOpenDeliverySchemaRadiusCollection.Create;  
end;

destructor TACBrOpenDeliverySchemaGeoRadius.Destroy;
begin
  Fradius.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaGeoRadius.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  Fradius.Clear;
  AJSon
    .Value('geoMidpointLatitude', FgeoMidpointLatitude)
    .Value('geoMidpointLongitude', FgeoMidpointLongitude);

  LJSONArray := AJSon.AsJSONArray['radius'];
  if Assigned(LJSONArray) then
  begin
    for I := 0 to Pred(LJSONArray.Count) do
      Fradius.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
  end;
end;

procedure TACBrOpenDeliverySchemaGeoRadius.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  I: Integer;
  LJSONArray: TACBrJSONArray;
begin
  AJSon
    .AddPair('geoMidpointLatitude', FgeoMidpointLatitude)
    .AddPair('geoMidpointLongitude', FgeoMidpointLongitude);

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Fradius.Count) do
      LJSONArray.AddElementJSONString(Fradius[I].AsJSON);
  except
    LJSONArray.Free;
    raise;
  end;

  AJSon.AddPair('radius', LJSONArray);
end;

function TACBrOpenDeliverySchemaGeoRadius.IsEmpty: Boolean;
begin
  Result := (FgeoMidpointLatitude = 0) and 
            (FgeoMidpointLongitude = 0) and
            (Fradius.Count = 0);
end;

end.

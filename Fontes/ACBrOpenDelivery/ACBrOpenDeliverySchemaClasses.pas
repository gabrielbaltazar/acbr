unit ACBrOpenDeliverySchemaClasses;

interface

uses
  ACBrOpenDeliverySchema,
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
   JsonDataObjects_ACBr,
  {$Else}
   Jsons,
  {$EndIf}
  SysUtils;

type
  TACBrOpenDeliverySchemaAddress = class;
  TACBrOpenDeliverySchemaBasicInfo = class;
  TACBrOpenDeliverySchemaContactPhone = class;
  TACBrOpenDeliverySchemaImage = class;
  TACBrOpenDeliverySchemaPrice = class;

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
    procedure DoWriteToJSon(AJSon: TJsonObject); override;
    procedure DoReadFromJSon(AJSon: TJsonObject); override;

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
    FaveragePreprationTime: Integer;
    FminOrderValue: TACBrOpenDeliverySchemaPrice;
    FmerchantType: TACBrODMerchantType;
    FmerchantCategories: TACBrODMerchantCategoriesArray;
    Faddress: TACBrOpenDeliverySchemaAddress;
    FcontactEmails: TACBrODStringArray;
    FcontactPhones: TACBrOpenDeliverySchemaContactPhone;
    FlogoImage: TACBrOpenDeliverySchemaImage;
    FbannerImage: TACBrOpenDeliverySchemaImage;
    FcreatedAt: TDateTime;
  public
    property name: String read Fname write Fname;
    property document: String read Fdocument write Fdocument;
    property corporateName: String read FcorporateName write FcorporateName;
    property description: string read Fdescription write Fdescription;
    property averageTicket: Double read FaverageTicket write FaverageTicket;
    property averagePreprationTime: Integer read FaveragePreprationTime write FaveragePreprationTime;
    property minOrderValue: TACBrOpenDeliverySchemaPrice read FminOrderValue write FminOrderValue;
    property merchantType: TACBrODMerchantType read FmerchantType write FmerchantType;
    property merchantCategories: TACBrODMerchantCategoriesArray read FmerchantCategories write FmerchantCategories;
    property address: TACBrOpenDeliverySchemaAddress read Faddress write Faddress;
    property contactEmails: TACBrODStringArray read FcontactEmails write FcontactEmails;
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
  public
    property commercialNumber: String read FcommercialNumber write FcommercialNumber;
    property whatsappNumber: string read FwhatsappNumber write FwhatsappNumber;
  end;

  TACBrOpenDeliverySchemaImage = class(TACBrOpenDeliverySchema)
  private
    FURL: String;
    FCRC_32: String;
  public
    property URL: String read FURL write FURL;
    property CRC_32: String read FCRC_32 write FCRC_32;
  end;

  TACBrOpenDeliverySchemaPrice = class(TACBrOpenDeliverySchema)
  private
    Fvalue: Currency;
    Fcurrency: String;
  public
    property value: Currency read Fvalue write Fvalue;
    property &currency: String read Fcurrency write Fcurrency;
  end;

implementation

{ TACBrOpenDeliverySchemaBasicInfo }

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

procedure TACBrOpenDeliverySchemaAddress.DoReadFromJSon(AJSon: TJsonObject);
begin
  TACBrOpenDeliveryJson.New(AJson)
    .ValueAsString('country', Fcountry)
    .ValueAsString('state', Fstate)
    .ValueAsString('city', Fcity)
    .ValueAsString('district', Fdistrict)
    .ValueAsString('street', Fstreet)
    .ValueAsString('number', Fnumber)
    .ValueAsString('postalCode', FpostalCode)
    .ValueAsString('complement', Fcomplement)
    .ValueAsString('reference', Freference)
    .ValueAsFloat('latitude', Flatitude)
    .ValueAsFloat('longitude', Flongitude)
    .Free;
end;

procedure TACBrOpenDeliverySchemaAddress.DoWriteToJSon(AJSon: TJsonObject);
begin
  TACBrOpenDeliveryJson.New(AJson)
    .AddString('country', Fcountry)
    .AddString('state', Fstate)
    .AddString('city', Fcity)
    .AddString('district', Fdistrict)
    .AddString('street', Fstreet)
    .AddString('number', Fnumber)
    .AddString('postalCode', FpostalCode)
    .AddString('complement', Fcomplement)
    .AddString('reference', Freference)
    .AddNumber('latitude', Flatitude)
    .AddNumber('longitude', Flongitude)
    .Free;
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

end.

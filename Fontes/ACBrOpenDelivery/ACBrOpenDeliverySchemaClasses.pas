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
  TACBrOpenDeliverySchemaServiceArea = class;
  TACBrOpenDeliverySchemaServiceHour = class;
  TACBrOpenDeliverySchemaTimePeriod = class;
  TACBrOpenDeliverySchemaWeekHourCollection = class;

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

  TACBrOpenDeliverySchemaGeoCoordinate = class(TACBrOpenDeliverySchema)
  private
    Flatitude: Double;
    Flongitude: Double;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property latitude: Double read Flatitude write Flatitude;
    property longitude: Double read Flongitude write Flongitude;
  end;

  TACBrOpenDeliverySchemaGeoCoordinateCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaGeoCoordinate;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaGeoCoordinate);
  public
    function New: TACBrOpenDeliverySchemaGeoCoordinate;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaGeoCoordinate read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaHolidayHour = class(TACBrOpenDeliverySchema)
  private
    Fdate: TDateTime;
    FtimePeriods: TACBrOpenDeliverySchemaTimePeriod;

  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property date: TDateTime read Fdate write Fdate;
    property timePeriods: TACBrOpenDeliverySchemaTimePeriod read FtimePeriods write FtimePeriods;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaHolidayHourCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaHolidayHour;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaHolidayHour);
  public
    function New: TACBrOpenDeliverySchemaHolidayHour;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaHolidayHour read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaMenu = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    Fname: String;
    Fdescription: String;
    FexternalCode: String;
    Fdisclaimer: String;
    FdisclaimerUrl: String;
    FcategoryId: TSplitResult;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property name: String read Fname write Fname;
    property description: String read Fdescription write Fdescription;
    property externalCode: String read FexternalCode write FexternalCode;
    property disclaimer: String read Fdisclaimer write Fdisclaimer;
    property disclaimerUrl: String read FdisclaimerUrl write FdisclaimerUrl;
    property categoryId: TSplitResult read FcategoryId write FcategoryId;
  end;

  TACBrOpenDeliverySchemaMenuCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaMenu;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaMenu);
  public
    function New: TACBrOpenDeliverySchemaMenu;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaMenu read GetItem write SetItem; default;
  end;

  TACBrOpenDeliverySchemaPolygon = class(TACBrOpenDeliverySchema)
  private
    FgeoCoordinates: TACBrOpenDeliverySchemaGeoCoordinateCollection;
    Fprice: TACBrOpenDeliverySchemaPrice;
    FestimateDeliveryTime: Integer;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property geoCoordinates: TACBrOpenDeliverySchemaGeoCoordinateCollection read FgeoCoordinates write FgeoCoordinates;
    property price: TACBrOpenDeliverySchemaPrice read Fprice write Fprice;
    property estimateDeliveryTime: Integer read FestimateDeliveryTime write FestimateDeliveryTime;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaPolygonCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaPolygon;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaPolygon);
  public
    function New: TACBrOpenDeliverySchemaPolygon;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaPolygon read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaService = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    Fstatus: TACBrODStatus;
    FserviceType: TACBrODServiceType;
    FmenuId: String;
    FserviceArea: TACBrOpenDeliverySchemaServiceArea;
    FserviceHours: TACBrOpenDeliverySchemaServiceHour;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property status: TACBrODStatus read Fstatus write Fstatus;
    property serviceType: TACBrODServiceType read FserviceType write FserviceType;
    property menuId: String read FmenuId write FmenuId;
    property serviceArea: TACBrOpenDeliverySchemaServiceArea read FserviceArea write FserviceArea;
    property serviceHours: TACBrOpenDeliverySchemaServiceHour read FserviceHours write FserviceHours;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaServiceCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaService;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaService);
  public
    function New: TACBrOpenDeliverySchemaService;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaService read GetItem write SetItem; default;
  end;

  TACBrOpenDeliverySchemaServiceArea = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    Fpolygon: TACBrOpenDeliverySchemaPolygonCollection;
    FgeoRadius: TACBrOpenDeliverySchemaGeoRadius;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

  public
    property id: String read Fid write Fid;
    property polygon: TACBrOpenDeliverySchemaPolygonCollection read Fpolygon write Fpolygon;
    property geoRadius: TACBrOpenDeliverySchemaGeoRadius read FgeoRadius write FgeoRadius;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaServiceHour = class(TACBrOpenDeliverySchema)
  private
    FweekHours: TACBrOpenDeliverySchemaWeekHourCollection;
    FholidayHours: TACBrOpenDeliverySchemaHolidayHourCollection;
    Fid: String;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property weekHours: TACBrOpenDeliverySchemaWeekHourCollection read FweekHours write FweekHours;
    property holidayHours: TACBrOpenDeliverySchemaHolidayHourCollection read FholidayHours write FholidayHours;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaTimePeriod = class(TACBrOpenDeliverySchema)
  private
    FstartTime: TDateTime;
    FendTime: TDateTime;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

  public
    property startTime: TDateTime read FstartTime write FstartTime;
    property endTime: TDateTime read FendTime write FendTime;
  end;

  TACBrOpenDeliverySchemaWeekHour = class(TACBrOpenDeliverySchema)
  private
    FdayOfWeek: TACBrODDayOfWeekArray;
    FtimePeriods: TACBrOpenDeliverySchemaTimePeriod;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

  public
    property dayOfWeek: TACBrODDayOfWeekArray read FdayOfWeek write FdayOfWeek;
    property timePeriods : TACBrOpenDeliverySchemaTimePeriod read FtimePeriods write FtimePeriods;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaWeekHourCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaWeekHour;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaWeekHour);
  public
    function New: TACBrOpenDeliverySchemaWeekHour;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaWeekHour read GetItem write SetItem; default;
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

{ TACBrOpenDeliverySchemaGeoCoordinate }

procedure TACBrOpenDeliverySchemaGeoCoordinate.Clear;
begin
  Flatitude := 0;
  Flongitude := 0;
end;

procedure TACBrOpenDeliverySchemaGeoCoordinate.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .Value('latitude', Flatitude)
    .Value('longitude', Flongitude);
end;

procedure TACBrOpenDeliverySchemaGeoCoordinate.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('latitude', Flatitude)
    .AddPair('longitude', Flongitude);
end;

function TACBrOpenDeliverySchemaGeoCoordinate.IsEmpty: Boolean;
begin
  Result := (Flatitude = 0) and (Flongitude = 0);
end;

{ TACBrOpenDeliverySchemaGeoCoordinateCollection }

function TACBrOpenDeliverySchemaGeoCoordinateCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaGeoCoordinate;
begin
  Result := TACBrOpenDeliverySchemaGeoCoordinate(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaGeoCoordinateCollection.New: TACBrOpenDeliverySchemaGeoCoordinate;
begin
  Result := TACBrOpenDeliverySchemaGeoCoordinate.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaGeoCoordinateCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaGeoCoordinate);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaPolygon }

procedure TACBrOpenDeliverySchemaPolygon.Clear;
begin
  inherited;
  FestimateDeliveryTime := 0;
  Fprice.Clear;
  FgeoCoordinates.Clear;
end;

constructor TACBrOpenDeliverySchemaPolygon.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fprice := TACBrOpenDeliverySchemaPrice.Create('price');
  FgeoCoordinates := TACBrOpenDeliverySchemaGeoCoordinateCollection.Create;
end;

destructor TACBrOpenDeliverySchemaPolygon.Destroy;
begin
  Fprice.Free;
  FgeoCoordinates.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaPolygon.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  AJson
    .Value('estimateDeliveryTime', FestimateDeliveryTime);

  Fprice.DoReadFromJSon(AJSon.AsJSONContext['price']);
  LJSONArray := AJSon.AsJSONArray['geoCoordinates'];
  if Assigned(LJSONArray) then
  begin
    for I := 0 to Pred(LJSONArray.Count) do
      FgeoCoordinates.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
  end;
end;

procedure TACBrOpenDeliverySchemaPolygon.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  I: Integer;
  LJSONArray: TACBrJSONArray;
begin
  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(FgeoCoordinates.Count) do
      LJSONArray.AddElementJSONString(FgeoCoordinates[I].AsJSON);
  except
    LJSONArray.Free;
    raise;
  end;

  AJSon
    .AddPair('geoCoordinates', LJSONArray)
    .AddPairJSONString('price', Fprice.AsJSON)
    .AddPair('estimateDeliveryTime', FestimateDeliveryTime);
end;

function TACBrOpenDeliverySchemaPolygon.IsEmpty: Boolean;
begin
  Result := (FestimateDeliveryTime = 0) and
            (Fprice.IsEmpty) and
            (FgeoCoordinates.Count = 0);
end;

{ TACBrOpenDeliverySchemaPolygonCollection }

function TACBrOpenDeliverySchemaPolygonCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaPolygon;
begin
  Result := TACBrOpenDeliverySchemaPolygon(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaPolygonCollection.New: TACBrOpenDeliverySchemaPolygon;
begin
  Result := TACBrOpenDeliverySchemaPolygon.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaPolygonCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaPolygon);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaServiceArea }

procedure TACBrOpenDeliverySchemaServiceArea.Clear;
begin
  Fid := '';
  Fpolygon.Clear;
  FgeoRadius.Clear;
end;

constructor TACBrOpenDeliverySchemaServiceArea.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fpolygon := TACBrOpenDeliverySchemaPolygonCollection.Create;
  FgeoRadius := TACBrOpenDeliverySchemaGeoRadius.Create('geoRadius');
end;

destructor TACBrOpenDeliverySchemaServiceArea.Destroy;
begin
  Fpolygon.Free;
  FgeoRadius.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaServiceArea.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  Fpolygon.Clear;
  Fid := AJSon.AsString['id'];
  FgeoRadius.DoReadFromJSon(AJSon.AsJSONContext['geoRadius']);
  LJSONArray := AJSon.AsJSONArray['polygon'];
  if Assigned(LJSONArray) then
  begin
    for I := 0 to Pred(LJSONArray.Count) do
      Fpolygon.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
  end;
end;

procedure TACBrOpenDeliverySchemaServiceArea.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  I: Integer;
  LJSONArray: TACBrJSONArray;
begin
  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Fpolygon.Count) do
      LJSONArray.AddElementJSONString(Fpolygon[I].AsJSON);
  except
    LJSONArray.Free;
    raise;
  end;

  AJson
    .AddPair('id', Fid)
    .AddPair('polygon', LJSONArray)
    .AddPairJSONString('geoRadius', FgeoRadius.AsJSON);
end;

function TACBrOpenDeliverySchemaServiceArea.IsEmpty: Boolean;
begin
  Result :=
    (Fid = '') and
    (Fpolygon.Count = 0) and
    (FgeoRadius.IsEmpty);
end;

{ TACBrOpenDeliverySchemaTimePeriod }

procedure TACBrOpenDeliverySchemaTimePeriod.Clear;
begin
  FstartTime := 0;
  FendTime := 0;
end;

procedure TACBrOpenDeliverySchemaTimePeriod.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .ValueISOTime('startTime', FstartTime)
    .ValueISOTime('endTime', FendTime);
end;

procedure TACBrOpenDeliverySchemaTimePeriod.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .AddPair('startTime', FormatDateTime('hh:mm:ss', FstartTime))
    .AddPair('endTime', FormatDateTime('hh:mm:ss', FendTime))
end;

function TACBrOpenDeliverySchemaTimePeriod.IsEmpty: Boolean;
begin
  Result := (FstartTime = 0) and (FendTime = 0);
end;

{ TACBrOpenDeliverySchemaWeekHour }

procedure TACBrOpenDeliverySchemaWeekHour.Clear;
begin
  FdayOfWeek := [];
  FtimePeriods.Clear;
end;

constructor TACBrOpenDeliverySchemaWeekHour.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FtimePeriods := TACBrOpenDeliverySchemaTimePeriod.Create('timePeriods');
end;

destructor TACBrOpenDeliverySchemaWeekHour.Destroy;
begin
  FtimePeriods.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaWeekHour.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LSplitResult: TSplitResult;
  I: Integer;
begin
  FtimePeriods.DoReadFromJSon(AJSon.AsJSONContext['timePeriods']);
  AJSon.Value('dayOfWeek', LSplitResult);

  SetLength(FdayOfWeek, Length(LSplitResult));
  for I := 0 to Pred(Length(LSplitResult)) do
    FdayOfWeek[I] := StrToDayOfWeek(LSplitResult[I]);
end;

procedure TACBrOpenDeliverySchemaWeekHour.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('dayOfWeek', DayOfWeekToArray(FdayOfWeek))
    .AddPairJSONString('timePeriods', FtimePeriods.AsJSON);
end;

function TACBrOpenDeliverySchemaWeekHour.IsEmpty: Boolean;
begin
  Result := (Length(FdayOfWeek) = 0) and (FtimePeriods.IsEmpty);
end;

{ TACBrOpenDeliverySchemaHolidayHour }

procedure TACBrOpenDeliverySchemaHolidayHour.Clear;
begin
  Fdate := 0;
  FtimePeriods.Clear;
end;

constructor TACBrOpenDeliverySchemaHolidayHour.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FtimePeriods := TACBrOpenDeliverySchemaTimePeriod.Create('timePeriods');
end;

destructor TACBrOpenDeliverySchemaHolidayHour.Destroy;
begin
  FtimePeriods.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaHolidayHour.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon.ValueISODate('date', Fdate);
  FtimePeriods.DoReadFromJSon(AJSon.AsJSONContext['timePeriods']);
end;

procedure TACBrOpenDeliverySchemaHolidayHour.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPairISODate('date', Fdate)
    .AddPairJSONString('timePeriods', FtimePeriods.AsJSON);
end;

function TACBrOpenDeliverySchemaHolidayHour.IsEmpty: Boolean;
begin
  Result := (Fdate = 0) and (FtimePeriods.IsEmpty);
end;

{ TACBrOpenDeliverySchemaHolidayHourCollection }

function TACBrOpenDeliverySchemaHolidayHourCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaHolidayHour;
begin
  Result := TACBrOpenDeliverySchemaHolidayHour(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaHolidayHourCollection.New: TACBrOpenDeliverySchemaHolidayHour;
begin
  Result := TACBrOpenDeliverySchemaHolidayHour.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaHolidayHourCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaHolidayHour);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaWeekHourCollection }

function TACBrOpenDeliverySchemaWeekHourCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaWeekHour;
begin
  Result := TACBrOpenDeliverySchemaWeekHour(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaWeekHourCollection.New: TACBrOpenDeliverySchemaWeekHour;
begin
  Result := TACBrOpenDeliverySchemaWeekHour.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaWeekHourCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaWeekHour);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaServiceHour }

procedure TACBrOpenDeliverySchemaServiceHour.Clear;
begin
  Fid := '';
  FweekHours.Clear;
  FholidayHours.Clear;
end;

constructor TACBrOpenDeliverySchemaServiceHour.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FweekHours := TACBrOpenDeliverySchemaWeekHourCollection.Create;
  FholidayHours := TACBrOpenDeliverySchemaHolidayHourCollection.Create;
end;

destructor TACBrOpenDeliverySchemaServiceHour.Destroy;
begin
  FweekHours.Free;
  FholidayHours.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaServiceHour.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  FweekHours.Clear;
  FholidayHours.Clear;
  AJSon.Value('id', Fid);
  LJSONArray := AJSon.AsJSONArray['weekHours'];
  if Assigned(LJSONArray) then
  begin
    for I := 0 to Pred(LJSONArray.Count) do
      FweekHours.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
  end;

  LJSONArray := AJSon.AsJSONArray['holidayHours'];
  if Assigned(LJSONArray) then
  begin
    for I := 0 to Pred(LJSONArray.Count) do
      FholidayHours.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
  end;
end;

procedure TACBrOpenDeliverySchemaServiceHour.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  LJSONWeek: TACBrJSONArray;
  LJSONHoliday: TACBrJSONArray;
  I: Integer;
begin
  AJson.AddPair('id', Fid);
  LJSONWeek := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(FweekHours.Count) do
      LJSONWeek.AddElementJSONString(FweekHours[I].AsJSON);
    AJSon.AddPair('weekHours', LJSONWeek);
  except
    LJSONWeek.Free;
    raise;
  end;

  LJSONHoliday := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(FholidayHours.Count) do
      LJSONHoliday.AddElementJSONString(FholidayHours[I].AsJSON);
    AJSon.AddPair('holidayHours', LJSONHoliday);
  except
    LJSONHoliday.Free;
    raise;
  end;
end;

function TACBrOpenDeliverySchemaServiceHour.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (FholidayHours.Count = 0) and
            (FweekHours.Count = 0);
end;

{ TACBrOpenDeliverySchemaService }

procedure TACBrOpenDeliverySchemaService.Clear;
begin
  Fid := '';
  Fstatus := sAvailable;
  FserviceType := stDelivery;
  FmenuId := '';
  FserviceArea.Clear;
  FserviceHours.Clear;
end;

constructor TACBrOpenDeliverySchemaService.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FserviceArea := TACBrOpenDeliverySchemaServiceArea.Create('serviceArea');
  FserviceHours := TACBrOpenDeliverySchemaServiceHour.Create('serviceHours');
end;

destructor TACBrOpenDeliverySchemaService.Destroy;
begin
  FserviceArea.Free;
  FserviceHours.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaService.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LStrEnum: String;
begin
  AJson
    .Value('id', Fid)
    .Value('menuId', FmenuId);

  LStrEnum := AJSon.AsString['status'];
  Fstatus := StrToStatus(LStrEnum);

  LStrEnum := AJSon.AsString['serviceType'];
  FserviceType := StrToServiceType(LStrEnum);

  FserviceArea.DoReadFromJSon(AJSon.AsJSONContext['serviceArea']);
  FserviceHours.DoReadFromJSon(AJSon.AsJSONContext['serviceHours']);
end;

procedure TACBrOpenDeliverySchemaService.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('status', StatusToStr(Fstatus))
    .AddPair('serviceType', ServiceTypeToStr(FserviceType))
    .AddPair('menuId', FmenuId)
    .AddPairJSONString('serviceArea', FserviceArea.AsJSON)
    .AddPairJSONString('serviceHours', FserviceHours.AsJSON);
end;

function TACBrOpenDeliverySchemaService.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (Fstatus = sAvailable) and
            (FserviceType = stDelivery) and
            (FmenuId = '') and
            (FserviceArea.IsEmpty) and
            (FserviceHours.IsEmpty);
end;

{ TACBrOpenDeliverySchemaServiceCollection }

function TACBrOpenDeliverySchemaServiceCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaService;
begin
  Result := TACBrOpenDeliverySchemaService(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaServiceCollection.New: TACBrOpenDeliverySchemaService;
begin
  Result := TACBrOpenDeliverySchemaService.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaServiceCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaService);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaMenu }

procedure TACBrOpenDeliverySchemaMenu.Clear;
begin
  Fid := '';
  Fname := '';
  Fdescription := '';
  FexternalCode := '';
  Fdisclaimer := '';
  FdisclaimerUrl := '';
  FcategoryId := [];
end;

procedure TACBrOpenDeliverySchemaMenu.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .Value('id', Fid)
    .Value('name', Fname)
    .Value('description', Fdescription)
    .Value('externalCode', FexternalCode)
    .Value('disclaimer', Fdisclaimer)
    .Value('disclaimerURL', FdisclaimerUrl)
    .Value('categoryId', FcategoryId);
end;

procedure TACBrOpenDeliverySchemaMenu.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('name', Fname)
    .AddPair('description', Fdescription)
    .AddPair('externalCode', FexternalCode)
    .AddPair('disclaimer', Fdisclaimer)
    .AddPair('disclaimerURL', FdisclaimerUrl)
    .AddPair('categoryId', FcategoryId);
end;

function TACBrOpenDeliverySchemaMenu.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (Fname = '') and
            (Fdescription = '') and
            (FexternalCode = '') and
            (Fdisclaimer = '') and
            (FdisclaimerUrl = '') and
            (Length(FcategoryId) = 0);
end;

{ TACBrOpenDeliverySchemaMenuCollection }

function TACBrOpenDeliverySchemaMenuCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaMenu;
begin
  Result := TACBrOpenDeliverySchemaMenu(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaMenuCollection.New: TACBrOpenDeliverySchemaMenu;
begin
  Result := TACBrOpenDeliverySchemaMenu.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaMenuCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaMenu);
begin
  inherited Items[Index] := Value;
end;

end.

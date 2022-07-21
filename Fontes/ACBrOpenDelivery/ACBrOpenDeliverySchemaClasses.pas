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
  TACBrOpenDeliverySchemaAvailability = class;
  TACBrOpenDeliverySchemaAvailabilityCollection = class;
  TACBrOpenDeliverySchemaBasicInfo = class;
  TACBrOpenDeliverySchemaCategory = class;
  TACBrOpenDeliverySchemaCategoryCollection = class;
  TACBrOpenDeliverySchemaContactPhone = class;
  TACBrOpenDeliverySchemaEvent = class;
  TACBrOpenDeliverySchemaGeoCoordinate = class;
  TACBrOpenDeliverySchemaGeoCoordinateCollection = class;
  TACBrOpenDeliverySchemaGeoRadius = class;
  TACBrOpenDeliverySchemaHolidayHour = class;
  TACBrOpenDeliverySchemaHolidayHourCollection = class;
  TACBrOpenDeliverySchemaHour = class;
  TACBrOpenDeliverySchemaHourCollection = class;
  TACBrOpenDeliverySchemaImage = class;
  TACBrOpenDeliverySchemaItem = class;
  TACBrOpenDeliverySchemaItemCollection = class;
  TACBrOpenDeliverySchemaItemOffer = class;
  TACBrOpenDeliverySchemaItemOfferCollection = class;
  TACBrOpenDeliverySchemaMenu = class;
  TACBrOpenDeliverySchemaMenuCollection = class;
  TACBrOpenDeliverySchemaMerchant = class;
  TACBrOpenDeliverySchemaNutritionalInfo = class;
  TACBrOpenDeliverySchemaOption = class;
  TACBrOpenDeliverySchemaOptionCollection = class;
  TACBrOpenDeliverySchemaOptionGroup = class;
  TACBrOpenDeliverySchemaOptionGroupCollection = class;
  TACBrOpenDeliverySchemaPolygon = class;
  TACBrOpenDeliverySchemaPolygonCollection = class;
  TACBrOpenDeliverySchemaPrice = class;
  TACBrOpenDeliverySchemaRadius = class;
  TACBrOpenDeliverySchemaRadiusCollection = class;
  TACBrOpenDeliverySchemaService = class;
  TACBrOpenDeliverySchemaServiceCollection = class;
  TACBrOpenDeliverySchemaServiceArea = class;
  TACBrOpenDeliverySchemaServiceHour = class;
  TACBrOpenDeliverySchemaServiceHourCollection = class;
  TACBrOpenDeliverySchemaTimePeriod = class;

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

  TACBrOpenDeliverySchemaAvailability = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    FstartDate: TDateTime;
    FendDate: TDateTime;
    Fhours: TACBrOpenDeliverySchemaHourCollection;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property startDate: TDateTime read FstartDate write FstartDate;
    property endDate: TDateTime read FendDate write FendDate;
    property hours: TACBrOpenDeliverySchemaHourCollection read Fhours write Fhours;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaAvailabilityCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaAvailability;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaAvailability);
  public
    function New: TACBrOpenDeliverySchemaAvailability;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaAvailability read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaCategory = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    Findex: Integer;
    Fname: String;
    Fdescription: String;
    FexternalCode: String;
    Fstatus: TACBrODStatus;
    FavailabilityId: TSplitResult;
    FitemOfferId: TSplitResult;
    Fimage: TACBrOpenDeliverySchemaImage;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property index: Integer read Findex write Findex;
    property name: String read Fname write Fname;
    property description: String read Fdescription write Fdescription;
    property externalCode: String read FexternalCode write FexternalCode;
    property status: TACBrODStatus read Fstatus write Fstatus;
    property availabilityId: TSplitResult read FavailabilityId write FavailabilityId;
    property itemOfferId: TSplitResult read FitemOfferId write FitemOfferId;
    property image: TACBrOpenDeliverySchemaImage read Fimage write Fimage;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaCategoryCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaCategory;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaCategory);
  public
    function New: TACBrOpenDeliverySchemaCategory;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaCategory read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaError = class(TACBrOpenDeliverySchema)
  private
    FTitle: String;
    FStatus: Integer;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    property Status: Integer read FStatus write FStatus;
    property Title: String read FTitle write FTitle;
  end;

  TACBrOpenDeliverySchemaEvent = class(TACBrOpenDeliverySchema)
  private
    FEventType: TACBrODEventType;
    FEventId: string;
    FOrderId: string;
    FOrderURL: string;
    FCreatedAt: TDateTime;
    FSourceAppId: String;

  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property EventId: string read FEventId write FEventId;
    property EventType: TACBrODEventType read FEventType write FEventType;
    property OrderId: string read FOrderId write FOrderId;
    property OrderURL: string read FOrderURL write FOrderURL;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property SourceAppId: String read FSourceAppId write FSourceAppId;
  end;

  TACBrOpenDeliverySchemaEventCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaEvent;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaEvent);
  public
    function New: TACBrOpenDeliverySchemaEvent;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaEvent read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaItem = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    Fname: String;
    Fdescription: String;
    FexternalCode: String;
    Fimage: TACBrOpenDeliverySchemaImage;
    FnutritionalInfo: TACBrOpenDeliverySchemaNutritionalInfo;
    Fserving: Integer;
    Funit: String;
    Fean: String;

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
    property image: TACBrOpenDeliverySchemaImage read Fimage write Fimage;
    property nutritionalInfo: TACBrOpenDeliverySchemaNutritionalInfo read FnutritionalInfo write FnutritionalInfo;
    property serving: Integer read Fserving write Fserving;
    property &unit: String read Funit write Funit;
    property ean: String read Fean write Fean;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaItemCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaItem;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaItem);
  public
    function New: TACBrOpenDeliverySchemaItem;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaItem read GetItem write SetItem; default;
  end;

  TACBrOpenDeliverySchemaItemOffer = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    FitemId: String;
    Findex: Integer;
    Fprice: TACBrOpenDeliverySchemaPrice;
    FavailabilityId: TSplitResult;
    FoptionGroupsId: TSplitResult;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property itemId: String read FitemId write FitemId;
    property index: Integer read Findex write Findex;
    property price: TACBrOpenDeliverySchemaPrice read Fprice write Fprice;
    property availabilityId: TSplitResult read FavailabilityId write FavailabilityId;
    property optionGroupsId: TSplitResult read FoptionGroupsId write FoptionGroupsId;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaItemOfferCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaItemOffer;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaItemOffer);
  public
    function New: TACBrOpenDeliverySchemaItemOffer;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaItemOffer read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaMerchant = class(TACBrOpenDeliverySchema)
  private
    FlastUpdate: TDateTime;
    Fid: String;
    FTTL: Integer;
    Fstatus: TACBrODStatus;
    FbasicInfo: TACBrOpenDeliverySchemaBasicInfo;
    Fservices: TACBrOpenDeliverySchemaServiceCollection;
    Fmenus: TACBrOpenDeliverySchemaMenuCollection;
    Fitems: TACBrOpenDeliverySchemaItemCollection;
    Fcategories: TACBrOpenDeliverySchemaCategoryCollection;
    FitemOffers: TACBrOpenDeliverySchemaItemOfferCollection;
    FoptionGroups: TACBrOpenDeliverySchemaOptionGroupCollection;
    Favailabilities: TACBrOpenDeliverySchemaAvailabilityCollection;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property lastUpdate: TDateTime read FlastUpdate write FlastUpdate;
    property TTL: Integer read FTTL write FTTL;
    property id: String read Fid write Fid;
    property status: TACBrODStatus read Fstatus write Fstatus;
    property basicInfo: TACBrOpenDeliverySchemaBasicInfo read FbasicInfo write FbasicInfo;
    property services: TACBrOpenDeliverySchemaServiceCollection read Fservices write Fservices;
    property menus: TACBrOpenDeliverySchemaMenuCollection read Fmenus write Fmenus;
    property items: TACBrOpenDeliverySchemaItemCollection read Fitems write Fitems;
    property categories: TACBrOpenDeliverySchemaCategoryCollection read Fcategories write Fcategories;
    property itemOffers: TACBrOpenDeliverySchemaItemOfferCollection read FitemOffers write FitemOffers;
    property optionGroups: TACBrOpenDeliverySchemaOptionGroupCollection read FoptionGroups write FoptionGroups;
    property availabilities: TACBrOpenDeliverySchemaAvailabilityCollection read Favailabilities write Favailabilities;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaNutritionalInfo = class(TACBrOpenDeliverySchema)
  private
    Fdescription: String;
    Fcalories: String;
    Fallergen: TACBrODAllergenArray;
    Fadditives: TSplitResult;
    FsuitableDiet: TACBrODSuitableDietArray;
    FisAlcoholic: Boolean;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property description: String read Fdescription write Fdescription;
    property calories: String read Fcalories write Fcalories;
    property allergen: TACBrODAllergenArray read Fallergen write Fallergen;
    property additives: TSplitResult read Fadditives write Fadditives;
    property suitableDiet: TACBrODSuitableDietArray read FsuitableDiet write FsuitableDiet;
    property isAlcoholic: Boolean read FisAlcoholic write FisAlcoholic;
  end;

  TACBrOpenDeliverySchemaOption = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    FitemId: String;
    Findex: Integer;
    Fprice: TACBrOpenDeliverySchemaPrice;
    FmaxPermitted: Integer;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property itemId: String read FitemId write FitemId;
    property index: Integer read Findex write Findex;
    property price: TACBrOpenDeliverySchemaPrice read Fprice write Fprice;
    property maxPermitted: Integer read FmaxPermitted write FmaxPermitted;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaOptionCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaOption;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaOption);
  public
    function New: TACBrOpenDeliverySchemaOption;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaOption read GetItem write SetItem; default;
  end;

  TACBrOpenDeliverySchemaOptionGroup = class(TACBrOpenDeliverySchema)
  private
    Fid: String;
    Findex: Integer;
    Fname: String;
    Fdescription: String;
    FexternalCode: String;
    Fstatus: TACBrODStatus;
    FminPermitted: Integer;
    FmaxPermitted: Integer;
    Foptions: TACBrOpenDeliverySchemaOptionCollection;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    property id: String read Fid write Fid;
    property index: Integer read Findex write Findex;
    property name: String read Fname write Fname;
    property description: String read Fdescription write Fdescription;
    property externalCode: String read FexternalCode write FexternalCode;
    property status: TACBrODStatus read Fstatus write Fstatus;
    property minPermitted: Integer read FminPermitted write FminPermitted;
    property maxPermitted: Integer read FmaxPermitted write FmaxPermitted;
    property options: TACBrOpenDeliverySchemaOptionCollection read Foptions write Foptions;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaOptionGroupCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaOptionGroup;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaOptionGroup);
  public
    function New: TACBrOpenDeliverySchemaOptionGroup;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaOptionGroup read GetItem write SetItem; default;
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
    FweekHours: TACBrOpenDeliverySchemaHourCollection;
    FholidayHours: TACBrOpenDeliverySchemaHolidayHourCollection;
    Fid: String;
  protected
    procedure DoWriteToJSon(AJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(AJSon: TACBrJSONObject); override;

  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;

    property id: String read Fid write Fid;
    property weekHours: TACBrOpenDeliverySchemaHourCollection read FweekHours write FweekHours;
    property holidayHours: TACBrOpenDeliverySchemaHolidayHourCollection read FholidayHours write FholidayHours;

    constructor Create(const AObjectName: string = ''); override;
    destructor Destroy; override;
  end;

  TACBrOpenDeliverySchemaServiceHourCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaServiceHour;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaServiceHour);
  public
    function New: TACBrOpenDeliverySchemaServiceHour;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaServiceHour read GetItem write SetItem; default;
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

  TACBrOpenDeliverySchemaHour = class(TACBrOpenDeliverySchema)
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

  TACBrOpenDeliverySchemaHourCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TACBrOpenDeliverySchemaHour;
    procedure SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaHour);
  public
    function New: TACBrOpenDeliverySchemaHour;
    property Items[Index: Integer]: TACBrOpenDeliverySchemaHour read GetItem write SetItem; default;
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
  FminOrderValue.DoReadFromJSon(AJSon.AsJSONObject['minOrderValue']);
  Faddress.DoReadFromJSon(AJSon.AsJSONObject['address']);
  FcontactPhones.DoReadFromJSon(AJSon.AsJSONObject['contactPhones']);
  FlogoImage.DoReadFromJSon(AJSon.AsJSONObject['logoImage']);
  FbannerImage.DoReadFromJSon(AJSon.AsJSONObject['bannerImage']);

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
    .AddPairJSONObject('minOrderValue', FminOrderValue.AsJSON)
    .AddPair('merchantType', MerchantTypeToStr(FmerchantType))
    .AddPair('merchantCategories', MerchantCategoriesToArray(FmerchantCategories))
    .AddPairJSONObject('address', Faddress.AsJSON)
    .AddPair('contactEmails', FcontactEmails)
    .AddPairJSONObject('contactPhones', FcontactPhones.AsJSON)
    .AddPairJSONObject('logoImage', FlogoImage.AsJSON)
    .AddPairJSONObject('bannerImage', FbannerImage.AsJSON)
    .AddPairISODateTime('createdAt', FcreatedAt);
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

  Fprice.DoReadFromJSon(AJSon.AsJSONObject['price']);
end;

procedure TACBrOpenDeliverySchemaRadius.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .AddPair('size', Fsize)
    .AddPairJSONObject('price', Fprice.AsJSON)
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

  Fprice.DoReadFromJSon(AJSon.AsJSONObject['price']);
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
    .AddPairJSONObject('price', Fprice.AsJSON)
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
  FgeoRadius.DoReadFromJSon(AJSon.AsJSONObject['geoRadius']);
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
    .AddPairJSONObject('geoRadius', FgeoRadius.AsJSON);
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

{ TACBrOpenDeliverySchemaHour }

procedure TACBrOpenDeliverySchemaHour.Clear;
begin
  FdayOfWeek := [];
  FtimePeriods.Clear;
end;

constructor TACBrOpenDeliverySchemaHour.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FtimePeriods := TACBrOpenDeliverySchemaTimePeriod.Create('timePeriods');
end;

destructor TACBrOpenDeliverySchemaHour.Destroy;
begin
  FtimePeriods.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaHour.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LSplitResult: TSplitResult;
  I: Integer;
begin
  FtimePeriods.DoReadFromJSon(AJSon.AsJSONObject['timePeriods']);
  AJSon.Value('dayOfWeek', LSplitResult);

  SetLength(FdayOfWeek, Length(LSplitResult));
  for I := 0 to Pred(Length(LSplitResult)) do
    FdayOfWeek[I] := StrToDayOfWeek(LSplitResult[I]);
end;

procedure TACBrOpenDeliverySchemaHour.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('dayOfWeek', DayOfWeekToArray(FdayOfWeek))
    .AddPairJSONObject('timePeriods', FtimePeriods.AsJSON);
end;

function TACBrOpenDeliverySchemaHour.IsEmpty: Boolean;
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
  FtimePeriods.DoReadFromJSon(AJSon.AsJSONObject['timePeriods']);
end;

procedure TACBrOpenDeliverySchemaHolidayHour.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPairISODateTime('date', Fdate)
    .AddPairJSONObject('timePeriods', FtimePeriods.AsJSON);
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

{ TACBrOpenDeliverySchemaHourCollection }

function TACBrOpenDeliverySchemaHourCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaHour;
begin
  Result := TACBrOpenDeliverySchemaHour(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaHourCollection.New: TACBrOpenDeliverySchemaHour;
begin
  Result := TACBrOpenDeliverySchemaHour.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaHourCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaHour);
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
  FweekHours := TACBrOpenDeliverySchemaHourCollection.Create;
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

  FserviceArea.DoReadFromJSon(AJSon.AsJSONObject['serviceArea']);
  FserviceHours.DoReadFromJSon(AJSon.AsJSONObject['serviceHours']);
end;

procedure TACBrOpenDeliverySchemaService.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('status', StatusToStr(Fstatus))
    .AddPair('serviceType', ServiceTypeToStr(FserviceType))
    .AddPair('menuId', FmenuId)
    .AddPairJSONObject('serviceArea', FserviceArea.AsJSON)
    .AddPairJSONObject('serviceHours', FserviceHours.AsJSON);
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

{ TACBrOpenDeliverySchemaCategory }

procedure TACBrOpenDeliverySchemaCategory.Clear;
begin
  FId := '';
  Findex := 0;
  Fname := '';
  Fdescription := '';
  FexternalCode := '';
  Fstatus := sAvailable;
  FavailabilityId := [];
  FitemOfferId := [];
  Fimage.Clear;
end;

constructor TACBrOpenDeliverySchemaCategory.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fimage := TACBrOpenDeliverySchemaImage.Create('image');
end;

destructor TACBrOpenDeliverySchemaCategory.Destroy;
begin
  Fimage.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaCategory.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LStrStatus: String;
begin
  AJSon
    .Value('id', Fid)
    .Value('index', Findex)
    .Value('name', Fname)
    .Value('description', Fdescription)
    .Value('externalCode', FexternalCode)
    .Value('status', LStrStatus)
    .Value('availabilityId', FavailabilityId)
    .Value('itemOfferId', FitemOfferId);

  Fimage.DoReadFromJSon(AJSon.AsJSONObject['image']);
  Fstatus := StrToStatus(LStrStatus);
end;

procedure TACBrOpenDeliverySchemaCategory.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJson
    .AddPair('id', Fid)
    .AddPair('index', Findex)
    .AddPair('name', Fname)
    .AddPair('description', Fdescription)
    .AddPairJSONObject('image', Fimage.AsJSON)
    .AddPair('externalCode', FexternalCode)
    .AddPair('status', StatusToStr(Fstatus))
    .AddPair('availabilityId', FavailabilityId)
    .AddPair('itemOfferId', FitemOfferId);
end;

function TACBrOpenDeliverySchemaCategory.IsEmpty: Boolean;
begin
  Result := (FId = '') and
            (Findex = 0) and
            (Fname = '') and
            (Fdescription = '') and
            (FexternalCode = '') and
            (Fstatus = sAvailable) and
            (Length(FavailabilityId) = 0) and
            (Length(FitemOfferId) = 0) and
            (Fimage.IsEmpty);
end;

{ TACBrOpenDeliverySchemaCategoryCollection }

function TACBrOpenDeliverySchemaCategoryCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaCategory;
begin
  Result := TACBrOpenDeliverySchemaCategory(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaCategoryCollection.New: TACBrOpenDeliverySchemaCategory;
begin
  Result := TACBrOpenDeliverySchemaCategory.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaCategoryCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaCategory);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaItemOffer }

procedure TACBrOpenDeliverySchemaItemOffer.Clear;
begin
  Fid := '';
  FitemId := '';
  Findex := 0;
  FavailabilityId := [];
  FoptionGroupsId := [];
  Fprice.Clear;
end;

constructor TACBrOpenDeliverySchemaItemOffer.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fprice := TACBrOpenDeliverySchemaPrice.Create('price');
end;

destructor TACBrOpenDeliverySchemaItemOffer.Destroy;
begin
  Fprice.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaItemOffer.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .Value('id', Fid)
    .Value('itemId', FitemId)
    .Value('index', Findex)
    .Value('availabilityId', FavailabilityId)
    .Value('optionGroupsId', FoptionGroupsId);

  Fprice.DoReadFromJSon(AJSon.AsJSONObject['price']);
end;

procedure TACBrOpenDeliverySchemaItemOffer.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('itemId', FitemId)
    .AddPair('index', Findex)
    .AddPairJSONObject('price', Fprice.AsJSON)
    .AddPair('availabilityId', FavailabilityId)
    .AddPair('optionGroupsId', FoptionGroupsId);
end;

function TACBrOpenDeliverySchemaItemOffer.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (FitemId = '') and
            (Findex = 0) and
            (Length(FavailabilityId) = 0) and
            (Length(FoptionGroupsId) = 0) and
            (Fprice.IsEmpty);
end;

{ TACBrOpenDeliverySchemaItemOfferCollection }

function TACBrOpenDeliverySchemaItemOfferCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaItemOffer;
begin
  Result := TACBrOpenDeliverySchemaItemOffer(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaItemOfferCollection.New: TACBrOpenDeliverySchemaItemOffer;
begin
  Result := TACBrOpenDeliverySchemaItemOffer.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaItemOfferCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaItemOffer);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaNutritionalInfo }

procedure TACBrOpenDeliverySchemaNutritionalInfo.Clear;
begin
  Fdescription := '';
  Fcalories := '';
  Fallergen := [];
  Fadditives := [];
  FsuitableDiet := [];
  FisAlcoholic := False;
end;

procedure TACBrOpenDeliverySchemaNutritionalInfo.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LStrAllergen: TSplitResult;
  LStrSuitableDiet: TSplitResult;
  I: Integer;
begin
  AJSon
    .Value('description', Fdescription)
    .Value('calories', Fcalories)
    .Value('allergen', LStrAllergen)
    .Value('additives', Fadditives)
    .Value('suitableDiet', LStrSuitableDiet)
    .Value('isAlcoholic', FisAlcoholic);


  SetLength(Fallergen, Length(LStrAllergen));
  for I := 0 to Pred(Length(LStrAllergen)) do
    Fallergen[I] := StrToAllergen(LStrAllergen[I]);

  SetLength(FsuitableDiet, Length(LStrSuitableDiet));
  for I := 0 to Pred(Length(LStrSuitableDiet)) do
    FsuitableDiet[I] := StrToSuitableDiet(LStrSuitableDiet[I]);
end;

procedure TACBrOpenDeliverySchemaNutritionalInfo.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  LStrAllergen: TSplitResult;
  LStrSuitableDiet: TSplitResult;
begin
  LStrAllergen := AllergensToArray(Fallergen);
  LStrSuitableDiet := SuitableDietToArray(FsuitableDiet);

  AJSon
    .AddPair('description', Fdescription)
    .AddPair('calories', Fcalories)
    .AddPair('allergen', LStrAllergen)
    .AddPair('additives', Fadditives)
    .AddPair('suitableDiet', LStrSuitableDiet)
    .AddPair('isAlcoholic', FisAlcoholic);
end;

function TACBrOpenDeliverySchemaNutritionalInfo.IsEmpty: Boolean;
begin
  Result := (Fdescription = '') and
            (Fcalories = '') and
            (Length(Fallergen) = 0) and
            (Length(Fadditives) = 0) and
            (Length(FsuitableDiet) = 0) and
            (not (FisAlcoholic));
end;

{ TACBrOpenDeliverySchemaItem }

procedure TACBrOpenDeliverySchemaItem.Clear;
begin
  Fid := '';
  Fname := '';
  Fdescription := '';
  FexternalCode := '';
  Fserving := 0;
  Funit := '';
  Fean := '';
  Fimage.Clear;
  FnutritionalInfo.Clear;
end;

constructor TACBrOpenDeliverySchemaItem.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fimage := TACBrOpenDeliverySchemaImage.Create('image');
  FnutritionalInfo := TACBrOpenDeliverySchemaNutritionalInfo.Create('nutritionalInfo');
end;

destructor TACBrOpenDeliverySchemaItem.Destroy;
begin
  Fimage.Free;
  FnutritionalInfo.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaItem.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .Value('id', Fid)
    .Value('name', Fname)
    .Value('description', Fdescription)
    .Value('externalCode', FexternalCode)
    .Value('serving', Fserving)
    .Value('unit', Funit)
    .Value('ean', Fean);

  Fimage.DoReadFromJSon(AJSon.AsJSONObject['image']);
  FnutritionalInfo.DoReadFromJSon(AJSon.AsJSONObject['nutritionalInfo']);
end;

procedure TACBrOpenDeliverySchemaItem.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('name', Fname)
    .AddPair('description', Fdescription)
    .AddPair('externalCode', FexternalCode)
    .AddPairJSONObject('image', Fimage.AsJSON)
    .AddPairJSONObject('nutritionalInfo', FnutritionalInfo.AsJSON)
    .AddPair('serving', Fserving)
    .AddPair('unit', Funit)
    .AddPair('ean', Fean);
end;

function TACBrOpenDeliverySchemaItem.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (Fname = '') and
            (Fdescription = '') and
            (FexternalCode = '') and
            (Fserving = 0) and
            (Funit = '') and
            (Fean = '') and
            (Fimage.IsEmpty) and
            (FnutritionalInfo.IsEmpty);
end;

{ TACBrOpenDeliverySchemaItemCollection }

function TACBrOpenDeliverySchemaItemCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaItem;
begin
  Result := TACBrOpenDeliverySchemaItem(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaItemCollection.New: TACBrOpenDeliverySchemaItem;
begin
  Result := TACBrOpenDeliverySchemaItem.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaItemCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaItem);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaOption }

procedure TACBrOpenDeliverySchemaOption.Clear;
begin
  Fid := '';
  FitemId := '';
  Findex := 0;
  FmaxPermitted := 0;
  Fprice.Clear;
end;

constructor TACBrOpenDeliverySchemaOption.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fprice := TACBrOpenDeliverySchemaPrice.Create('price');
end;

destructor TACBrOpenDeliverySchemaOption.Destroy;
begin
  Fprice.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaOption.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .Value('id', Fid)
    .Value('itemId', FitemId)
    .Value('index', Findex)
    .Value('maxPermitted', FmaxPermitted);

  Fprice.DoReadFromJSon(AJSon.AsJSONObject['price']);
end;

procedure TACBrOpenDeliverySchemaOption.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('itemId', FitemId)
    .AddPair('index', Findex)
    .AddPairJSONObject('price', Fprice.AsJSON)
    .AddPair('maxPermitted', FmaxPermitted);
end;

function TACBrOpenDeliverySchemaOption.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (FitemId = '') and
            (Findex = 0) and
            (Fprice.IsEmpty) and
            (FmaxPermitted = 0);
end;

{ TACBrOpenDeliverySchemaOptionCollection }

function TACBrOpenDeliverySchemaOptionCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaOption;
begin
  Result := TACBrOpenDeliverySchemaOption(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaOptionCollection.New: TACBrOpenDeliverySchemaOption;
begin
  Result := TACBrOpenDeliverySchemaOption.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaOptionCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaOption);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaOptionGroup }

procedure TACBrOpenDeliverySchemaOptionGroup.Clear;
begin
  Fid := '';
  Findex := 0;
  Fname := '';
  Fdescription := '';
  FexternalCode := '';
  Fstatus := sAvailable;
  FminPermitted := 0;
  FmaxPermitted := 0;
  Foptions.Clear;
end;

constructor TACBrOpenDeliverySchemaOptionGroup.Create(const AObjectName: string);
begin
  inherited;
  Foptions := TACBrOpenDeliverySchemaOptionCollection.Create;
end;

destructor TACBrOpenDeliverySchemaOptionGroup.Destroy;
begin
  Foptions.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaOptionGroup.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LStrStatus: String;
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  Foptions.Clear;
  AJSon
    .Value('id', Fid)
    .Value('index', Findex)
    .Value('name', Fname)
    .Value('description', Fdescription)
    .Value('externalCode', FexternalCode)
    .Value('status', LStrStatus)
    .Value('minPermitted', FminPermitted)
    .Value('maxPermitted', FmaxPermitted);

  Fstatus := StrToStatus(LStrStatus);
  LJSONArray := AJSon.AsJSONArray['options'];
  for I := 0 to Pred(LJSONArray.Count) do
    Foptions.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
end;

procedure TACBrOpenDeliverySchemaOptionGroup.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  AJSon
    .AddPair('id', Fid)
    .AddPair('index', Findex)
    .AddPair('name', Fname)
    .AddPair('description', Fdescription)
    .AddPair('externalCode', FexternalCode)
    .AddPair('status', StatusToStr(FStatus))
    .AddPair('minPermitted', FminPermitted)
    .AddPair('maxPermitted', FmaxPermitted);

  LJSONArray := TACBrJSONArray.Create;
  try
    LJSONArray.OwnerJSON := True;
    for I := 0 to Pred(Foptions.Count) do
      LJSONArray.AddElementJSONString(Foptions[I].AsJSON);

    AJSon.AddPair('options', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;
end;

function TACBrOpenDeliverySchemaOptionGroup.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (Findex = 0) and
            (Fname = '') and
            (Fdescription = '') and
            (FexternalCode = '') and
            (Fstatus = sAvailable) and
            (FminPermitted = 0) and
            (FmaxPermitted = 0) and
            (Foptions.Count = 0);
end;

{ TACBrOpenDeliverySchemaOptionGroupCollection }

function TACBrOpenDeliverySchemaOptionGroupCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaOptionGroup;
begin
  Result := TACBrOpenDeliverySchemaOptionGroup(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaOptionGroupCollection.New: TACBrOpenDeliverySchemaOptionGroup;
begin
  Result := TACBrOpenDeliverySchemaOptionGroup.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaOptionGroupCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaOptionGroup);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaServiceHourCollection }

function TACBrOpenDeliverySchemaServiceHourCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaServiceHour;
begin
  Result := TACBrOpenDeliverySchemaServiceHour(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaServiceHourCollection.New: TACBrOpenDeliverySchemaServiceHour;
begin
  Result := TACBrOpenDeliverySchemaServiceHour.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaServiceHourCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaServiceHour);
begin
  inherited Items[Index] := Value;
end;

{ TACBrOpenDeliverySchemaAvailability }

procedure TACBrOpenDeliverySchemaAvailability.Clear;
begin
  Fid := '';
  FstartDate := 0;
  FendDate := 0;
  Fhours.Clear;
end;

constructor TACBrOpenDeliverySchemaAvailability.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  Fhours := TACBrOpenDeliverySchemaHourCollection.Create;
end;

destructor TACBrOpenDeliverySchemaAvailability.Destroy;
begin
  Fhours.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaAvailability.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  AJSon
    .Value('id', Fid)
    .ValueISODate('startDate', FstartDate)
    .ValueISODate('endDate', FendDate);

  LJSONArray := AJSon.AsJSONArray['hours'];
  for I := 0 to Pred(LJSONArray.Count) do
    Fhours.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
end;

procedure TACBrOpenDeliverySchemaAvailability.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  AJSon
    .AddPair('id', Fid)
    .AddPairISODateTime('startDate', FstartDate)
    .AddPairISODateTime('endDate', FendDate);

  LJSONArray := TACBrJSONArray.Create;
  try
    LJSONArray.OwnerJSON := True;
    for I := 0 to Pred(Fhours.Count) do
      LJSONArray.AddElementJSONString(Fhours[I].AsJSON);
    AJSon.AddPair('hours', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;
end;

function TACBrOpenDeliverySchemaAvailability.IsEmpty: Boolean;
begin
  Result := (Fid = '') and
            (FstartDate = 0) and
            (FendDate = 0) and
            (Fhours.Count = 0);
end;

{ TACBrOpenDeliverySchemaAvailabilityCollection }

function TACBrOpenDeliverySchemaAvailabilityCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaAvailability;
begin
  Result := TACBrOpenDeliverySchemaAvailability(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaAvailabilityCollection.New: TACBrOpenDeliverySchemaAvailability;
begin
  Result := TACBrOpenDeliverySchemaAvailability.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaAvailabilityCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaAvailability);
begin
  inherited Items[Index];
end;

{ TACBrOpenDeliverySchemaMerchant }

procedure TACBrOpenDeliverySchemaMerchant.Clear;
begin
  FlastUpdate := 0;
  FTTL := 0;
  Fid := '';
  Fstatus := sAvailable;
  FbasicInfo.Clear;
  Fservices.Clear;
  Fmenus.Clear;
  Fitems.Clear;
  Fcategories.Clear;
  FitemOffers.Clear;
  FoptionGroups.Clear;
  Favailabilities.Clear;
end;

constructor TACBrOpenDeliverySchemaMerchant.Create(const AObjectName: string);
begin
  inherited Create(AObjectName);
  FbasicInfo := TACBrOpenDeliverySchemaBasicInfo.Create('basicInfo');
  Fservices := TACBrOpenDeliverySchemaServiceCollection.Create;
  Fmenus := TACBrOpenDeliverySchemaMenuCollection.Create;
  Fitems := TACBrOpenDeliverySchemaItemCollection.Create;
  Fcategories := TACBrOpenDeliverySchemaCategoryCollection.Create;
  FitemOffers := TACBrOpenDeliverySchemaItemOfferCollection.Create;
  FoptionGroups := TACBrOpenDeliverySchemaOptionGroupCollection.Create;
  Favailabilities := TACBrOpenDeliverySchemaAvailabilityCollection.Create;
end;

destructor TACBrOpenDeliverySchemaMerchant.Destroy;
begin
  FbasicInfo.Free;
  Fservices.Free;
  Fmenus.Free;
  Fitems.Free;
  Fcategories.Free;
  FitemOffers.Free;
  FoptionGroups.Free;
  Favailabilities.Free;
  inherited;
end;

procedure TACBrOpenDeliverySchemaMerchant.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LStrStatus: String;
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  AJSon
    .ValueISODateTime('lastUpdate', FlastUpdate)
    .Value('TTL', FTTL)
    .Value('id', Fid)
    .Value('status', LStrStatus);
  Fstatus := StrToStatus(LStrStatus);
  FbasicInfo.DoReadFromJSon(AJSon.AsJSONObject['basicInfo']);

  LJSONArray := AJSon.AsJSONArray['services'];
  for I := 0 to Pred(LJSONArray.Count) do
    Fservices.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;

  LJSONArray := AJSon.AsJSONArray['menus'];
  for I := 0 to Pred(LJSONArray.Count) do
    Fmenus.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;

  LJSONArray := AJSon.AsJSONArray['categories'];
  for I := 0 to Pred(LJSONArray.Count) do
    Fcategories.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;

  LJSONArray := AJSon.AsJSONArray['itemOffers'];
  for I := 0 to Pred(LJSONArray.Count) do
    FitemOffers.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;

  LJSONArray := AJSon.AsJSONArray['optionGroups'];
  for I := 0 to Pred(LJSONArray.Count) do
    FoptionGroups.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;

  LJSONArray := AJSon.AsJSONArray['availabilities'];
  for I := 0 to Pred(LJSONArray.Count) do
    Favailabilities.New.AsJSON := LJSONArray.ItemAsJSONObject[I].ToJSON;
end;

procedure TACBrOpenDeliverySchemaMerchant.DoWriteToJSon(AJSon: TACBrJSONObject);
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  AJSon
    .AddPairISODateTime('lastUpdate', FlastUpdate)
    .AddPair('TTL', FTTL)
    .AddPair('id', Fid)
    .AddPair('status', StatusToStr(Fstatus))
    .AddPairJSONObject('basicInfo', FbasicInfo.AsJSON);

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Fservices.Count) do
      LJSONArray.AddElementJSONString(Fservices[I].AsJSON);
    AJSon.AddPair('services', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Fmenus.Count) do
      LJSONArray.AddElementJSONString(Fmenus[I].AsJSON);
    AJSon.AddPair('menus', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Fitems.Count) do
      LJSONArray.AddElementJSONString(Fitems[I].AsJSON);
    AJSon.AddPair('items', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Fcategories.Count) do
      LJSONArray.AddElementJSONString(Fcategories[I].AsJSON);
    AJSon.AddPair('categories', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(FitemOffers.Count) do
      LJSONArray.AddElementJSONString(FitemOffers[I].AsJSON);
    AJSon.AddPair('itemOffers', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(FoptionGroups.Count) do
      LJSONArray.AddElementJSONString(FoptionGroups[I].AsJSON);
    AJSon.AddPair('optionGroups', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;

  LJSONArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Favailabilities.Count) do
      LJSONArray.AddElementJSONString(Favailabilities[I].AsJSON);
    AJSon.AddPair('availabilities', LJSONArray);
  except
    LJSONArray.Free;
    raise;
  end;
end;

function TACBrOpenDeliverySchemaMerchant.IsEmpty: Boolean;
begin
  Result := (FlastUpdate = 0) and
            (FTTL = 0) and
            (Fid = '') and
            (Fstatus = sAvailable) and
            (FbasicInfo.IsEmpty) and
            (Fservices.Count = 0) and
            (Fmenus.Count = 0) and
            (Fitems.Count = 0) and
            (Fcategories.Count = 0) and
            (FitemOffers.Count = 0) and
            (FoptionGroups.Count = 0) and
            (Favailabilities.Count = 0);
end;

{ TACBrOpenDeliverySchemaError }

procedure TACBrOpenDeliverySchemaError.Clear;
begin
  FStatus := 0;
  FTitle := '';
end;

procedure TACBrOpenDeliverySchemaError.DoReadFromJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .Value('status', FStatus)
    .Value('title', FTitle);
end;

procedure TACBrOpenDeliverySchemaError.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('status', FStatus)
    .AddPair('title', FTitle);
end;

function TACBrOpenDeliverySchemaError.IsEmpty: Boolean;
begin
  Result := (Fstatus = 0) and (FTitle = '');
end;

{ TACBrOpenDeliverySchemaEvent }

procedure TACBrOpenDeliverySchemaEvent.Clear;
begin
  FEventId := '';
  FEventType := etCreated;
  FOrderId := '';
  FOrderURL := '';
  FCreatedAt := 0;
  FSourceAppId := '';
end;

procedure TACBrOpenDeliverySchemaEvent.DoReadFromJSon(AJSon: TACBrJSONObject);
var
  LStrEventType: string;
begin
  AJSon
    .Value('eventId',  FEventId)
    .Value('eventType', LStrEventType)
    .Value('orderId', FOrderId)
    .Value('orderURL', FOrderURL)
    .ValueISODateTime('createdAt', FCreatedAt)
    .Value('sourceAppId', FSourceAppId);

  FEventType := StrToEventType(LStrEventType);
end;

procedure TACBrOpenDeliverySchemaEvent.DoWriteToJSon(AJSon: TACBrJSONObject);
begin
  AJSon
    .AddPair('eventId', FEventId)
    .AddPair('eventType', EventTypeToStr(FEventType))
    .AddPair('orderId', FOrderId)
    .AddPair('orderURL', FOrderURL)
    .AddPairISODateTime('createdAt', FCreatedAt)
    .AddPair('sourceAppId', FSourceAppId);
end;

function TACBrOpenDeliverySchemaEvent.IsEmpty: Boolean;
begin
  Result := (FEventId = '') and
            (FEventType = etCreated) and
            (FOrderId = '') and
            (FOrderURL = '') and
            (FCreatedAt = 0) and
            (FSourceAppId = '');
end;

{ TACBrOpenDeliverySchemaEventCollection }

function TACBrOpenDeliverySchemaEventCollection.GetItem(Index: Integer): TACBrOpenDeliverySchemaEvent;
begin
  Result := TACBrOpenDeliverySchemaEvent(inherited Items[Index]);
end;

function TACBrOpenDeliverySchemaEventCollection.New: TACBrOpenDeliverySchemaEvent;
begin
  Result := TACBrOpenDeliverySchemaEvent.Create;
  Self.Add(Result);
end;

procedure TACBrOpenDeliverySchemaEventCollection.SetItem(Index: Integer; Value: TACBrOpenDeliverySchemaEvent);
begin
  inherited Items[Index] := Value;
end;

end.

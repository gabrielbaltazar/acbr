unit pcnConversaoOD;

interface

uses
  SysUtils,
  StrUtils,
  TypInfo,
  Classes,
  ACBrUtil.Strings;

type
  TACBrODDayOfWeek = (dwMonday, dwTuesday, dwWednesday, dwThursday, dwFriday, dwSaturday, dwSunday);

  TACBrODDayOfWeekArray = array of TACBrODDayOfWeek;

  TACBrODMerchantCategories = (mcBurgers,
                               mcPizza,
                               mcFastFood,
                               mcHotDog,
                               mcJapanese,
                               mcDesserts,
                               mcAmerican,
                               mcIceCream,
                               mcBBQ,
                               mcSandwich,
                               mcMexican,
                               mcBrazilian,
                               mcPastry,
                               mcArabian,
                               mcComfortFood,
                               mcVegetarian,
                               mcVegan,
                               mcBakery,
                               mcHealthy,
                               mcItalian,
                               mcChinese,
                               mcJuiceSmoothies,
                               mcSeafood,
                               mcCafe,
                               mcSalads,
                               mcCoffeeTea,
                               mcPasta,
                               mcBreakfastBrunch,
                               mcLatinAmerican,
                               mcConvenience,
                               mcPub,
                               mcHawaiian,
                               mcEuropean,
                               mcFamilyMeals,
                               mcFrench,
                               mcIndian,
                               mcPortuguese,
                               mcSpanish,
                               mcGourmet,
                               mcKidsFriendly,
                               mcSouthAmerican,
                               mcSpecialtyFoods,
                               mcArgentinian,
                               mcPremium,
                               mcAffordableMeals);

  TACBrODMerchantCategoriesArray = array of TACBrODMerchantCategories;

  TACBrODMerchantType = (mtRestaurant);

  TACBrODServiceType = (stDelivery, stTakeout);

  TACBrODStatus = (sAvailable, sUnavailable);

function DayOfWeekToStr(AValue: TACBrODDayOfWeek): String;
function DayOfWeekToArray(AValue: TACBrODDayOfWeekArray): TSplitResult;
function StrToDayOfWeek(const AValue: String): TACBrODDayOfWeek;

function MerchantCategoriesToStr(AValue: TACBrODMerchantCategories): String;
function MerchantCategoriesToArray(AValue: TACBrODMerchantCategoriesArray): TSplitResult;
function StrToMerchantCategories(const AValue: String): TACBrODMerchantCategories;

function MerchantTypeToStr(AValue: TACBrODMerchantType): string;
function StrToMerchantType(AValue: String): TACBrODMerchantType;

function ServiceTypeToStr(AValue: TACBrODServiceType): string;
function StrToServiceType(AValue: String): TACBrODServiceType;

function StatusToStr(AValue: TACBrODStatus): string;
function StrToStatus(AValue: String): TACBrODStatus;

implementation

function DayOfWeekToStr(AValue: TACBrODDayOfWeek): String;
begin
  case AValue of
    dwMonday: Result := 'MONDAY';
    dwTuesday: Result := 'TUESDAY';
    dwWednesday: Result := 'WEDNESDAY';
    dwThursday: Result := 'THURSDAY';
    dwFriday: Result := 'FRIDAY';
    dwSaturday: Result := 'SATURDAY';
    dwSunday: Result := 'SUNDAY';
  else
    Result := '';
  end;
end;

function DayOfWeekToArray(AValue: TACBrODDayOfWeekArray): TSplitResult;
var
  I: Integer;
begin
  SetLength(Result, Length(AValue));
  for I := 0 to Pred(Length(AValue)) do
    Result[I] := DayOfWeekToStr(AValue[I]);
end;

function StrToDayOfWeek(const AValue: String): TACBrODDayOfWeek;
var
  LStr: String;
begin
  LStr := UpperCase(AValue);
  if LStr = 'MONDAY' then
    Result := dwMonday
  else if LStr = 'TUESDAY' then
    Result := dwTuesday
  else if LStr = 'WEDNESDAY' then
    Result := dwWednesday
  else if LStr = 'THURSDAY' then
    Result := dwThursday
  else if LStr = 'FRIDAY' then
    Result := dwFriday
  else if LStr = 'SATURDAY' then
    Result := dwSaturday
  else if LStr = 'SUNDAY' then
    Result := dwSunday;
end;

function MerchantCategoriesToStr(AValue: TACBrODMerchantCategories): String;
begin
  case AValue of
    mcBurgers: Result := 'BURGERS';
    mcPizza: Result := 'PIZZA';
    mcFastFood: Result := 'FAST_FOOD';
    mcHotDog: Result := 'HOT_DOG';
    mcJapanese: Result := 'JAPANESE';
    mcDesserts: Result := 'DESSERTS';
    mcAmerican: Result := 'AMERICAN';
    mcIceCream: Result := 'ICE_CREAM';
    mcBBQ: Result := 'BBQ';
    mcSandwich: Result := 'SANDWICH';
    mcMexican: Result := 'MEXICAN';
    mcBrazilian: Result := 'BRAZILIAN';
    mcPastry: Result := 'PASTRY';
    mcArabian: Result := 'ARABIAN';
    mcComfortFood: Result := 'COMFORT_FOOD';
    mcVegetarian: Result := 'VEGETARIAN';
    mcVegan: Result := 'VEGAN';
    mcBakery: Result := 'BAKERY';
    mcHealthy: Result := 'HEALTHY';
    mcItalian: Result := 'ITALIAN';
    mcChinese: Result := 'CHINESE';
    mcJuiceSmoothies: Result := 'JUICE_SMOOTHIES';
    mcSeafood: Result := 'SEAFOOD';
    mcCafe: Result := 'CAFE';
    mcSalads: Result := 'SALADS';
    mcCoffeeTea: Result := 'COFFEE_TEA';
    mcPasta: Result := 'PASTA';
    mcBreakfastBrunch: Result := 'BREAKFAST_BRUNCH';
    mcLatinAmerican: Result := 'LATIN_AMERICAN';
    mcConvenience: Result := 'CONVENIENCE';
    mcPub: Result := 'PUB';
    mcHawaiian: Result := 'HAWAIIAN';
    mcEuropean: Result := 'EUROPEAN';
    mcFamilyMeals: Result := 'FAMILY_MEALS';
    mcFrench: Result := 'FRENCH';
    mcIndian: Result := 'INDIAN';
    mcPortuguese: Result := 'PORTUGUESE';
    mcSpanish: Result := 'SPANISH';
    mcGourmet: Result := 'GOURMET';
    mcKidsFriendly: Result := 'KIDS_FRIENDLY';
    mcSouthAmerican: Result := 'SOUTH_AMERICAN';
    mcSpecialtyFoods: Result := 'SPECIALTY_FOODS';
    mcArgentinian: Result := 'ARGENTINIAN';
    mcPremium: Result := 'PREMIUM';
    mcAffordableMeals: Result := 'AFFORDABLE_MEALS';
  else
    Result := '';
  end;
end;

function MerchantCategoriesToArray(AValue: TACBrODMerchantCategoriesArray): TSplitResult;
var
  I: Integer;
begin
  SetLength(Result, Length(AValue));
  for I := 0 to Pred(Length(AValue)) do
    Result[I] := MerchantCategoriesToStr(AValue[I]);
end;

function StrToMerchantCategories(const AValue: String): TACBrODMerchantCategories;
var
  LStr: String;
begin
  LStr := UpperCase(AValue);
  if LStr = 'BURGERS' then
    Result := mcBurgers
  else if LStr = 'PIZZA' then
    Result := mcPizza
  else if LStr = 'FAST_FOOD' then
    Result := mcFastFood
  else if LStr = 'HOT_DOG' then
    Result := mcHotDog
  else if LStr = 'JAPANESE' then
    Result := mcJapanese
  else if LStr = 'DESSERTS' then
    Result := mcDesserts
  else if LStr = 'AMERICAN' then
    Result := mcAmerican
  else if LStr = 'ICE_CREAM' then
    Result := mcIceCream
  else if LStr = 'BBQ' then
    Result := mcBBQ
  else if LStr = 'SANDWICH' then
    Result := mcSandwich
  else if LStr = 'MEXICAN' then
    Result := mcMexican
  else if LStr = 'BRAZILIAN' then
    Result := mcBrazilian
  else if LStr = 'PASTRY' then
    Result := mcPastry
  else if LStr = 'ARABIAN' then
    Result := mcArabian
  else if LStr = 'COMFORT_FOOD' then
    Result := mcComfortFood
  else if LStr = 'VEGETARIAN' then
    Result := mcVegetarian
  else if LStr = 'VEGAN' then
    Result := mcVegan
  else if LStr = 'BAKERY' then
    Result := mcBakery
  else if LStr = 'HEALTHY' then
    Result := mcHealthy
  else if LStr = 'ITALIAN' then
    Result := mcItalian
  else if LStr = 'CHINESE' then
    Result := mcChinese
  else if LStr = 'JUICE_SMOOTHIES' then
    Result := mcJuiceSmoothies
  else if LStr = 'SEAFOOD' then
    Result := mcSeafood
  else if LStr = 'CAFE' then
    Result := mcCafe
  else if LStr = 'SALADS' then
    Result := mcSalads
  else if LStr = 'COFFEE_TEA' then
    Result := mcCoffeeTea
  else if LStr = 'PASTA' then
    Result := mcPasta
  else if LStr = 'BREAKFAST_BRUNCH' then
    Result := mcBreakfastBrunch
  else if LStr = 'LATIN_AMERICAN' then
    Result := mcLatinAmerican
  else if LStr = 'CONVENIENCE' then
    Result := mcConvenience
  else if LStr = 'PUB' then
    Result := mcPub
  else if LStr = 'HAWAIIAN' then
    Result := mcHawaiian
  else if LStr = 'EUROPEAN' then
    Result := mcEuropean
  else if LStr = 'FAMILY_MEALS' then
    Result := mcFamilyMeals
  else if LStr = 'FRENCH' then
    Result := mcFrench
  else if LStr = 'INDIAN' then
    Result := mcIndian
  else if LStr = 'PORTUGUESE' then
    Result := mcPortuguese
  else if LStr = 'SPANISH' then
    Result := mcSpanish
  else if LStr = 'GOURMET' then
    Result := mcGourmet
  else if LStr = 'KIDS_FRIENDLY' then
    Result := mcKidsFriendly
  else if LStr = 'SOUTH_AMERICAN' then
    Result := mcSouthAmerican
  else if LStr = 'SPECIALTY_FOODS' then
    Result := mcSpecialtyFoods
  else if LStr = 'ARGENTINIAN' then
    Result := mcArgentinian
  else if LStr = 'PREMIUM' then
    Result := mcPremium
  else if LStr = 'AFFORDABLE_MEALS' then
    Result := mcAffordableMeals;
end;

function MerchantTypeToStr(AValue: TACBrODMerchantType): string;
begin
  case AValue of
    mtRestaurant: Result := 'RESTAURANT';
  else
    Result := '';
  end;
end;

function StrToMerchantType(AValue: String): TACBrODMerchantType;
begin
  Result := mtRestaurant;
end;

function ServiceTypeToStr(AValue: TACBrODServiceType): string;
begin
  case AValue of
    stDelivery: Result := 'DELIVERY';
    stTakeout: Result := 'TAKEOUT';
  else
    Result := '';
  end;

end;
function StrToServiceType(AValue: String): TACBrODServiceType;
var
  LStr: String;
begin
  LStr := UpperCase(AValue);
  if LStr = 'DELIVERY' then
    Result := stDelivery
  else if LStr = 'TAKEOUT' then
    Result := stDelivery;
end;

function StatusToStr(AValue: TACBrODStatus): string;
begin
  case AValue of
    sAvailable: Result := 'AVAILABLE';
    sUnavailable: Result := 'UNAVAILABLE';
  else
    Result := '';
  end;
end;

function StrToStatus(AValue: String): TACBrODStatus;
var
  LStr: string;
begin
  LStr := UpperCase(AValue);
  if LStr = 'AVAILABLE' then
    Result := sAvailable
  else if LStr = 'UNAVAILABLE' then
    Result := sUnavailable;
end;

end.
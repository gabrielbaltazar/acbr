unit pcnConversaoOD;

interface

uses
  SysUtils,
  StrUtils,
  TypInfo,
  Classes,
  ACBrUtil.Strings;

type
  TACBrODAllergen =
    (aAlmonds, aAlphaIsomethylIonone, aAlcohol, aAmylCinnamal, aAniseAlcohol,
     aBarley, aBenzylAlcohol, aBenzylBenzoate, aBenzylCinnamate, aBenzylSalicylate,
     aBrazilNuts, aButylphenylMethylpropionate, aCarrots, aCashewNuts, aCelery,
     aCerealsContainingGluten, aCinnamal, aCinnamylAlcohol, aCitral, aCitronellol,
     aCocoa, aCoriander, aCorn, aCoumarin, aCrustaceans, aEggs, aEugenol, aEverniaFurfuracea,
     aEverniaPrunastri, aFarnesol, aFish, aGeraniol, aGluten, aHazelnuts, aHexylCinnamal,
     aHydroxycitronellal, aKamut, aLactose, aLupine, aMacadamiaNuts, aMethyl2Octynoate, aMilk,
     aMolluscs, aMustard, aNoDeclaredAllergens, aOat, aPeanuts, aPeas, aPecanNuts, aPistachios,
     aProdFruits, aQueenslandNuts, aRye, aSesameSeeds, aSoybeans, aSpelt, aSulphurDioxide,
     aTreeNuts, aTreeNutTraces, aWalnuts, aWheat);

  TACBrODAllergenArray = array of TACBrODAllergen;

  TACBrODDayOfWeek =
    (dwMonday, dwTuesday, dwWednesday, dwThursday, dwFriday,
     dwSaturday, dwSunday);

  TACBrODDayOfWeekArray = array of TACBrODDayOfWeek;

  TACBrODMerchantCategories =
    (mcBurgers, mcPizza, mcFastFood, mcHotDog, mcJapanese, mcDesserts, mcAmerican,
     mcIceCream, mcBBQ, mcSandwich, mcMexican, mcBrazilian, mcPastry, mcArabian,
     mcComfortFood, mcVegetarian, mcVegan, mcBakery, mcHealthy, mcItalian, mcChinese,
     mcJuiceSmoothies, mcSeafood, mcCafe, mcSalads, mcCoffeeTea, mcPasta, mcBreakfastBrunch,
     mcLatinAmerican, mcConvenience, mcPub, mcHawaiian, mcEuropean, mcFamilyMeals, mcFrench,
     mcIndian, mcPortuguese, mcSpanish, mcGourmet, mcKidsFriendly, mcSouthAmerican,
     mcSpecialtyFoods, mcArgentinian, mcPremium, mcAffordableMeals);

  TACBrODMerchantCategoriesArray = array of TACBrODMerchantCategories;

  TACBrODMerchantType = (mtRestaurant);

  TACBrODServiceType = (stDelivery, stTakeout);

  TACBrODStatus = (sAvailable, sUnavailable);

  TACBrODSuitableDiet =
    (sdDiabetic, sdGlutenFree, sdHalal, sdHindu, sdKosher,
     sdLowCalorie, sdLowFat, sdLowLactose, sdLowSalt, sdVegan,
     sdVegetarian);

  TACBrODSuitableDietArray = array of TACBrODSuitableDiet;

function AllergenToStr(AValue: TACBrODAllergen): String;
function AllergensToArray(AValue: TACBrODAllergenArray): TSplitResult;
function StrToAllergen(const AValue: String): TACBrODAllergen;

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

function SuitableDietToStr(AValue: TACBrODSuitableDiet): String;
function SuitableDietToArray(AValue: TACBrODSuitableDietArray): TSplitResult;
function StrToSuitableDiet(const AValue: String): TACBrODSuitableDiet;

implementation

function AllergenToStr(AValue: TACBrODAllergen): String;
begin
  case AValue of
    aAlmonds: Result := 'ALMONDS';
    aAlphaIsomethylIonone: Result := 'ALPHA_ISOMETHYL_IONONE';
    aAlcohol: Result := 'ALCOHOL';
    aAmylCinnamal: Result := 'AMYL_CINNAMAL';
    aAniseAlcohol: Result := 'ANISE_ALCOHOL';
    aBarley: Result := 'BARLEY';
    aBenzylAlcohol: Result := 'BENZYL_ALCOHOL';
    aBenzylBenzoate: Result := 'BENZYL_BENZOATE';
    aBenzylCinnamate: Result := 'BENZYL_CINNAMATE';
    aBenzylSalicylate: Result := 'BENZYL_SALICYLATE';
    aBrazilNuts: Result := 'BRAZIL_NUTS';
    aButylphenylMethylpropionate: Result := 'BUTYLPHENYL_METHYLPROPIONATE';
    aCarrots: Result := 'CARROTS';
    aCashewNuts: Result := 'CASHEW_NUTS';
    aCelery: Result := 'CELERY';
    aCerealsContainingGluten: Result := 'CEREALS_CONTAINING_GLUTEN';
    aCinnamal: Result := 'CINNAMAL';
    aCinnamylAlcohol: Result := 'CINNAMYL_ALCOHOL';
    aCitral: Result := 'CITRAL';
    aCitronellol: Result := 'CITRONELLOL';
    aCocoa: Result := 'COCOA';
    aCoriander: Result := 'CORIANDER';
    aCorn: Result := 'CORN';
    aCoumarin: Result := 'COUMARIN';
    aCrustaceans: Result := 'CRUSTACEANS';
    aEggs: Result := 'EGGS';
    aEugenol: Result := 'EUGENOL';
    aEverniaFurfuracea: Result := 'EVERNIA_FURFURACEA';
    aEverniaPrunastri: Result := 'EVERNIA_PRUNASTRI';
    aFarnesol: Result := 'FARNESOL';
    aFish: Result := 'FISH';
    aGeraniol: Result := 'GERANIOL';
    aGluten: Result := 'GLUTEN';
    aHazelnuts: Result := 'HAZELNUTS';
    aHexylCinnamal: Result := 'HEXYL_CINNAMAL';
    aHydroxycitronellal: Result := 'HYDROXYCITRONELLAL';
    aKamut: Result := 'KAMUT';
    aLactose: Result := 'LACTOSE';
    aLupine: Result := 'LUPINE';
    aMacadamiaNuts: Result := 'MACADAMIA_NUTS';
    aMethyl2Octynoate: Result := 'METHYL_2_OCTYNOATE';
    aMilk: Result := 'MILK';
    aMolluscs: Result := 'MOLLUSCS';
    aMustard: Result := 'MUSTARD';
    aNoDeclaredAllergens: Result := 'NO_DECLARED_ALLERGENS';
    aOat: Result := 'OAT';
    aPeanuts: Result := 'PEANUTS';
    aPeas: Result := 'PEAS';
    aPecanNuts: Result := 'PECAN_NUTS';
    aPistachios: Result := 'PISTACHIOS';
    aProdFruits: Result := 'POD_FRUITS';
    aQueenslandNuts: Result := 'QUEENSLAND_NUTS';
    aRye: Result := 'RYE';
    aSesameSeeds: Result := 'SESAME_SEEDS';
    aSoybeans: Result := 'SOYBEANS';
    aSpelt: Result := 'SPELT';
    aSulphurDioxide: Result := 'SULPHUR_DIOXIDE';
    aTreeNuts: Result := 'TREE_NUTS';
    aTreeNutTraces: Result := 'TREE_NUT_TRACES';
    aWalnuts: Result := 'WALNUTS';
    aWheat: Result := 'WHEAT';
  else
    Result := '';
  end;
end;

function AllergensToArray(AValue: TACBrODAllergenArray): TSplitResult;
var
  I: Integer;
begin
  SetLength(Result, Length(AValue));
  for I := 0 to Pred(Length(AValue)) do
    Result[I] := AllergenToStr(AValue[I]);
end;

function StrToAllergen(const AValue: String): TACBrODAllergen;
var
  LStr: String;
begin
  Result := aAlmonds;
  LStr := UpperCase(AValue);
  if LStr = 'ALMONDS' then
    Result := aAlmonds
  else if LStr = 'ALPHA_ISOMETHYL_IONONE' then
    Result := aAlphaIsomethylIonone
  else if LStr = 'ALCOHOL' then
    Result := aAlcohol
  else if LStr = 'AMYL_CINNAMAL' then
    Result := aAmylCinnamal
  else if LStr = 'ANISE_ALCOHOL' then
    Result := aAniseAlcohol
  else if LStr = 'BARLEY' then
    Result := aBarley
  else if LStr = 'BENZYL_ALCOHOL' then
    Result := aBenzylAlcohol
  else if LStr = 'BENZYL_BENZOATE' then
    Result := aBenzylBenzoate
  else if LStr = 'BENZYL_CINNAMATE' then
    Result := aBenzylCinnamate
  else if LStr = 'BENZYL_SALICYLATE' then
    Result := aBenzylSalicylate
  else if LStr = 'BRAZIL_NUTS' then
    Result := aBrazilNuts
  else if LStr = 'BUTYLPHENYL_METHYLPROPIONATE' then
    Result := aButylphenylMethylpropionate
  else if LStr = 'CARROTS' then
    Result := aCarrots
  else if LStr = 'CASHEW_NUTS' then
    Result := aCashewNuts
  else if LStr = 'CELERY' then
    Result := aCelery
  else if LStr = 'CEREALS_CONTAINING_GLUTEN' then
    Result := aCerealsContainingGluten
  else if LStr = 'CINNAMAL' then
    Result := aCinnamal
  else if LStr = 'CINNAMYL_ALCOHOL' then
    Result := aCinnamylAlcohol
  else if LStr = 'CITRAL' then
    Result := aCitral
  else if LStr = 'CITRONELLOL' then
    Result := aCitronellol
  else if LStr = 'COCOA' then
    Result := aCocoa
  else if LStr = 'CORIANDER' then
    Result := aCoriander
  else if LStr = 'CORN' then
    Result := aCorn
  else if LStr = 'COUMARIN' then
    Result := aCoumarin
  else if LStr = 'CRUSTACEANS' then
    Result := aCrustaceans
  else if LStr = 'EGGS' then
    Result := aEggs
  else if LStr = 'EUGENOL' then
    Result := aEugenol
  else if LStr = 'EVERNIA_FURFURACEA' then
    Result := aEverniaFurfuracea
  else if LStr = 'EVERNIA_PRUNASTRI' then
    Result := aEverniaPrunastri
  else if LStr = 'FARNESOL' then
    Result := aFarnesol
  else if LStr = 'FISH' then
    Result := aFish
  else if LStr = 'GERANIOL' then
    Result := aGeraniol
  else if LStr = 'GLUTEN' then
    Result := aGluten
  else if LStr = 'HAZELNUTS' then
    Result := aHazelnuts
  else if LStr = 'HEXYL_CINNAMAL' then
    Result := aHexylCinnamal
  else if LStr = 'HYDROXYCITRONELLAL' then
    Result := aHydroxycitronellal
  else if LStr = 'KAMUT' then
    Result := aKamut
  else if LStr = 'LACTOSE' then
    Result := aLactose
  else if LStr = 'LUPINE' then
    Result := aLupine
  else if LStr = 'MACADAMIA_NUTS' then
    Result := aMacadamiaNuts
  else if LStr = 'METHYL_2_OCTYNOATE' then
    Result := aMethyl2Octynoate
  else if LStr = 'MILK' then
    Result := aMilk
  else if LStr = 'MOLLUSCS' then
    Result := aMolluscs
  else if LStr = 'MUSTARD' then
    Result := aMustard
  else if LStr = 'NO_DECLARED_ALLERGENS' then
    Result := aNoDeclaredAllergens
  else if LStr = 'OAT' then
    Result := aOat
  else if LStr = 'PEANUTS' then
    Result := aPeanuts
  else if LStr = 'PEAS' then
    Result := aPeas
  else if LStr = 'PECAN_NUTS' then
    Result := aPecanNuts
  else if LStr = 'PISTACHIOS' then
    Result := aPistachios
  else if LStr = 'POD_FRUITS' then
    Result := aProdFruits
  else if LStr = 'QUEENSLAND_NUTS' then
    Result := aQueenslandNuts
  else if LStr = 'RYE' then
    Result := aRye
  else if LStr = 'SESAME_SEEDS' then
    Result := aSesameSeeds
  else if LStr = 'SOYBEANS' then
    Result := aSoybeans
  else if LStr = 'SPELT' then
    Result := aSpelt
  else if LStr = 'SULPHUR_DIOXIDE' then
    Result := aSulphurDioxide
  else if LStr = 'TREE_NUTS' then
    Result := aTreeNuts
  else if LStr = 'TREE_NUT_TRACES' then
    Result := aTreeNutTraces
  else if LStr = 'WALNUTS' then
    Result := aWalnuts
  else if LStr = 'WHEAT' then
    Result := aWheat;
end;


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
  Result := dwMonday;
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
  Result := mcBurgers;
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
  Result := stDelivery;
  LStr := UpperCase(AValue);
  if LStr = 'DELIVERY' then
    Result := stDelivery
  else if LStr = 'TAKEOUT' then
    Result := stTakeout;
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
  Result := sAvailable;
  LStr := UpperCase(AValue);
  if LStr = 'AVAILABLE' then
    Result := sAvailable
  else if LStr = 'UNAVAILABLE' then
    Result := sUnavailable;
end;

function SuitableDietToStr(AValue: TACBrODSuitableDiet): String;
begin
  case AValue of
    sdDiabetic: Result := 'DIABETIC';
    sdGlutenFree: Result := 'GLUTEN_FREE';
    sdHalal: Result := 'HALAL';
    sdHindu: Result := 'HINDU';
    sdKosher: Result := 'KOSHER';
    sdLowCalorie: Result := 'LOW_CALORIE';
    sdLowFat: Result := 'LOW_FAT';
    sdLowLactose: Result := 'LOW_LACTOSE';
    sdLowSalt: Result := 'LOW_SALT';
    sdVegan: Result := 'VEGAN';
    sdVegetarian: Result := 'VEGETARIAN';
  else
    Result := '';
  end;
end;

function SuitableDietToArray(AValue: TACBrODSuitableDietArray): TSplitResult;
var
  I: Integer;
begin
  SetLength(Result, Length(AValue));
  for I := 0 to Pred(Length(AValue)) do
    Result[I] := SuitableDietToStr(AValue[I]);
end;

function StrToSuitableDiet(const AValue: String): TACBrODSuitableDiet;
var
  LStr: string;
begin
  Result := sdDiabetic;
  LStr := UpperCase(AValue);
  if LStr = 'DIABETIC' then
    Result := sdDiabetic
  else if LStr = 'GLUTEN_FREE' then
    Result := sdGlutenFree
  else if LStr = 'HALAL' then
    Result := sdHalal
  else if LStr = 'HINDU' then
    Result := sdHindu
  else if LStr = 'KOSHER' then
    Result := sdKosher
  else if LStr = 'LOW_CALORIE' then
    Result := sdLowCalorie
  else if LStr = 'LOW_FAT' then
    Result := sdLowFat
  else if LStr = 'LOW_LACTOSE' then
    Result := sdLowLactose
  else if LStr = 'LOW_SALT' then
    Result := sdLowSalt
  else if LStr = 'VEGAN' then
    Result := sdVegan
  else if LStr = 'VEGETARIAN' then
    Result := sdVegetarian;
end;

end.

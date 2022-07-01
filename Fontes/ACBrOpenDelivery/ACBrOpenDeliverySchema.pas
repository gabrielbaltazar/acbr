unit ACBrOpenDeliverySchema;

interface

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrJSON,
  Classes,
  SysUtils;

type
  TACBrJSONObject = ACBrJSON.TACBrJSONObject;
  TACBrJSONArray = ACBrJSON.TACBrJSONArray;

  TACBrOpenDeliverySchema = class
  private
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);

    function GetJSONContext(AJson: TACBrJSONObject): TACBrJSONObject;
  protected
    FObjectName: String;

    procedure DoWriteToJSon(AJson: TACBrJSONObject); virtual;
    procedure DoReadFromJSon(AJson: TACBrJSONObject); virtual;

  public
    constructor Create(const AObjectName: string = ''); virtual;
    procedure Clear; virtual;
    function IsEmpty: Boolean; virtual;
    procedure WriteToJSon(AJson: TACBrJSONObject);
    procedure ReadFromJSon(AJson: TACBrJSONObject);

    property AsJSON: String read GetAsJSON write SetAsJSON;
  end;

//  TACBrOpenDeliveryJson = class
//  private
//    FJson: TACBrJSONObject;
//
//  public
//    constructor Create(AJson: TACBrJSONObject);
//    class function New(AJson: TACBrJSONObject): TACBrOpenDeliveryJson;
//
//    function AddArray(AName: string; AValue: TACBrJSONArray; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//    function AddBoolean(AName: string; AValue: Boolean; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//    function AddDateTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//    function AddObject(AName: string; AValue: TACBrJSONObject; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//    function AddString(AName, AValue: String; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//    function AddNumber(AName: string; AValue: Double; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//
//    function ValueAsBoolean(AName: String; var AValue: Boolean; ADefault: Boolean = False): TACBrOpenDeliveryJson;
//    function ValueAsInteger(AName: String; var AValue: Integer; ADefault: Integer = 0): TACBrOpenDeliveryJson;
//    function ValueAsDateTime(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrOpenDeliveryJson;
//    function ValueAsFloat(AName: String; var AValue: Double; ADefault: Double = 0): TACBrOpenDeliveryJson;
//    function ValueAsString(AName: String; var AValue: String; ADefault: String = ''): TACBrOpenDeliveryJson;
//  end;

  TACBrODStringArray = array of String;

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

implementation

{ TACBrOpenDeliverySchema }

procedure TACBrOpenDeliverySchema.Clear;
begin

end;

constructor TACBrOpenDeliverySchema.Create(const AObjectName: string);
begin
  inherited Create;
  FObjectName := AObjectName;
end;

procedure TACBrOpenDeliverySchema.DoReadFromJSon(AJson: TACBrJSONObject);
begin

end;

procedure TACBrOpenDeliverySchema.DoWriteToJSon(AJson: TACBrJSONObject);
begin

end;

function TACBrOpenDeliverySchema.GetAsJSON: String;
var
  LJSON: TACBrJSONObject;
begin
  LJSON := TACBrJSONObject.Create;
  try
    WriteToJSon(LJSON);
    LJSON.OwnerJSON := True;
    Result := LJSON.ToJSON;
  finally
    LJSON.Free;
  end;
end;

function TACBrOpenDeliverySchema.GetJSONContext(AJson: TACBrJSONObject): TACBrJSONObject;
begin
  Result := AJson;
  if (FObjectName <> '') then
    Result := AJSon.AsJSONContext[FObjectName];
//  begin
//    {$IfDef USE_JSONDATAOBJECTS_UNIT}
//     Result := AJson.O[FObjectName];
//    {$Else}
//     Result := AJson[FObjectName].AsObject;
//    {$EndIf}
//  end
//  else
//    Result := AJson;
end;

function TACBrOpenDeliverySchema.IsEmpty: Boolean;
begin
  Result := False;
end;

procedure TACBrOpenDeliverySchema.ReadFromJSon(AJson: TACBrJSONObject);
begin
  Clear;
  DoReadFromJSon(GetJSONContext(AJSon));
end;

procedure TACBrOpenDeliverySchema.SetAsJSON(const AValue: String);
var
  LJSON: TACBrJSONObject;
begin
  Clear;
  LJSON := TACBrJSONObject.Parse(AValue);
  try
    ReadFromJSon(LJSON);
  finally
    LJSON.Free;
  end;
end;

procedure TACBrOpenDeliverySchema.WriteToJSon(AJson: TACBrJSONObject);
begin
  if IsEmpty then
    Exit;

  DoWriteToJSon(GetJSONContext(AJSon));
end;

{ TACBrOpenDeliveryJson }

//function TACBrOpenDeliveryJson.AddArray(AName: string; AValue: TACBrJSONArray; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  if (Assigned(AValue)) and ((AValue.Count > 0) or (not AIgnoreEmpty)) then
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    FJson.S[AName] := AValue;
//  {$Else}
//    FJson[AName].AsArray := AValue;
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.AddBoolean(AName: string; AValue, AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    FJson.S[AName] := AValue;
//  {$Else}
//    FJson[AName].AsBoolean := AValue;
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.AddDateTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  if (AValue <> 0) or (not AIgnoreEmpty) then
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    FJson.S[AName] := DateTimeToIso8601(AValue);
//  {$Else}
//    FJson[AName].AsString := DateTimeToIso8601(AValue);
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.AddNumber(AName: string; AValue: Double; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  if (AValue <> 0) or (not AIgnoreEmpty) then
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    FJson.S[AName] := AValue;
//  {$Else}
//    FJson[AName].AsNumber := AValue;
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.AddObject(AName: string; AValue: TACBrJSONObject; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  if (Assigned(AValue)) or (not AIgnoreEmpty) then
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    FJson.S[AName] := AValue;
//  {$Else}
//    FJson[AName].AsObject := AValue;
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.AddString(AName, AValue: String; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  if (AValue <> '') or (not AIgnoreEmpty) then
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    FJson.S[AName] := AValue;
//  {$Else}
//    FJson[AName].AsString := AValue;
//  {$EndIf}
//end;
//
//constructor TACBrOpenDeliveryJson.Create(AJson: TACBrJSONObject);
//begin
//  FJson := AJson;
//end;
//
//class function TACBrOpenDeliveryJson.New(AJson: TACBrJSONObject): TACBrOpenDeliveryJson;
//begin
//  Result := Self.Create(AJson);
//end;
//
//function TACBrOpenDeliveryJson.ValueAsBoolean(AName: String; var AValue: Boolean; ADefault: Boolean = False): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  AValue := ADefault;
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//
//  {$Else}
//    AValue := FJson[AName].AsBoolean;
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.ValueAsDateTime(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrOpenDeliveryJson;
//var
//  LStrValue: String;
//begin
//  Result := Self;
//  AValue := ADefault;
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    LStrValue := FJson.S[AName].AsString;
//  {$Else}
//    LStrValue := FJson[AName].AsString;
//  {$EndIf}
//  if LStrValue <> '' then
//    AValue := Iso8601ToDateTime(LStrValue);
//end;
//
//function TACBrOpenDeliveryJson.ValueAsFloat(AName: String; var AValue: Double; ADefault: Double = 0): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  AValue := ADefault;
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    AValue := StringToFloatDef(FJson.S[AName].AsString, 0);
//  {$Else}
//    AValue := StringToFloatDef(FJson[AName].AsString, 0);
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.ValueAsInteger(AName: String; var AValue: Integer; ADefault: Integer = 0): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  AValue := ADefault;
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    AValue := StrToIntDef(FJson[AName].AsString, 0);
//  {$Else}
//    AValue := StrToIntDef(FJson[AName].AsString, 0);
//  {$EndIf}
//end;
//
//function TACBrOpenDeliveryJson.ValueAsString(AName: String; var AValue: String; ADefault: String = ''): TACBrOpenDeliveryJson;
//begin
//  Result := Self;
//  AValue := ADefault;
//  {$IfDef USE_JSONDATAOBJECTS_UNIT}
//    AValue := FJson.S[AName].AsString;
//  {$Else}
//    AValue := FJson[AName].AsString;
//  {$EndIf}
//end;

end.

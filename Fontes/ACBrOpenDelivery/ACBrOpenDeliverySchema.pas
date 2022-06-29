unit ACBrOpenDeliverySchema;

interface

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    JsonDataObjects_ACBr,
  {$Else}
    Jsons,
  {$EndIf}
  Classes,
  SysUtils;

type
  TACBrOpenDeliverySchema = class
  private
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);

    function GetJSONContext(AJson: TJsonObject): TJsonObject;
  protected
    FObjectName: String;

    procedure DoWriteToJSon(AJson: TJsonObject); virtual;
    procedure DoReadFromJSon(AJson: TJsonObject); virtual;

  public
    constructor Create(const AObjectName: string = ''); virtual;
    procedure Clear; virtual;
    function IsEmpty: Boolean; virtual;
    procedure WriteToJSon(AJson: TJsonObject);
    procedure ReadFromJSon(AJson: TJsonObject);

    property AsJSON: String read GetAsJSON write SetAsJSON;
  end;

  TACBrOpenDeliveryJson = class
  private
    FJson: TJsonObject;

  public
    constructor Create(AJson: TJsonObject);
    class function New(AJson: TJsonObject): TACBrOpenDeliveryJson;

    function AddArray(AName: string; AValue: TJsonArray; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
    function AddBoolean(AName: string; AValue: Boolean; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
    function AddDateTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
    function AddObject(AName: string; AValue: TJsonObject; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
    function AddString(AName, AValue: String; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
    function AddNumber(AName: string; AValue: Double; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;

    function ValueAsBoolean(AName: String; var AValue: Boolean; ADefault: Boolean = False): TACBrOpenDeliveryJson;
    function ValueAsInteger(AName: String; var AValue: Integer; ADefault: Integer = 0): TACBrOpenDeliveryJson;
    function ValueAsDateTime(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrOpenDeliveryJson;
    function ValueAsFloat(AName: String; var AValue: Double; ADefault: Double = 0): TACBrOpenDeliveryJson;
    function ValueAsString(AName: String; var AValue: String; ADefault: String = ''): TACBrOpenDeliveryJson;
  end;

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

procedure TACBrOpenDeliverySchema.DoReadFromJSon(AJson: TJsonObject);
begin

end;

procedure TACBrOpenDeliverySchema.DoWriteToJSon(AJson: TJsonObject);
begin

end;

function TACBrOpenDeliverySchema.GetAsJSON: String;
var
  LJSON: TJsonObject;
begin
  LJSON := TJsonObject.Create;
  try
    WriteToJSon(LJSON);
    {$IfDef USE_JSONDATAOBJECTS_UNIT}
     Result := LJSON.ToJSON();
    {$Else}
     Result := LJSON.Stringify;
    {$EndIf}
  finally
    LJSON.Free;
  end;
end;

function TACBrOpenDeliverySchema.GetJSONContext(AJson: TJsonObject): TJsonObject;
begin
  if (FObjectName <> '') then
  begin
    {$IfDef USE_JSONDATAOBJECTS_UNIT}
     Result := AJson.O[FObjectName];
    {$Else}
     Result := AJson[FObjectName].AsObject;
    {$EndIf}
  end
  else
    Result := AJson;
end;

function TACBrOpenDeliverySchema.IsEmpty: Boolean;
begin
  Result := False;
end;

procedure TACBrOpenDeliverySchema.ReadFromJSon(AJson: TJsonObject);
begin
  Clear;
  DoReadFromJSon(GetJSONContext(AJSon));
end;

procedure TACBrOpenDeliverySchema.SetAsJSON(const AValue: String);
var
  LJSON: TJsonObject;
begin
  Clear;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
   JsonSerializationConfig.NullConvertsToValueTypes := True;
   js := TJsonObject.Parse(AValue) as TJsonObject;
   try
     ReadFromJSon(js);
   finally
     js.Free;
   end;
  {$Else}
   LJSON := TJsonObject.Create;
   try
     LJSON.Parse(AValue);
     ReadFromJSon(LJSON);
   finally
     LJSON.Free;
   end;
  {$EndIf}
end;

procedure TACBrOpenDeliverySchema.WriteToJSon(AJson: TJsonObject);
begin
  if IsEmpty then
    Exit;

  DoWriteToJSon(GetJSONContext(AJSon));
end;

{ TACBrOpenDeliveryJson }

function TACBrOpenDeliveryJson.AddArray(AName: string; AValue: TJsonArray; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
begin
  Result := Self;
  if (Assigned(AValue)) and ((AValue.Count > 0) or (not AIgnoreEmpty)) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsArray := AValue;
  {$EndIf}
end;

function TACBrOpenDeliveryJson.AddBoolean(AName: string; AValue, AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
begin
  Result := Self;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsBoolean := AValue;
  {$EndIf}
end;

function TACBrOpenDeliveryJson.AddDateTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := DateTimeToIso8601(AValue);
  {$Else}
    FJson[AName].AsString := DateTimeToIso8601(AValue);
  {$EndIf}
end;

function TACBrOpenDeliveryJson.AddNumber(AName: string; AValue: Double; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsNumber := AValue;
  {$EndIf}
end;

function TACBrOpenDeliveryJson.AddObject(AName: string; AValue: TJsonObject; AIgnoreEmpty: Boolean): TACBrOpenDeliveryJson;
begin
  Result := Self;
  if (Assigned(AValue)) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsObject := AValue;
  {$EndIf}
end;

function TACBrOpenDeliveryJson.AddString(AName, AValue: String; AIgnoreEmpty: Boolean = False): TACBrOpenDeliveryJson;
begin
  Result := Self;
  if (AValue <> '') or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsString := AValue;
  {$EndIf}
end;

constructor TACBrOpenDeliveryJson.Create(AJson: TJsonObject);
begin
  FJson := AJson;
end;

class function TACBrOpenDeliveryJson.New(AJson: TJsonObject): TACBrOpenDeliveryJson;
begin
  Result := Self.Create(AJson);
end;

function TACBrOpenDeliveryJson.ValueAsBoolean(AName: String; var AValue: Boolean; ADefault: Boolean = False): TACBrOpenDeliveryJson;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}

  {$Else}
    AValue := FJson[AName].AsBoolean;
  {$EndIf}
end;

function TACBrOpenDeliveryJson.ValueAsDateTime(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrOpenDeliveryJson;
var
  LStrValue: String;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    LStrValue := FJson.S[AName].AsString;
  {$Else}
    LStrValue := FJson[AName].AsString;
  {$EndIf}
  if LStrValue <> '' then
    AValue := Iso8601ToDateTime(LStrValue);
end;

function TACBrOpenDeliveryJson.ValueAsFloat(AName: String; var AValue: Double; ADefault: Double = 0): TACBrOpenDeliveryJson;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StringToFloatDef(FJson.S[AName].AsString, 0);
  {$Else}
    AValue := StringToFloatDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrOpenDeliveryJson.ValueAsInteger(AName: String; var AValue: Integer; ADefault: Integer = 0): TACBrOpenDeliveryJson;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StrToIntDef(FJson[AName].AsString, 0);
  {$Else}
    AValue := StrToIntDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrOpenDeliveryJson.ValueAsString(AName: String; var AValue: String; ADefault: String = ''): TACBrOpenDeliveryJson;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := FJson.S[AName].AsString;
  {$Else}
    AValue := FJson[AName].AsString;
  {$EndIf}
end;

end.

unit ACBrJSON;

interface

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  pcnConversaoOD,
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    JsonDataObjects_ACBr,
  {$Else}
    Jsons,
  {$EndIf}
  Classes,
  SysUtils;

type
  TACBrJSONArray = class;

  TACBrJSONObject = class
  private
    FJSON: TJsonObject;
    FContexts: TList;
    FOwnerJSON: Boolean;

    class function CreateJsonObject(AJsonString: String): TJsonObject;

    function GetAsBoolean(AName: String): Boolean;
    function GetAsFloat(AName: String): Double;
    function GetAsInteger(AName: String): Integer;
    function GetAsISODate(AName: String): TDateTime;
    function GetAsString(AName: String): String;
    function GetAsJSONArray(AName: String): TACBrJSONArray;
    function GetAsJSONContext(AName: String): TACBrJSONObject;

  public
    function AddPair(AName: string; AValue: TJsonArray; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: Boolean; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: TJsonObject; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName, AValue: String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: Integer; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: Double; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: array of String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPairISODate(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPairJSONString(AName: string; AValue: String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;

    function Value(AName: String; var AValue: Boolean; ADefault: Boolean = False): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: Integer; ADefault: Integer = 0): TACBrJSONObject; overload;
    function ValueISODate(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrJSONObject;
    function Value(AName: String; var AValue: Double; ADefault: Double = 0): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: Currency; ADefault: Currency = 0): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: String; ADefault: String = ''): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: TACBrODStringArray; ADefault: TACBrODStringArray = []): TACBrJSONObject; overload;

    property OwnerJSON: Boolean read FOwnerJSON write FOwnerJSON;
    property AsBoolean[AName: String]: Boolean read GetAsBoolean;
    property AsFloat[AName: String]: Double read GetAsFloat;
    property AsInteger[AName: String]: Integer read GetAsInteger;
    property AsISODate[AName: String]: TDateTime read GetAsISODate;
    property AsString[AName: String]: String read GetAsString;
    property AsJSONContext[AName: String]: TACBrJSONObject read GetAsJSONContext;
    property AsJSONArray[AName: String]: TACBrJSONArray read GetAsJSONArray;

    function ToJSON: String;
    class function Parse(const AJSONString: String): TACBrJSONObject;

    constructor Create; overload;
    constructor Create(AJSONObject: TJsonObject); overload;
    destructor Destroy; override;
  end;

  TACBrJSONArray = class
  private
    FJSON: TJsonArray;
    FContexts: TList;
    FOwnerJSON: Boolean;

    class function CreateJsonArray(AJsonString: String): TJsonArray;
    function GetItems(AIndex: Integer): String;

  public
    property OwnerJSON: Boolean read FOwnerJSON write FOwnerJSON;
    property Items[AIndex: Integer]: String read GetItems;

    function AddElement(const AValue: String): TACBrJSONArray;

    function Count: Integer;
    function ToJSON: String;
    class function Parse(const AJSONString: String): TACBrJSONArray;

    constructor Create; overload;
    constructor Create(AJSONArray: TJsonArray); overload;
    destructor Destroy; override;
  end;

implementation

{ TACBrJSONObject }

constructor TACBrJSONObject.Create;
begin
  FJSON := TJsonObject.Create;
  FContexts := TList.Create;
end;

function TACBrJSONObject.AddPair(AName: string; AValue: TJsonObject; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (Assigned(AValue)) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsObject := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName: string; AValue, AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsBoolean := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName: string; AValue: TJsonArray; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (Assigned(AValue)) and ((AValue.Count > 0) or (not AIgnoreEmpty)) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsArray := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName: string; AValue: Double; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsNumber := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName: string; AValue: Integer; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.I[AName] := AValue;
  {$Else}
    FJson[AName].AsInteger := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName, AValue: String; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (AValue <> '') or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := AValue;
  {$Else}
    FJson[AName].AsString := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPairISODate(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := DateTimeToIso8601(AValue);
  {$Else}
    FJson[AName].AsString := DateTimeToIso8601(AValue);
  {$EndIf}
end;

function TACBrJSONObject.AddPairJSONString(AName, AValue: String; AIgnoreEmpty: Boolean): TACBrJSONObject;
var
  LJSON: TJsonObject;
begin
  Result := Self;
  LJSON := CreateJsonObject(AValue);
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
     FJson.O[AName] := LJSON;
  {$Else}
    try
      FJson[AName].AsObject := LJSON[AName].AsObject;
    finally
      LJSON.Free;
    end;
  {$EndIf}
end;

function TACBrJSONObject.GetAsBoolean(AName: String): Boolean;
begin
  Value(AName, Result);
end;

function TACBrJSONObject.GetAsFloat(AName: String): Double;
begin
  Value(AName, Result);
end;

function TACBrJSONObject.GetAsInteger(AName: String): Integer;
begin
  Value(AName, Result);
end;

function TACBrJSONObject.GetAsISODate(AName: String): TDateTime;
begin
  ValueISODate(AName, Result);
end;

function TACBrJSONObject.GetAsJSONArray(AName: String): TACBrJSONArray;
var
  LJSON: TJsonArray;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    LJSON := FJSON.O[AName];
  {$Else}
    LJSON := FJSON[AName].AsArray;
  {$EndIf}

  Result := TACBrJSONArray.Create(LJSON);
  FContexts.Add(Result);
end;

function TACBrJSONObject.GetAsJSONContext(AName: String): TACBrJSONObject;
var
  LJSON: TJsonObject;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    LJSON := FJSON.O[AName];
  {$Else}
    LJSON := FJSON[AName].AsObject;
  {$EndIf}

  Result := TACBrJSONObject.Create(LJSON);
  FContexts.Add(Result);
end;

function TACBrJSONObject.GetAsString(AName: String): String;
begin
  Value(AName, Result);
end;

class function TACBrJSONObject.Parse(const AJSONString: String): TACBrJSONObject;
var
  LJSON: TJsonObject;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    JsonSerializationConfig.NullConvertsToValueTypes := True;
    LJSON := TJsonObject.Parse(AValue) as TJsonObject;
    try
      Result := TACBrJSONObject.Create(LJSON);
      Result.OwnerJSON := True;
    except
      LJSON.Free;
      raise;
    end;
  {$Else}
    LJSON := TJsonObject.Create;
    try
      LJSON.Parse(AJSONString);
      Result := TACBrJSONObject.Create(LJSON);
      Result.OwnerJSON := True;
    except
      LJSON.Free;
      raise;
    end;
  {$EndIf}
end;

function TACBrJSONObject.ToJSON: String;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    Result := FJSON.ToJSON();
  {$Else}
    Result := FJSON.Stringify;
  {$EndIf}
end;

constructor TACBrJSONObject.Create(AJSONObject: TJsonObject);
begin
  FOwnerJSON := False;
  FJSON := AJSONObject;
  FContexts := TList.Create;
end;

class function TACBrJSONObject.CreateJsonObject(AJsonString: String): TJsonObject;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    JsonSerializationConfig.NullConvertsToValueTypes := True;
    Result := TJsonObject.Parse(AValue) as TJsonObject;
  {$Else}
    Result := TJsonObject.Create;
    try
      Result.Parse(AJSONString);
    except
      Result.Free;
      raise;
    end;
  {$EndIf}
end;

destructor TACBrJSONObject.Destroy;
var
  I: Integer;
begin
  for I := Pred(FContexts.Count) downto 0 do
    TACBrJSONObject(FContexts.Items[I]).Free;
  FContexts.Free;
  if FOwnerJSON then
    FJSON.Free;
  inherited;
end;

function TACBrJSONObject.Value(AName: String; var AValue: Boolean; ADefault: Boolean): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := FJSON.S[AName].AsBoolean;
  {$Else}
    AValue := FJSON[AName].AsBoolean;
  {$EndIf}
end;

function TACBrJSONObject.ValueISODate(AName: String; var AValue: TDateTime; ADefault: TDateTime): TACBrJSONObject;
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

function TACBrJSONObject.Value(AName: String; var AValue: Double; ADefault: Double): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StringToFloatDef(FJson.S[AName].AsString, 0);
  {$Else}
    AValue := StringToFloatDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrJSONObject.Value(AName: String; var AValue: Integer; ADefault: Integer): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StrToIntDef(FJson[AName].AsString, 0);
  {$Else}
    AValue := StrToIntDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrJSONObject.Value(AName: String; var AValue: String; ADefault: String): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := FJson.S[AName].AsString;
  {$Else}
    AValue := FJson[AName].AsString;
  {$EndIf}
end;

function TACBrJSONObject.Value(AName: String; var AValue: Currency; ADefault: Currency): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StringToFloatDef(FJson.S[AName].AsString, 0);
  {$Else}
    AValue := StringToFloatDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName: string; AValue: array of String; AIgnoreEmpty: Boolean): TACBrJSONObject;
var
  LStr: String;
  I: Integer;
  LJSONArray: TJsonArray;
begin
  Result := Self;
  LStr := '[';
  for I := 0 to Pred(Length(AValue)) do
  begin
    if I > 0 then
      LStr := LStr + ',';
    LStr := LStr + '"' + AValue[I] + '"';
  end;
  LStr := LStr + ']';

  if (Length(AValue) > 0) or (not AIgnoreEmpty) then
  begin
    {$IfDef USE_JSONDATAOBJECTS_UNIT}
      FJson.[AName] := AValue;
    {$Else}
      LJSONArray := TJsonArray.Create;
      try
        LJSONArray.Parse(LStr);
        FJson[AName].AsArray := LJSONArray;
      finally
        LJSONArray.Free;
      end;
    {$EndIf}
  end;
end;

function TACBrJSONObject.Value(AName: String; var AValue: TACBrODStringArray; ADefault: TACBrODStringArray): TACBrJSONObject;
var
  LJSONArray: TJsonArray;
  I: Integer;
begin
  Result := Self;
  LJSONArray := FJSON[AName].AsArray;
  SetLength(AValue, LJSONArray.Count);
  for I := 0 to Pred(LJSONArray.Count) do
    AValue[I] := LJSONArray.Items[I].AsString;
end;

{ TACBrJSONArray }

constructor TACBrJSONArray.Create;
begin
  FJSON := TJsonArray.Create;
  FContexts := TList.Create;
end;

function TACBrJSONArray.AddElement(const AValue: String): TACBrJSONArray;
begin
  Result := Self;
  FJSON.Put(AValue);
end;

function TACBrJSONArray.Count: Integer;
begin
  Result := FJSON.Count;
end;

constructor TACBrJSONArray.Create(AJSONArray: TJsonArray);
begin
  FOwnerJSON := False;
  FJSON := AJSONArray;
  FContexts := TList.Create;
end;

class function TACBrJSONArray.CreateJsonArray(AJsonString: String): TJsonArray;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    JsonSerializationConfig.NullConvertsToValueTypes := True;
    Result := TJsonArray.Parse(AValue) as TJsonArray;
  {$Else}
    Result := TJsonArray.Create;
    try
      Result.Parse(AJSONString);
    except
      Result.Free;
      raise;
    end;
  {$EndIf}
end;

destructor TACBrJSONArray.Destroy;
var
  I: Integer;
begin
  for I := Pred(FContexts.Count) downto 0 do
    TACBrJSONObject(FContexts.Items[I]).Free;
  FContexts.Free;
  if FOwnerJSON then
    FJSON.Free;
  inherited;
end;

function TACBrJSONArray.GetItems(AIndex: Integer): String;
begin
  Result := FJSON.Items[AIndex].AsString;
end;

class function TACBrJSONArray.Parse(const AJSONString: String): TACBrJSONArray;
var
  LJSON: TJsonArray;
begin
  LJSON := CreateJsonArray(AJSONString);
  try
    Result := TACBrJSONArray.Create(LJSON);
    Result.OwnerJSON := True;
  except
    LJSON.Free;
    raise;
  end;
end;

function TACBrJSONArray.ToJSON: String;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    Result := FJSON.ToJSON();
  {$Else}
    Result := FJSON.Stringify;
  {$EndIf}
end;

end.

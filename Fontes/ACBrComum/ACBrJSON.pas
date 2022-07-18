unit ACBrJSON;

interface

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    JsonDataObjects_ACBr,
  {$Else}
    Jsons,
  {$EndIf}
  Classes,
  SysUtils;

type
  TACBrJSONArray = class;

  TACBrJSON = class
  public
    function ToJSON: String; virtual; abstract;
  end;

  TACBrJSONObject = class(TACBrJSON)
  private
    FJSON: TJsonObject;
    FContexts: TList;
    FOwnerJSON: Boolean;

    class function CreateJsonObject(AJsonString: String): TJsonObject;

    function GetAsBoolean(AName: String): Boolean;
    function GetAsFloat(AName: String): Double;
    function GetAsInteger(AName: String): Integer;
    function GetAsISODateTime(AName: String): TDateTime;
    function GetAsString(AName: String): String;
    function GetAsISOTime(AName: String): TDateTime;
    function GetAsJSONArray(AName: String): TACBrJSONArray;
    function GetAsJSONObject(AName: String): TACBrJSONObject;
    function GetAsISODate(AName: String): TDateTime;

  public
    function AddPair(AName: string; AValue: Boolean; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName, AValue: String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: Integer; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: Double; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: array of String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPair(AName: string; AValue: TACBrJSONArray; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPairISODateTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPairISOTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPairJSONString(AName: string; AValue: String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;
    function AddPairJSONArray(AName: string; AValue: String; AIgnoreEmpty: Boolean = False): TACBrJSONObject; overload;

    function Value(AName: String; var AValue: Boolean; ADefault: Boolean = False): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: Integer; ADefault: Integer = 0): TACBrJSONObject; overload;
    function ValueISODate(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrJSONObject;
    function ValueISODateTime(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrJSONObject;
    function ValueISOTime(AName: String; var AValue: TDateTime; ADefault: TDateTime = 0): TACBrJSONObject;
    function Value(AName: String; var AValue: Double; ADefault: Double = 0): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: Currency; ADefault: Currency = 0): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: String; ADefault: String = ''): TACBrJSONObject; overload;
    function Value(AName: String; var AValue: TSplitResult; ADefault: TSplitResult = []): TACBrJSONObject; overload;

    property OwnerJSON: Boolean read FOwnerJSON write FOwnerJSON;
    property AsBoolean[AName: String]: Boolean read GetAsBoolean;
    property AsFloat[AName: String]: Double read GetAsFloat;
    property AsInteger[AName: String]: Integer read GetAsInteger;
    property AsISODateTime[AName: String]: TDateTime read GetAsISODateTime;
    property AsISODate[AName: String]: TDateTime read GetAsISODate;
    property AsISOTime[AName: String]: TDateTime read GetAsISOTime;
    property AsString[AName: String]: String read GetAsString;
    property AsJSONObject[AName: String]: TACBrJSONObject read GetAsJSONObject;
    property AsJSONArray[AName: String]: TACBrJSONArray read GetAsJSONArray;

    function ToJSON: String; override;
    class function Parse(const AJSONString: String): TACBrJSONObject;

    constructor Create; overload;
    constructor Create(AJSONObject: TJsonObject); overload;
    destructor Destroy; override;
  end;

  TACBrJSONArray = class(TACBrJSON)
  private
    FJSON: TJsonArray;
    FContexts: TList;
    FOwnerJSON: Boolean;

    class function CreateJsonArray(AJsonString: String): TJsonArray;
    function GetItems(AIndex: Integer): String;
    function GetItemAsJSONObject(AIndex: Integer): TACBrJSONObject;

  public
    property OwnerJSON: Boolean read FOwnerJSON write FOwnerJSON;
    property Items[AIndex: Integer]: String read GetItems;
    property ItemAsJSONObject[AIndex: Integer]: TACBrJSONObject read GetItemAsJSONObject;

    function AddElement(const AValue: String): TACBrJSONArray; overload;
    function AddElementJSONString(const AValue: String): TACBrJSONArray; overload;

    function Count: Integer;
    function ToJSON: String; override;
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
  FOwnerJSON := True;
  FContexts := TList.Create;
end;

function TACBrJSONObject.AddPair(AName: string; AValue, AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.B[AName] := AValue;
  {$Else}
    FJson[AName].AsBoolean := AValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPair(AName: string; AValue: Double; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.F[AName] := AValue;
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

function TACBrJSONObject.AddPairISODateTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := DateTimeToIso8601(AValue);
  {$Else}
    FJson[AName].AsString := DateTimeToIso8601(AValue);
  {$EndIf}
end;

function TACBrJSONObject.AddPairISOTime(AName: string; AValue: TDateTime; AIgnoreEmpty: Boolean): TACBrJSONObject;
var
  LValue: string;
begin
  Result := Self;
  LValue := FormatDateTime('hh:mm:ss', AValue);
  if (AValue <> 0) or (not AIgnoreEmpty) then
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJson.S[AName] := LValue;
  {$Else}
    FJson[AName].AsString := LValue;
  {$EndIf}
end;

function TACBrJSONObject.AddPairJSONArray(AName, AValue: String; AIgnoreEmpty: Boolean): TACBrJSONObject;
var
  LJSONArray: TJsonArray;
begin
  Result := Self;
  LJSONArray := TJsonArray.Create;
  try
    LJSONArray.Parse(AValue);
    {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJSON.A[AName] := LJSONArray;
    {$ELSE}
    FJSON.Put(AName, AValue);
    {$ENDIF}
  finally
    LJSONArray.Free;
  end;
end;

function TACBrJSONObject.AddPairJSONString(AName, AValue: String; AIgnoreEmpty: Boolean): TACBrJSONObject;
var
  LJSON: TJsonObject;
begin
  Result := Self;
  LJSON := CreateJsonObject(AValue);
  try
    {$IfDef USE_JSONDATAOBJECTS_UNIT}
     FJson.O[AName] := LJSON.O[AName].Clone;
    {$Else}
    FJson[AName].AsObject := LJSON[AName].AsObject;
    {$EndIf}
  finally
    LJSON.Free;
  end;
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

function TACBrJSONObject.GetAsISODateTime(AName: String): TDateTime;
begin
  ValueISODateTime(AName, Result);
end;

function TACBrJSONObject.GetAsJSONArray(AName: String): TACBrJSONArray;
var
  LJSON: TJsonArray;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    LJSON := FJSON.A[AName];
  {$Else}
    LJSON := FJSON[AName].AsArray;
  {$EndIf}

  Result := TACBrJSONArray.Create(LJSON);
  FContexts.Add(Result);
end;

function TACBrJSONObject.GetAsJSONObject(AName: String): TACBrJSONObject;
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

function TACBrJSONObject.GetAsISOTime(AName: String): TDateTime;
var
  LStr: String;
begin
  LStr := GetAsString(AName);
  Result := StringToDateTime(LStr);
end;

class function TACBrJSONObject.Parse(const AJSONString: String): TACBrJSONObject;
var
  LJSON: TJsonObject;
begin
  LJSON := CreateJsonObject(AJSONString);
  try
    Result := TACBrJSONObject.Create(LJSON);
    Result.OwnerJSON := True;
  except
    LJSON.Free;
    raise;
  end;
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
    Result := TJsonObject.Parse(AJsonString) as TJsonObject;
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
    AValue := FJSON.B[AName];
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
    LStrValue := FJson.S[AName];
  {$Else}
    LStrValue := FJson[AName].AsString;
  {$EndIf}
  if LStrValue <> '' then
    AValue := EncodeDataHora(LStrValue, 'yyyy-MM-dd');
end;

function TACBrJSONObject.ValueISODateTime(AName: String; var AValue: TDateTime; ADefault: TDateTime): TACBrJSONObject;
var
  LStrValue: String;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    LStrValue := FJson.S[AName];
  {$Else}
    LStrValue := FJson[AName].AsString;
  {$EndIf}
  if LStrValue <> '' then
    AValue := Iso8601ToDateTime(LStrValue);
end;

function TACBrJSONObject.ValueISOTime(AName: String; var AValue: TDateTime; ADefault: TDateTime): TACBrJSONObject;
var
  LStrValue: String;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    LStrValue := FJson.S[AName];
  {$Else}
    LStrValue := FJson[AName].AsString;
  {$EndIf}
  if LStrValue <> '' then
    AValue := StringToDateTime(Copy(LStrValue, 1, 8), 'hh:mm:ss');
end;

function TACBrJSONObject.Value(AName: String; var AValue: Double; ADefault: Double): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StringToFloatDef(FJson.S[AName], 0);
  {$Else}
    AValue := StringToFloatDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrJSONObject.Value(AName: String; var AValue: Integer; ADefault: Integer): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StrToIntDef(FJson.S[AName], 0);
  {$Else}
    AValue := StrToIntDef(FJson[AName].AsString, 0);
  {$EndIf}
end;

function TACBrJSONObject.Value(AName: String; var AValue: String; ADefault: String): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := FJson.S[AName];
  {$Else}
    AValue := FJson[AName].AsString;
  {$EndIf}
end;

function TACBrJSONObject.Value(AName: String; var AValue: Currency; ADefault: Currency): TACBrJSONObject;
begin
  Result := Self;
  AValue := ADefault;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    AValue := StringToFloatDef(FJson.S[AName], 0);
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
    LJSONArray := TACBrJSONArray.CreateJsonArray(LStr);
    try
      {$IfDef USE_JSONDATAOBJECTS_UNIT}
      FJson.A[AName] := LJSONArray.Clone;
      {$Else}
      FJson[AName].AsArray := LJSONArray;
      {$EndIf}
    finally
      LJSONArray.Free;
    end;
  end;
end;

function TACBrJSONObject.Value(AName: String; var AValue: TSplitResult; ADefault: TSplitResult): TACBrJSONObject;
var
  LJSONArray: TACBrJSONArray;
  I: Integer;
begin
  Result := Self;
  LJSONArray := GetAsJSONArray(AName);
  SetLength(AValue, LJSONArray.Count);
  for I := 0 to Pred(LJSONArray.Count) do
    AValue[I] := LJSONArray.Items[I];
end;

function TACBrJSONObject.AddPair(AName: string; AValue: TACBrJSONArray; AIgnoreEmpty: Boolean): TACBrJSONObject;
begin
  Result := Self;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
  FJSON.A[AName] := TACBrJSONArray.CreateJsonArray(AValue.ToJSON);
  {$ELSE}
  FJSON.Put(AName, AValue.FJSON);
  {$ENDIF}
  AValue.OwnerJSON := True;
  FContexts.Add(AValue);
end;

{ TACBrJSONArray }

constructor TACBrJSONArray.Create;
begin
  FOwnerJSON := True;
  FJSON := TJsonArray.Create;
  FContexts := TList.Create;
end;

function TACBrJSONArray.AddElement(const AValue: String): TACBrJSONArray;
begin
  Result := Self;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
  FJSON.Add(AValue);
  {$Else}
  FJSON.Put(AValue);
  {$EndIf}
end;

function TACBrJSONArray.AddElementJSONString(const AValue: String): TACBrJSONArray;
begin
  Result := Self;
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
    FJSON.AddObject(TACBrJSONObject.CreateJsonObject(AValue));
  {$Else}
    FJSON.Add.Parse(AValue);
  {$EndIf}
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
    Result := TJsonArray.Parse(AJsonString) as TJsonArray;
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

function TACBrJSONArray.GetItemAsJSONObject(AIndex: Integer): TACBrJSONObject;
var
  {$IfNDef USE_JSONDATAOBJECTS_UNIT}
  LJSONStr: string;
  {$EndIf}
  LJSON: TJsonObject;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
  LJSON := FJSON.Items[AIndex].ObjectValue.Clone;
  {$ELSE}
  LJSONStr := TJsonObject(FJSON.Items[AIndex]).Stringify;
  LJSON := TJsonObject.Create;
  LJSON.Parse(LJSONStr);
  {$ENDIF}
  try
    Result := TACBrJSONObject.Create(LJSON);
    Result.OwnerJSON := True;
    FContexts.Add(Result);
  except
    LJSON.Free;
    raise;
  end;
end;

function TACBrJSONArray.GetItems(AIndex: Integer): String;
begin
  {$IfDef USE_JSONDATAOBJECTS_UNIT}
  Result := FJSON.Items[AIndex].Value;
  {$Else}
  Result := FJSON.Items[AIndex].AsString;
  {$EndIf}
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

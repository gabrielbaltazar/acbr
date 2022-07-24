unit ACBrOpenDeliverySchema;

interface

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrBase,
  ACBrJSON,
  pcnConversaoOD,
  Classes,
  SysUtils,
  TypInfo;

resourcestring
  sErroMetodoNaoImplementado = 'Método %s não implementado para Classe %s';

type
  TACBrJSONObject = ACBrJSON.TACBrJSONObject;
  TACBrJSONArray = ACBrJSON.TACBrJSONArray;

  EACBrOpenDeliveryException = class(EACBrException);

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

  TACBrOpenDeliverySchemaArray = class(TACBrObjectList)
  private
//    function GetAsJSONArray: string;
//    procedure SetAsJSON(AValue: string);

  protected
    FArrayName: String;

    function NewSchema: TACBrOpenDeliverySchema; virtual;
  public
    constructor Create(const AArrayName: String);
    procedure Clear; override;
    function IsEmpty: Boolean; virtual;

    function ToJSonArray: TACBrJSONArray;

    procedure WriteToJSon(AJSon: TACBrJSONObject); virtual;
    procedure ReadFromJSon(AJSon: TACBrJSONObject); virtual;

//    property AsJSON: String read GetAsJSON write SetAsJSON;
  end;

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
    Result := AJSon.AsJSONObject[FObjectName]
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

{ TACBrOpenDeliverySchemaArray }

procedure TACBrOpenDeliverySchemaArray.Clear;
begin
  inherited Clear;
end;

constructor TACBrOpenDeliverySchemaArray.Create(const AArrayName: String);
begin
  inherited Create(True);
  FArrayName := AArrayName;
end;

function TACBrOpenDeliverySchemaArray.IsEmpty: Boolean;
begin
  Result := (Count < 1);
end;

function TACBrOpenDeliverySchemaArray.NewSchema: TACBrOpenDeliverySchema;
begin
  {$IfDef FPC}Result := Nil;{$EndIf}
  raise EACBrOpenDeliveryException
    .CreateFmt(ACBrStr(sErroMetodoNaoImplementado), ['NewSchema', ClassName]);
end;

procedure TACBrOpenDeliverySchemaArray.ReadFromJSon(AJSon: TACBrJSONObject);
var
  LJSonArray: TACBrJSONArray;
  I: Integer;
begin
  Clear;
  LJSonArray := AJSon.AsJSONArray[FArrayName];
  if Assigned(LJSonArray) then
    for I := 0 to Pred(LJSonArray.Count) do
      NewSchema.DoReadFromJSon(LJSonArray.ItemAsJSONObject[I]);
end;

function TACBrOpenDeliverySchemaArray.ToJSonArray: TACBrJSONArray;
var
  I: Integer;
begin
  Result := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Count) do
      Result.AddElementJSONString(TACBrOpenDeliverySchema(Items[I]).AsJSON);
  except
    Result.Free;
    raise;
  end;
end;

procedure TACBrOpenDeliverySchemaArray.WriteToJSon(AJSon: TACBrJSONObject);
var
  LJSonArray: TACBrJSONArray;
  I: Integer;
begin
  if IsEmpty then
    Exit;

  LJSonArray := TACBrJSONArray.Create;
  try
    for I := 0 to Pred(Count) do
      LJSonArray.AddElementJSONString(TACBrOpenDeliverySchema(Items[I]).AsJSON);

    AJSon.AddPair(FArrayName, LJSonArray);
  except
    LJSonArray.Free;
    raise;
  end;
end;

end.

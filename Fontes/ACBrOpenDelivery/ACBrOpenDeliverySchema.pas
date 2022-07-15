unit ACBrOpenDeliverySchema;

interface

uses
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrJSON,
  pcnConversaoOD,
  Classes,
  SysUtils,
  TypInfo;

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
    Result := AJSon.AsJSONContext[FObjectName]
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

end.

unit ACBrJSONTest;

interface

uses
  Classes,
  SysUtils,
  Math,
  ACBrJSON,
  ACBrUtil.Strings,
  ACBrTests.Util;

type
  TTestACBrJSONObject = class(TTestCase)
  private
    FJSON: TACBrJSONObject;
    FStrJSON: String;

    procedure Parse;

  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure ParseValidJSONObject;
    procedure ParseInvalidJSON;

  end;

implementation

{ TACBrJSONObjectParse }

procedure TTestACBrJSONObject.Parse;
begin
  FJSON := TACBrJSONObject.Parse(FStrJSON);
end;

procedure TTestACBrJSONObject.ParseInvalidJSON;
begin
  FStrJSON := '{"name:"value"}';
  CheckException(Parse, Exception);
end;

procedure TTestACBrJSONObject.ParseValidJSONObject;
begin
  FStrJSON := '{"name":"value"}';
  FJSON := TACBrJSONObject.Parse(FStrJSON);

  CheckNotNull(FJSON);
  CheckEquals(FStrJSON, FJSON.ToJSON);
end;

procedure TTestACBrJSONObject.SetUp;
begin
  inherited;
  FStrJSON := ACBrStr('{' +
    '"name1": "value1",' +
    '"name2": "value2",' +

end;

procedure TTestACBrJSONObject.TearDown;
begin
  FJSON.Free;
  inherited;
end;

initialization
  _RegisterTest('ACBrComum.ACBrJSON.TJSONObject.Parse', TTestACBrJSONObject);

end.


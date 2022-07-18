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
    procedure AsBoolean;
    procedure AsFloat;
    procedure AsInteger;
    procedure AsISODate;
    procedure AsISODateTime;
    procedure AsISOTime;
    procedure AsString;
    procedure AsStringInvalidField;
  end;

implementation

{ TACBrJSONObjectParse }

procedure TTestACBrJSONObject.AsBoolean;
begin
  Parse;
  CheckTrue(FJSON.AsBoolean['column8']);
end;

procedure TTestACBrJSONObject.AsFloat;
begin
  Parse;
  CheckEquals('5,4', FloatToStr(FJSON.AsFloat['column3']));
end;

procedure TTestACBrJSONObject.AsInteger;
begin
  Parse;
  CheckEquals(2, FJSON.AsInteger['column2']);
end;

procedure TTestACBrJSONObject.AsISODate;
begin
  Parse;
  CheckEquals('2022-05-30', FormatDateTime('yyyy-MM-dd', FJSON.AsISODate['column5']));
end;

procedure TTestACBrJSONObject.AsISODateTime;
begin
  Parse;
  CheckEquals('2022-05-31 17:40:37', FormatDateTime('yyyy-MM-dd hh:mm:ss', FJSON.AsISODateTime['column6']));
end;

procedure TTestACBrJSONObject.AsISOTime;
begin
  Parse;
  CheckEquals('17:40:37', FormatDateTime('hh:mm:ss', FJSON.AsISOTime['column7']));
end;

procedure TTestACBrJSONObject.AsString;
begin
  Parse;
  CheckEquals('value1', FJSON.AsString['column1']);
end;

procedure TTestACBrJSONObject.AsStringInvalidField;
begin
  Parse;
  CheckEquals('', FJSON.AsString['aa']);
end;

procedure TTestACBrJSONObject.Parse;
begin
  FJSON := TACBrJSONObject.Parse(FStrJSON);
end;

procedure TTestACBrJSONObject.ParseInvalidJSON;
begin
  FStrJSON := '{"name:"value"}';
  CheckException(Parse, Exception, 'teste');
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
      '"column1": "value1",' +
      '"column2": 2,' +
      '"column3": 5.4,' +
      '"column5": "2022-05-30",' +
      '"column6": "2022-05-31 17:40:37",' +
      '"column7": "17:40:37",' +
      '"column8": true' +
    '}');
end;

procedure TTestACBrJSONObject.TearDown;
begin
  FJSON.Free;
  inherited;
end;

initialization
  {$IF CompilerVersion >= 30.0}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF};

  _RegisterTest('ACBrComum.ACBrJSON.TJSONObject.Parse', TTestACBrJSONObject);

end.


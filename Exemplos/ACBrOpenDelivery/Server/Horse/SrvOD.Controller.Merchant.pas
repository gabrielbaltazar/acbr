unit SrvOD.Controller.Merchant;

interface

uses
  Horse,
  ACBrJSON,
  ACBrOpenDeliverySchemaClasses,
  System.Classes,
  System.DateUtils,
  System.Types,
  System.SysUtils;

procedure Registry;

implementation

const
  API_KEY_ACBR = '9AD4B257-F630-4A84-BAB9-AD003935B160';

function LoadFromResource(AResourceName: String): string;
var
  LResource: TResourceStream;
  LStringStream: TStringStream;
begin
  LResource := TResourceStream.Create(HInstance, AResourceName, RT_RCDATA);
  try
    LStringStream := TStringStream.Create;
    try
      LResource.SaveToStream(LStringStream);
      Result := UTF8ToString(LStringStream.DataString);
      Result := Result.Replace(#$FEFF, '');
    finally
      LStringStream.Free;
    end;
  finally
    LResource.Free;
  end;
end;

function LoadFromFile(AFileName: String): string;
var
  LFile: String;
begin
  LFile := ExtractFilePath(GetModuleName(HInstance)) + AFileName + '.json';
  if not FileExists(LFile) then
  begin
    Result := LoadFromResource(AFileName);
    with TStringList.Create do
    try
      Text := Result;
      SaveToFile(LFile);
      Exit;
    finally
      Free;
    end;
  end;

  with TStringList.Create do
  try
    LoadFromFile(LFile);
    Result := Text;
  finally
    Free;
  end;
end;

function LoadJSON(AResourceName: String): TACBrJSONObject;
var
  LJSON: String;
begin
  LJSON := LoadFromFile(AResourceName);
  Result := TACBrJSONObject.Parse(LJSON);
end;

procedure GetInformationOfAMerchant(Req: THorseRequest; Res: THorseResponse);
var
  LJSONObject: TACBrJSONObject;
  LAPIKey: string;
begin
  LAPIKey := Req.Headers.Field('X-API-KEY').AsString;
  if LAPIKey.ToLower = API_KEY_ACBR.ToLower then
    LJSONObject := LoadJSON('MERCHANT_ACBR')
  else
    raise EHorseException.New
            .Status(THTTPStatus.BadRequest)
            .Error('API-KEY inv�lida.');

  Res.Send<TACBrJSONObject>(LJSONObject);
end;

procedure Registry;
begin
  THorse
    .Get('v1/merchant', GetInformationOfAMerchant);
end;

end.
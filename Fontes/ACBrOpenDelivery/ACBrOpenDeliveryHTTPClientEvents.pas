unit ACBrOpenDeliveryHTTPClientEvents;

interface

uses
  ACBrOpenDeliveryHTTP,
  ACBrOpenDeliverySchemaClasses,
  pcnConversaoOD,
  ACBrJSON,
  ACBrUtil.Strings,
  SysUtils,
  Classes;

type
  TACBrOpenDeliveryHTTPClientEvents = class
  private
    FBaseUrl: string;
    FResource: string;
    FToken: string;
    FEvents: array of TACBrODEventType;
    FPollingMerchant: array of string;
    FHTTP: TACBrOpenDeliveryHTTPRequest;

  public
    constructor Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
    destructor Destroy; override;

    function BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
    function Resource(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
    function Token(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
    function AddEventType(const AValue: TACBrODEventType): TACBrOpenDeliveryHTTPClientEvents;
    function AddPollingMerchant(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;

    function GetNewEvents: TACBrOpenDeliverySchemaEventCollection;
    procedure AcknowledgeEvents(AEvents: TACBrOpenDeliverySchemaAcknowledgmentCollection);
  end;

implementation

{ TACBrOpenDeliveryHTTPClientEvents }

procedure TACBrOpenDeliveryHTTPClientEvents.AcknowledgeEvents(AEvents: TACBrOpenDeliverySchemaAcknowledgmentCollection);
var
  LResponse: TACBrOpenDeliveryHTTPResponse;
  LJSONArray: TACBrJSONArray;
begin
  if (not Assigned(AEvents)) or (AEvents.Count = 0) then
    Exit;

  LJSONArray := AEvents.ToJSonArray;
  try
    FHTTP
      .POST
      .BaseURL(FBaseUrl)
      .Resource(FResource + '/acknowledgment')
      .Body(LJSONArray)
      .Token(FToken);

    LResponse := FHTTP.Send;
    try
    finally
      LResponse.Free;
    end;
  finally
    LJSONArray.Free;
  end;
end;

function TACBrOpenDeliveryHTTPClientEvents.AddEventType(const AValue: TACBrODEventType): TACBrOpenDeliveryHTTPClientEvents;
begin
  Result := Self;
  SetLength(FEvents, Length(FEvents) + 1);
  FEvents[Length(FEvents) - 1] := AValue;
end;

function TACBrOpenDeliveryHTTPClientEvents.AddPollingMerchant(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
begin
  Result := Self;
  SetLength(FPollingMerchant, Length(FPollingMerchant) + 1);
  FPollingMerchant[Length(FPollingMerchant) - 1] := AValue;
end;

function TACBrOpenDeliveryHTTPClientEvents.BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
begin
  Result := Self;
  FBaseUrl := AValue;
end;

constructor TACBrOpenDeliveryHTTPClientEvents.Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
begin
  FHTTP := AHTTPRequest;
  FResource := 'v1/events';
end;

destructor TACBrOpenDeliveryHTTPClientEvents.Destroy;
begin
  FHTTP.Free;
  inherited;
end;

function TACBrOpenDeliveryHTTPClientEvents.GetNewEvents: TACBrOpenDeliverySchemaEventCollection;
var
  LStrEvents: string;
  LStrMerchants: string;
  I: Integer;
  LResponse: TACBrOpenDeliveryHTTPResponse;
  LJSONArray: TACBrJSONArray;
begin
  Result := nil;
  try
    for I := 0 to Pred(Length(FEvents)) do
    begin
      if I > 0 then
        LStrEvents := LStrEvents + ',';
      LStrEvents := LStrEvents + EventTypeToStr(FEvents[I]);
    end;

    for I := 0 to Pred(Length(FPollingMerchant)) do
    begin
      if I > 0 then
        LStrMerchants := LStrMerchants + ',';
      LStrMerchants := LStrMerchants + FPollingMerchant[I];
    end;

    FHTTP
      .GET
      .BaseURL(FBaseUrl)
      .Resource(FResource + ':polling')
      .Token(FToken);

    if LStrEvents <> '' then
      FHTTP.AddOrSetQuery('eventType', LStrEvents);

    if LStrMerchants <> '' then
      FHTTP.AddOrSetHeader('x-polling-merchants', LStrMerchants);

    LResponse := FHTTP.Send;
    try
      LJSONArray := LResponse.GetJSONArray;
      Result := TACBrOpenDeliverySchemaEventCollection.Create('');
      try
        Result.AsJSON := LJSONArray.ToJSON;
      except
        Result.Free;
        raise;
      end;
    finally
      LResponse.Free;
    end;
  finally
    SetLength(FEvents, 0);
    SetLength(FPollingMerchant, 0);
  end;
end;

function TACBrOpenDeliveryHTTPClientEvents.Resource(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
begin
  Result := Self;
  FResource := AValue;
end;

function TACBrOpenDeliveryHTTPClientEvents.Token(const AValue: string): TACBrOpenDeliveryHTTPClientEvents;
begin
  Result := Self;
  FToken := AValue;
end;

end.

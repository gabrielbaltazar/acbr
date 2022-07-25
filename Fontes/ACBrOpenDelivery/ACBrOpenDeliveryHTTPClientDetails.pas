unit ACBrOpenDeliveryHTTPClientDetails;

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
  TACBrOpenDeliveryHTTPClientDetails = class
  private
    FBaseUrl: string;
    FResource: string;
    FToken: string;
    FHTTP: TACBrOpenDeliveryHTTPRequest;

  public
    constructor Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
    destructor Destroy; override;

    function BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientDetails;
    function Resource(const AValue: string): TACBrOpenDeliveryHTTPClientDetails;
    function Token(const AValue: string): TACBrOpenDeliveryHTTPClientDetails;

    function GetOrderDetails(const AOrderId: string): TACBrOpenDeliverySchemaOrder;
  end;

implementation

{ TACBrOpenDeliveryHTTPClientDetails }

function TACBrOpenDeliveryHTTPClientDetails.BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientDetails;
begin
  Result := Self;
  FBaseUrl := AValue;
end;

constructor TACBrOpenDeliveryHTTPClientDetails.Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
begin
  FHTTP := AHTTPRequest;
  FResource := 'v1/orders/{orderId}';
end;

destructor TACBrOpenDeliveryHTTPClientDetails.Destroy;
begin
  FHTTP.Free;
  inherited;
end;

function TACBrOpenDeliveryHTTPClientDetails.GetOrderDetails(const AOrderId: string): TACBrOpenDeliverySchemaOrder;
var
  LResponse: TACBrOpenDeliveryHTTPResponse;
  LJSON: TACBrJSONObject;
begin
  FHTTP
    .GET
    .BaseURL(FBaseUrl)
    .Resource(StringReplace(FResource, '{orderId}', AOrderId, []))
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
    LJSON := LResponse.GetJSONObject;
    Result := TACBrOpenDeliverySchemaOrder.Create;
    try
      Result.AsJSON := LJSON.ToJSON;
    except
      Result.Free;
      raise;
    end;
  finally
    LResponse.Free;
  end;
end;

function TACBrOpenDeliveryHTTPClientDetails.Resource(const AValue: string): TACBrOpenDeliveryHTTPClientDetails;
begin
  Result := Self;
  FResource := AValue;
end;

function TACBrOpenDeliveryHTTPClientDetails.Token(const AValue: string): TACBrOpenDeliveryHTTPClientDetails;
begin
  Result := Self;
  FToken := AValue;
end;

end.

unit ACBrOpenDeliveryHTTPClientActions;

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
  TACBrOpenDeliveryHTTPClientActions = class
  private
    FBaseUrl: string;
    FResource: string;
    FToken: string;
    FHTTP: TACBrOpenDeliveryHTTPRequest;

  public
    constructor Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
    destructor Destroy; override;

    function BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientActions;
    function Resource(const AValue: string): TACBrOpenDeliveryHTTPClientActions;
    function Token(const AValue: string): TACBrOpenDeliveryHTTPClientActions;

    procedure Confirm(AOrderConfirmations: TACBrOpenDeliverySchemaOrderConfirmation);
    procedure ReadyForPickup(const AOrderId: string);
    procedure Dispatch(const AOrderId: string);
    procedure RequestOrderCancellation(ACancelRequest: TACBrOpenDeliverySchemaOrderCancelRequest);
    procedure AcceptOrderCancellation(const AOrderId: string);
    procedure DenyOrderCancellation(ADenyRequest: TACBrOpenDeliverySchemaOrderCancelDenyRequest);
  end;

implementation

{ TACBrOpenDeliveryHTTPClientActions }

procedure TACBrOpenDeliveryHTTPClientActions.AcceptOrderCancellation(const AOrderId: string);
var
  LResource: string;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  LResource := StringReplace(FResource, '{orderId}', AOrderId, []) + '/acceptOrderCancellation';
  FHTTP
    .POST
    .BaseURL(FBaseUrl)
    .Resource(LResource)
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
  finally
    LResponse.Free;
  end;
end;

function TACBrOpenDeliveryHTTPClientActions.BaseUrl(const AValue: string): TACBrOpenDeliveryHTTPClientActions;
begin
  Result := Self;
  FBaseUrl := AValue;
end;

procedure TACBrOpenDeliveryHTTPClientActions.Confirm(AOrderConfirmations: TACBrOpenDeliverySchemaOrderConfirmation);
var
  LResource: string;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  LResource := StringReplace(FResource, '{orderId}', AOrderConfirmations.id, []) + '/confirm';
  FHTTP
    .POST
    .BaseURL(FBaseUrl)
    .Resource(LResource)
    .Body(AOrderConfirmations.AsJSON)
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
  finally
    LResponse.Free;
  end;
end;

constructor TACBrOpenDeliveryHTTPClientActions.Create(const AHTTPRequest: TACBrOpenDeliveryHTTPRequest);
begin
  FHTTP := AHTTPRequest;
  FResource := 'v1/orders/{orderId}';
end;

procedure TACBrOpenDeliveryHTTPClientActions.DenyOrderCancellation(ADenyRequest: TACBrOpenDeliverySchemaOrderCancelDenyRequest);
var
  LResource: string;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  LResource := StringReplace(FResource, '{orderId}', ADenyRequest.orderId, []) + '/denyCancellation';
  FHTTP
    .POST
    .BaseURL(FBaseUrl)
    .Resource(LResource)
    .Body(ADenyRequest.AsJSON)
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
  finally
    LResponse.Free;
  end;
end;

destructor TACBrOpenDeliveryHTTPClientActions.Destroy;
begin
  FHTTP.Free;
  inherited;
end;

procedure TACBrOpenDeliveryHTTPClientActions.Dispatch(const AOrderId: string);
var
  LResource: string;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  LResource := StringReplace(FResource, '{orderId}', AOrderId, []) + '/dispatch';
  FHTTP
    .POST
    .BaseURL(FBaseUrl)
    .Resource(LResource)
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
  finally
    LResponse.Free;
  end;
end;

procedure TACBrOpenDeliveryHTTPClientActions.ReadyForPickup(const AOrderId: string);
var
  LResource: string;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  LResource := StringReplace(FResource, '{orderId}', AOrderId, []) + '/readyForPickup';
  FHTTP
    .POST
    .BaseURL(FBaseUrl)
    .Resource(LResource)
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
  finally
    LResponse.Free;
  end;
end;

procedure TACBrOpenDeliveryHTTPClientActions.RequestOrderCancellation(ACancelRequest: TACBrOpenDeliverySchemaOrderCancelRequest);
var
  LResource: string;
  LResponse: TACBrOpenDeliveryHTTPResponse;
begin
  LResource := StringReplace(FResource, '{orderId}', ACancelRequest.orderId, []) + '/requestCancellation';
  FHTTP
    .POST
    .BaseURL(FBaseUrl)
    .Resource(LResource)
    .Body(ACancelRequest.AsJSON)
    .Token(FToken);

  LResponse := FHTTP.Send;
  try
  finally
    LResponse.Free;
  end;
end;

function TACBrOpenDeliveryHTTPClientActions.Resource(const AValue: string): TACBrOpenDeliveryHTTPClientActions;
begin
  Result := Self;
  FResource := AValue;
end;

function TACBrOpenDeliveryHTTPClientActions.Token(const AValue: string): TACBrOpenDeliveryHTTPClientActions;
begin
  Result := Self;
  FToken := AValue;
end;

end.

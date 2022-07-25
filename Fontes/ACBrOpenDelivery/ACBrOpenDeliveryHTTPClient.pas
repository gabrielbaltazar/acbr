unit ACBrOpenDeliveryHTTPClient;

interface

uses
  ACBrOpenDeliveryHTTP,
  ACBrOpenDeliveryHTTPClientAuth,
  ACBrOpenDeliveryHTTPClientDetails,
  ACBrOpenDeliveryHTTPClientEvents;

type
  TACBrOpenDeliveryHTTPClient = class
  private
    FAuth: TACBrOpenDeliveryHTTPClientAuth;
    FDetails: TACBrOpenDeliveryHTTPClientDetails;
    FEvents: TACBrOpenDeliveryHTTPClientEvents;

    function GetAuth: TACBrOpenDeliveryHTTPClientAuth;
    function GetEvents: TACBrOpenDeliveryHTTPClientEvents;

    function NewHTTP: TACBrOpenDeliveryHTTPRequest;
    function GetDetails: TACBrOpenDeliveryHTTPClientDetails;

  public
    destructor Destroy; override;

    property Auth: TACBrOpenDeliveryHTTPClientAuth read GetAuth;
    property Details: TACBrOpenDeliveryHTTPClientDetails read GetDetails;
    property Events: TACBrOpenDeliveryHTTPClientEvents read GetEvents;
  end;

implementation

{ TACBrOpenDeliveryHTTPClient }

destructor TACBrOpenDeliveryHTTPClient.Destroy;
begin
  FAuth.Free;
  FDetails.Free;
  FEvents.Free;
  inherited;
end;

function TACBrOpenDeliveryHTTPClient.GetAuth: TACBrOpenDeliveryHTTPClientAuth;
begin
  if not Assigned(FAuth) then
    FAuth := TACBrOpenDeliveryHTTPClientAuth.Create(NewHTTP);
  Result := FAuth;
end;

function TACBrOpenDeliveryHTTPClient.GetDetails: TACBrOpenDeliveryHTTPClientDetails;
begin
  if not Assigned(FDetails) then
    FDetails := TACBrOpenDeliveryHTTPClientDetails.Create(NewHTTP);
  Result := FDetails;
end;

function TACBrOpenDeliveryHTTPClient.GetEvents: TACBrOpenDeliveryHTTPClientEvents;
begin
  if not Assigned(FEvents) then
    FEvents := TACBrOpenDeliveryHTTPClientEvents.Create(NewHTTP);
  Result := FEvents;
end;

function TACBrOpenDeliveryHTTPClient.NewHTTP: TACBrOpenDeliveryHTTPRequest;
begin
  Result := TACBrOpenDeliveryHTTPRequest.New('');
end;

end.

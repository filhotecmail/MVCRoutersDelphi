unit Routers.Midleware.Abstract;

interface
  uses System.classes;

  type TMidlwareRoute = Class Abstract(TPersistent)
  strict private
    FIsValidate: Boolean;
    FMsgnotValidate: String;
    procedure SetIsValidate(const Value: Boolean);
    procedure SetMsgnotValidate(const Value: String);
  published
    property IsValidate: Boolean read FIsValidate write SetIsValidate;
    property Msg: String read FMsgnotValidate write SetMsgnotValidate;
  end;

implementation
 { TMidlwareRoute }
procedure TMidlwareRoute.SetIsValidate(const Value: Boolean);
begin
  FIsValidate := Value;
end;

procedure TMidlwareRoute.SetMsgnotValidate(const Value: String);
begin
  FMsgnotValidate := Value;
end;

end.

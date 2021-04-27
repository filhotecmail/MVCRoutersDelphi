unit Routers.Middleware.Abstract;

interface
  uses System.classes;

  type TMiddlwareRoute = Class Abstract(TPersistent)
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
procedure TMiddlwareRoute.SetIsValidate(const Value: Boolean);
begin
  FIsValidate := Value;
end;

procedure TMiddlwareRoute.SetMsgnotValidate(const Value: String);
begin
  FMsgnotValidate := Value;
end;

end.

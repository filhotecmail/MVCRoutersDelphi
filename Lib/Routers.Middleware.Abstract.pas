unit Routers.Middleware.Abstract;

interface
  uses System.classes,System.SysUtils, Rtti;

  type TMiddlwareRoute = Class Abstract(TPersistent)
  strict private
    FIsValidate: Boolean;
    FMsgnotValidate: String;
    procedure SetIsValidate(const Value: Boolean);
    procedure SetMsgnotValidate(const Value: String);
  private
    FACallBackValue: TProc<TValue>;
    procedure SetACallBackValue(const Value: TProc<TValue>);
  published
    property IsValidate: Boolean read FIsValidate write SetIsValidate;
    property Msg: String read FMsgnotValidate write SetMsgnotValidate;
    property ACallBackValue: TProc<TValue> read FACallBackValue write SetACallBackValue;
  end;

implementation
 { TMidlwareRoute }
procedure TMiddlwareRoute.SetACallBackValue(const Value: TProc<TValue>);
begin
  FACallBackValue := Value;
end;

procedure TMiddlwareRoute.SetIsValidate(const Value: Boolean);
begin
  FIsValidate := Value;
end;

procedure TMiddlwareRoute.SetMsgnotValidate(const Value: String);
begin
  FMsgnotValidate := Value;
end;

end.

unit Connection.Master.IInterface;

interface
 uses System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,RTTI;

    type TAfterCommit = procedure(Sender: TObject) of object;
    type TAfterConnect = procedure(Sender: TObject) of object;
    type TAfterDisconnect = procedure(Sender: TObject) of object;
    type TAfterRollback= procedure(Sender: TObject) of object;
    type TAfterStartTransaction= procedure(Sender: TObject) of object;
    type TBeforeCommit= procedure(Sender: TObject) of object;
    type TBeforeConnect= procedure(Sender: TObject) of object;
    type TBeforeDisconnect= procedure(Sender: TObject) of object;
    type TBeforeRollback= procedure(Sender: TObject) of object;
    type TBeforeStartTransaction= procedure(Sender: TObject) of object;
    type TError= procedure (ASender, AInitiator: TObject; var AException: Exception) of object;
    type TLogin = procedure(ASender: TObject; ATrace: String) of object;
    type TLost = procedure(Sender: TObject) of object;
    type TRecover = procedure(ASender, AInitiator: TObject; AException: Exception)of object;
    type TRestored= procedure(Sender: TObject) of object;

  type TEventsConnection = class
  private
    FBeforeCommit: TBeforeCommit;
    FAfterDisconnect: TAfterDisconnect;
    FBeforeRollback: TBeforeRollback;
    FBeforeStartTransaction: TBeforeStartTransaction;
    FBeforeConnect: TBeforeConnect;
    FAfterCommit: TAfterCommit;
    FRestored: TRestored;
    FRecover: TRecover;
    FBeforeDisconnect: TBeforeDisconnect;
    FAfterRollback: TAfterRollback;
    FError: TError;
    FLogin: TLogin;
    FAfterStartTransaction: TAfterStartTransaction;
    FAfterConnect: TAfterConnect;
    FLost: TLost;
    procedure SetAfterCommit(const Value: TAfterCommit);
    procedure SetAfterConnect(const Value: TAfterConnect);
    procedure SetAfterDisconnect(const Value: TAfterDisconnect);
    procedure SetAfterRollback(const Value: TAfterRollback);
    procedure SetAfterStartTransaction(const Value: TAfterStartTransaction);
    procedure SetBeforeCommit(const Value: TBeforeCommit);
    procedure SetBeforeConnect(const Value: TBeforeConnect);
    procedure SetBeforeDisconnect(const Value: TBeforeDisconnect);
    procedure SetBeforeRollback(const Value: TBeforeRollback);
    procedure SetBeforeStartTransaction(const Value: TBeforeStartTransaction);
    procedure SetError(const Value: TError);
    procedure SetLogin(const Value: TLogin);
    procedure SetLost(const Value: TLost);
    procedure SetRecover(const Value: TRecover);
    procedure SetRestored(const Value: TRestored);
  published
    Property AfterCommit: TAfterCommit read FAfterCommit write SetAfterCommit;
    Property AfterConnect:TAfterConnect read FAfterConnect write SetAfterConnect;
    Property AfterDisconnect:TAfterDisconnect read FAfterDisconnect write SetAfterDisconnect;
    Property AfterRollback:TAfterRollback read FAfterRollback write SetAfterRollback;
    Property AfterStartTransaction:TAfterStartTransaction read FAfterStartTransaction write SetAfterStartTransaction;
    Property BeforeCommit:TBeforeCommit read FBeforeCommit write SetBeforeCommit;
    Property BeforeConnect:TBeforeConnect read FBeforeConnect write SetBeforeConnect;
    Property BeforeDisconnect:TBeforeDisconnect read FBeforeDisconnect write SetBeforeDisconnect;
    Property BeforeRollback:TBeforeRollback read FBeforeRollback write SetBeforeRollback;
    Property BeforeStartTransaction:TBeforeStartTransaction read FBeforeStartTransaction write SetBeforeStartTransaction;
    Property Error:TError read FError write SetError;
    Property Login:TLogin read FLogin write SetLogin;
    Property Lost:TLost read FLost write SetLost;
    Property Recover:TRecover read FRecover write SetRecover;
    Property Restored:TRestored read FRestored write SetRestored;
  end;
  type
     IConnectionMaster = Interface
     ['{2C6E4D36-B52D-4C75-ADAC-C93DEADF2369}']
     function SetConnection( pComponent: TObject ):IConnectionMaster;
     function GetConnection:TValue;
     function AssignEvents( CallBack: TProc<TEventsConnection> ):IConnectionMaster;
  End;

 implementation

{ TEventsConnection }

procedure TEventsConnection.SetAfterCommit(const Value: TAfterCommit);
begin
  FAfterCommit := Value;
end;

procedure TEventsConnection.SetAfterConnect(const Value: TAfterConnect);
begin
  FAfterConnect := Value;
end;

procedure TEventsConnection.SetAfterDisconnect(const Value: TAfterDisconnect);
begin
  FAfterDisconnect := Value;
end;

procedure TEventsConnection.SetAfterRollback(const Value: TAfterRollback);
begin
  FAfterRollback := Value;
end;

procedure TEventsConnection.SetAfterStartTransaction(const Value: TAfterStartTransaction);
begin
  FAfterStartTransaction := Value;
end;

procedure TEventsConnection.SetBeforeCommit(const Value: TBeforeCommit);
begin
  FBeforeCommit := Value;
end;

procedure TEventsConnection.SetBeforeConnect(const Value: TBeforeConnect);
begin
  FBeforeConnect := Value;
end;

procedure TEventsConnection.SetBeforeDisconnect(const Value: TBeforeDisconnect);
begin
  FBeforeDisconnect := Value;
end;

procedure TEventsConnection.SetBeforeRollback(const Value: TBeforeRollback);
begin
  FBeforeRollback := Value;
end;

procedure TEventsConnection.SetBeforeStartTransaction(const Value: TBeforeStartTransaction);
begin
  FBeforeStartTransaction := Value;
end;

procedure TEventsConnection.SetError(const Value: TError);
begin
  FError := Value;
end;

procedure TEventsConnection.SetLogin(const Value: TLogin);
begin
  FLogin := Value;
end;

procedure TEventsConnection.SetLost(const Value: TLost);
begin
  FLost := Value;
end;

procedure TEventsConnection.SetRecover(const Value: TRecover);
begin
  FRecover := Value;
end;

procedure TEventsConnection.SetRestored(const Value: TRestored);
begin
  FRestored := Value;
end;

end.

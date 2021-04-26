unit Connection.Master.Firedac;

Interface
uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,Connection.Master.IInterface,
  Rtti,System.Generics.Collections,System.Generics.Defaults, Json;

 type
  TMasterFiredac = class(TInterfacedPersistent,IConnectionMaster)
  strict private
    FAowner: TComponent;
  private
    { Private declarations }
    FCon: TFDConnection;
    FPsysFB: TFDPhysFBDriverLink;
    FEvents: TEventsConnection;
    FConfigDatabase: TJSONObject;
  public
    { Public declarations }
     function SetConnection( pComponent: TObject ):IConnectionMaster;
     function GetConnection:TValue;
     function AssignEvents( CallBack: TProc<TEventsConnection> ):IConnectionMaster;
     class function New( AOwner: TComponent; AConfig: TJsonObject ):IConnectionMaster;
     constructor Create(AOwner: TComponent; AConfig: TJsonObject); virtual;
  end;

implementation
{ TMasterFiredac }
function TMasterFiredac.AssignEvents(CallBack: TProc<TEventsConnection>): IConnectionMaster;
begin
 Result:= Self;
 if Assigned(CallBack) then
    CallBack(FEvents);
end;

constructor TMasterFiredac.Create(AOwner: TComponent; AConfig: TJsonObject);
begin
 FAowner:= AOwner;
 FConfigDatabase:= AConfig;
end;

function TMasterFiredac.GetConnection: TValue;
begin
 Result := FCon;
end;

class function TMasterFiredac.New( AOwner: TComponent; AConfig: TJsonObject ): IConnectionMaster;
begin
 Result := TMasterFiredac.Create(AOwner,AConfig);
end;

function TMasterFiredac.SetConnection(pComponent: TObject): IConnectionMaster;
begin
 Result:= Self;
 if Assigned(pComponent) then
  ( pComponent As TFDQuery ).Connection := FCon;
end;

initialization
 RegisterClassAlias( TMasterFiredac, 'OConFiredac');
 Finalization
 UnRegisterClass( TMasterFiredac );
end.

unit Model.ObjectConcrete;

interface

uses Model.IInterfaces, system.Classes, system.SysUtils, Rtti, Observers.IInterfaces,
  System.Generics.Collections, DataBase.Config.Types, Commom.Utils,
  Services.Containner.IInterfaces, DB, Datasnap.DBClient,
  Services.Containner.ObjConcrete, MidasLib, Commom.RTTI.Utils;

type
  TModelAbstract = class Abstract(TInterfacedPersistent, IModel, ISubject)
  strict private
    FAOwner: TObject;
    FObserver: IObservers;
  private
    FPropriedades: TProps;
    FListDao: TDictionary<string, TObject>;
    FListObserver: TList<IObservers>;
    FSetConnection: string;
    FContainnerServices: TDictionary<string, TObject>;
    FDaos: TArray<string>;
    FRegisterContainnerServices: TArray<string>;
    function Props(const AProps: Tproc<TProps>): IModel; virtual;
    function Rules(const AFieldsNames: TArray<string>; const AfriendlyNames: Tarray<string>;
      AMessagesErrorForFields: TArray<TMessagesErrorType>): IModel; virtual;
    procedure SetPropriedades(const Value: TProps);
    procedure SetSetConnection(const Value: string);
    procedure SetDao(const Value: TArray<string>);

  public
    constructor Create(AOwner: TObject; AObserverClass: TCLass); virtual;

    function AddObserver(AObservers: IObservers): ISubject; virtual;
    function RemoveObserver(AObservers: IObservers): ISubject; virtual;
    function NotifyObservers: ISubject; virtual;
    procedure AfterOpen(Obj: TValue); virtual;
    procedure BeforeOpen(Obj: TValue); virtual;
    procedure AfterClose(Obj: TValue); virtual;
    procedure BeforeClose(Obj: TValue); virtual;
    procedure AfterInsert(Obj: TValue); virtual;
    procedure BeforeInsert(Obj: TValue); virtual;
    procedure AfterPost(Obj: TValue); virtual;
    procedure BeforePost(Obj: TValue); virtual;
    procedure AfterEdit(Obj: TValue); virtual;
    procedure BeforeEdit(Obj: TValue); virtual;
    procedure AfterDelete(Obj: TValue); virtual;
    procedure BeforeDelete(Obj: TValue); virtual;
    procedure OnState(Obj: TValue); virtual;
    procedure Aftercancel(Obj: TValue); virtual;
    procedure BeforeCancel(Obj: TValue); virtual;
    procedure OnError(Obj: TValue); virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Get(AParams: TArray<TValue>): variant; virtual; abstract;
    function Post(AParams: TArray<TValue> = nil): variant; virtual; abstract;
    function GetAll: variant; virtual; abstract;
    procedure InternalRegisterDaos( AParamsConstructor: TArray<TArrayOfParams> );
    procedure CreateAsTclientDataset(AObject: TObject);
    procedure InternalregisterContainnerServices(AParamsConstructor: TArray<TArrayOfParams>);
  published
    property Properties: TProps read FPropriedades write SetPropriedades;
    procedure RegisterContainnerServices(const Value: TArray<string>;
      AParamsConstructor: Tarray<TArrayOfParams>);
    procedure RegisterDAOs( const ADAOsNames: TArray<string>;
      AParamsConstructor: Tarray<TArrayOfParams> );

    function ContainnerServices<T>(const AContainnerName: string): T;
    function Execute<T>(const AClassName: string; const AMethodName: string; APArams: array of TValue): T;
    procedure FreeListObjects;
  end;

implementation

{ TModelAbstract }

function TModelAbstract.AddObserver(AObservers: IObservers): ISubject;
begin
  result := self;
  FListObserver.Add(AObservers);
end;

procedure TModelAbstract.Aftercancel(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].Aftercancel(Obj);
end;

procedure TModelAbstract.AfterClose(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].AfterClose(Obj);
end;

procedure TModelAbstract.AfterConstruction;
begin
  inherited;

end;

procedure TModelAbstract.AfterDelete(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].AfterDelete(Obj);
end;

procedure TModelAbstract.AfterEdit(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].AfterEdit(Obj);
end;

procedure TModelAbstract.AfterInsert(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].AfterInsert(Obj);
end;

procedure TModelAbstract.AfterOpen(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].AfterOpen(Obj);
end;

procedure TModelAbstract.AfterPost(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].AfterPost(Obj);
end;

procedure TModelAbstract.BeforeCancel(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforeCancel(Obj);
end;

procedure TModelAbstract.BeforeClose(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforeClose(Obj);
end;

procedure TModelAbstract.BeforeDelete(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforeDelete(Obj);
end;

procedure TModelAbstract.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FListObserver);
  FreeAndNil(FPropriedades);
  FreeAndNil(FListDao);
  FreeAndNil(FContainnerServices);
end;

procedure TModelAbstract.BeforeEdit(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforeEdit(Obj);
end;

procedure TModelAbstract.BeforeInsert(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforeInsert(Obj);
end;

procedure TModelAbstract.BeforeOpen(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforeOpen(Obj);
end;

procedure TModelAbstract.BeforePost(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].BeforePost(Obj);
end;

function TModelAbstract.ContainnerServices<T>(const AContainnerName: string): T;
begin
  if FContainnerServices.ContainsKey(AContainnerName) then
    result := TValue.From(FContainnerServices.Items[AContainnerName]).AsType<T>;
end;

constructor TModelAbstract.Create(AOwner: TObject; AObserverClass: TCLass);
begin
  inherited Create;
  FAOwner := AOwner;
  FListObserver := TList<IObservers>.Create;
  FPropriedades := TProps.Create;
  FListDao := TDictionary<string, TObject>.Create;
  FContainnerServices := TDictionary<string, TObject>.Create;
  //FObserver:= AObserverClass;
end;

procedure TModelAbstract.CreateAsTclientDataset(AObject: TObject);
var
  X: integer;
  Y: integer;
  Frequired: boolean;
begin
  if (AObject is TClientDataset) then
  begin
    for X := Low(Properties.Fillable) to High(Properties.Fillable) do
    begin
      for Y := Low(Properties.RequiredFields) to High(Properties.RequiredFields) do
        Frequired := (Properties.RequiredFields[y] = Properties.Fillable[x]);

      TClientDataset(AObject).FieldDefs.Add(Properties.Fillable[x],
        Properties.FieldTypes[x], Properties.SizeFields[x], Frequired);
    end;
    TClientDataset(AObject).CreateDataSet;
  end;
end;

function TModelAbstract.Execute<T>(const AClassName, AMethodName: string; APArams: array of TValue): T;
begin
  result := TInvoke.Create._InvokeRttiMethod<T>(FListDao.Items[AClassName], AMethodName, APArams);
end;

procedure TModelAbstract.FreeListObjects;
begin

end;

procedure TModelAbstract.InternalregisterContainnerServices(AParamsConstructor: TArray<TArrayOfParams>);
var
  I: integer;
begin
  for I := Low(FRegisterContainnerServices) to High(FRegisterContainnerServices) do
    Assert(GetClass(FRegisterContainnerServices[I]) <> nil,
      Format('Não existe um ContainnerServices registrado com o Alias %s ', [FRegisterContainnerServices[I]]));

  TLib.CreateFromRTTI(FRegisterContainnerServices, AParamsConstructor, FContainnerServices,
    procedure (AObject: TObject)
    begin
  { Dentro do Dicionário de dados o sistema irá criar as instâncias dos Dao´s informados
   acionando o método construtor.}
      CreateAsTclientDataset(AObject);
    end);
end;

function TModelAbstract.NotifyObservers: ISubject;
var
  I: integer;
begin
  result := Self;
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].Notify;
end;

procedure TModelAbstract.OnError(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].OnError(Obj);
end;

procedure TModelAbstract.OnState(Obj: TValue);
var
  I: integer;
begin
  for I := 0 to FListObserver.Count - 1 do
    FListObserver.Items[I].OnState(Obj);
end;

function TModelAbstract.Props(const AProps: Tproc<TProps>): IModel;
begin
  result := self;
end;

procedure TModelAbstract.InternalRegisterDaos( AParamsConstructor: TArray<TArrayOfParams> );
var I: Integer;
begin
 for I := Low(FDaos) to High(FDaos) do
   Assert(GetClass(FDaos[i]) <> nil, Format('Não existe um DAO registrado com o Alias %s ',[ FDaos[i] ]));
   TLib.CreateFromRTTI(FDaos, AParamsConstructor, FListDao);
  { Dentro do Dicionário de dados o sistema irá criar as instâncias dos Dao´s informados
    acionando o método construtor.}
end;

function TModelAbstract.RemoveObserver(AObservers: IObservers): ISubject;
begin
  result := self;
  FListObserver.Remove(AObservers);
end;

function TModelAbstract.Rules(const AFieldsNames, AfriendlyNames: Tarray<string>;
  AMessagesErrorForFields: TArray<TMessagesErrorType>): IModel;
begin

end;

procedure TModelAbstract.SetDao(const Value: TArray<string>);
begin
  FDaos := Value;
end;

procedure TModelAbstract.SetPropriedades(const Value: TProps);
begin
  FPropriedades := Value;
end;

procedure TModelAbstract.RegisterContainnerServices(const Value: TArray<string>;
  AParamsConstructor: Tarray<TArrayOfParams>);
begin
  FRegisterContainnerServices := Value;
  // Registra Containers de Serviços para o Modelo
  InternalregisterContainnerServices(AParamsConstructor);
end;

procedure TModelAbstract.RegisterDAOs(const ADAOsNames: TArray<string>;
  AParamsConstructor: Tarray<TArrayOfParams>);
begin
 FDaos := ADAOsNames;
 InternalRegisterDaos(AParamsConstructor);
end;

procedure TModelAbstract.SetSetConnection(const Value: string);
begin
  FSetConnection := Value;

end;

end.

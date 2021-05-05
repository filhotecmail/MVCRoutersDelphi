unit Model.ObjectConcrete;

interface

uses Model.IInterfaces,system.classes,system.SysUtils,Rtti, Observers.IInterfaces,
     System.Generics.Collections, DataBase.Config.Types, Commom.Utils,
  Services.Containner.IInterfaces,DB,Datasnap.DBClient,
  Services.Containner.ObjConcrete,MidasLib;

 type TModelAbstract = class Abstract(TInterfacedPersistent,IModel,ISubject)
  strict private
    FAOwner: TObject;
    FObserver: IObservers;
    private
    FPropriedades: TProps;
    FListDao: TDictionary<String,TObject>;
    FListObserver: TList<IObservers>;
    FSetConnection: String;
    FContainnerServices: TDictionary<String,TObject>;
    FDao: TArray<String>;
    FRegisterContainnerServices: TArray<String>;
     function Props(const AProps: Tproc<TProps>):IModel; virtual;
     function Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ):IModel; Virtual;
    procedure SetPropriedades(const Value: TProps);
    procedure SetSetConnection(const Value: String);
    procedure SetDao(const Value: TArray<String>);
    procedure SetRegisterContainnerServices(const Value: TArray<String>);
  public
    Constructor Create(AOwner: TObject; AObserverClass: TCLass); virtual;

    function AddObserver(AObservers: IObservers): ISubject; virtual;
    function RemoveObserver(AObservers: IObservers): ISubject; virtual;
    function NotifyObservers: ISubject; virtual;
    procedure AfterOpen(Obj: TValue); virtual;
    procedure BeforeOpen(Obj: TValue);virtual;
    procedure AfterClose(Obj: TValue);virtual;
    procedure BeforeClose(Obj: TValue); virtual;
    procedure AfterInsert(Obj: TValue);virtual;
    procedure BeforeInsert(Obj: TValue);virtual;
    procedure AfterPost(Obj: TValue);virtual;
    procedure BeforePost(Obj: TValue);virtual;
    procedure AfterEdit(Obj: TValue);virtual;
    procedure BeforeEdit(Obj: TValue);virtual;
    procedure AfterDelete(Obj: TValue); virtual;
    procedure BeforeDelete(Obj: TValue);virtual;
    procedure OnState(Obj: TValue);virtual;
    procedure Aftercancel(Obj: TValue);virtual;
    procedure BeforeCancel(Obj: TValue); virtual;
    procedure OnError(Obj: TValue);virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Get(AParams: TArray<TValue>):variant; virtual; Abstract;
    function Post(AParams: TArray<TValue> = nil):Variant; virtual; Abstract;
    function GetAll:Variant; virtual; Abstract;
    procedure RegisterDaos;
    procedure CreateAsTclientDataset(AObject: TObject);
   published
    property Properties:TProps read FPropriedades write SetPropriedades;
    property SetConnection: String read FSetConnection write SetSetConnection;
    property RegisterDAO: TArray<String> read FDao write SetDao;
    property RegisterContainnerServices: TArray<String> read FRegisterContainnerServices write SetRegisterContainnerServices;
    function ContainnerServices<T>(Const AContainnerName: String):T;
    function Execute<T>(Const AClassName: String; Const AMethodName: String; APArams: Array of TValue ):T;
    procedure InternalregisterContainnerServices;
    procedure FreeListObjects;
  end;

  implementation
{ TModelAbstract }

function TModelAbstract.AddObserver(AObservers: IObservers): ISubject;
begin
 Result := self;
 FListObserver.Add(AObservers);
end;

procedure TModelAbstract.Aftercancel(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].Aftercancel(Obj);
end;

procedure TModelAbstract.AfterClose(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterClose(Obj);
end;

procedure TModelAbstract.AfterConstruction;
begin
  inherited;

end;

procedure TModelAbstract.AfterDelete(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterDelete(Obj);
end;

procedure TModelAbstract.AfterEdit(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterEdit(Obj);
end;

procedure TModelAbstract.AfterInsert(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterInsert(Obj);
end;

procedure TModelAbstract.AfterOpen(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterOpen(Obj);
end;

procedure TModelAbstract.AfterPost(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterPost(Obj);
end;

procedure TModelAbstract.BeforeCancel(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeCancel(Obj);
end;

procedure TModelAbstract.BeforeClose(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeClose(Obj);
end;

procedure TModelAbstract.BeforeDelete(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeDelete(Obj);
end;

procedure TModelAbstract.BeforeDestruction;
begin
  inherited;
 FreeAndNil(FListObserver);
 FreeAndNil(FPropriedades);
 FreeAndNil( FListDao );
 FreeAndNil( FContainnerServices );
end;

procedure TModelAbstract.BeforeEdit(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeEdit(Obj);
end;

procedure TModelAbstract.BeforeInsert(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeInsert(Obj);
end;

procedure TModelAbstract.BeforeOpen(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeOpen(Obj);
end;

procedure TModelAbstract.BeforePost(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforePost(Obj);
end;

function TModelAbstract.ContainnerServices<T>(const AContainnerName: String): T;
begin
 if  FContainnerServices.ContainsKey(AContainnerName) then
     Result := TValue.From(FContainnerServices.Items[AContainnerName]).AsType<T>;
end;

constructor TModelAbstract.Create(AOwner: TObject; AObserverClass: TCLass);
begin
 inherited Create;
 FAOwner:= AOwner;
 FListObserver := TList<IObservers>.create;
 FPropriedades:= TProps.Create;
 FListDao:= TDictionary<String,TObject>.create;
 FContainnerServices:= TDictionary<String,TObject>.create;
 //FObserver:= AObserverClass;
end;

procedure TModelAbstract.CreateAsTclientDataset(AObject: TObject);
var
  X: Integer;
  Y: Integer;
  Frequired: Boolean;
begin
 if (AObject is TClientDataset) then
      begin
        for X := Low(Properties.Fillable) to High(Properties.Fillable) do
        begin
         for Y := Low(Properties.RequiredFields) to High(Properties.RequiredFields) do
           Frequired:= (Properties.RequiredFields[y] = Properties.Fillable[x]);

         TClientDataset( AObject ).FieldDefs.Add( Properties.Fillable[x],
          Properties.FieldTypes[x],Properties.SizeFields[x],Frequired );
        end;
         TClientDataset( AObject).CreateDataSet;
      end;
end;

function TModelAbstract.Execute<T>(const AClassName, AMethodName: String;
  APArams: array of TValue):T;
begin
 Result:=  TInvoke.Create._InvokeRttiMethod<T>( FListDao.Items[AClassName],AMethodName,APArams );
end;

procedure TModelAbstract.FreeListObjects;
begin

end;

procedure TModelAbstract.InternalregisterContainnerServices;
var FClass: TPersistentClass;
    FObject: TObject;
    RttiContext: TRttiContext;
    RttiInstanceType: TRttiInstanceType;
    RttiMethod: TRttiMethod;
    Instance: TValue;
    I: Integer;
    FObserversClass: TPersistentClass;
    RttiContextObserver: TRttiContext;
    FClassObserver: TPersistentClass;
    RttiInstanceTypeObserver: TRttiInstanceType;
    RttiField: TRttiField;
  X: Integer;
  Y: Integer;
  Frequired: Boolean;
begin
  for I := Low(FRegisterContainnerServices) to High(FRegisterContainnerServices) do
  begin
  { Dentro do Dicionário de dados o sistema irá criar as instâncias dos Dao´s informados
    acionando o método construtor.}
    Assert( GetClass(FRegisterContainnerServices[i]) <> nil,'Não existe um ContainnerServices registrado com o Alias '+FRegisterContainnerServices[i]  );
    if not FContainnerServices.ContainsKey(FRegisterContainnerServices[i]) then
    begin
      FClass:= FindClass(FRegisterContainnerServices[i]);
      RttiContext := TRttiContext.Create;
      RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
      Instance := RttiInstanceType;
      RttiMethod := RttiInstanceType.GetMethod('Create');
      FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,[nil]).AsObject;
      CreateAsTclientDataset(FObject);
      // Vai injetar no Field da Classe base Chamado Model a instância Criada;
      FContainnerServices.Add(FRegisterContainnerServices[i],FObject);
    end;
  end;
end;

function TModelAbstract.NotifyObservers: ISubject;
var
  I: Integer;
begin
 Result := Self;
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].Notify;
end;

procedure TModelAbstract.OnError(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].OnError(Obj);
end;

procedure TModelAbstract.OnState(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].OnState(Obj);
end;

function TModelAbstract.Props(const AProps: Tproc<TProps>): IModel;
begin
  Result := self;
end;

procedure TModelAbstract.RegisterDaos;
var FClass: TPersistentClass;
    FObject: TObject;
    RttiContext: TRttiContext;
    RttiInstanceType: TRttiInstanceType;
    RttiMethod: TRttiMethod;
    Instance: TValue;
    I: Integer;
    FObserversClass: TPersistentClass;
    RttiContextObserver: TRttiContext;
    FClassObserver: TPersistentClass;
    RttiInstanceTypeObserver: TRttiInstanceType;
    RttiField: TRttiField;
begin
  for I := Low(FDao) to High(FDao) do
  begin
  { Dentro do Dicionário de dados o sistema irá criar as instâncias dos Dao´s informados
    acionando o método construtor.}
    Assert( GetClass(FDao[i]) <> nil,'Não existe um DAO registrado com o Alias '+FDao[i]  );
    if not FListDao.ContainsKey(FDao[i]) then
    begin
      FClass:= FindClass(FDao[i]);
      RttiContext := TRttiContext.Create;
      RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
      Instance := RttiInstanceType;
      RttiMethod := RttiInstanceType.GetMethod('Create');
      FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,[]).AsObject;
      // Vai injetar no Field da Classe base Chamado Model a instância Criada;
      FListDao.Add(FDao[i],FObject);
    end;
  end;
end;

function TModelAbstract.RemoveObserver(AObservers: IObservers): ISubject;
begin
 Result := self;
 FListObserver.Remove(AObservers);
end;

function TModelAbstract.Rules(const AFieldsNames,
  AfriendlyNames: Tarray<String>;
  AMessagesErrorForFields: TArray<TMessagesErrorType>): IModel;
begin

end;

procedure TModelAbstract.SetDao(const Value: TArray<String>);
begin
  FDao := Value;
  RegisterDaos;
end;

procedure TModelAbstract.SetPropriedades(const Value: TProps);
begin
  FPropriedades := Value;
end;

procedure TModelAbstract.SetRegisterContainnerServices(
  const Value: TArray<String>);
begin
  FRegisterContainnerServices := Value;
  // Registra Containers de Serviços para o Modelo
  InternalregisterContainnerServices;
end;

procedure TModelAbstract.SetSetConnection(const Value: String);
begin
  FSetConnection := Value;

end;

end.

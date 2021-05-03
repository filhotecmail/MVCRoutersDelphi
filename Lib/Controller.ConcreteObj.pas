unit Controller.ConcreteObj;

interface
  uses System.classes,Controller.IInterfaces,Rtti,Vcl.Forms,System.SysUtils,
  Model.ObjectConcrete, Model.IInterfaces,System.Generics.Collections,
  Observers.IInterfaces, View.Abstract;

type TControllerBase = Class Abstract(TInterfacedPersistent,IController)
  strict private
    FClass: TPersistentClass;
    FModels: TDictionary<String,TValue>;
    FObservers: TDictionary<String,TValue>;
    FProvidersService: TDictionary<String,TValue>;
  private
    FModelName: string;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Render():TValue; virtual;
    function Get(const AValues: Tarray<TValue>):TValue; virtual;
    function Models(AModelsNames: TArray<String>; AObservers: TArray<String>):TControllerBase;
    function Model( Const AModelName: string ):TValue;

     /// <summary>
     ///  verificar Se existe a classe registrada ServiceProider Informada.
     ///   verificar se existe um Model que possa corresponder ao provedor de serviços
     ///   Se não existir Informar ao Usuário que não existe um model que possa interagir com o provedor de serviços.
     ///   Se existir Acionar o construtor New Da classe e armazenar a instância do construtor.
     ///   Adicionar No Dicionariod e dados como Chave o Nome do Modelo e a Instância do ServiceProvider, para que
     ///   possamos recuperar provedores de serviços registrados para o Modelo.
     ///
     /// </summary>
    function ProviderService(AProviderServiceName: TArray<String>; AModels: TArray<String>):TValue;
    function OBServers( Const AObserverNames: TArray<String> ):TControllerBase; virtual;
End;

  function View(Const AViewName: String; AOwner: TComponent; AControllerName: String):TObject;

implementation
 { TControllerBase }

 function View(Const AViewName: String; AOwner: TComponent; AControllerName: String):TObject;
 var FrmClass : TFormClass;
     Frm : TForm;
 begin
  Assert( GetClass(AViewName) <> nil,'View não registrada' );
  FrmClass := TFormClass(FindClass(AViewName));
  Frm      := FrmClass.Create(Application);
  Result:= TForm.Create(AOwner);
  try
   Frm.ShowModal;
  finally
   FreeAndNil( Frm );
  end;
 end;

procedure TControllerBase.AfterConstruction;
begin
  inherited;
   FModels:= TDictionary<String,TValue>.create;
   FObservers:= TDictionary<String,TValue>.create;
   FProvidersService:= TDictionary<String,TValue>.create;
end;


procedure TControllerBase.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FModels );
  FreeAndNil( FObservers );
  FreeAndNil( FProvidersService );
end;

function TControllerBase.Get(const AValues: Tarray<TValue>): TValue;
begin


end;

function TControllerBase.Model(const AModelName: string): TValue;
begin
 if not FModels.ContainsKey(AModelName) then
 begin
    Result := FModels.Items[AModelname];
 end;
end;

function TControllerBase.Models(AModelsNames: TArray<String>; AObservers: TArray<String>): TControllerBase;
var FClass: TPersistentClass;
    FObject: TObject;
    RttiContext: TRttiContext;
    RttiInstanceType: TRttiInstanceType;
    RttiMethod: TRttiMethod;
    Instance: TValue;
    I,X: Integer;
  FObserversClass: TPersistentClass;
  RttiContextObserver: TRttiContext;
  FClassObserver: TPersistentClass;
  RttiInstanceTypeObserver: TRttiInstanceType;
begin
 Result := Self;
 for I := Low(AModelsNames) to High(AModelsNames) do
  if not FModels.ContainsKey(AModelsNames[I]) then
  begin
    FClass:= FindClass(AModelsNames[I]);
    RttiContext := TRttiContext.Create;
    RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
    Instance := RttiInstanceType;
    FModels.Add(AModelsNames[i],Instance);

    FObservers.Add(AModelsNames[i],AObservers[i]);
    FClassObserver:= FindClass(AObservers[i]);
    RttiContextObserver := TRttiContext.Create;
    RttiInstanceTypeObserver:= RttiContext.FindType(FClassObserver.UnitName+'.'+FClassObserver.ClassName).AsInstance;
    RttiMethod := RttiInstanceType.GetMethod('create');
    Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType,[nil,FClassObserver]);
   end;
end;

function TControllerBase.OBServers(
  const AObserverNames: TArray<String>): TControllerBase;
begin

end;
 {$REGION 'Area do Provedor de serviços'}
function TControllerBase.ProviderService(AProviderServiceName,
  AModels: TArray<String>): TValue;
   var FClass: TPersistentClass;
      FObject: TObject;
      RttiContext: TRttiContext;
      RttiInstanceType: TRttiInstanceType;
      RttiMethod: TRttiMethod;
      Instance: TValue;
      I,X: Integer;
begin


end;
 {$ENDREGION}
function TControllerBase.Render(): TValue;
begin
 Result := Self;
end;

end.

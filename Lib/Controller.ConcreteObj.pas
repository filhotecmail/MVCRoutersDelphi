unit Controller.ConcreteObj;

interface
  uses System.classes,Controller.IInterfaces,Rtti,Vcl.Forms,System.SysUtils,
  Model.ObjectConcrete, Model.IInterfaces,System.Generics.Collections,
  Observers.IInterfaces, View.Abstract, Services.Containner.ObjConcrete;

  type TArrayOfParams = Array of TValue;

type TControllerBase = Class Abstract(TInterfacedPersistent,IController)
  strict private
    FClass: TPersistentClass;
    FModels: TDictionary<String,TObject>;
    FObservers: TDictionary<String,TValue>;
    FContainnersServices: TDictionary<String,TValue>;
    function ExcuteMethod<T>( AInstance: TObject; AMethodName: String; AmethodParams: Array of TValue ):T;
  private
    FModelName: string;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Render():TValue; virtual;
    function Get(const AValues: Tarray<TValue>):TValue; virtual;
    /// <summary>
    ///   Construtor dos Modelos, o Sistema irá construir as instâncias de Modelos resgistrados para os controllers.
    ///  Irá armazenar em uma Lista os Modelos e sua Instância
    ///  AParamsConstructor: TArray<TArrayOfParams> é um Array de parametros para cada modelo Iterado.
    ///   [ 'Nome do Modelo', Modelo 2  ] , [ [ Parametos do Modelo 1  ],[ Parametos do Modelo 2  ]   ]
    /// </summary>
    function Models(AModelsNames: TArray<String>; AParamsConstructor: TArray<TArrayOfParams>):TControllerBase;
    /// <summary>
    ///   Recupera um Valor do Tipo Variant de um Método que será executado em um Modelo
    /// </summary>
    function GetValue<T>(AModelName: String; AModelMethod: String; AMethodParams: Array of TValue):T; overload;
    function Model( Const AModelName: string ):TValue; overload;
     /// <summary>
     ///  verificar Se existe a classe registrada ServiceProider Informada.
     ///   verificar se existe um Model que possa corresponder ao provedor de serviços
     ///   Se não existir Informar ao Usuário que não existe um model que possa interagir com o provedor de serviços.
     ///   Se existir Acionar o construtor New Da classe e armazenar a instância do construtor.
     ///   Adicionar No Dicionariod e dados como Chave o Nome do Modelo e a Instância do ServiceProvider, para que
     ///   possamos recuperar provedores de serviços registrados para o Modelo.
     ///
     /// </summary>
    function ContainnersServices(AProviderServiceName: TArray<String>; AModels: TArray<String>):TValue;
    function GetContainnersServices(AContainnerName: string):TValue;
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
   FModels:= TDictionary<String, TObject>.create;
   FObservers:= TDictionary<String,TValue>.create;
   FContainnersServices:= TDictionary<String,TValue>.create;
end;


procedure TControllerBase.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FModels );
  FreeAndNil( FObservers );
  FreeAndNil( FContainnersServices );
end;

function TControllerBase.Get(const AValues: Tarray<TValue>): TValue;
begin


end;

function TControllerBase.Model(const AModelName: string): TValue;
begin
 Result:= nil;
 if FModels.ContainsKey(AModelName) then
    Result := FModels.Items[AModelname]
    else raise Exception.Create('Não existe um model registrado na lista com esse nome '+AModelName);
end;

function TControllerBase.GetValue<T>(AModelName: String; AModelMethod: String; AMethodParams: Array of TValue): T;
begin
 Result:= ExcuteMethod<T>( Model(AModelName).AsObject ,AModelMethod,AMethodParams );
end;

function TControllerBase.Models(AModelsNames: TArray<String>; AParamsConstructor: TArray<TArrayOfParams>): TControllerBase;
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
    RttiMethod := RttiInstanceType.GetMethod('Create');
    FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,AParamsConstructor[I]).AsObject;
    FModels.Add(AModelsNames[i],FObject);
   end;
end;

function TControllerBase.OBServers(
  const AObserverNames: TArray<String>): TControllerBase;
begin

end;
 {$REGION 'Area do Provedor de serviços'}
function TControllerBase.ContainnersServices(AProviderServiceName,
  AModels: TArray<String>): TValue;
   var FClass: TPersistentClass;
      FObject: TObject;
      RttiContext: TRttiContext;
      RttiInstanceType: TRttiInstanceType;
      RttiMethod: TRttiMethod;
      Instance: TValue;
      I,X: Integer;
begin
 Result:= FContainnersServices;
end;
 function TControllerBase.ExcuteMethod<T>(AInstance: TObject; AMethodName: String;
  AmethodParams: array of TValue): T;
var  RttiContext: TRttiContext;
     RttiInstanceType: TRttiInstanceType;
     RttiMethod: TRttiMethod;
     InstanceOf: TValue;
     FValue: TValue;
begin
  RttiContext := TRttiContext.Create;
  RttiInstanceType := RttiContext.FindType(AInstance.UnitName+'.'+AInstance.ClassName).AsInstance;
  RttiMethod := RttiInstanceType.GetMethod(AMethodName);
  InstanceOf:= RttiInstanceType.MetaclassType;
 if RttiMethod <> nil then
   FValue:= RttiMethod.Invoke( AInstance , AmethodParams);
   Result:= FValue.AsType<T>;
end;

{$ENDREGION}
function TControllerBase.Render(): TValue;
begin
 Result := Self;
end;

function TControllerBase.GetContainnersServices(AContainnerName: string): TValue;
begin
 Result:= nil;
 if FContainnersServices.ContainsKey(AContainnerName) then
    Result := FContainnersServices.Items[AContainnerName]
    else
    raise Exception.Create('Não existe um ServicesContainner registrado na lista com o nome de '+AContainnerName);
end;

end.

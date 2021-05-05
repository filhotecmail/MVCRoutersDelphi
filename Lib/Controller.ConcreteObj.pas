unit Controller.ConcreteObj;

interface

uses System.Classes, Controller.IInterfaces, Rtti, Vcl.Forms, System.SysUtils,
  Model.ObjectConcrete, Model.IInterfaces, System.Generics.Collections,
  Observers.IInterfaces, View.Abstract, Services.Containner.ObjConcrete,
  Commom.RTTI.Utils;

type
  TControllerBase = class Abstract(TInterfacedPersistent, IController)
  strict private
    FClass: TPersistentClass;
    FModels: TDictionary<string, TObject>;
    FObservers: TDictionary<string, TValue>;
    FContainnersServices: TDictionary<string, TObject>;

    // A Chave do Tipo string representa o Nome do containner Service
    // O Valor é a Instância do Model
    FContainnerServicesModel: TDictionary<string, TObject>;
    function ExcuteMethod<T>(AInstance: TObject; AMethodName: string; AmethodParams: array of TValue): T;
    function Model(const AModelName: string): TValue; overload;
    function Containner(const AContainnerName: string): TValue;
  private
    FModelName: string;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Render(): TValue; virtual;
    function Get(const AValues: Tarray<TValue>): TValue; virtual;
    /// <summary>
    ///   Construtor dos Modelos, o Sistema irá construir as instâncias de Modelos resgistrados para os controllers.
    ///  Irá armazenar em uma Lista os Modelos e sua Instância
    ///  AParamsConstructor: TArray<TArrayOfParams> é um Array de parametros para cada modelo Iterado.
    ///   [ 'Nome do Modelo', Modelo 2  ] , [ [ Parametos do Modelo 1  ],[ Parametos do Modelo 2  ]   ]
    /// </summary>
    function Models(AModelsNames: TArray<string>; AParamsConstructor: TArray<TArrayOfParams>): TControllerBase;
    /// <summary>
    ///   Recupera um Valor do Tipo Variant de um Método que será executado em um Modelo
    /// </summary>
    function GetValue<T>(AModelName: string; AModelMethod: string; AMethodParams: array of TValue): T; overload;
    /// <summary>
    ///  verificar Se existe a classe registrada ServiceProider Informada.
    ///   verificar se existe um Model que possa corresponder ao provedor de serviços
    ///   Se não existir Informar ao Usuário que não existe um model que possa interagir com o provedor de serviços.
    ///   Se existir Acionar o construtor New Da classe e armazenar a instância do construtor.
    ///   Adicionar No Dicionariod e dados como Chave o Nome do Modelo e a Instância do ServiceProvider, para que
    ///   possamos recuperar provedores de serviços registrados para o Modelo.
    ///
    /// </summary>
    function ContainnersServices(AContainnerServiceName, AModels: TArray<string>;
      AParamsConstructorContainner: TArray<TArrayOfParams>): TValue;

    function ExcuteContainnerMethod<T>(AContainnerName: string; const AMethodName: string;
      AMethodparams: TArrayOfParams): T;
    function OBServers(const AObserverNames: TArray<string>): TControllerBase; virtual;
  end;

function View(const AViewName: string; AOwner: TComponent; AControllerName: string): TObject;

implementation

{ TControllerBase }

function View(const AViewName: string; AOwner: TComponent; AControllerName: string): TObject;
var
  FrmClass: TFormClass;
  Frm: TForm;
begin
  Assert(GetClass(AViewName) <> nil, 'View não registrada');
  FrmClass := TFormClass(FindClass(AViewName));
  Frm := FrmClass.Create(Application);
  result := TForm.Create(AOwner);
  try
    Frm.ShowModal;
  finally
    FreeAndNil(Frm);
  end;
end;

procedure TControllerBase.AfterConstruction;
begin
  inherited;
  FModels := TDictionary<string, TObject>.Create;
  FObservers := TDictionary<string, TValue>.Create;
  FContainnersServices := TDictionary<string, TObject>.Create;
  FContainnerServicesModel := TDictionary<string, TObject>.Create;
end;

procedure TControllerBase.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FModels);
  FreeAndNil(FObservers);
  FreeAndNil(FContainnersServices);
  FreeAndNil(FContainnerServicesModel);
end;

function TControllerBase.Get(const AValues: Tarray<TValue>): TValue;
begin

end;

function TControllerBase.Model(const AModelName: string): TValue;
begin
  result := nil;
  if FModels.ContainsKey(AModelName) then
    result := FModels.Items[AModelname]
  else
    raise Exception.Create('Não existe um model registrado na lista com esse nome ' + AModelName);
end;

function TControllerBase.GetValue<T>(AModelName: string; AModelMethod: string; AMethodParams: array of TValue): T;
begin
  result := ExcuteMethod<T>(Model(AModelName).AsObject, AModelMethod, AMethodParams);
end;

function TControllerBase.Models(AModelsNames: TArray<string>;
  AParamsConstructor: TArray<TArrayOfParams>): TControllerBase;
begin
  result := Self;
  TLib.CreateFromRTTI(AModelsNames, AParamsConstructor, FModels);
end;

function TControllerBase.OBServers(const AObserverNames: TArray<string>): TControllerBase;
begin

end; 

 {$REGION 'Area do Provedor de serviços'}
function TControllerBase.Containner(const AContainnerName: string): TValue;
begin
  result := nil;
  if FContainnersServices.ContainsKey(AContainnerName) then
    result := FContainnersServices.Items[AContainnerName]
  else
    raise Exception.Create('Não existe um Containner Service registrado na lista com esse nome ' + AContainnerName);
end;

function TControllerBase.ContainnersServices(AContainnerServiceName, AModels: TArray<string>;
  AParamsConstructorContainner: TArray<TArrayOfParams>): TValue;
var
  I: integer;
  FItem: string;
  FParams: TArray<TArrayOfParams>;
begin
  result := Self;
 {Verificar na Lista de Models se existe um Modelo registrado com os nomes passados no Array
  Verificar Se existem ContainnersServices registrados informados no Array de ContainnersService
  Se existir ..
  criar as Instâncias dos ContainnersServices registrando em uma Lista o nome do ContainnerService e o
  Objeto da instância.
  Armazenar em um Dicionario de dados o Pair entre o Modelo e o ServiceContainner do Modelo.
   por exemplo.: Para 1 Modelo podem existir varios ContainnerServices.
   Em algum momento eu preciso recuperar para qual Modelo o Containner Service está registrado e atuando
   Servicos.
  }
  for I := Low(AContainnerServiceName) to High(AContainnerServiceName) do
  begin
    FItem := AContainnerServiceName[i];
    FParams := AParamsConstructorContainner;
    Assert(FModels.ContainsKey(AModels[i]), 'Não existe um Model de nome .: ' + AModels[i] + ' para Containner registrado');
    Assert(GetClass(FItem) <> nil, 'Não existe um Containner registrado com o Alias ' + FItem);
    if not FContainnersServices.ContainsKey(FItem) then
      TLib.CreateFromRTTI(FItem, FParams[i],
        procedure (Aobject: TObject; RttiField: TFieldLibRtti; RttiInstanceType: TInstanceLibRtti)
        begin
          RttiField := RttiInstanceType.GetField('FModel');
          RttiField.SetValue(Aobject, FModels.Items[AModels[i]]);
          FContainnersServices.Add(FItem, Aobject);
          FContainnerServicesModel.AddOrSetValue(FItem, FModels.Items[AModels[i]]);
        end)// Vai injetar no Field da Classe base Chamado Model a instância Criada;
    ;
  end;
end;

function TControllerBase.ExcuteMethod<T>(AInstance: TObject; AMethodName: string; AmethodParams: array of TValue): T;
begin
  result := TLib.ExecuteMethod<T>(AInstance, AMethodName, AmethodParams);
end;

{$ENDREGION 'Area do Provedor de serviços'}

function TControllerBase.Render(): TValue;
begin
  result := Self;
end;

function TControllerBase.ExcuteContainnerMethod<T>(AContainnerName: string; const AMethodName: string;
  AMethodparams: TArrayOfParams): T;
begin
  if FContainnersServices.ContainsKey(AContainnerName) then
    result := ExcuteMethod<T>(Containner(AContainnerName).AsObject, AMethodName, AMethodParams)
  else
    raise Exception.Create('Não existe um ServicesContainner registrado na lista com o nome de ' + AContainnerName);
end;

end.

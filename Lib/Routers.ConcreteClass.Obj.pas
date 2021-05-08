unit Routers.ConcreteClass.Obj;

interface
 uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,Rtti,
  System.Generics.Collections,System.Generics.Defaults, Json,Vcl.Forms,
  Routers.Middleware.Abstract,Vcl.Dialogs;

  type TControllerName=  String;
  type TInstanceName = String;
  Type TMidlewares = TArray<String>;
  Type TmethodParams = Array of TValue;
  Type TRouterType = (AController,AModel,AView,AMethod);

  type TMethodsClass = class
  private
    FMethodName: String;
    FMethodParams: TmethodParams;
    FAClassName: String;
    FMiddlewareNames: TMidlewares;
    FMethodAlias: String;
    FRouterType: TRouterType;
    FIsConstrutor: Boolean;
    procedure SetAClassName(const Value: String);
    procedure SetMethodName(const Value: String);
    procedure SetMethodParams(const Value: TmethodParams);
    procedure SetMiddlewareNames(const Value: TMidlewares);
    procedure SetMethodAlias(const Value: String);
    procedure SetRouterType(const Value: TRouterType);
    procedure SetIsConstrutor(const Value: Boolean);
  published
      property AClassName: String read FAClassName write SetAClassName;
      property MethodName: String read FMethodName write SetMethodName;
      property IsConstrutor: Boolean read FIsConstrutor write SetIsConstrutor;
      property MethodAlias: String read FMethodAlias write SetMethodAlias;
      property RouterType: TRouterType read FRouterType write SetRouterType;
      property MethodParams: TmethodParams read FMethodParams write SetMethodParams;
      property MiddlewareNames: TMidlewares read FMiddlewareNames write SetMiddlewareNames;
      procedure AddParam( const Value: TValue; Position: integer );
      function ExecuteMethod:TValue;
  end;

  type TGroupobjects = class
  private
    FAMiddlewares: TArray<String>;
    FAgroupName: String;
    FMethods: TDictionary<String, TMethodsClass>;
    FAMethodsExceptThisMiddleware: TDictionary<String, TMethodsClass>;
    procedure SetAgroupName(const Value: String);
    procedure SetAMiddlewares(const Value: TArray<String>);
    procedure SetMethods(const Value: TDictionary<String, TMethodsClass>);
    procedure SetAMethodsExceptThisMiddleware(
      const Value: TDictionary<String, TMethodsClass>);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  published
    property AgroupName: String read FAgroupName write SetAgroupName;
    property AMiddlewares: TArray<String> read FAMiddlewares write SetAMiddlewares;
    property AMethodsExceptThisMiddleware: TDictionary<String,TMethodsClass> read FAMethodsExceptThisMiddleware write SetAMethodsExceptThisMiddleware;
    property Methods: TDictionary<String,TMethodsClass> read FMethods write SetMethods;
  end;

  Type TGroupRoute = class
     private
      FListGroups: TDictionary<String,TGroupobjects>;
     public
      function AddInList( AGroupName: String; AMiddlewares: TArray<String>;  ARouters: TArray<TMethodsClass>; AexceptThis: TArray<TMethodsClass>  ):TGroupRoute; overload;
      function GetInList(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue):TGroupobjects;
      function Execute(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue):TValue;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  Type TControllersRoute = class
  Type TConstructorParams = Array of TValue;
  strict private
    FviewName: string;
   private
    FControllersForView: TDictionary<TControllerName,TPersistentClass>;
    FControllerName: STring;
    FControllerObj: TPersistentClass;
  private
    FListaGrupos: TDictionary<String,TGroupRoute>;
    function Execute(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
           ConstrutorName: String; AParamsConstructor: Array of TValue): TValue; overload;

  public
    function Route(const AClassName: String; Method: String; AParams: Array of TValue; AMidleWareNames: TMidlewares = nil; const AMethodAlias: String = ''): TValue; overload;
    function Route(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
     ConstrutorName: String; AConstructorParam: TConstructorParams; AMidleWareNames: TMidlewares = nil; const AMethodAlias: String = ''): TValue; Overload;
    function RegisterRouters( ASourceController: TPersistentClass; AControllerAlias: String ):TControllersRoute; overload;

    function Router(AControllerAlias: String;
             Method: String; AParams: Array of TValue;
             AMidleWareNames: TMidlewares = nil;
             const AMethodAlias: String = ''; ARouteType: TRouterType = AController ):TValue; overload;
    /// <summary>
    ///  Recupera a Lista de Grupos
    /// </summary>
    function Getgroups(Const AGroupName: String ):TGroupRoute;
    /// <summary>
    ///  Registra na lista o Grupo de rotas
    ///  O Sistema irá checar , ao invokar o grupo e se o grupo tiver Algum Middlware Declarado
    /// </summary>
    function RegisterGroup( AGroupName: String; AMiddlewares: TArray<String>;  ARouters: TArray<TMethodsClass> ):TControllersRoute; overload;
    function RegisterGroup( AGroupName: String; AMiddlewares: TArray<String>;  ARouters: TArray<TMethodsClass>; AExceptThis: TArray<TMethodsClass>):TControllersRoute; overload;
    function FreeRoute(const AClassName: String):TControllersRoute;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  procedure CheckMidlewares(const AMidlewares: TMidlewares; AMidlwareCallBack: TProc<TMiddlwareRoute>);

 var RoutersController:TControllersRoute;
 implementation

  var FRoutersInstance:  TDictionary<String,TValue>;

procedure TControllersRoute.AfterConstruction;
begin
  inherited;
 FListaGrupos:=  TDictionary<String,TGroupRoute>.create;
 FControllersForView := TDictionary<TControllerName,TPersistentClass>.Create;
 {// Cria a lista de Instâncias Criadas}
 if Not Assigned(FRoutersInstance) then
 FRoutersInstance    := TDictionary<TInstanceName,TValue>.Create;
end;

procedure TControllersRoute.BeforeDestruction;
var LKey: String;
    FObject: TObject;
begin
  inherited;
  FreeAndNil( FControllersForView );

  for LKey in FRoutersInstance.Keys do
  begin
   FObject:= FRoutersInstance.items[LKey].AsObject;
   FreeAndNil(FObject);
  end;

 for LKey in FListaGrupos.Keys do
 begin
  FObject:= FListaGrupos.Items[LKey];
  FreeAndNil(FObject);
 end;

  if Assigned(FRoutersInstance) then
  FreeAndNil( FRoutersInstance );

  FreeAndNil( FListaGrupos );
end;

procedure CheckMidlewares(const AMidlewares: TMidlewares; AMidlwareCallBack: TProc<TMiddlwareRoute>);
 var FMidleware: TObject;
      I: integer;
begin
  if ( AMidlewares <> nil ) and ( length(AMidlewares)> 0 ) then
  begin
    for I := Low(AMidlewares) to High(AMidlewares) do
    begin
      FMidleware:= TObject(GetClass(AMidlewares[I]).Create);
     try
      Assert( TMiddlwareRoute(FMidleware).IsValidate,TMiddlwareRoute(FMidleware).Msg);
      if Assigned(AMidlwareCallBack) then
         AMidlwareCallBack(TMiddlwareRoute(FMidleware));
     finally
      FreeAndNil(FMidleware);
     end;
    end;
  end else
   if Assigned(AMidlwareCallBack) then
      AMidlwareCallBack(TMiddlwareRoute(nil));

end;

function TControllersRoute.RegisterGroup(AGroupName: String;
  AMiddlewares: TArray<String>; ARouters,
  AExceptThis: TArray<TMethodsClass>): TControllersRoute;
begin
  Result:= self;
  Assert( not FListaGrupos.ContainsKey('AGroupName'),'Já existe um grupo registrado com esse nome!' );
  FListaGrupos.Add( AgroupName, TGroupRoute.Create.AddInList(AGroupName,AMiddlewares,ARouters,AExceptThis));
end;

function TControllersRoute.RegisterRouters(ASourceController: TPersistentClass;
  AControllerAlias: String): TControllersRoute;
begin
 RegisterClassAlias(ASourceController,AControllerAlias);
end;

function TControllersRoute.Route(const AClassName: String; Method: String;
  AParams: array of TValue; AMidleWareNames: TMidlewares; const AMethodAlias: String): TValue;
begin
  Result := route(AClassName,Method,AParams,False,'',[],AMidleWareNames);
end;

function TControllersRoute.RegisterGroup(AGroupName: String;
  AMiddlewares: TArray<String>; ARouters: TArray<TMethodsClass>): TControllersRoute;
begin
  Result:= self;
  Assert( not FListaGrupos.ContainsKey('AGroupName'),'Já existe um grupo registrado com esse nome!' );
  FListaGrupos.Add( AgroupName, TGroupRoute.Create.AddInList(AGroupName,AMiddlewares,ARouters,[]));
end;

function TControllersRoute.Router(
  AControllerAlias, Method: String; AParams: array of TValue;
  AMidleWareNames: TMidlewares; const AMethodAlias: String;ARouteType: TRouterType): TValue;

 var FValue: TValue;
      FAClassName: String;
      FMethod: String;
      FAParams: array of TValue;
      FAConstrutor: Boolean;
      FConstrutorName: String;
      FAConstructorParam: TConstructorParams;
      FAMidleWareNames: TMidlewares;
      I: Integer;
begin
  FAClassName:= AControllerAlias;
  FMethod    := Method;
  for I := Low(AParams) to High(AParams) do
   System.Insert(AParams[i],FAParams,I);

//  FAConstrutor := AConstrutor;
//  FConstrutorName:= ConstrutorName;
//  FAConstructorParam:= AConstructorParam;
  CheckMidlewares(AMidleWareNames,
  procedure
  ( AMiddleCallBack: TMiddlwareRoute )
  begin
   FValue:= Execute(FAClassName,FMethod,FAParams,False,'',[]);
   if Assigned(AMiddleCallBack.ACallBackValue) then
   AMiddleCallBack.ACallBackValue(FValue);
  end);
// if GetClass(AClassName) <> nil then
//  Result := FValue
//  else
//  raise Exception.Create('Nenhuma rota encontrada com o nome de '+AClassName);
end;

function TControllersRoute.Route(const AClassName: String; Method: String;
  AParams: array of TValue; AConstrutor: Boolean; ConstrutorName: String;
  AConstructorParam: TConstructorParams; AMidleWareNames: TMidlewares; const AMethodAlias: String): TValue;
  var FValue: TValue;
      FAClassName: String;
      FMethod: String;
      FAParams: array of TValue;
      FAConstrutor: Boolean;
      FConstrutorName: String;
      FAConstructorParam: TConstructorParams;
      FAMidleWareNames: TMidlewares;
      I: Integer;
begin
  FAClassName:= AClassName;
  FMethod    := Method;
  for I := Low(AParams) to High(AParams) do
   System.Insert(AParams[i],FAParams,I);

  FAConstrutor := AConstrutor;
  FConstrutorName:= ConstrutorName;
  FAConstructorParam:= AConstructorParam;
  // Passa pela verificação dos Middlewares
  CheckMidlewares(AMidleWareNames,
  procedure
  ( AMiddleCallBack: TMiddlwareRoute )
  begin
   FValue:= Execute(FAClassName,FMethod,FAParams,FAConstrutor,FConstrutorName,FAConstructorParam);
   if AMiddleCallBack <> nil then
   if Assigned(AMiddleCallBack.ACallBackValue) then
      AMiddleCallBack.ACallBackValue(FValue);
  end);
end;

function TControllersRoute.Execute(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
  ConstrutorName: String; AParamsConstructor: Array of TValue): TValue;
 var FClass: TPersistentClass;
     FObject: TObject;
     RttiContext: TRttiContext;
     RttiInstanceType: TRttiInstanceType;
     RttiMethod: TRttiMethod;
begin
  FClass:= FindClass(AClassName);
  RttiContext := TRttiContext.Create;
  RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
  RttiMethod := RttiInstanceType.GetMethod(Method);
  if AConstrutor then
 begin
  if not FRoutersInstance.ContainsKey(AClassName) then
         FRoutersInstance.AddOrSetValue(AClassName,RttiMethod.Invoke(RttiInstanceType.MetaclassType,[]));
   result:= FRoutersInstance.Items[AClassName].AsObject;
 end else
 begin
  result:= RttiInstanceType.MetaclassType;
  Result:= RttiMethod.Invoke( FRoutersInstance.Items[AClassName] , AParams);
 end;
end;

function TControllersRoute.FreeRoute(const AClassName: String): TControllersRoute;
 var Obj: TObject;
begin
 Obj:= (FRoutersInstance.Items[AClassName].AsType<TObject>);
 FreeAndNil( Obj );
 FRoutersInstance.Remove(AClassName);
end;

 function TControllersRoute.Getgroups(const AGroupName: String): TGroupRoute;
begin
  Assert( FListaGrupos.ContainsKey(AGroupName),'Não existe um grupo com esse prefixo!' );
  Result:= FListaGrupos.Items[AGroupName];
end;

{ TGroupRoute }

function TGroupRoute.AddinList(AGroupName: String; AMiddlewares: TArray<String>;
  ARouters: TArray<TMethodsClass>; AexceptThis: TArray<TMethodsClass> ): TGroupRoute;
  var AGroupObject: TGroupobjects;
  I: Integer;
begin
 Result:= Self;
 AGroupObject:= TGroupobjects.Create;
 AGroupObject.AgroupName := AGroupName;
 AGroupObject.AMiddlewares:= AMiddlewares;

 for I := Low(ARouters) to High(ARouters) do
 begin
  AGroupObject.Methods.Add( ARouters[I].MethodName,ARouters[I] );
  AGroupObject.Methods.Add( ARouters[I].MethodAlias,ARouters[I] );
 end;

 for I := Low(AexceptThis) to High(AexceptThis) do
 begin
  AGroupObject.AMethodsExceptThisMiddleware.Add( AexceptThis[I].MethodAlias,AexceptThis[I] );
  AGroupObject.AMethodsExceptThisMiddleware.Add( AexceptThis[I].MethodName,AexceptThis[I] );
 end;
 FListGroups.Add(AGroupName,AGroupObject);
end;

procedure TGroupRoute.AfterConstruction;
begin
  inherited;
 FListGroups:= TDictionary<String,TGroupobjects>.create;
end;

procedure TGroupRoute.BeforeDestruction;
 var FKeys: String;
     Fobject: TObject;
begin
  inherited;
  for FKeys in FListGroups.Keys do
  begin
    Fobject:= FListGroups.Items[FKeys];
    FreeAndNil( Fobject );
  end;
  FreeAndNil( FListGroups );
end;

function TGroupRoute.Execute(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue): TValue;
 var I: Integer;
     FValue: TValue;
begin
 Result:= FValue;
 Assert( FListGroups.ContainsKey(AGroupName),'Não existe um Grupo com esse objeto' );
 Assert(FListGroups.Items[AGroupName].Methods.ContainsKey(AMethodName) or
        FListGroups.Items[AGroupName].FAMethodsExceptThisMiddleware.ContainsKey(AMethodName), 'Não existe um Método no grupo');
 // Vai verifiacar na Lista de grupos de Rotas, no array de middlewares , se existe
 // algum middleware informado, se existir , todos os métodos disparados para aquele grupo de rotas
 // só serão executados caso passe pelo middleware;
  if FListGroups.Items[AGroupName].AMethodsExceptThisMiddleware.ContainsKey(AMethodName) then
     FValue:= FListGroups.Items[AGroupName].AMethodsExceptThisMiddleware.Items[AMethodName].ExecuteMethod
     else
  begin
   CheckMidlewares(FListGroups.Items[AGroupName].AMiddlewares,
    procedure
   ( AMiddleCallBack: TMiddlwareRoute )
   begin
    FValue:= FListGroups.Items[AGroupName].Methods.Items[AMethodName].ExecuteMethod;
    if AMiddleCallBack <> nil then
    if Assigned(AMiddleCallBack.ACallBackValue) then
      AMiddleCallBack.ACallBackValue(FValue);
   end);
  end;

end;

function TGroupRoute.GetinList(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue): TGroupobjects;
begin
 Assert( FListGroups.ContainsKey(AGroupName),'Não existe um Grupo com esse objeto' );
 Result:= FListGroups.Items[AGroupName];
 Assert(Result.Methods.ContainsKey(AMethodName), 'Não existe um Grupo com esse objeto');
 Result.Methods.Items[AMethodName].ExecuteMethod;
end;

{ TGroupobjects }

procedure TGroupobjects.AfterConstruction;
begin
  inherited;
  FMethods:= TDictionary<String, TMethodsClass>.create;
  FAMethodsExceptThisMiddleware:= TDictionary<String, TMethodsClass>.create;
end;

procedure TGroupobjects.BeforeDestruction;
 var FKeys: String;
     FObjects: TObject;
begin
 inherited;
 FreeAndNil( FMethods );
 FreeAndNil( FAMethodsExceptThisMiddleware );
end;

procedure TGroupobjects.SetAgroupName(const Value: String);
begin
  FAgroupName := Value;
end;

procedure TGroupobjects.SetAMethodsExceptThisMiddleware(
  const Value: TDictionary<String, TMethodsClass>);
begin
  FAMethodsExceptThisMiddleware := Value;
end;

procedure TGroupobjects.SetAMiddlewares(const Value: TArray<String>);
begin
  FAMiddlewares := Value;
end;

procedure TGroupobjects.SetMethods(const Value: TDictionary<String, TMethodsClass>);
begin
  FMethods := Value;
end;

{ TRoutermethods }

//function TRoutermethods.Router(AControllerAlias, Method: String;
//  AParams: array of TValue; AMidleWareNames: TMidlewares;
//  const AMethodAlias: String; ARouteType: TRouterType): TValue;
//begin
//
//end;

{ TMethodsClass }

procedure TMethodsClass.AddParam(const Value: TValue; Position: integer);
begin
 Insert(Value,FMethodParams,Position);
end;

function TMethodsClass.ExecuteMethod: TValue;
begin
 Result:= RoutersController.Route(FAClassName,FMethodName,FMethodParams,IsConstrutor,'',[],FMiddlewareNames,MethodAlias );
end;

procedure TMethodsClass.SetAClassName(const Value: String);
begin
  FAClassName := Value;
end;

procedure TMethodsClass.SetIsConstrutor(const Value: Boolean);
begin
  FIsConstrutor := Value;
end;

procedure TMethodsClass.SetMethodAlias(const Value: String);
begin
  FMethodAlias := Value;
end;

procedure TMethodsClass.SetMethodName(const Value: String);
begin
  FMethodName := Value;
end;

procedure TMethodsClass.SetMethodParams(const Value: TmethodParams);
begin
  FMethodParams := Value;
end;

procedure TMethodsClass.SetMiddlewareNames(const Value: TMidlewares);
begin
  FMiddlewareNames := Value;
end;

procedure TMethodsClass.SetRouterType(const Value: TRouterType);
begin
  FRouterType := Value;
end;

initialization
 //
 Finalization
 FreeAndNil( RoutersController );

end.

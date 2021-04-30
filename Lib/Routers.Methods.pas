unit Routers.Methods;

interface

uses Rtti, Routers.ConcreteClass.Obj;

 function Construtor( Const ABuildMethodType: TMethodsClass ): TMethodsClass;

 function Route(AControllerAlias: String; Method: String; AParams: Array of TValue;
  AMidleWareNames: TMidlewares = nil; const AMethodAlias: String = '';
  ARouteType: TRouterType = AController): TMethodsClass;

 function Controller(AControllerAlias: String;
 Method: String; const AParams: Array of TValue; AMidleWareNames: TMidlewares = nil;
 const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TMethodsClass;

// function get(AControllerAlias: String;
//             Method: String; AParams: Array of TValue;
//             AMidleWareNames: TMidlewares = nil;
//             const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TValue;
//
// function Post(AControllerAlias: String;
//             Method: String; AParams: Array of TValue;
//             AMidleWareNames: TMidlewares = nil;
//             const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TValue;
//
// function Put(AControllerAlias: String;
//             Method: String; AParams: Array of TValue;
//             AMidleWareNames: TMidlewares = nil;
//             const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TValue;
//
// function Service(AControllerAlias: String;
//             Method: String; AParams: Array of TValue;
//             AMidleWareNames: TMidlewares = nil;
//             const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TValue;
//
// function Domain(AControllerAlias: String;
//             Method: String; AParams: Array of TValue;
//             AMidleWareNames: TMidlewares = nil;
//             const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TValue;
//
// function Model(AControllerAlias: String;
//             Method: String; AParams: Array of TValue;
//             AMidleWareNames: TMidlewares = nil;
//             const AMethodAlias: String = ''; ARouteType: TRouterType = AController): TValue;

 // Registra os grupos de rotas
 function RegisterGroup(AGroupName: String;AMiddlewares: TArray<String>;
 ARouters: TArray<TMethodsClass>):TControllersRoute; overload;

 function RegisterGroup(AGroupName: String;AMiddlewares: TArray<String>;
 ARouters: TArray<TMethodsClass>; ExceptThis: TArray<TMethodsClass> ):TControllersRoute; overload;
 // invoka um Método que pertence a um grupo de rotas
 function Group(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue):TValue;

implementation
{ TControllersRoute }

function RegisterGroup(AGroupName: String;AMiddlewares: TArray<String>;
 ARouters: TArray<TMethodsClass>; ExceptThis: TArray<TMethodsClass> ):TControllersRoute;
 begin
  Result:= RoutersController.RegisterGroup(AGroupName,AMiddlewares,ARouters,ExceptThis);
 end;

function Construtor( Const ABuildMethodType: TMethodsClass ): TMethodsClass;
begin
 ABuildMethodType.isConstrutor:= true;
 Result:= ABuildMethodType;
end;

function Route(AControllerAlias: String; Method: String; AParams: Array of TValue;
 AMidleWareNames: TMidlewares = nil;const AMethodAlias: String = '';
 ARouteType: TRouterType = AController): TMethodsClass;
begin

end;

function Group(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue):TValue;
begin
 Result:= RoutersController.Getgroups(AGroupName).Execute(AGroupName,AMethodName,AMethodParams);
end;

function Controller(AControllerAlias: String;Method: String; const AParams: Array of TValue;
  AMidleWareNames: TMidlewares = nil; const AMethodAlias: String = '';
  ARouteType: TRouterType = AController): TMethodsClass;
 var FMethodClass:TMethodsClass;
     I: Integer;
begin
 // Cria o Objeto de Metodos registrados para gravar no grupo
 FMethodClass:= TMethodsClass.Create;
 FMethodClass.AClassName := AControllerAlias;
 FMethodClass.MethodName := Method;
 FMethodClass.MethodAlias:= AMethodAlias;
 FMethodClass.RouterType := ARouteType;
 for I := Low(AParams) to High(AParams) do
  FMethodClass.AddParam(AParams[i],I);
 Result:=  FMethodClass;
end;

function RegisterGroup(AGroupName: String;
  AMiddlewares: TArray<String>; ARouters: TArray<TMethodsClass>):TControllersRoute;
begin
 Result:= RoutersController.RegisterGroup(AGroupName,AMiddlewares,ARouters);
end;
 Initialization
  RoutersController := TControllersRoute.Create;
 Finalization

end.

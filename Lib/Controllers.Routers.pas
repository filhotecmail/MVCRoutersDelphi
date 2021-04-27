unit Controllers.Routers;

interface
 uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,Rtti,
  System.Generics.Collections,System.Generics.Defaults, Json,Vcl.Forms,
  Routers.Midleware.Abstract;

  type TControllerName=  String;
  type TInstanceName = String;
  Type TRouterType = (Controller,Model,View);

  Type TControllersRoute = class
   Type TConstructorParams = Array of TValue;
   Type TMidlewares = TArray<String>;
  strict private
    FviewName: string;
   private
    FControllersForView: TDictionary<TControllerName,TPersistentClass>;
    FControllerName: STring;
    FControllerObj: TPersistentClass;
    procedure CheckMidlewares(const AMidlewares: TMidlewares);
  private
    function Execute(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
           ConstrutorName: String; AParamsConstructor: Array of TValue; ARouterType:TRouterType): TValue; overload;
  public
    function Route(const AClassName: String; Method: String; AParams: Array of TValue; AMidleWareNames: TMidlewares = nil): TValue; overload;
    function Route(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
     ConstrutorName: String; AConstructorParam: TConstructorParams;
     ARouterType:TRouterType; AMidleWareNames: TMidlewares = nil): TValue; Overload;
    function RegisterRouters( ASourceController: TPersistentClass; AControllerAlias: String ):TControllersRoute; overload;
    function FreeRoute(const AClassName: String):TControllersRoute;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  var RoutersController:TControllersRoute;

implementation
{ TControllersRoute }

  var FRoutersInstance:  TDictionary<String,TValue>;

procedure TControllersRoute.AfterConstruction;
begin
  inherited;
 FControllersForView := TDictionary<TControllerName,TPersistentClass>.Create;
 {// Cria a lista de Instâncias Criadas}
 if Not Assigned(FRoutersInstance) then
 FRoutersInstance    := TDictionary<TInstanceName,TValue>.Create;
end;

procedure TControllersRoute.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FControllersForView );
  if Assigned(FRoutersInstance) then
  FreeAndNil( FRoutersInstance );
end;

procedure TControllersRoute.CheckMidlewares(const AMidlewares: TMidlewares);
 var FMidleware: TObject;
      I: integer;
begin
  if ( AMidlewares <> nil ) and ( length(AMidlewares)> 0 ) then
  begin
    for I := Low(AMidlewares) to High(AMidlewares) do
    begin
      FMidleware:= TObject(GetClass(AMidlewares[I]).Create);
     try
      Assert( TMidlwareRoute(FMidleware).IsValidate,
              TMidlwareRoute(FMidleware).Msg);
     finally
      FreeAndNil(FMidleware);
     end;
    end;
  end;
end;

function TControllersRoute.RegisterRouters(ASourceController: TPersistentClass;
  AControllerAlias: String): TControllersRoute;
begin
 RegisterClassAlias(ASourceController,AControllerAlias);
end;

function TControllersRoute.Route(const AClassName: String; Method: String;
  AParams: array of TValue; AMidleWareNames: TMidlewares): TValue;
begin
  Result := route(AClassName,Method,AParams,False,'',[],Controller,AMidleWareNames);
end;

function TControllersRoute.Route(const AClassName: String; Method: String;
  AParams: array of TValue; AConstrutor: Boolean; ConstrutorName: String;
  AConstructorParam: TConstructorParams; ARouterType: TRouterType;
  AMidleWareNames: TMidlewares): TValue;
begin
  CheckMidlewares(AMidleWareNames);
 if GetClass(AClassName) <> nil then
  Result := Execute(AClassName,Method,AParams,AConstrutor,ConstrutorName,AConstructorParam,ARouterType)
  else
  raise Exception.Create('Nenhuma rota encontrada com o nome de '+AClassName);
end;

function TControllersRoute.Execute(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
  ConstrutorName: String; AParamsConstructor: Array of TValue; ARouterType:TRouterType): TValue;
 var FClass: TPersistentClass;
     RttiContext: TRttiContext;
     RttiInstanceType: TRttiInstanceType;
     RttiMethod: TRttiMethod;
     Instance: TValue;
begin
  Result:= Self;
 case ARouterType of
  Controller: begin
                FClass:= GetClass(AClassName);
                RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
                if AConstrutor then
                begin
                 RttiMethod := RttiInstanceType.GetMethod(ConstrutorName);
                 Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType,AParamsConstructor);
                 FRoutersInstance.Add(AClassName,Instance);
                 RttiMethod := RttiInstanceType.GetMethod(Method);
                 RttiMethod.Invoke(FRoutersInstance.Items[AClassName], AParams);
                end else
                begin
                 RttiMethod := RttiInstanceType.GetMethod(Method);
                 RttiMethod.Invoke(FRoutersInstance.Items[AClassName], AParams);
                end;
              end;
  Model: ;

  View: ;
 end;
end;

function TControllersRoute.FreeRoute(const AClassName: String): TControllersRoute;
 var Obj: TObject;
begin
 Obj:= (FRoutersInstance.Items[AClassName].AsType<TObject>);
 FreeAndNil( Obj );
 FRoutersInstance.Remove(AClassName);
end;

 initialization
 //
 Finalization
 FreeAndNil( RoutersController );

end.

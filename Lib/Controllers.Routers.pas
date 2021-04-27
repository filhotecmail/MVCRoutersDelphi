unit Controllers.Routers;

interface
 uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,Rtti,
  System.Generics.Collections,System.Generics.Defaults, Json,Vcl.Forms;

  type TControllerName=  String;
  type TInstanceName = String;
  Type TRouterType = (Controller,Model,View);

  Type TControllersRoute = class
   Type TConstructorParams = Array of TValue;
  strict private
    FviewName: string;
   private
    FControllersForView: TDictionary<TControllerName,TPersistentClass>;
    FControllerName: STring;
    FControllerObj: TPersistentClass;
  private

     function Execute(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean;
           ConstrutorName: String; AParamsConstructor: Array of TValue; ARouterType:TRouterType): TValue; overload;
  public
    //function Route(const AClassName: String; Method: String; AParams: Array of TValue; AMidleWareName: String = '' ):TValue; Overload;
    function Route(const AClassName: String; Method: String; AParams: Array of TValue; AConstrutor: Boolean = False;
     ConstrutorName: String= ''; AConstructorParam: TConstructorParams = nil;
     ARouterType:TRouterType= Controller; AMidleWareName: String = ''): TValue; Overload;
    function RegisterRouters( ASourceController: TPersistentClass; AControllerAlias: String ):TControllersRoute; overload;
    function FreeRoute(const AClassName: String):TControllersRoute;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  type TMidlwareRoute = Class Abstract(TPersistent)
  strict private
    FIsValidate: Boolean;
    FMsgnotValidate: String;
    procedure SetIsValidate(const Value: Boolean);
    procedure SetMsgnotValidate(const Value: String);
  published
    property IsValidate: Boolean read FIsValidate write SetIsValidate;
    property MsgnotValidate: String read FMsgnotValidate write SetMsgnotValidate;
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

function TControllersRoute.RegisterRouters(ASourceController: TPersistentClass;
  AControllerAlias: String): TControllersRoute;
begin
 RegisterClassAlias(ASourceController,AControllerAlias);
end;

function TControllersRoute.Route(const AClassName: String; Method: String;
  AParams: array of TValue; AConstrutor: Boolean; ConstrutorName: String;
  AConstructorParam: TConstructorParams; ARouterType: TRouterType;
  AMidleWareName: String): TValue;
  var FMidleware: TObject;
begin
  if not Trim(AMidleWareName).IsNullOrEmpty(AMidleWareName) then
  begin
    FMidleware:= TObject(GetClass(AMidleWareName).Create);
   try
    Assert( TMidlwareRoute(FMidleware).IsValidate,
            TMidlwareRoute(FMidleware).MsgnotValidate);
   finally
    FreeAndNil(FMidleware);
   end;
  end;
 if GetClass(AClassName) <> nil then
  Result := Execute(AClassName,Method,AParams,AConstrutor,ConstrutorName,AConstructorParam,ARouterType)
  else
  raise Exception.Create('Nenhuma rota encontrada com o nome de '+AClassName);
end;

//function TControllersRoute.Route(const AClassName: String; Method: String; AParams: array of TValue; AMidleWareName: String = ''): TValue;
//var FClass: TPersistentClass;
//     RttiContext: TRttiContext;
//     RttiInstanceType: TRttiInstanceType;
//     RttiMethod: TRttiMethod;
//     Instance: TValue;
//begin
//  Result:= Self;
//  if not Trim(AMidleWareName).IsNullOrEmpty(AMidleWareName) then
//    Assert( TMidlwareRoute(GetClass(AMidleWareName)).IsValidate,TMidlwareRoute(GetClass(AMidleWareName)).MsgnotValidate);
//
//  Assert( GetClass(AClassName) <> nil,'Nenhuma rota encontrada com o nome de '+AClassName+'!');
//  if not ( FRoutersInstance.Items[AClassName].IsEmpty ) then
//  begin
//    FClass:= GetClass(AClassName);
//    RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
//    RttiMethod := RttiInstanceType.GetMethod(Method);
//    RttiMethod.Invoke(FRoutersInstance.Items[AClassName], AParams);
//  end else
//  raise Exception.Create('Utilize o Método Construtor da Rota');
//end;

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

 { TMidlwareRoute }

procedure TMidlwareRoute.SetIsValidate(const Value: Boolean);
begin
  FIsValidate := Value;
end;

procedure TMidlwareRoute.SetMsgnotValidate(const Value: String);
begin
  FMsgnotValidate := Value;
end;

initialization

 Finalization
 FreeAndNil( RoutersController );

end.

unit Services.Containner.ObjConcrete;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Services.Containner.IInterfaces,Data.DB,System.Rtti;
  Type TArrayofParams = Array of TValue;
  type TContainnerServices = class(TInterfacedPersistent,IServiceProvider)
  private
    FDataSources: TDictionary<String,TDatasource>;
    FModel: TObject;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function AddDatasources(ADatasourceName: String; ADatasource: TDatasource):TContainnerServices;
    Function GetDatasource(ADatasourceName: String):TDatasource;
    Function Executemethod<T>(Const AMethodname: String; AMethodParams:TArrayofParams ):T;
  end;

implementation

{ TContainnerServices }
function TContainnerServices.AddDatasources(ADatasourceName: String;
  ADatasource: TDatasource): TContainnerServices;
begin

end;

procedure TContainnerServices.AfterConstruction;
begin
  inherited;
  FDataSources:= TDictionary<String,TDatasource>.create;
end;

procedure TContainnerServices.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FDataSources );
end;

function TContainnerServices.Executemethod<T>(const AMethodname: String;
  AMethodParams: TArrayofParams): T;
var  RttiContext: TRttiContext;
     RttiInstanceType: TRttiInstanceType;
     RttiMethod: TRttiMethod;
     InstanceOf: TValue;
     FValue: TValue;
begin
  if Fmodel <> nil then
  begin
    RttiContext := TRttiContext.Create;
    RttiInstanceType := RttiContext.FindType(FModel.UnitName+'.'+FModel.ClassName).AsInstance;
    RttiMethod := RttiInstanceType.GetMethod(AMethodName);
    InstanceOf:= RttiInstanceType.MetaclassType;
   if RttiMethod <> nil then
     FValue:= RttiMethod.Invoke( FModel , AmethodParams);
     Result:= FValue.AsType<T>;
  end;
end;

function TContainnerServices.GetDatasource(ADatasourceName: String): TDatasource;
begin

end;

end.

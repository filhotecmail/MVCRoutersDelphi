unit Services.Containner.ObjConcrete;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Services.Containner.IInterfaces,Data.DB;

  type TContainnerServices = class(TInterfacedPersistent,IServiceProvider)
  private
    FDataSources: TDictionary<String,TDatasource>;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function AddDatasources(ADatasourceName: String; ADatasource: TDatasource):TContainnerServices;
    Function GetDatasource(ADatasourceName: String):TDatasource;
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

function TContainnerServices.GetDatasource(ADatasourceName: String): TDatasource;
begin

end;

end.

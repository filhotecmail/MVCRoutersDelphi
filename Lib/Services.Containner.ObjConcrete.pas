unit Services.Containner.ObjConcrete;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Services.Containner.IInterfaces,Data.DB;

  type TServiceProvider = class(TInterfacedPersistent,IServiceProvider)
  private
    FDataSources: TDictionary<String,TDatasource>;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function AddDatasources(ADatasourceName: String; ADatasource: TDatasource):TServiceProvider;
    Function GetDatasource(ADatasourceName: String):TDatasource;
  end;

implementation

{ TServiceProvider }
function TServiceProvider.AddDatasources(ADatasourceName: String;
  ADatasource: TDatasource): TServiceProvider;
begin

end;

procedure TServiceProvider.AfterConstruction;
begin
  inherited;
  FDataSources:= TDictionary<String,TDatasource>.create;
end;

procedure TServiceProvider.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FDataSources );
end;

function TServiceProvider.GetDatasource(ADatasourceName: String): TDatasource;
begin

end;

end.

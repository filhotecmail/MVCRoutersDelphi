unit Oficina.DAO.RestClientHttp;

interface
 uses System.Classes,System.SysUtils,System.Variants,System.Generics.Collections,System.Rtti,
  Dao.Base, Dao.IInterfaces,Oficina.DAO.IInterfaces,DataBase.Config.Types,Data.DB;

  type TOficinaDAOHttp = class(TDaoBase,IOficinaDaoHttPServices)
  public

    procedure AfterConstruction; override;
    function GetCars(const Aparam: TObject): OleVariant;
    function GetData(const ASql: string; APArams: System.TArray<System.Variant>;
      var ADataset: TDataSet): IDaoBase; override;
     function ClientConfig( AConfigServiceType: RestClientAPIConfig ):IDaoRestClient;
     function Execute( ACallBack: TProc<TRequestCallBack,TResponseCallBack> ):IDaoRestClient;
  end;

implementation
{ TOficinaDAOHttp }

procedure TOficinaDAOHttp.AfterConstruction;
begin
  inherited;
   ResourceName:= DriverManager('WebServiceTeste');
end;

function TOficinaDAOHttp.ClientConfig(
  AConfigServiceType: RestClientAPIConfig): IDaoRestClient;
begin

end;

function TOficinaDAOHttp.Execute(
  ACallBack: TProc<TRequestCallBack, TResponseCallBack>): IDaoRestClient;
begin

end;

function TOficinaDAOHttp.GetCars(const Aparam: TObject): OleVariant;
begin
 Result:=
  '  { '
 +'  "id": "3635065", '
 +'  "SKU": "3635065", '
 +'  "Model": "KDL-40NX700", '
 +'  "name": "Sony 40 in. Bravia TV", '
 +'  "Description": "This is an amazing tv. You should buy it.", '
 +'  "Brand": "Sony", '
 +'  "Aspect Ratio": "16:9", '
 +'  "Feature": ["Child Lock", "Picture in Picture", "Sleep Timer"], '
 +'  "Release Date": "10-19-2010" '
 +'  } ';

end;


  function TOficinaDAOHttp.GetData(const ASql: string;
  APArams: System.TArray<System.Variant>; var ADataset: TDataSet): IDaoBase;
begin

end;

Initialization
  RegisterClassAlias(TOficinaDAOHttp,'OficinaDAOSrvHttp');
  finalization
  UnRegisterClass(TOficinaDAOHttp);
end.

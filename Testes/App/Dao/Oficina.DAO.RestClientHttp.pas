unit Oficina.DAO.RestClientHttp;

interface
 uses System.Classes,System.SysUtils,System.Variants,System.Generics.Collections,System.Rtti,
  Dao.Base, Dao.IInterfaces,Oficina.DAO.IInterfaces,DataBase.Config.Types,Data.DB;

  type TOficinaDAOHttp = class(TDaoBase,IOficinaDaoHttPServices)
  public
    function GetData(Const ASql:String; APArams: Tarray<Variant>): IDao; overload;
    procedure AfterConstruction; override;
    function GetCars(const Aparam: TObject): OleVariant;
  end;

implementation
{ TOficinaDAOHttp }

procedure TOficinaDAOHttp.AfterConstruction;
begin
  inherited;
   ResourceName:= GetConfig('WebServiceTeste');
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

function TOficinaDAOHttp.GetData(const ASql: String;
  APArams: Tarray<Variant>): IDao;
begin
 Result:= (Self as IDao);
end;

  Initialization
  RegisterClassAlias(TOficinaDAOHttp,'OficinaDAOSrvHttp');
  finalization
  UnRegisterClass(TOficinaDAOHttp);
end.

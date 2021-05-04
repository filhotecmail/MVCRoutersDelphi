unit Oficina.DAO.Dataset;

interface
 uses System.Classes,System.SysUtils,System.Variants,System.Generics.Collections,System.Rtti,
  Dao.Base, Dao.IInterfaces,Oficina.DAO.IInterfaces,Data.DB;

  type TOficinaDAODataset = class(TDaoBase,IOficinaDAODataset)
  public
      function GetData(Const ASql:String; APArams: Tarray<Variant>): IDao; overload;
      function GetCars(const Aparam: TDataSet): OleVariant;
  end;


implementation
{ TOficinaDAODataset }

function TOficinaDAODataset.GetCars(const Aparam: TDataSet): OleVariant;
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

function TOficinaDAODataset.GetData(const ASql: String;
  APArams: Tarray<Variant>): IDao;
begin
 Result:= (Self as IDao);
end;

 Initialization
  RegisterClassAlias(TOficinaDAODataset,'OficinaDAODataset');
 finalization
  UnRegisterClass(TOficinaDAODataset);

end.

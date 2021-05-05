unit Oficina.DAO.IInterfaces;

interface

uses Dao.IInterfaces,Data.DB,System.VarUtils,System.Variants;

   type IOficinaDAODataset = Interface(IDaoDataset)
     ['{A8572320-C09A-4859-A60B-E07F07D2B781}']
      function GetCars(Const Aparam: TDataset):OleVariant;
   End;

   type IOficinaDaoHttPServices = Interface(IDaoRestClient)
     ['{30614B60-12C9-48B0-8E31-B7765FC6AE35}']
     function GetCars(Const Aparam: TObject):OleVariant;
   End;

implementation

end.

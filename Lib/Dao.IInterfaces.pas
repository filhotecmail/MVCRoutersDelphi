unit Dao.IInterfaces;

interface
  Uses System.Classes,System.Variants;

 Type IDao = Interface
     ['{86E8C5C6-AE2D-4592-82E6-C067C131D5A9}']
      function GetData(Const ASql:String; APArams: Tarray<Variant>): IDao; overload;
 End;

implementation

end.

unit Dao.Base;

interface
   Uses System.Classes, System.VarUtils, System.SysUtils,System.Generics.Collections,
   System.Generics.Defaults,System.Rtti,Data.db, Dao.IInterfaces,
  DataBase.Config, DataBase.Config.Types;

 type
      TDaoBase = class Abstract(TInterfacedPersistent,IDao)
  private
    FResourceName: TStringArrayConfigs;
    procedure SetResourceName(const Value: TStringArrayConfigs);
  public
    function GetData(Const ASql:String; APArams: Tarray<Variant>): IDao; overload; virtual; abstract;
    function SetData():IDao; overload; virtual; abstract;
    function Cancel():IDao;overload; virtual; abstract;
    function Post():IDao;overload; virtual; abstract;
    function Edit():IDao; overload; virtual; abstract;
    function Delete(Const ID: Variant):IDao;overload; virtual; abstract;
    property ResourceName: TStringArrayConfigs read FResourceName write SetResourceName;
   end;

implementation

{ TDaoBase }



{ TDaoBase }

procedure TDaoBase.SetResourceName(const Value: TStringArrayConfigs);
begin
  FResourceName := Value;
end;

end.

unit Dao.Base;

interface
   Uses System.Classes, System.VarUtils, System.SysUtils,System.Generics.Collections,
   System.Generics.Defaults,System.Rtti,Data.db, Dao.IInterfaces,
  DataBase.Config, DataBase.Config.Types;

 type
      TDaoBase = class Abstract(TInterfacedPersistent,IDaoBase)
  private
    FResourceName: TStringArrayConfigs;
    procedure SetResourceName(const Value: TStringArrayConfigs);
  public
    function GetData(Const ASql:String; APArams: Tarray<Variant>;var ADataset: TDataset): IDaoBase; overload; virtual; abstract;
    function GetAll(out AObject: OleVariant):OleVariant; overload; virtual; abstract;
    function SetData():IDaoBase; overload; virtual; abstract;
    function Cancel():IDaoBase;overload; virtual; abstract;
    function Post():IDaoBase;overload; virtual; abstract;
    function Edit():IDaoBase; overload; virtual; abstract;
    function Delete(Const ID: Variant):IDaoBase;overload; virtual; abstract;
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

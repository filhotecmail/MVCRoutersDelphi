unit Dao.Base;

interface
   Uses System.Classes, System.VarUtils, System.SysUtils,System.Generics.Collections,
   System.Generics.Defaults,System.Rtti,Data.db, Dao.IInterfaces,
  DataBase.Config, DataBase.Config.Types;

 type
      TDaoBase = class Abstract(TInterfacedPersistent,IDaoBase)
  strict private
    FAOWNer: TComponent;
  private
    FResourceName: TStringArrayConfigs;
    procedure SetResourceName(const Value: TStringArrayConfigs);
  public
    function GetData(Const ASql:String; APArams: Tarray<Variant>;var ADataset: TDataset): IDaoBase; overload; virtual; abstract;
    function GetAll(AObject: TObject):OleVariant; overload; virtual; abstract;
    function SetData():IDaoBase; overload; virtual; abstract;
    function Cancel():IDaoBase;overload; virtual; abstract;
    function Post():IDaoBase;overload; virtual; abstract;
    function Edit():IDaoBase; overload; virtual; abstract;
    function Delete(Const ID: Variant):IDaoBase;overload; virtual; abstract;
    property ResourceName: TStringArrayConfigs read FResourceName write SetResourceName;
    constructor create(AOWner: TComponent);
   end;

implementation

{ TDaoBase }



{ TDaoBase }

constructor TDaoBase.create(AOWner: TComponent);
begin
 FAOWNer:= AOWner;
end;

procedure TDaoBase.SetResourceName(const Value: TStringArrayConfigs);
begin
  FResourceName := Value;
end;

end.

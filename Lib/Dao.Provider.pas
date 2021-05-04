unit Dao.Provider;

interface
  Uses System.SysUtils,System.Generics.Collections,System.Classes,Dao.Provider.IInterfaces;

  type TDaoProvider = class Abstract( TInterfacedPersistent,IDaoProvider )
      public
       function Connect():IDaoProvider;
       function Disconect():IDaoProvider;
       function ConnectionDefauts(AConnectionName: String; AConnection: String):IDaoProvider;
  end;

implementation

{ TDaoProvider }

function TDaoProvider.Connect: IDaoProvider;
begin

end;

function TDaoProvider.ConnectionDefauts(AConnectionName: String; AConnection: String): IDaoProvider;
begin

end;

function TDaoProvider.Disconect: IDaoProvider;
begin

end;

end.

unit Dao.Provider.IInterfaces;

interface
  Uses System.SysUtils,System.Generics.Collections,System.Classes;

  type IDaoProvider = Interface
   ['{69813BBD-775A-47D1-B7C8-8D6DFC911C85}']
   function Connect():IDaoProvider;
   function Disconect():IDaoProvider;
   function ConnectionDefauts(AConnectionName: String; AConnection: String):IDaoProvider;
  end;

implementation

end.

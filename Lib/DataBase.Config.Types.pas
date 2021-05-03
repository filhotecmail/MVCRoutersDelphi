unit DataBase.Config.Types;

interface
  uses System.classes,System.Generics.Defaults,System.Generics.Collections, System.VarUtils,System.SysUtils;

  type FirebirdDriver= array of String;
  type MySqlDriver = array of String;

  procedure AddConnections(Key: String; Value: String);

implementation
  var Connections: TDictionary<String,String>;

  procedure AddConnections(Key: String; Value:String);
  begin
    Connections.Add(Key,Value);
  end;

  Initialization
   Connections:= TDictionary<String,String>.Create;
  Finalization
   FreeAndNil( Connections );
end.

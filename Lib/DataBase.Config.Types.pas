unit DataBase.Config.Types;

interface
  uses System.classes,System.Generics.Defaults,System.Generics.Collections, System.VarUtils,System.SysUtils,
  Commom.Utils;
  type TStringArrayConfigs = array of String;

  type FirebirdDriverConfig= TStringArrayConfigs;
  type PostGresDiverConfig= TStringArrayConfigs;
  type MySqlDriverConfig = TStringArrayConfigs;
  type MariaDBDriverConfig= TStringArrayConfigs;
  type MongoDBDriverConfig= TStringArrayConfigs;
  type GraphQlDriverConfig= TStringArrayConfigs;
  type RestClientAPIConfig = TStringArrayConfigs;
  type Neo4JDriverConfig = TStringArrayConfigs;
  type RedisDriverConfig= TStringArrayConfigs;

  procedure AddConnections(Key: String; Value: TStringArrayConfigs);
  function PatchConfig(APatch: TStringArrayConfigs; Value: String):Variant; overload;
  function DriverManager(Key: String):TStringArrayConfigs;

implementation
 var Connections: TDictionary<String,TStringArrayConfigs>;

function PatchConfig(APatch: TStringArrayConfigs; Value: String):Variant;
begin
 Result:= _ReadArrayStringSeparadorValue(APatch,Value,':');
end;

function DriverManager(Key: String):TStringArrayConfigs;
begin
 Assert(Connections.ContainsKey(Key),format('Não existe uma configuração na lista de nome %s',[Key]));
 result:= Connections.Items[Key];
 end;

  procedure AddConnections(Key: String; Value: TStringArrayConfigs);
  begin
    Connections.Add(Key,Value);
  end;

  Initialization
   Connections:= TDictionary<String,TStringArrayConfigs>.Create;
  Finalization
   FreeAndNil( Connections );
end.

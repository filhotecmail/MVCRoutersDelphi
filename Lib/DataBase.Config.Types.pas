unit DataBase.Config.Types;

interface
  uses System.classes,System.Generics.Defaults,System.Generics.Collections, System.VarUtils,System.SysUtils,
  Commom.Utils;
  type TStringArrayConfigs = array of String;

  type FirebirdDriverConfig= TStringArrayConfigs;
  type MySqlDriverConfig = TStringArrayConfigs;
  type RestClientAPIConfig = TStringArrayConfigs;

  procedure AddConnections(Key: String; Value: TStringArrayConfigs);
  function GetConfig(Key: String):TStringArrayConfigs;
  function PatchConfig(APatch: TStringArrayConfigs; Value: String):Variant; overload;

implementation
  var Connections: TDictionary<String,TStringArrayConfigs>;

  function PatchConfig(APatch: TStringArrayConfigs; Value: String):Variant;
  begin
   Result:= _ReadArrayStringSeparadorValue(APatch,Value,':');
  end;

  function GetConfig(Key: String):TStringArrayConfigs;
  begin
   Assert(Connections.ContainsKey(Key),'Não existe uma configuração na lista com esse nome');
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

unit DataBase.Config;

interface
 uses System.classes,System.SysUtils, DataBase.Config.Types;

  var Firebird :   FirebirdDriver;

implementation

 Initialization
   Firebird:= [
      'DatabaseName: ',
      'Host: 127.0.0.1'
      ];
  AddConnections('Firebird',Firebird[0]);
 finalization

end.

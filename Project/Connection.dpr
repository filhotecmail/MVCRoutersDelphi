program Connection;

uses
  Vcl.Forms,
  Connection.Master.ViewTeste in '..\Testes\Connection.Master.ViewTeste.pas' {Form24},
  Connection.Master.IInterface in '..\Lib\Connection.Master.IInterface.pas',
  Config.DataBase.ObjectConcrete in '..\Resources\Config.DataBase.ObjectConcrete.pas',
  Vcl.Themes,
  Vcl.Styles,
  Connection.Master.Firedac in '..\Lib\Connection.Master.Firedac.pas',
  Database.IInterfaces in '..\Lib\Firedac\Database.IInterfaces.pas',
  Database.Controller in '..\Lib\Firedac\Database.Controller.pas',
  Database.Model in '..\Lib\Model\Database.Model.pas',
  Domains.Controller in '..\Lib\Domains.Controller.pas',
  Controllers.Routers in '..\Lib\Controllers.Routers.pas',
  Clientes.Controller in '..\Testes\Clientes.Controller.pas',
  Clientes.view in '..\Testes\Clientes.view.pas' {FVisaoCliente},
  Controllers.Global in '..\Lib\Controllers.Global.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm24, Form24);
  Application.Run;
end.

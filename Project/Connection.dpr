program Connection;

uses
  Vcl.Forms,
  Connection.Master.ViewTeste in '..\Testes\Connection.Master.ViewTeste.pas' {Form24},
  Vcl.Themes,
  Vcl.Styles,
  Domains.Controller in '..\Lib\Domains.Controller.pas',
  Controllers.Routers in '..\Lib\Controllers.Routers.pas',
  Clientes.Controller in '..\Testes\Clientes.Controller.pas',
  Cliente.routers in '..\Testes\Cliente.routers.pas',
  Clientes.view in '..\Testes\Clientes.view.pas' {FVisaoCliente},
  Controllers.Routers.ObjectConcrete in '..\Lib\Controllers.Routers.ObjectConcrete.pas',
  Routers.Auth.Midleware in '..\Lib\Routers.Auth.Midleware.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  RoutersController := TControllersRoute.Create;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm24, Form24);
  Application.Run;
end.

program Connection;

uses
  Vcl.Forms,
  Connection.Master.ViewTeste in '..\Testes\App\Views\Connection.Master.ViewTeste.pas' {Form24},
  Vcl.Themes,
  Vcl.Styles,
  Domains.Controller in '..\Lib\Domains.Controller.pas',
  Controllers.Routers in '..\Lib\Controllers.Routers.pas',
  Clientes.Controller in '..\Testes\App\controllers\Clientes.Controller.pas',
  Routers.Facade in '..\Testes\App\routers\Routers.Facade.pas',
  Clientes.view in '..\Testes\App\Views\Clientes.view.pas' {FVisaoCliente},
  Controllers.Routers.ObjectConcrete in '..\Lib\Controllers.Routers.ObjectConcrete.pas',
  Routers.Auth.Midleware in '..\Testes\App\midlewares\Routers.Auth.Midleware.pas',
  Routers.Middleware.Abstract in '..\Lib\Routers.Middleware.Abstract.pas',
  Routers.Methods in '..\Lib\Routers.Methods.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm24, Form24);
  Application.Run;
end.

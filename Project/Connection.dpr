program Connection;

uses
  Vcl.Forms,
  Connection.Master.ViewTeste in '..\Testes\Connection.Master.ViewTeste.pas' {Form24},
  Vcl.Themes,
  Vcl.Styles,
  Domains.Controller in '..\Lib\Domains.Controller.pas',
  Controllers.Routers in '..\Lib\Controllers.Routers.pas',
  Clientes.Controller in '..\Testes\Clientes.Controller.pas',
  Controllers.Global in '..\Lib\Controllers.Global.pas',
  Clientes.view in '..\Testes\Clientes.view.pas' {FVisaoCliente};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm24, Form24);
  Application.Run;
end.

program Connection;

uses
  Vcl.Forms,
  Connection.Master.ViewTeste in '..\Testes\App\Views\Connection.Master.ViewTeste.pas' {Form24},
  Vcl.Themes,
  Vcl.Styles,
  Controller.IInterfaces in '..\Lib\Controller.IInterfaces.pas',
  Routers.ConcreteClass.Obj in '..\Lib\Routers.ConcreteClass.Obj.pas',
  Oficina.Controller in '..\Testes\App\controllers\Oficina.Controller.pas',
  Routers.Facade in '..\Testes\App\routers\Routers.Facade.pas',
  Clientes.view in '..\Testes\App\Views\Clientes.view.pas' {FVisaoCliente},
  Routers.Auth.Midleware in '..\Testes\App\midlewares\Routers.Auth.Midleware.pas',
  Routers.Middleware.Abstract in '..\Lib\Routers.Middleware.Abstract.pas',
  Routers.Methods in '..\Lib\Routers.Methods.pas',
  Controller.ConcreteObj in '..\Lib\Controller.ConcreteObj.pas',
  System.Helper in '..\Lib\Helpers\System.Helper.pas',
  Model.ObjectConcrete in '..\Lib\Model.ObjectConcrete.pas',
  Model.IInterfaces in '..\Lib\Model.IInterfaces.pas',
  Oficina.Model in '..\Testes\App\Models\Oficina.Model.pas',
  Notify.Subscribe in '..\Lib\Notify.Subscribe.pas',
  Observers.IInterfaces in '..\Lib\Observers.IInterfaces.pas',
  View.Abstract in '..\Lib\View.Abstract.pas',
  Services.Containner.IInterfaces in '..\Lib\Services.Containner.IInterfaces.pas',
  Services.Containner.ObjConcrete in '..\Lib\Services.Containner.ObjConcrete.pas',
  Oficina.Services.Dataset.Containner in '..\Testes\App\ServicesContainners\Oficina.Services.Dataset.Containner.pas',
  DataBase.Config in '..\Lib\DataBase.Config.pas',
  DataBase.Config.Types in '..\Lib\DataBase.Config.Types.pas',
  Dao.Base in '..\Lib\Dao.Base.pas',
  Dao.IInterfaces in '..\Lib\Dao.IInterfaces.pas',
  Dao.Provider in '..\Lib\Dao.Provider.pas',
  Dao.Provider.IInterfaces in '..\Lib\Dao.Provider.IInterfaces.pas',
  Dao.Provider.PostGres in '..\Lib\Dao.Provider.PostGres.pas',
  Dao.Provider.Firebird in '..\Lib\Dao.Provider.Firebird.pas',
  Dao.Provider.RestClientLIB in '..\Lib\Dao.Provider.RestClientLIB.pas',
  Dao.RestClient in '..\Lib\Dao.Conectors\Dao.RestClient.pas',
  Commom.Utils in '..\Lib\Commom.Utils.pas',
  Oficina.DAO.Dataset in '..\Testes\App\Dao\Oficina.DAO.Dataset.pas',
  Oficina.DAO.IInterfaces in '..\Testes\App\Dao\Oficina.DAO.IInterfaces.pas',
  Oficina.DAO.RestClientHttp in '..\Testes\App\Dao\Oficina.DAO.RestClientHttp.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TForm24, Form24);
  Application.Run;
end.

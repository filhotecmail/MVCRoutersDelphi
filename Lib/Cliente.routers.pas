unit Cliente.routers;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes,Clientes.Controller, Clientes.view;

  procedure RegisterControllers;

implementation

uses
  Controllers.Routers;

 procedure RegisterControllers;
 begin
  RoutersController.RegisterRouters(Clientes.Controller.TClientesController,'/Clientes');
  RoutersController.RegisterRouters(TFVisaoCliente,'/ClientesView');
 end;
  Initialization
  RegisterControllers;
end.
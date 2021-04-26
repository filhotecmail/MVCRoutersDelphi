unit Unit1;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes,Clientes.Controller, Clientes.view;


  procedure RegisterControllers;

implementation

uses
  Controllers.Routers;

 procedure RegisterControllers;
 begin
  RoutersController.RegisterRouters(TClientesController,'/Clientes','/ClientesView',TFVisaoCliente);
 end;

  Initialization
  RoutersController := TControllersRoute.Create;
  RegisterControllers;
  finalization
  FreeAndNil( RoutersController );
end.

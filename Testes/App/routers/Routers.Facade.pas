unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization
 RegisterGroup('Clientes',[],[
 Controller('/ClientesController','create',[],[],'CriaControllerClientes'),
 Controller('/ClientesController','submit',[],[],'TesteSubmit')
 ] );

Finalization

end.

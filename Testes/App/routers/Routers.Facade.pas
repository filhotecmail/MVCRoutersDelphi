unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Clientes',['Auth'],[
   // Método será executado depois da execução do Middleware
   Construtor(Controller('/ClientesController','create',[],[],'CriaControllerClientes'))

 ],[
     // Método que não será validado pelo Middleware da Rota, Em referência a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele não vai acionar o Middleware do grupo de rota
     Controller('/ClientesController','Submit',[],[],'TesteSubmit')
    ] );

Finalization

end.

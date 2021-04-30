unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Clientes',['Auth'],[
   // Método será executado depois da execução do Middleware
     Controller('/ClientesController','Submit',[],[],'TesteSubmit')
 ],[
      Construtor(Controller('/ClientesController','create',[],[],'CriaControllerClientes')),
      Controller('/ClientesController','MethodSemAuh',[],[],'Metodnaexcessao')
     // Método que não será validado pelo Middleware da Rota, Em referência a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele não vai acionar o Middleware do grupo de rota

    ] );

Finalization

end.

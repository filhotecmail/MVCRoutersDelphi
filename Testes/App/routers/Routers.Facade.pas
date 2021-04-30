unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Clientes',['Auth'],[
   // M�todo ser� executado depois da execu��o do Middleware
     Controller('/ClientesController','Submit',[],[],'TesteSubmit')
 ],[
      Construtor(Controller('/ClientesController','create',[],[],'CriaControllerClientes')),
      Controller('/ClientesController','MethodSemAuh',[],[],'Metodnaexcessao')
     // M�todo que n�o ser� validado pelo Middleware da Rota, Em refer�ncia a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele n�o vai acionar o Middleware do grupo de rota

    ] );

Finalization

end.

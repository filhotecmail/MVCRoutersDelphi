unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Oficina Zezinhos Informatica Ltda.ME',['Auth'],[
   // M�todo ser� executado depois da execu��o do Middleware
     Construtor(Controller('/Oficinadozezinho','create',[],[],'Falar com a Oficina')),
     Controller('/Oficinadozezinho','AssistenciaComputadores',[],[],'Arrumo Computadores'),
     Controller('/Oficinadozezinho','Venda',[],[],'Vendo Perifericos'),
     Controller('/Oficinadozezinho','Reballing',[],[],'Reballing em Procesadores'),
     Controller('/Oficinadozezinho','ConsertoNotebooks',[],[],'Conserto de Notebooks'),
     Controller('/Oficinadozezinho','ConsertoLCD',[],[],'Conserto de Monitores LCD'),
     Controller('/Oficinadozezinho','ConsertoLED',[],[],'Conserto de Monitores Led'),
     Controller('/Oficinadozezinho','impressoras',[],[],'Manuten��o de impressoras'),
     Controller('/Oficinadozezinho','impressorasFiscais',[],[],'Manuten��o de Impressoras Fiscais'),
     Controller('/Oficinadozezinho','ManutencaoCelulares',[],[],'Manuten��o de Celulares'),
     Controller('/Oficinadozezinho','Eletronica',[],[],'Servi�os de eletronica'),
     Controller('/Oficinadozezinho','WatsApp',[],[],'Grupo no WatsApp'),
     Controller('/Oficinadozezinho','Email',[],[],'Envie um email para a oficina'),
     Controller('/Oficinadozezinho','Render',[],[],'Ver a oficina do zezinho'),
     Controller('/Oficinadozezinho','ListaServicos',[],[],'Lista de servi�os da oficina do zezinho')
 ],[

     // M�todo que n�o ser� validado pelo Middleware da Rota, Em refer�ncia a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele n�o vai acionar o Middleware do grupo de rota
    ] );

Finalization

end.

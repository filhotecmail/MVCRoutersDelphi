unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Oficina Zezinhos Informatica Ltda.ME',['Auth'],[
   // Método será executado depois da execução do Middleware
     Construtor(Controller('/Oficinadozezinho','create',[],[],'Falar com a Oficina')),
     Controller('/Oficinadozezinho','AssistenciaComputadores',[],[],'Arrumo Computadores'),
     Controller('/Oficinadozezinho','Venda',[],[],'Vendo Perifericos'),
     Controller('/Oficinadozezinho','Reballing',[],[],'Reballing em Procesadores'),
     Controller('/Oficinadozezinho','ConsertoNotebooks',[],[],'Conserto de Notebooks'),
     Controller('/Oficinadozezinho','ConsertoLCD',[],[],'Conserto de Monitores LCD'),
     Controller('/Oficinadozezinho','ConsertoLED',[],[],'Conserto de Monitores Led'),
     Controller('/Oficinadozezinho','impressoras',[],[],'Manutenção de impressoras'),
     Controller('/Oficinadozezinho','impressorasFiscais',[],[],'Manutenção de Impressoras Fiscais'),
     Controller('/Oficinadozezinho','ManutencaoCelulares',[],[],'Manutenção de Celulares'),
     Controller('/Oficinadozezinho','Eletronica',[],[],'Serviços de eletronica'),
     Controller('/Oficinadozezinho','WatsApp',[],[],'Grupo no WatsApp'),
     Controller('/Oficinadozezinho','Email',[],[],'Envie um email para a oficina'),
     Controller('/Oficinadozezinho','Render',[],[],'Ver a oficina do zezinho'),
     Controller('/Oficinadozezinho','ListaServicos',[],[],'Lista de serviços da oficina do zezinho')
 ],[

     // Método que não será validado pelo Middleware da Rota, Em referência a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele não vai acionar o Middleware do grupo de rota
    ] );

Finalization

end.

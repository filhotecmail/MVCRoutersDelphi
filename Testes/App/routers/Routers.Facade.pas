unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Oficina',['Auth'],[
   // Método será executado depois da execução do Middleware
     Construtor(Controller('/OficinaInformatica','create',[],[],'Falar com a Oficina')),
     Controller('/OficinaInformatica','AssistenciaComputadores',[],[],'Arrumo Computadores'),
     Controller('/OficinaInformatica','Venda',[],[],'Vendo Perifericos'),
     Controller('/OficinaInformatica','Reballing',[],[],'Reballing em Procesadores'),
     Controller('/OficinaInformatica','ConsertoNotebooks',[],[],'Conserto de Notebooks'),
     Controller('/OficinaInformatica','ConsertoLCD',[],[],'Conserto de Monitore LCD'),
     Controller('/OficinaInformatica','ConsertoLED',[],[],'Conserto de Monitore Led'),
     Controller('/OficinaInformatica','impressoras',[],[],'Manutenção de impressoras'),
     Controller('/OficinaInformatica','impressorasFiscais',[],[],'Manutenção de Impressoras Fiscais'),
     Controller('/OficinaInformatica','ManutencaoCelulares',[],[],'Manutenção de Celulares'),
     Controller('/OficinaInformatica','Eletronica',[],[],'Serviços de eletronica'),
     Controller('/OficinaInformatica','WatsApp',[],[],'Grupo no WatsApp'),
     Controller('/OficinaInformatica','Email',[],[],'Envie um email para a oficina')
 ],[

     // Método que não será validado pelo Middleware da Rota, Em referência a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele não vai acionar o Middleware do grupo de rota
    ] );

Finalization

end.

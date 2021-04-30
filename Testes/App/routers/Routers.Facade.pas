unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Oficina',['Auth'],[
   // M�todo ser� executado depois da execu��o do Middleware
     Construtor(Controller('/OficinaInformatica','create',[],[],'Falar com a Oficina')),
     Controller('/OficinaInformatica','AssistenciaComputadores',[],[],'Arrumo Computadores'),
     Controller('/OficinaInformatica','Venda',[],[],'Vendo Perifericos'),
     Controller('/OficinaInformatica','Reballing',[],[],'Reballing em Procesadores'),
     Controller('/OficinaInformatica','ConsertoNotebooks',[],[],'Conserto de Notebooks'),
     Controller('/OficinaInformatica','ConsertoLCD',[],[],'Conserto de Monitore LCD'),
     Controller('/OficinaInformatica','ConsertoLED',[],[],'Conserto de Monitore Led'),
     Controller('/OficinaInformatica','impressoras',[],[],'Manuten��o de impressoras'),
     Controller('/OficinaInformatica','impressorasFiscais',[],[],'Manuten��o de Impressoras Fiscais'),
     Controller('/OficinaInformatica','ManutencaoCelulares',[],[],'Manuten��o de Celulares'),
     Controller('/OficinaInformatica','Eletronica',[],[],'Servi�os de eletronica'),
     Controller('/OficinaInformatica','WatsApp',[],[],'Grupo no WatsApp'),
     Controller('/OficinaInformatica','Email',[],[],'Envie um email para a oficina')
 ],[

     // M�todo que n�o ser� validado pelo Middleware da Rota, Em refer�ncia a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele n�o vai acionar o Middleware do grupo de rota
    ] );

Finalization

end.

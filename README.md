# MVC|Routers-Delphi
 MVC Baseado em sistemas de rotas , inspirado no Modelo Laravel- PHP.
 Em construção!

O Laravel me chamou atenção por sua simplicidade e sua arquitetura MVC organizada. O Sistema de rotas do Laravel é um Facade para a aplicação simplificar seus serviços.
# 1.1 — Facade
  Quando pensamos em uma fachada, desenhamos, ilustramos algo em que podemos identificar, conhecer , se familiarizer, entender. Por exemplo, quando você olha para uma fachada de uma loja e entende com apenas 1 slogan ou uma frase que está escrita no banner, tudo o que a loja oferece. Você olha para a vitrine da fachada e observa que toda a loja se resume em coisas simples e fáceis de entender, porém não conhecemos todo o esforço e todo o trabalho que há nos bastidores da loja, no estoque , na limpeza, não queremos expor um estoque complexo ao cliente , mas sim uma fachada simples e intuítiva.
#
![image](https://user-images.githubusercontent.com/18727307/116164493-26d78900-a6d0-11eb-99da-edc15648ad9f.png)

O Padrão de Design de Fachada define uma interface simples para usar um sistema ou um conjunto de objetos.

Há um subsistema complexo com muitas classes e dependências entre elas. Os clientes que desejam usar este subsistema ou partes dele devem olhar para as diferentes interfaces das classes que contêm e entender como funcionam. Ao fazê-lo, eles inevitavelmente constroem muitas dependências de diferentes objetos e estão intimamente ligados às classes do subsistema.

A fachada é trocada entre clientes e o subsistema. Ele "encapsula" o subsistema, contém a lógica complexa para trabalhar com o subsistema e fornece uma interface simplificada (métodos) para o cliente para o mundo exterior. A fachada delega as chamadas do cliente para o subsistema. Isso permite que o cliente use o sistema através da Fachada sem conhecer as classes, seus relacionamentos e dependências.

# O Laravel
. O Laravel representa toda a complexidade em sistemas de Rotas , Facade. O Sistema de rotas do Laravel, concentra tudo que é necessário para que a aplicação funcuione perfeitamente, deixando simples e explicitamente o que se tem a nossa disposição. 

  Por exemplo, você está construíndo um sistema de pagamento, você não vai oferecer ao cliente, ou para uma equipe , regras complexas ou expor objetos complexos cheio de regras complexas para que se possa utilizar o sistema, ao invés disso, você expõem em métodos simples o que aquela fachada representa e os métodos que fazem ela funcionar.
    
              
               Function Pagar( PValor: Currency ):TJsonObject;
               Fuction MostrarSaldo( IdCliente: Intege ):TJsonObject;

   Bom nesse caso apresentado acima, as duas funções representam de forma simples e objetiva, concisa o que elas representam e o que elas fazem, porém e se precisássemos expor mais que apenas funções ou métodos. Poderíamos por exemplo representar nossos controles de pagamento.
         
      Route::POST('/Pagar',[Pagamento.Controller::Class,'store'])->('Pagamento')
      Route::Get('/Saldo',[Pagamento.Controller::Class,'Index'])->('MostrarSaldo')

Analisando o Código acima, Entendemos que uma Rota , representa um método 'store', identificado pelo nome, essa rota tem o prefixo '/Pagar', ela representa o controller de pagamento Pagamento.controller e identifico que essa rota é uma Classe.
No final podemos dar um apelido, menos complexo e mais amigável á rota, deixando somente como 'Pagamento'.

  A Grande vantagem disso em nosso mundo Delphi, podemos utilizar a biblioteca RTTI para mapear as classes e os Objetos e poder reduzir o acoplamento, aqueles monte de uses onde todo mundo conhece todo mundo.
  Bom a idéa é , contruir um sistema MVC, Onde Nossas Rotas serão publicáveis em um Grande Facade para a aplicação.
  Vamos ver na prática!

# ObjectPascal-DELPHI

   O Primeiro passo foi criar uma unidade com apenas 1 único método chamado RegisterControllers. 
 ```Delphi
  uses
   Controllers.Routers;

 procedure RegisterControllers;
 begin
  RoutersController.RegisterRouters(Clientes.Controller.TClientesController,'/Clientes');
  RoutersController.RegisterRouters(TFVisaoCliente,'/ClientesView');
 end;
  Initialization
  RoutersController := TControllersRoute.Create;
  RegisterControllers;
  finalization
  FreeAndNil( RoutersController );
```
O Sistema irá registrar utilizando o recurso da propria VCL, RegisterClassAlias() 
```Delphi
 function TControllersRoute.RegisterRouters(ASourceController: TPersistentClass;
  AControllerAlias: String): TControllersRoute;
begin
 RegisterClassAlias(ASourceController,AControllerAlias);
end;
```
 Abaixo temos um exemplo de como Invokar as rotas, o primeiro overload, invoka uma Rota chamada '/Clientes', seu método 'Render', Você pode passar Parâmetros caso precise, True ou false determina se é um método construtor ou não, se for um método construtor, deverá informar o nome do Método , por ex: Create(), Createnew(), New, Build, Make , etc.., em seguida você pode passar os parâmetros do construtor, e o tipo , teremos inicialmente 3 tipos de rotas , Controller, Model,View.
```Delphi
RoutersController.Route('/Clientes','Render',[],True,'New',[],Controller);
RoutersController.Route('/Clientes','Submit',[]);
```
Contamos também com um Método para liberar a instância da memória. Nesse ponto é que me pergunto, será que podemos resolver isso de uma forma automática?, Poderíamos contar com classes Interfeceadas, porém , quero deixar as rotas livres, reduzindo e muito todo acoplamento e dependências entre as classes.
```Delphi
 RoutersController.FreeRoute('/Clientes');
```
Olhando o método abaixo, você ja deva estar se perguntando e com certeza deva ter entendido o real propósito.Sim, Invocaremos o método 'Submit' do Controller '/Clientes' a qualquer momento.
```Delphi
RoutersController.Route('/Clientes','Submit',[]);
```  
Bom com isso eu já consigo elaborar meu sistema MVC , onde a View não conhece o Controller , o Controller não conhece a View e o Controller não precisa conhecer o Modelo, se quiser hehehe, claro não podemos chegar tão fundo assim, mas podemos extender isso a outras arquiteturas como cadamas de Serviço, Domínio.



         

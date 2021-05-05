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

# vamos pensar em uma Fachada.
   Pense em uma Empresa, uma oficina de informatica e venda de periféricos, com serviços de eletrônica.
   Bom vamos tentar resumir o que a empresa faz , sem falar ao cliente como fazemos a coisa funcionar. O Cliente não precisa conhecer o Objeto Tecnicos, o Objeto Balcão, e uma Oficina de informatica é uma oficina de informática. Agora tente falar de sua oficina para quem passa na rua .

   ![image](https://user-images.githubusercontent.com/18727307/116729477-9645c500-a9bd-11eb-83ee-4ca080930f3a.png)

  Vamos ver como isso pode ser feito na nossa fachada.

  ```Delphi

 RegisterGroup('Oficina Zezinhos Informatica Ltda.ME',['Auth'],[
   // Método será executado depois da execução do Middleware
     Construtor(Controller('/OficinaInformatica','create',[],[],'Falar com a Oficina')),
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
     Controller('/Oficinadozezinho','Email',[],[],'Envie um email para a oficina')
 ],[

     // Método que não será validado pelo Middleware da Rota, Em referência a Except do Laravel
     // Nesse caso Mesmo a rota tendo um middleware , ele não vai acionar o Middleware do grupo de rota
    ] );
    
  ```

  Agora temos uma simples Fachada para os serviços prestados da oficia do zezinho.
   Vamos pensar agora que como eu não conheço o zezinho, mas eu sei o que eles fazem e tem o telefone dele lá e uma forma de falar com eles, então eu não preciso nem conhecer a loja do Zezinho..

```Delphi
  procedure TForm24.btn4Click(Sender: TObject);
begin
  Group('Oficina Zezinhos Informatica Ltda.ME','Falar com a Oficina',[]);
  Group('Oficina Zezinhos Informatica Ltda.ME','Arrumo Computadores',[]);
  Group('Oficina Zezinhos Informatica Ltda.ME','Vendo Perifericos',[]);
end;

```
 

# O Laravel
. O Laravel representa toda a complexidade em sistemas de Rotas , Facade. O Sistema de rotas do Laravel, concentra tudo que é necessário para que a aplicação funcuione perfeitamente, deixando simples e explicitamente o que se tem a nossa disposição. 

  Por exemplo, você está construíndo um sistema de pagamento, você não vai oferecer ao cliente, ou para uma equipe , regras complexas ou expor objetos complexos cheio de regras complexas para que se possa utilizar o sistema, ao invés disso, você expõem em métodos simples o que aquela fachada representa e os métodos que fazem ela funcionar.
    
              
               Function Pagar( PValor: Currency ):TJsonObject;
               Fuction MostrarSaldo( IdCliente: Integer ):TJsonObject;

   Bom nesse caso apresentado acima, as duas funções representam de forma simples e objetiva, concisa o que elas representam e o que elas fazem, porém e se precisássemos expor mais que apenas funções ou métodos. Poderíamos por exemplo representar nossos controles de pagamento.
         
      Route::POST('/Pagar',[Pagamento.Controller::Class,'store'])->('Pagamento')
      Route::Get('/Saldo',[Pagamento.Controller::Class,'Index'])->('MostrarSaldo')

Analisando o Código acima, Entendemos que uma Rota , representa um método 'store', identificado pelo nome, essa rota tem o prefixo '/Pagar', ela representa o controller de pagamento Pagamento.controller e identifico que essa rota é uma Classe.
No final podemos dar um apelido, menos complexo e mais amigável á rota, deixando somente como 'Pagamento'.

  A Grande vantagem disso em nosso mundo Delphi, podemos utilizar a biblioteca RTTI para mapear as classes e os Objetos e poder reduzir o acoplamento, aqueles monte de uses onde todo mundo conhece todo mundo.
  Bom a idéa é , contruir um sistema MVC, Onde Nossas Rotas serão publicáveis em um Grande Facade para a aplicação.

# MVC- Motivação.
  A idéia original é construirmos a Arquitetura do problema dentro da camada MVC, tenho a premissa de entregar um sistema completo para criação e registros das rotas , o Facade , o Controller e o Model, e fazer com que eles não se conheçam.

 O que é o MVC. 
   O padrão MVC representa o padrão Model-View-Controller (model-view-controller). Este modo é usado para desenvolvimento hierárquico de aplicativos.

Modelo - O modelo representa um objeto ou JAVA POJO que acessa os dados. Também pode ter lógica para atualizar o controlador quando os dados mudam.
Visualização - uma visualização representa uma visualização dos dados contidos no modelo.
Controlador - O controlador atua no modelo e na visualização. Ele controla o fluxo de dados para modelar objetos e atualiza a visualização quando os dados são alterados. Ele separa a vista do modelo.

![image](https://user-images.githubusercontent.com/18727307/116269556-b6268000-a754-11eb-852b-65c7165227ea.png)


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
```Delphi
 interface
uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;
  
implementation

initialization

 RegisterGroup('Clientes',['Auth'],[
 Controller('/ClientesController','create',[],[],'CriaControllerClientes'),
 Controller('/ClientesController','submit',[],[],'TesteSubmit')
 ] );
end.
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

#Sistema de Midlewares para as rotas.
  Pensando em pequenos trechos de códigos que vão executar pequenas lógicas para que as rotas possam ser acionadas.
   Dessa forma Criei uma classe base Chamada TMidlewareRouters..
Uma Classe Abstrata pequena com apenas 2 propriedades iniciais para podermos trabalhar
  ```Delphi
    type TMidlwareRoute = Class Abstract(TPersistent)
  strict private
    FIsValidate: Boolean;
    FMsgnotValidate: String;
    procedure SetIsValidate(const Value: Boolean);
    procedure SetMsgnotValidate(const Value: String);
  published
    property IsValidate: Boolean read FIsValidate write SetIsValidate;
    property MsgnotValidate: String read FMsgnotValidate write SetMsgnotValidate;
  end;
  ```
 Intejando o midleware como parte de uma lógica dentro da classe de rotas.
```Delphi
function TControllersRoute.Route(const AClassName: String; Method: String; AParams: array of TValue;
  AConstrutor: Boolean; ConstrutorName: String; AParamsConstructor: array of TValue; ARouterType:TRouterType; AMidleWareName: String = ''): TValue;
  var FMidleware: TObject;
begin
  if not Trim(AMidleWareName).IsNullOrEmpty(AMidleWareName) then
  begin
    FMidleware:= TObject(GetClass(AMidleWareName).Create);
   try
    Assert( TMidlwareRoute(FMidleware).IsValidate,
            TMidlwareRoute(FMidleware).MsgnotValidate);
   finally
    FreeAndNil(FMidleware);
   end;
  end;
 if GetClass(AClassName) <> nil then
  Result := Execute(AClassName,Method,AParams,AConstrutor,ConstrutorName,AParamsConstructor,ARouterType)
  else
  raise Exception.Create('Nenhuma rota encontrada com o nome de '+AClassName);
end;

```
E agora o Toque final, testando, vamos Criar uma Classe herdando da classe Abstrata de Midlewares, e vamos chama-la de AUth.
```Delphi
type TAuthMidleware = Class(TMidlwareRoute)
   private
    FUsername: string;
    FPassWord: String;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  End;

implementation
{ TAuthMidleware }
procedure TAuthMidleware.AfterConstruction;
begin
  inherited;
   // Executar a Lógica
   MsgnotValidate:= 'Usuário não autenticado';
   IsValidate := (( FUsername = 'Carlos') and (  FPassWord = '1234' ) );
end;
procedure TAuthMidleware.BeforeDestruction;
begin
  inherited;
end;

initialization
 RegisterClassAlias(TAuthMidleware,'Auth');
 Finalization
 UnRegisterClass( TAuthMidleware );
end.
```

Passando Array de Midlewares para verifição nas rotas.
```Delphi
 interface
uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;
  
implementation

initialization

 RegisterGroup('Clientes',['Auth'],[
 Controller('/ClientesController','create',[],[],'CriaControllerClientes'),
 Controller('/ClientesController','submit',[],[],'TesteSubmit')
 ] );
end.
```
# Uma chamada View para o controller.

Seguindo o modelo MVC do Laravel, foi criado um método view no sistema de rotas, para que seja possível dentro do controller chamar uma View pelo Nome.
```Delphi
procedure TClientesController.Render;
begin
 View('/ClientesView',Self);
end;

```
# Middlewares para Grupos de rotas.
Motivação, Laravel, Qualquer método que for invocado no Facade vai passar por um Middleware.
 Vai verifiacar na Lista de grupos de Rotas, no array de middlewares , se existe
 algum middleware informado, se existir , todos os métodos disparados para aquele grupo de rotas
 só serão executados caso passe pelo middleware;
```Delphi
function TGroupRoute.Execute(AGroupName: String;AMethodName: String; AMethodParams: Array of TValue): TValue;
 var I: Integer;
     FValue: TValue;
begin
 Assert( FListGroups.ContainsKey(AGroupName),'Não existe um Grupo com esse objeto' );
 Assert(FListGroups.Items[AGroupName].Methods.ContainsKey(AMethodName), 'Não existe um Grupo com esse objeto');
 // Vai verifiacar na Lista de grupos de Rotas, no array de middlewares , se existe
 // algum middleware informado, se existir , todos os métodos disparados para aquele grupo de rotas
 // só serão executados caso passe pelo middleware;
  begin
   CheckMidlewares(FListGroups.Items[AGroupName].AMiddlewares,
    procedure
   ( AMiddleCallBack: TMiddlwareRoute )
   begin
    FValue:= FListGroups.Items[AGroupName].Methods.Items[AMethodName].ExecuteMethod;
    if AMiddleCallBack <> nil then
    if Assigned(AMiddleCallBack.ACallBackValue) then
      AMiddleCallBack.ACallBackValue(FValue);
   end);
  end;
 Result:= FValue;
end;
```
Você precisa apenas Informar o middleware na construção da rota.
Exemplo - Informando um Middleware de para o grupo de rotas.
```Delphi
 unit Routers.Facade;

interface

uses
  System.SysUtils,System.Generics.Collections,System.Classes, Routers.Methods;

implementation

initialization

 RegisterGroup('Clientes',['Auth'],[
 Construtor(Controller('/ClientesController','create',[],[],'CriaControllerClientes')),
 Controller('/ClientesController','Submit',[],[],'TesteSubmit')
 ] );

Finalization

end.

```

# Cobrindo uma Rota com o Método Construtor.

  Rotas podem ser cobertas pelo método Construtor , ao ser informado, você diz que aquela rota vai executar um método que é um construtor do objeto.
 ```
  Construtor( Rota(  Nome da rota, Método, Parametros, Um Apelido para a Rota )  );   

```

# Chamando Rotas que estão em um Grupo de rotas.
   Você pode ter grupos de rotas registrados no Facade de rotas, e para utilizar ex:  Método Group( 'Nome da rota','Método' ou Apelido do Método, Parametros )
```Delphi

procedure TForm24.btn4Click(Sender: TObject);
begin
  Group('Clientes','CriaControllerClientes',[]);
  Group('Clientes','TesteSubmit',[]);

   Método Group( 'Nome da rota','Método' ou Apelido do Método, Parametros )
end;
``` 
Você pode passar tanto o Nome do Método da rota , ou o apelido que designou para o Método.

# MVC
  Seguindo como inspração o Modelo MVC do Laravel , teremos o primeiro elemento registrado nas rotas do facade. O Controller.
  MVC é o acrônimo de Model-View-Controller (em português: Arquitetura Modelo-Visão-Controle - MVC) é um padrão de projeto de software,[1] ou padrão de arquitetura de software formulado na década de 1970,[2] focado no reuso de código e a separação de conceitos em três camadas interconectadas, onde a apresentação dos dados e interação dos usuários (front-end) são separados dos métodos que interagem com o banco de dados (back-end).[2]

Normalmente usado para o desenvolvimento de interfaces de usuário que divide uma aplicação em partes (camadas/componentes) interconectadas. Isto é feito para separar representações de informação internas dos modos como a informação é apresentada para e aceita pelo usuário,[3][4] levando ao desenvolvimento paralelo de maneira eficiente.

Os componentes do MVC
Tradicionalmente usado para interfaces gráficas de usuário (GUIs), esta arquitetura tornou-se popular para projetar aplicações web e até mesmo para aplicações móveis, para desktop e para outros clientes.[6] Linguagens de programação populares como Java, C#, Object Pascal/Delphi, Ruby, PHP, JavaScript e outras possuem frameworks MVC populares que são atualmente usados no desenvolvimentos de aplicações web.

Camada de modelo ou da lógica da aplicação (Model)
Modelo é a ponte entre as camadas Visão (View) e Controle (Controller), consiste na parte lógica da aplicação, que gerencia o comportamento dos dados através de regras de negócios, lógica e funções. Esta fica apenas esperando a chamada das funções,  que permite o acesso para os dados serem coletados, gravados e, exibidos.

É o coração da execução, responsável por tudo que a aplicação vai fazer a partir dos comandos da camada de controle em um ou mais elementos de dados, respondendo a perguntas sobre o sua condição e a instruções para mudá-las. O modelo sabe o que o aplicativo quer fazer e é a principal estrutura computacional da arquitetura, pois é ele quem modela o problema que está se tentando resolver. Modela os dados e o comportamento por trás do processo de negócios. Se preocupa apenas com o armazenamento, manipulação e geração de dados. É um encapsulamento de dados e de comportamento independente da apresentação.

Um modelo (model) armazena dados e notifica suas visões e controladores associados quando há uma mudança em seu estado. Estas notificações permitem que as visões produzam saídas atualizadas e que os controladores alterem o conjunto de comandos disponíveis. Uma implementação passiva do MVC monta estas notificações, devido a aplicação não necessitar delas ou a plataforma de software não suportá-las.

# O Controller

 Como mostra nosso Exemplo o Controller irá fazer o Recurso da herança, um controller Base do Core.
Perceba que a Base nos da um método para registrar Modelos a partir do nome do Modelo, isso faz com que o Controller não tenha uma injeção direta do Modelo, ou da clase real.
O Mecanismo por RTTI irá instanciar o Modelo.

Outros recursos podem ser registrados através do Controlller comoo apresenta o exemplo acima, como um ContainnerService para a aplicação.  

  fonte.: https://pt.wikipedia.org/wiki/MVC

# Container de serviços 
  Baseado no modelo Laravel.

O container de serviço Laravel é uma ferramenta poderosa para gerenciar dependências de classes e executar injeção de dependências. A injeção de dependência é uma frase sofisticada que essencialmente significa o seguinte: as dependências da classe são "injetadas" na classe por meio do construtor ou, em alguns casos, dos métodos "setter".
Sua finalidade é fazer com que o controller possa recuperar dados em Containners de Serviços providos conectados a um Modelo de negócio.
Podemos ter Containnners de serviços personalizados para diferentes ocasiões.

Mais sobre os services Containners.
https://laravel.com/docs/8.x/container

```Delphi
procedure TOficinaModel.AfterConstruction;
begin
 RegisterContainnerServices:= [ 'OficinaServicecontainner' ];
end;

```

Recuperando um Containenr de serviços atraves do model, utilizando a Chamada do Méthodo Execute<T>.

```Delphi
   Execute<Variant>('OficinaDAODataset','GetAll', [ ContainnerServices<TDataset>('OficinaServicecontainner') ])
```
O Método ContainnerServices<T>, recupera um Containner de serviços registrados pelo Model , o containner de serviços pode herdar e ter especializações e regras de negócios proprias, removendo do Model toda a regra de negócio. Podemos ter varios containners services para cada Situação que assim exigir.

```Delphi
ContainnerServices<TDataset>('OficinaServicecontainner')
```


# Drivermanager
 Seguindo o modelo ja conhecido do Java e outras tecnologias , assim como Laravel, o framework irá te entregar uma unidade chamada [  DataBase.Config  ]
 crie uma Variável que representará o tipo da tecnologia e dentro do Array, com uma simples anotação separada por ' : ' especifique as propriedades necessárias para configurar os drivers de conexão.

Abaixo de implementation , crie as variáveis que representam os tipos da tecnologia.
```Delphi
implementation
   var LocalDatabase   : FirebirdDriverConfig;
      WebServiceTeste : RestClientAPIConfig;
```
Utilize a sessão Initialize para montar as strings e adicionar a lista de configurações.

```Delphi
Initialization
   LocalDatabase:= [
      'DatabaseName: BancoTeste',
      'Host: 127.0.0.1',
      'Port:3050',
      'CharSet:win1252'
      ];

  WebServiceTeste:= [
      'Host: 1270.0.0.1',
      'BaseURL:www.google.com.br',
      'TokenAPI:AFSDFADFADFBBgngn5n46gn4d65b41d65b1zd6n5d6n546',
      'Port:8089',
      'ContentType:application/json',
      'Accept-Charset: utf-8, iso-8859-1;q=0.5',
      'Accept-Encoding: gzip, compress, br'
    ];
  AddConnections('LocalDatabase',LocalDatabase);
  AddConnections('WebServiceTeste',WebServiceTeste);
```
Utilize a unidade [ DataBase.Config.Types ], a função  " function DriverManager(Key: String):TStringArrayConfigs; " para recuperar uma configurações e o tipo dela.
```Delphi
 function DriverManager(Key: String):TStringArrayConfigs;
begin
 Assert(Connections.ContainsKey(Key),format('Não existe uma configuração na lista de nome %s',[Key]));
 result:= Connections.Items[Key];
 end;

```



    




         

{ ****************************************************************************
  Configure As Conex�es de acordo com os Tipos cedidos pela aplica��o
  Para Servi�os em WEB .:

  Acima de implementation crie Variaveis que v�o representar suas conex�es
  a serem adicionadas na lista
  var LocalDatabase :   FirebirdDriver;
      WebServiceLeopard: RestClientAPI;

      Abaixo de implementation entre as tags Initialization e Finalization,
      escreva a conex�o passando Nome da propriedade : Valor.



 Initialization
 LocalDatabase:= [
      'DatabaseName: ',
      'Host: 127.0.0.1'
      ];

  WebServiceTeste:= [
      'Host: ',
      'ServiceName: ',
      'TokenAPI: ',
      'Port: '
    ];
  AddConnections('LocalDatabase',LocalDatabase[0]);
  AddConnections('WebServiceLeopard',WebServiceLeopard[0]);
 finalization


*****************************************************************************}


unit DataBase.Config;

interface
 uses System.classes,System.SysUtils, DataBase.Config.Types;

  var LocalDatabase   : FirebirdDriverConfig;
      WebServiceTeste : RestClientAPIConfig;

implementation

 Initialization
 LocalDatabase:= [
      '{"DatabaseName": ',
      '"Host": "127.0.0.1"}'
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
 finalization

end.

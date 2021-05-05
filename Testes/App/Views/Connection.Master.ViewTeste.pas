unit Connection.Master.ViewTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,JSon, Routers.Methods,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Authenticator.OAuth, Dao.RestClient, DataBase.Config.Types, Data.DB,
  Datasnap.DBClient;

type
  TForm24 = class(TForm)
    mmo1: TMemo;
    btn4: TButton;
    btn5: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    OAuth1Authenticator1: TOAuth1Authenticator;
    Button1: TButton;
    ClientDataSet1: TClientDataSet;
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OnFoundDataBase( Obj: TJSONObject );
    procedure AfterConstruction; override;
  end;

var
  Form24: TForm24;

implementation
{$R *.dfm}

procedure TForm24.AfterConstruction;
begin
  inherited;

end;

procedure TForm24.btn4Click(Sender: TObject);
begin
  Group('Oficina Zezinhos Informatica Ltda.ME','Falar com a Oficina',[]);
  Group('Oficina Zezinhos Informatica Ltda.ME','Lista de serviços da oficina do zezinho',[]);
end;

procedure TForm24.btn5Click(Sender: TObject);
begin
// RoutersController.FreeRoute('/Clientes');
end;

procedure TForm24.Button1Click(Sender: TObject);
begin
// TDaoRestClient
//  .Create
//  .ClientConfig( GetConfig('WebServiceTeste') );
end;

procedure TForm24.OnFoundDataBase(Obj: TJSONObject);
begin
 mmo1.Lines.Clear;
 mmo1.Lines.Add( Obj.Format );
end;

 initialization
 RegisterClassAlias(TForm24,'/Clientes.View');
 Finalization
 UnRegisterClass( TForm24 );
end.

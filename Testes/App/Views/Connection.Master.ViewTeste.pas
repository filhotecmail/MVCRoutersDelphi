unit Connection.Master.ViewTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,JSon, Routers.Methods;

type
  TForm24 = class(TForm)
    mmo1: TMemo;
    btn4: TButton;
    btn5: TButton;
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
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
  // Irá executar sem Chechar o Middleware
  Group('Clientes','CriaControllerClientes',[]);
  Group('Clientes','Metodnaexcessao',[]);
  // Irá executar verificando o middleware
  Group('Clientes','TesteSubmit',[]);
end;

procedure TForm24.btn5Click(Sender: TObject);
begin
// RoutersController.FreeRoute('/Clientes');
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

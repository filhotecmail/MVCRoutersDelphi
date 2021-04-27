unit Connection.Master.ViewTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,JSon;

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
uses
  Controllers.Routers;
{$R *.dfm}


procedure TForm24.AfterConstruction;
begin
  inherited;

end;

procedure TForm24.btn4Click(Sender: TObject);
begin
 RoutersController.Route('/Clientes','Render',[],True,'New',[],Controller,'Auth');
 RoutersController.Route('/Clientes','Submit',[],'Auth');
end;

procedure TForm24.btn5Click(Sender: TObject);
begin
 RoutersController.FreeRoute('/Clientes');
end;

procedure TForm24.OnFoundDataBase(Obj: TJSONObject);
begin
 mmo1.Lines.Clear;
 mmo1.Lines.Add( Obj.Format );
end;
end.

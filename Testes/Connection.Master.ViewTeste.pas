unit Connection.Master.ViewTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,JSon, Config.DataBase.ObjectConcrete;

type
  TForm24 = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    Edit1: TEdit;
    grp1: TGroupBox;
    EdConectionName: TEdit;
    lbl1: TLabel;
    EdIp: TEdit;
    lbl2: TLabel;
    EdPorta: TEdit;
    lbl3: TLabel;
    btn2: TButton;
    btn3: TButton;
    Edit2: TEdit;
    lbl4: TLabel;
    btn4: TButton;
    btn5: TButton;
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
  private
    { Private declarations }
    FCons: IBuilderCons;
  public
    { Public declarations }
    procedure OnFoundDataBase( Obj: TJSONObject );
    procedure AfterConstruction; override;
  end;

var
  Form24: TForm24;

implementation
uses
  Database.IInterfaces, Controllers.Routers;
{$R *.dfm}
procedure TForm24.AfterConstruction;
begin
  inherited;
 FCons:= TBuilderOcons.New(
  procedure
  ( Arg: TBuilderEvents )
  begin
   Arg.OnFoundDatabase     := OnFoundDataBase;
   Arg.AfterAppendDatabase := OnFoundDataBase;
  end);
end;

procedure TForm24.btn1Click(Sender: TObject);
begin
 FCons.GetCons(Edit1.Text);
end;

procedure TForm24.btn2Click(Sender: TObject);
begin
 FCons
  .Add(EdConectionName.Text,
 procedure
 ( AProps: TConnectionProps )
 begin
  AProps.IpAddress:= EdIp.text;
  AProps.Port     := strtoint(EdPorta.Text);
 end);
end;

procedure TForm24.btn3Click(Sender: TObject);
begin
 FCons.DeleteConnection(Edit2.Text);
end;

procedure TForm24.btn4Click(Sender: TObject);
begin
 RoutersController.Route('/Clientes','Render',[],True,'New',[],Controller);
 RoutersController.Route('/Clientes','Submit',[]);
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

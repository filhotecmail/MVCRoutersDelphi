unit Clientes.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,Rtti,Json,
  System.Helper, View.Abstract;

type
  TFVisaoCliente = class(TAbstractView)
    btn1: TButton;
    btn2: TButton;
    ds1: TDataSource;
    dbgrd1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure AfterOpen(Obj: TValue); override;
  end;

implementation
{$R *.dfm}
{ TFVisaoCliente }
procedure TFVisaoCliente.AfterConstruction;
begin
  inherited AfterConstruction;

end;

procedure TFVisaoCliente.AfterOpen(Obj: TValue);
begin
  inherited;
  ShowMessage('Notificado pelo Modelo');
end;

procedure TFVisaoCliente.BeforeDestruction;
begin
  inherited BeforeDestruction;

end;
  initialization
  RegisterClassAlias(TFVisaoCliente,'/Oficina.View')
  Finalization
  UnRegisterClass(TFVisaoCliente);
end.

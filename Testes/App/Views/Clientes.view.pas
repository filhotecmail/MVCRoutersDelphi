unit Clientes.view;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,Rtti,Json;

type
  TFVisaoCliente = class(TForm)
    btn1: TButton;
    btn2: TButton;
    ds1: TDataSource;
    dbgrd1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Render(const AParam: Array of TValue);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    
  end;

implementation

uses
  Controllers.Routers;

{$R *.dfm}
{ TFVisaoCliente }
procedure TFVisaoCliente.AfterConstruction;
begin
  inherited;

end;

procedure TFVisaoCliente.BeforeDestruction;
begin
  inherited;

end;

procedure TFVisaoCliente.Render(const AParam: Array of TValue);
begin
 ShowMessage( AParam[0].AsType< TJSONObject>.ToJSON );
 ShowModal;
end;

end.

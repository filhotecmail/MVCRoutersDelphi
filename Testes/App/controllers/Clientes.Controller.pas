unit Clientes.Controller;

interface
  uses System.classes,Controller.IInterfaces, Vcl.Dialogs, Controller.ConcreteObj;

  type TClientesController = class(TControllerBase)
  private

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure OnClick( Sender:  TObject );
    class function New:TClientesController;
  end;

implementation
{ TClientesController }
procedure TClientesController.AfterConstruction;
begin
  inherited;

end;

procedure TClientesController.BeforeDestruction;
begin
  inherited;
  // RoutersController.FreeRoute('/ClientesView');
end;

class function TClientesController.New: TClientesController;
begin
 Result := TClientesController.Create;
end;

procedure TClientesController.OnClick(Sender: TObject);
begin

end;

 initialization
 RegisterClassAlias(TClientesController,'/ClientesController');
 Finalization
 UnRegisterClass( TClientesController );

end.

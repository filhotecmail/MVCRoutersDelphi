unit Clientes.Controller;

interface
  uses System.classes,Controller.IInterfaces, Vcl.Dialogs, Controller.ConcreteObj;

  type TClientesController = class(TControllerBase)
  private

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure Submit;
    procedure MethodSemAuh;
    procedure OnClick( Sender:  TObject );
    class function New:TClientesController;
  end;

implementation
{ TClientesController }
procedure TClientesController.AfterConstruction;
begin
  inherited;
  ShowMessage('Controller Criado');
end;

procedure TClientesController.BeforeDestruction;
begin
  inherited;
  // RoutersController.FreeRoute('/ClientesView');
end;

procedure TClientesController.MethodSemAuh;
begin
 ShowMessage('Chamou MethodSemAuh do controller em exceção a regra de excessoes');
end;

class function TClientesController.New: TClientesController;
begin
 Result := TClientesController.Create;
end;

procedure TClientesController.OnClick(Sender: TObject);
begin

end;

procedure TClientesController.Submit;
begin
 ShowMessage('Chamou Submit do controller criado');
end;

initialization
 RegisterClassAlias(TClientesController,'/ClientesController');
Finalization
 UnRegisterClass( TClientesController );

end.

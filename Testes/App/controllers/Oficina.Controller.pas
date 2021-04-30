unit Oficina.Controller;

interface
  uses System.classes,Controller.IInterfaces, Vcl.Dialogs, Controller.ConcreteObj,Rtti;

  type TOficinaInformatica = class(TControllerBase)
  private

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function AssistenciaComputadores: TValue;
    function Venda: TValue;
    function Reballing: TValue;
    function ConsertoNotebooks: TValue;
    function ConsertoLCD: TValue;
    function ConsertoLED: TValue;
    function impressoras: TValue;
    function impressorasFiscais: TValue;
    function ManutencaoCelulares: TValue;
    function Eletronica: TValue;
    function WatsApp: TValue;
    function Email: TValue;

    procedure OnClick( Sender:  TObject );
    class function New:TOficinaInformatica;
  end;

implementation
{ TOficinaInformatica }
procedure TOficinaInformatica.AfterConstruction;
begin
  inherited;
  ShowMessage('Controller Criado');
end;

function TOficinaInformatica.AssistenciaComputadores: TValue;
begin

end;

procedure TOficinaInformatica.BeforeDestruction;
begin
  inherited;
  // RoutersController.FreeRoute('/ClientesView');
end;


function TOficinaInformatica.ConsertoLCD: TValue;
begin

end;

function TOficinaInformatica.ConsertoLED: TValue;
begin

end;

function TOficinaInformatica.ConsertoNotebooks: TValue;
begin

end;

function TOficinaInformatica.Eletronica: TValue;
begin

end;

function TOficinaInformatica.Email: TValue;
begin

end;

function TOficinaInformatica.impressoras: TValue;
begin

end;

function TOficinaInformatica.impressorasFiscais: TValue;
begin

end;

function TOficinaInformatica.ManutencaoCelulares: TValue;
begin

end;

class function TOficinaInformatica.New: TOficinaInformatica;
begin
 Result := TOficinaInformatica.Create;
end;

procedure TOficinaInformatica.OnClick(Sender: TObject);
begin

end;


function TOficinaInformatica.Reballing: TValue;
begin

end;

function TOficinaInformatica.Venda: TValue;
begin

end;

function TOficinaInformatica.WatsApp: TValue;
begin

end;

initialization
 RegisterClassAlias(TOficinaInformatica,'/OficinaInformatica');
Finalization
 UnRegisterClass( TOficinaInformatica );

end.

unit Controller.ConcreteObj;

interface
  uses System.classes,Controller.IInterfaces,Rtti;

type TParamsValues_ = Array of TValue;
type TControllerBase = Class Abstract(TInterfacedPersistent,IController)

  public
    procedure AfterConstruction; override;
    function Render( Const AViewName: String ):TValue; virtual;
    function Get(const AValues: TParamsValues_ = nil):TValue; virtual;

  End;

implementation
 { TControllerBase }

procedure TControllerBase.AfterConstruction;
begin
  inherited;

end;

function TControllerBase.Get(const AValues: TParamsValues_): TValue;
begin

end;

function TControllerBase.Render(const AViewName: String): TValue;
begin

end;

end.

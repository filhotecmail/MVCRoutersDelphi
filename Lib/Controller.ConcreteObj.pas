unit Controller.ConcreteObj;

interface
  uses System.classes,Controller.IInterfaces;

type TControllerBase = Class(TInterfacedPersistent,IController)

  public
    procedure AfterConstruction; override;

  End;

implementation
 { TControllerBase }

procedure TControllerBase.AfterConstruction;
begin
  inherited;

end;

end.

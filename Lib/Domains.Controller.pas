unit Domains.Controller;

interface
  Uses System.SysUtils,System.Classes,System.Generics.Collections,Database.IInterfaces;

  type TControllerBase = Class(TInterfacedPersistent,IDomainController)

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

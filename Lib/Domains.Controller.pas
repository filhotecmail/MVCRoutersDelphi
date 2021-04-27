unit Domains.Controller;

interface
  Uses System.SysUtils,System.Classes,System.Generics.Collections;

  type IDomainController = interface
    ['{210C5CC7-8DEE-4C55-B17E-E0D10229A187}']

  end;

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

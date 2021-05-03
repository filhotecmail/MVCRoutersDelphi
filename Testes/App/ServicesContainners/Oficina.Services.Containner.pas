unit Oficina.Services.Containner;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Services.Containner.ObjConcrete;

  type TOficinaServicesContainner = class(TContainnerServices)
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function New:TOficinaServicesContainner;
  end;

implementation


 { TOficinaServicesContainner }

procedure TOficinaServicesContainner.AfterConstruction;
begin
  inherited;

end;

procedure TOficinaServicesContainner.BeforeDestruction;
begin
  inherited;

end;

class function TOficinaServicesContainner.New: TOficinaServicesContainner;
begin
 Result:= TOficinaServicesContainner.Create;
end;

initialization
 RegisterClassAlias(TOficinaServicesContainner,'OficinaServicecontainner');
 Finalization
 UnRegisterClass(TOficinaServicesContainner);

end.

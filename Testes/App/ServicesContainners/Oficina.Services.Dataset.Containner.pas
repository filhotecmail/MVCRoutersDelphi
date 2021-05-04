unit Oficina.Services.Dataset.Containner;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Services.Containner.ObjConcrete, System.RTTI;

  type TOficinaServicesContainner = class(TContainnerServices)
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Get(Arg: TArray<TValue>): Variant;
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

function TOficinaServicesContainner.Get(Arg: TArray<TValue>): Variant;
begin
 //Result :=  Executemethod<String>('GetAll',[]);
end;

initialization
 RegisterClassAlias(TOficinaServicesContainner,'OficinaServicecontainner');
 Finalization
 UnRegisterClass(TOficinaServicesContainner);

end.

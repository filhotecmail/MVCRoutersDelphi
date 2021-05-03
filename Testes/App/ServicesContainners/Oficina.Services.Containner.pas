unit Oficina.Services.Containner;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Services.Containner.ObjConcrete, System.RTTI,Vcl.Dialogs;

  type TOficinaServicesContainner = class(TContainnerServices)
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Get(Arg: TArray<TValue>): Variant;
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

function TOficinaServicesContainner.Get(Arg: TArray<TValue>): Variant;
begin
 Result := Executemethod<String>('GetAll',[]);
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

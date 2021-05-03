unit Oficina.Provider.Service;

interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,
  Provider.Service.IInterfaces, Provider.Service.ObjConcrete;

  type TOficinaProviderService = class(TServiceProvider)
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function New:TOficinaProviderService;
  end;

implementation


 { TOficinaProviderService }

procedure TOficinaProviderService.AfterConstruction;
begin
  inherited;

end;

procedure TOficinaProviderService.BeforeDestruction;
begin
  inherited;

end;

class function TOficinaProviderService.New: TOficinaProviderService;
begin
 Result:= TOficinaProviderService.Create;
end;

initialization
 RegisterClassAlias(TOficinaProviderService,'OficinaServiceprovider');
 Finalization
 UnRegisterClass(TOficinaProviderService);

end.

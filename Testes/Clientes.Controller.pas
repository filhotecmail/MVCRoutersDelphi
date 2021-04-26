unit Clientes.Controller;

interface
  uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,Rtti,
  System.Generics.Collections,System.Generics.Defaults, Json,Vcl.Forms,Database.IInterfaces, Domains.Controller,
  Vcl.Dialogs;

  type TClientesController = class(TControllerBase)
  private
   FValues: TJSONObject;
   FCallObj: Array of TValue;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure OnClick( Sender:  TObject );
    procedure Render;
    procedure Submit;
    class function New:TClientesController;
  end;

implementation
uses Controllers.Routers;
{ TClientesController }
procedure TClientesController.AfterConstruction;
begin
  inherited;
  FValues:= TJSONObject.Create;
  FValues.AddPair( TJSONPair.Create('Data', TJSONString.Create('Teste de cadastro')));
  Insert(FValues,FCallObj,Length(FCallObj)+1);
end;

procedure TClientesController.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FValues );
  RoutersController.FreeRoute('/ClientesView');
end;

class function TClientesController.New: TClientesController;
begin
 Result := TClientesController.Create;
end;

procedure TClientesController.OnClick(Sender: TObject);
begin

end;

procedure TClientesController.Render;
begin
 ShowMessage('Teste');
 RoutersController.Route('/ClientesView','Render',FCallObj,True,'Create',[nil],View);
end;

procedure TClientesController.Submit;
begin
 ShowMessage('Submit');
end;

end.

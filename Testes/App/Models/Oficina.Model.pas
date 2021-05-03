unit Oficina.Model;

interface

uses Model.IInterfaces, Model.ObjectConcrete,System.SysUtils,System.Generics.Defaults,Rtti,
     System.Classes,vcl.Dialogs;

  Type
     TOficinaModel = Class(TModelAbstract)
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  published
    function Get(AParams: System.TArray<TValue>): TValue; override;

 End;

implementation

{ TOficinaModel }

procedure TOficinaModel.AfterConstruction;
begin
  inherited AfterConstruction;

 with propriedades do
 begin
  TableName := 'CADCLIENTES';
  PrimaryKey:= 'ID';
  Generator:= 'GEN_CADCLIENTES_ID';
  Fillable := ['ID','NOME'];
 end;

end;

procedure TOficinaModel.BeforeDestruction;
begin
  inherited;

end;

function TOficinaModel.Get(AParams: System.TArray<TValue>): TValue;
begin
 Result := Self;
end;

 Initialization
  RegisterClassAlias(TOficinaModel,'Oficina');
 Finalization
  UnRegisterClass(TOficinaModel);
end.

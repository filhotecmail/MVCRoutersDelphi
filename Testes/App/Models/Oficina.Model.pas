unit Oficina.Model;

interface

uses Model.IInterfaces, Model.ObjectConcrete,System.SysUtils,System.Generics.Defaults,Rtti,
     System.Classes,vcl.Dialogs;

  Type
     TOficinaModel = Class(TModelAbstract)
  private
    FAOWner:TObject;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TObject; AObserverClass: TClass); override;
    function GetAll: Variant; override;
  published
    function Get(AParams: System.TArray<TValue>): Variant; override;
    function Getstr(AParams: String): TValue;
 End;

implementation

{ TOficinaModel }

procedure TOficinaModel.AfterConstruction;
begin
  inherited AfterConstruction;

 with propriedades do
 begin
  SetConnection:= 'Firebird';
  TableName := 'CADCLIENTES';
  PrimaryKey:= 'ID';
  Generator:= 'GEN_CADCLIENTES_ID';
  Fillable := ['ID','NOME'];
  FriendName:= [ 'Id','Nome ou raz�o social do cliente' ];
 end;

end;

procedure TOficinaModel.BeforeDestruction;
begin
  inherited;

end;

constructor TOficinaModel.Create(AOwner: TObject; AObserverClass: TClass);
begin
  inherited Create(AOwner,AObserverClass);
  FAOWner := AOwner;
end;

function TOficinaModel.Getstr(AParams: String): TValue;
begin
 Result := '{"Data":"Teste"}';
end;

function TOficinaModel.Get(AParams: System.TArray<TValue>): Variant;
begin
 Result := '{"Data":"Teste"}';
 {Verificar na lista de Containners de servi�os se existe algum containner registrado para esse model
  se existir o sistema ir� enviar o resultado para o Containner de servi�os }
end;

 function TOficinaModel.GetAll: Variant;
begin
 Result := '{"Data":"Teste do getAll do Modelo"}';
end;

Initialization
  RegisterClassAlias(TOficinaModel,'Oficina');
 Finalization
  UnRegisterClass(TOficinaModel);
end.

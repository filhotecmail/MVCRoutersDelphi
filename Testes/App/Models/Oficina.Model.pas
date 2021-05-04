unit Oficina.Model;

interface

uses Model.IInterfaces, Model.ObjectConcrete,System.SysUtils,System.Generics.Defaults,Rtti,
     System.Classes,Vcl.Dialogs,Data.DB;

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
 with Properties do
 begin
  TableName := 'CADCLIENTES';
  PrimaryKey:= 'ID';
  Generator := 'GEN_CADCLIENTES_ID';
  Fillable  := ['ID','NOME'];
  FriendName:= [ 'Id','Nome ou razão social do cliente' ];
 end;

 RegisterDAO:= [  'DaoOficinAmazonWs: OficinaDAOSrvHttp',
                  'DAOOficinaDataset: OficinaDAODataset' ];
 RegisterContainnerServices:= [ 'ContainnerServicosDataset:OficinaServicecontainner' ];

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
 {Verificar na lista de Containners de serviços se existe algum containner registrado para esse model
  se existir o sistema irá enviar o resultado para o Containner de serviços }
end;

function TOficinaModel.GetAll: Variant;
begin
 // Vai entrar o Business Core Baseado em TDataset
 {
   O Model Delega aum Serviço a sua responsabilidade de manipular os Objetos
   que serão alimentados pelo DAO.
   O Dao recebeu uma especialização do Tipo IDaoDataset
 }
 Result := Execute<Variant>('OficinaDAODataset','GetCars',[ ContainnerServices<TDataset>('OficinaServicecontainner') ]);
 ShowMessage( Result );
end;

 Initialization
 RegisterClassAlias(TOficinaModel,'Oficina');
 Finalization
 UnRegisterClass(TOficinaModel);
end.

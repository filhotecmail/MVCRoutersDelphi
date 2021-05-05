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
  RequiredFields:= ['ID'];
  SizeFields:= [0,60];
  FriendName:= [ 'Id','Nome ou razão social do cliente' ];
  FieldTypes:= [ ftInteger,ftString ];
 end;

 RegisterDAO:= ['OficinaDAOSrvHttp',
                'OficinaDAODataset' ];

 RegisterContainnerServices:= [ 'OficinaServicecontainner' ];
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

end;

function TOficinaModel.Get(AParams: System.TArray<TValue>): Variant;
begin


end;

function TOficinaModel.GetAll: Variant;
begin
 {O Model Delega aum Serviço a sua responsabilidade de manipular os Objetos
   que serão alimentados pelo DAO.O Dao recebeu uma especialização do Tipo IDaoDataset}
 Result := Execute<Variant>('OficinaDAODataset','GetAll',
           [ ContainnerServices<TDataset>('OficinaServicecontainner') ]);
 ShowMessage( Result );
end;

 Initialization
 RegisterClassAlias(TOficinaModel,'Oficina');
 Finalization
 UnRegisterClass(TOficinaModel);
end.

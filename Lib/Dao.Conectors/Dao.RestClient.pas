unit Dao.RestClient;

interface
 uses  System.classes,System.SysUtils,System.VarUtils,System.Generics.Collections,
       System.Generics.Defaults,System.Rtti,REST.Types, REST.Client,
       Data.Bind.Components, Data.Bind.ObjectScope,REST.Authenticator.OAuth,
  DataBase.Config, DataBase.Config.Types, Commom.Utils, Dao.Base,
  Dao.IInterfaces;

 type TRequestCallBack = reference to procedure( Req: TRESTRequest );
 type TResponseCallBack = reference to procedure( Res: TRESTResponse );

  Type IDaoRestClient = Interface
    ['{D2A488BE-0026-43EA-ADED-DEA969FD23CE}']
     function ClientConfig( AConfigServiceType: RestClientAPIConfig ):IDaoRestClient;
     function Execute( ACallBack: TProc<TRequestCallBack,TResponseCallBack> ):IDaoRestClient;
  End;

 type
   TDaoRestClient = class Abstract( TDaoBase, IDaoRestClient)
    private
     RESTClient: TRESTClient;
     RESTRequest: TRESTRequest;
     RESTResponse: TRESTResponse;
     OAuth2Authenticator: TOAuth2Authenticator;
     OAuth1Authenticator: TOAuth1Authenticator;
     FTRequestCallBack: TRequestCallBack;
     FTResponseCallBack: TResponseCallBack;
   public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Execute( ACallBack: TProc<TRequestCallBack,TResponseCallBack> ):IDaoRestClient;
    function ClientConfig( AConfigServiceType: RestClientAPIConfig ):IDaoRestClient;

    function GetData(const ASql: string;
      APArams: System.TArray<System.Variant>): IDao; override;
    function SetData: IDao; override;
    function Cancel: IDao; override;
    function Post: IDao; override;
    function Edit: IDao; override;
    function Delete(const ID: Variant): IDao; override;
  end;

implementation
{ TDaoRestClient }

procedure TDaoRestClient.AfterConstruction;
begin
  inherited;
  RESTClient := TRESTClient.Create(nil);
end;

procedure TDaoRestClient.BeforeDestruction;
begin
  inherited;
  FreeAndNil(RESTClient);
end;

function TDaoRestClient.Cancel: IDao;
begin

end;

function TDaoRestClient.ClientConfig(
  AConfigServiceType: RestClientAPIConfig): IDaoRestClient;
begin
 Result := Self;
 with RESTClient do
 begin
  BaseURL       := PatchConfig(AConfigServiceType,'BaseURL');
  ContentType   := PatchConfig(AConfigServiceType,'ContentType');
  AcceptCharset := PatchConfig(AConfigServiceType,'Accept-Charset');
  AcceptEncoding:= PatchConfig(AConfigServiceType,'Accept-Encoding');
 end;
end;

function TDaoRestClient.Delete(const ID: Variant): IDao;
begin

end;

function TDaoRestClient.Edit: IDao;
begin

end;

function TDaoRestClient.Execute(
  ACallBack: TProc<TRequestCallBack, TResponseCallBack>): IDaoRestClient;
begin
 if Assigned(ACallBack) then
   ACallBack(FTRequestCallBack,FTResponseCallBack);

end;

function TDaoRestClient.GetData(const ASql: string;
  APArams: System.TArray<System.Variant>): IDao;
begin

end;

function TDaoRestClient.Post: IDao;
begin

end;

function TDaoRestClient.SetData: IDao;
begin

end;

end.

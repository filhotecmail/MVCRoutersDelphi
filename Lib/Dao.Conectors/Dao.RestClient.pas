unit Dao.RestClient;

interface
 uses  System.classes,System.SysUtils,System.VarUtils,System.Generics.Collections,
       System.Generics.Defaults,System.Rtti,REST.Types, REST.Client,
       Data.Bind.Components, Data.Bind.ObjectScope,REST.Authenticator.OAuth,
  DataBase.Config, DataBase.Config.Types, Commom.Utils, Dao.Base,
  Dao.IInterfaces;



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

    function SetData: IDaoBase; override;
    function Cancel: IDaoBase; override;
    function Post: IDaoBase; override;
    function Edit: IDaoBase; override;
    function Delete(const ID: Variant): IDaoBase; override;
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



function TDaoRestClient.Cancel: IDaoBase;
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

function TDaoRestClient.Delete(const ID: Variant): IDaoBase;
begin

end;

function TDaoRestClient.Edit: IDaoBase;
begin

end;

function TDaoRestClient.Execute(
  ACallBack: TProc<TRequestCallBack, TResponseCallBack>): IDaoRestClient;
begin
 if Assigned(ACallBack) then
   ACallBack(FTRequestCallBack,FTResponseCallBack);

end;


function TDaoRestClient.Post: IDaoBase;
begin

end;

function TDaoRestClient.SetData: IDaoBase;
begin

end;

end.

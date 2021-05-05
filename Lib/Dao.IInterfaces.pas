unit Dao.IInterfaces;

interface
  Uses System.Classes,System.Variants,Data.Db,System.Generics.Defaults,System.SysUtils,
  System.Generics.Collections,REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope,REST.Authenticator.OAuth, DataBase.Config.Types;

 Type IDaoBase = interface
   ['{BF76C01D-761F-4443-B7CC-68BD020214C8}']

 end;

 Type IDaoDataset = Interface(IDaoBase)
     ['{86E8C5C6-AE2D-4592-82E6-C067C131D5A9}']
      function GetData(Const ASql:String; APArams: Tarray<Variant>; var ADataset: TDataset): IDaoDataset; overload;
 End;

 type TRequestCallBack = reference to procedure( Req: TRESTRequest );
 type TResponseCallBack = reference to procedure( Res: TRESTResponse );

  Type IDaoRestClient = Interface(IDaoBase)
    ['{D2A488BE-0026-43EA-ADED-DEA969FD23CE}']
     function ClientConfig( AConfigServiceType: RestClientAPIConfig ):IDaoRestClient;
     function Execute( ACallBack: TProc<TRequestCallBack,TResponseCallBack> ):IDaoRestClient;
  End;

implementation

end.

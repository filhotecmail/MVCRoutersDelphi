unit Database.IInterfaces;

interface
 uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,Rtti,
  System.Generics.Collections,System.Generics.Defaults, Json, Connection.Master.IInterface,Vcl.Forms;

 type TDomainObjResponse = class
  private
    FDataset: TDataset;
    FMsgCode: Word;
    FMsgStr: String;
    FJsonObject: TJSONObject;
    procedure SetDataset(const Value: TDataset);
    procedure SetJsonObject(const Value: TJSONObject);
    procedure SetMsgCode(const Value: Word);
    procedure SetMsgStr(const Value: String);
  published
       property Dataset: TDataset read FDataset write SetDataset;
       property JsonObject: TJSONObject read FJsonObject write SetJsonObject;
       property MsgCode: Word read FMsgCode write SetMsgCode;
       property MsgStr: String read FMsgStr write SetMsgStr;
 end;

 type TDomainObjRequisition = class
  private
    FDataset: TDataset;
    FMsgCode: Word;
    FMsgStr: String;
    FJsonObject: TJSONObject;
    procedure SetDataset(const Value: TDataset);
    procedure SetJsonObject(const Value: TJSONObject);
    procedure SetMsgCode(const Value: Word);
    procedure SetMsgStr(const Value: String);
  published
       property Dataset: TDataset read FDataset write SetDataset;
       property JsonObject: TJSONObject read FJsonObject write SetJsonObject;
       property MsgCode: Word read FMsgCode write SetMsgCode;
       property MsgStr: String read FMsgStr write SetMsgStr;
 end;
 type TDomainCallBack = reference to procedure( ARequisition: TDomainObjRequisition = nil; AResponse: TDomainObjRequisition = nil );

  type IDomainModel = Interface
      ['{D998FB93-18DB-4BD0-B279-E734CB296E15}']

  End;

  {$REGION 'Dominio da entidade'}
   { Representa a Entidade do Banco de dados }
  type
     IDomainEntity = Interface
     ['{ECBFDE8B-1828-4704-A21F-16FDC783B4E0}']

  End;
   {$ENDREGION}

  Type IDomainController = Interface
    ['{B78E42AD-D37B-43FC-B3C9-688CE4F89720}']

  End;



  type TControllersView = class(TForm)

  end;

implementation

{ TDomainObjResponse }

procedure TDomainObjResponse.SetDataset(const Value: TDataset);
begin
  FDataset := Value;
end;

procedure TDomainObjResponse.SetJsonObject(const Value: TJSONObject);
begin
  FJsonObject := Value;
end;

procedure TDomainObjResponse.SetMsgCode(const Value: Word);
begin
  FMsgCode := Value;
end;

procedure TDomainObjResponse.SetMsgStr(const Value: String);
begin
  FMsgStr := Value;
end;

{ TDomainObjRequisition }

procedure TDomainObjRequisition.SetDataset(const Value: TDataset);
begin
  FDataset := Value;
end;

procedure TDomainObjRequisition.SetJsonObject(const Value: TJSONObject);
begin
  FJsonObject := Value;
end;

procedure TDomainObjRequisition.SetMsgCode(const Value: Word);
begin
  FMsgCode := Value;
end;

procedure TDomainObjRequisition.SetMsgStr(const Value: String);
begin
  FMsgStr := Value;
end;

end.

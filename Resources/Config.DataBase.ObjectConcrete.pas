unit Config.DataBase.ObjectConcrete;

 interface
  uses System.Classes,System.SysUtils,System.Generics.Collections,System.Generics.Defaults,Json,Winapi.Windows,
       Vcl.Forms,REST.Json,Vcl.Dialogs;

 {$REGION 'Propriedades do Objeto de conexão'}
  type TConnectionProps = class
  strict private
    FPooled: Boolean;
    FProtocol: Integer;
    FCharSet: String;
    FPort: Integer;
    FIpAddress: String;
    FDataBaseName: String;
    FPassWord: string;
    FUserName: string;
    procedure SetCharSet(const Value: String);
    procedure SetDataBaseName(const Value: String);
    procedure SetIpAddress(const Value: String);
    procedure SetPassWord(const Value: string);
    procedure SetPooled(const Value: Boolean);
    procedure SetPort(const Value: Integer);
    procedure SetProtocol(const Value: Integer);
    procedure SetUserName(const Value: string);
  published
   property IpAddress: String read FIpAddress write SetIpAddress;
   property Port: Integer read FPort write SetPort;
   property DataBaseName: String read FDataBaseName write SetDataBaseName;
   property UserName: string read FUserName write SetUserName;
   property PassWord: string read FPassWord write SetPassWord;
   property Pooled: Boolean read FPooled write SetPooled;
   property Protocol: Integer read FProtocol write SetProtocol;
   property CharSet: String read FCharSet write SetCharSet;
   function ToJsonObject:  TJSONObject;
 end;
 {$ENDREGION}
  {$REGION 'Eventos do Objeto de conexão'}
 Type TOnFoundDatabase= procedure(Obj: TJSONObject) of object;
 Type TOnErrorSearch = procedure( AError: Exception ) of object;
 type TAfterAppendDatabase = procedure( Obj: TJSONObject ) of object;
 type TBuilderEvents = class
  private
    FAfterAppendDatabase: TAfterAppendDatabase;
    FOnErrorSearch: TOnErrorSearch;
    FOnFoundDatabase: TOnFoundDatabase;
    procedure SetAfterAppendDatabase(const Value: TAfterAppendDatabase);
    procedure SetOnErrorSearch(const Value: TOnErrorSearch);
    procedure SetOnFoundDatabase(const Value: TOnFoundDatabase);

  published
   property OnFoundDatabase: TOnFoundDatabase read FOnFoundDatabase write SetOnFoundDatabase;
   property OnErrorSearch:TOnErrorSearch read FOnErrorSearch write SetOnErrorSearch;
   property AfterAppendDatabase:TAfterAppendDatabase read FAfterAppendDatabase write SetAfterAppendDatabase;
 end;
 {$ENDREGION}
 type IBuilderCons = Interface
  ['{FE49C9E0-CD5F-4FA3-84B7-9B45EA220CED}']
   function GetCons( AConnectionName: String = '' ):TJsonObject;
   function Add( AConnetionName: String; AConnectionCalleable: TProc<TConnectionProps> ):IBuilderCons;
   function DeleteConnection(const AConnectionName: String):IBuilderCons;
 End;
 type TBuilderOcons = class(TInterfacedObject, IBuilderCons)
  private
    FFilePatch: String;
    FBuffer: TStringStream;
    FFullFileName: TFileName;
    FJsonObject: TJSONObject;
    FDataBases: TJSONArray;
    FEvents: TBuilderEvents;
    const FFileName = 'database.config.json';
    procedure SaveToFile(const ABuffer: TStringStream; AFileName: String; AContent: String);
    procedure CreateDefaultValue;
    function SetDefaultValues:TConnectionProps;
    function FindElementJsonArray( ASource: TJSONArray; const AElementName: String; CallBack: Tproc<Integer,TJSONObject> ):TJSONObject;
  public
    constructor Create( AEvents: TProc<TBuilderEvents> = nil ); Virtual;
    function Add( AConnetionName: String; AConnectionCalleable: TProc<TConnectionProps>):IBuilderCons;
    function GetCons( AConnectionName: String = '' ):TJsonObject;
    function DeleteConnection(const AConnectionName: String):IBuilderCons;
    class function New( AEvents: TProc<TBuilderEvents> = nil ): IBuilderCons;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
 end;
 implementation

{ TBuilderOcons }
function TBuilderOcons.Add(AConnetionName: String; AConnectionCalleable: TProc<TConnectionProps>): IBuilderCons;
 var FProps:TConnectionProps;
begin
 Result:= Self;
 FProps:= TConnectionProps.Create;
 if Assigned( AConnectionCalleable ) then
    AConnectionCalleable(FProps);
 try
  FDataBases.AddElement( TJSONObject.Create.AddPair(TJSONPair.Create(AConnetionName,
  FProps.ToJsonObject))  as TJSONValue );
  FBuffer.Clear;
  SaveToFile(FBuffer,FFullFileName,FJsonObject.ToJSON);
  if Assigned(FEvents.AfterAppendDatabase) then
       FEvents.AfterAppendDatabase(FJsonObject);
 finally
  FreeAndNil( FProps );
 end;
end;

procedure TBuilderOcons.AfterConstruction;
 var I: Integer; FJsonStr: string; FValue: TJSONValue;
begin
  inherited;
 FBuffer:= TStringStream.Create('', TEncoding.UTF8);
 FFullFileName := ExtractFilePath(Application.ExeName)+FFileName;
 FJsonObject:= TJSONObject.Create;
 FDataBases := TJSONArray.Create;
 if FileExists(FFullFileName) then
 begin
  FBuffer.LoadFromFile( FFullFileName );
  FValue:= FJsonObject.ParseJSONValue( FBuffer.DataString );
  FJsonObject:= FValue.AsType<TJSONObject>;
  FDataBases := FJsonObject.GetValue<TJSONArray>('Databases');
 end else
 begin
  FJsonObject.AddPair( TJSONPair.Create('Databases',FDataBases) );
  CreateDefaultValue;
  SaveToFile(FBuffer,FFullFileName,FJsonObject.ToJSON);
 end;
 GetCons();
end;

procedure TBuilderOcons.BeforeDestruction;
begin
  inherited;
  FreeAndNil( FEvents );
  FreeAndNil( FJsonObject );
  FreeAndNil( FBuffer );
end;

constructor TBuilderOcons.Create(AEvents: TProc<TBuilderEvents> = nil);
begin
 FEvents:= TBuilderEvents.Create;
 if Assigned(AEvents) then
    AEvents( FEvents );
end;

procedure TBuilderOcons.CreateDefaultValue;
 var FValue: TJSONObject;
begin
 FValue := TJSONObject.Create.AddPair( TJSONPair.Create('Default', SetDefaultValues.ToJsonObject));
 FDataBases.AddElement( FValue as TJSONValue );
end;

function TBuilderOcons.DeleteConnection(const AConnectionName: String): IBuilderCons;
begin
 Result := Self;
 FindElementJsonArray( FJsonObject.GetValue<TJSONArray>('Databases'),AConnectionName,
  procedure
  ( Iterator: Integer; Obj: TJSONObject )
    begin
     FJsonObject.GetValue<TJSONArray>('Databases').Remove(Iterator);
     SaveToFile(FBuffer,FFullFileName,FJsonObject.ToJSON);
    end);
  GetCons();
end;

function TBuilderOcons.FindElementJsonArray(ASource: TJSONArray; const AElementName: String;
  CallBack: Tproc<Integer, TJSONObject>): TJSONObject;
 var FPair: TJSONValue;
     FoundValue: TJSONValue;
     I: Integer;
begin
 Assert( not Trim(AElementName).IsNullOrEmpty(AElementName),'O Nome do elemento não pode ser vazio!' );
 Assert( ASource <> nil,'Elemento JsonArry não pode ser nil' );
 I:= -1;
 if not Trim(AElementName).IsNullOrEmpty(AElementName) then
   for FPair in ASource do
   begin
   Inc(I);
   FoundValue:= FPair.FindValue(AElementName);
    if FoundValue <> nil then
    begin
     if Assigned(CallBack) then
        CallBack(I,Result);
     Result := FoundValue.AsType<TJSONObject>;
    end;
  end;
end;

function TBuilderOcons.GetCons(AConnectionName: String = ''): TJsonObject;
 var FValue: TJSONValue;
     FArray: TJSONArray;
     FPair: TJSONValue;
     FoundValue: TJSONValue;
begin
 Result := FJsonObject;
 FArray:= Result.GetValue<TJSONArray>('Databases');
 if Trim( AConnectionName ).IsNullOrEmpty(AConnectionName) then
 begin
  Result := FJsonObject;
  if Assigned(FEvents.OnFoundDatabase) then
     FEvents.OnFoundDatabase(Result);
 end
  else
 try
  FindElementJsonArray( FArray,AConnectionName,
  procedure
  ( Iterator: Integer; Obj: TJSONObject )
    begin
      if Assigned(FEvents.OnFoundDatabase) then
        FEvents.OnFoundDatabase( FArray.Items[Iterator].AsType<TJSONObject> );
    end);
 Except
  on E: Exception do
   if Assigned(FEvents.OnErrorSearch) then
       FEvents.OnErrorSearch(E);
 end;
end;

 class function TBuilderOcons.New(AEvents: TProc<TBuilderEvents> = nil): IBuilderCons;
begin
 Result := TBuilderOcons.create(AEvents);
end;

procedure TBuilderOcons.SaveToFile(const ABuffer: TStringStream; AFileName: String; AContent: String);
begin
 ABuffer.Clear;
 ABuffer.WriteString(AContent);
 ABuffer.SaveToFile( AFileName );
end;

function TBuilderOcons.SetDefaultValues: TConnectionProps;
begin
 Result := TConnectionProps.Create;
 Result.Pooled := False;
 Result.Protocol:= 0;
 Result.CharSet:='none';
 Result.DataBaseName := 'teste.db';
 Result.UserName := 'sysdba';
 Result.PassWord := '1234';
end;

{ TConnectionProps }

procedure TConnectionProps.SetCharSet(const Value: String);
begin
  FCharSet := Value;
end;

procedure TConnectionProps.SetDataBaseName(const Value: String);
begin
  FDataBaseName := Value;
end;

procedure TConnectionProps.SetIpAddress(const Value: String);
begin
  FIpAddress := Value;
end;

procedure TConnectionProps.SetPassWord(const Value: string);
begin
  FPassWord := Value;
end;

procedure TConnectionProps.SetPooled(const Value: Boolean);
begin
  FPooled := Value;
end;

procedure TConnectionProps.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

procedure TConnectionProps.SetProtocol(const Value: Integer);
begin
  FProtocol := Value;
end;

procedure TConnectionProps.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

function TConnectionProps.ToJsonObject: TJSONObject;
begin
 Result := TJson.ObjectToJsonObject(Self)
end;

procedure TBuilderEvents.SetAfterAppendDatabase(const Value: TAfterAppendDatabase);
begin
  FAfterAppendDatabase := Value;
end;

procedure TBuilderEvents.SetOnErrorSearch(const Value: TOnErrorSearch);
begin
  FOnErrorSearch := Value;
end;

procedure TBuilderEvents.SetOnFoundDatabase(const Value: TOnFoundDatabase);
begin
  FOnFoundDatabase := Value;
end;

 Initialization

 Finalization
 ReportMemoryLeaksOnShutdown := DebugHook <> 0;
end.

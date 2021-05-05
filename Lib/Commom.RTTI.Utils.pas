unit Commom.RTTI.Utils;

interface
 uses System.Classes,System.SysUtils,System.VarUtils,
      System.Generics.Collections,System.Generics.Defaults,System.Types,System.Rtti;

 type TArrayOfParams = Array of TValue;
 type TFieldLibRtti = TRttiField;
 type TInstanceLibRtti = TRttiInstanceType;

 type
     TLib = class
  public
    class function CreateFromRTTI(AClassName: String; AParamsConstructor: Array of TValue; ACallBack: Tproc<TObject>): TObject; overload;
    class function CreateFromRTTI(AClassesNames: TArray<String>; ParamsConstructor: TArray<TArrayOfParams>; ADictionaryDest:  TDictionary<String,TObject>): TObject; overload;
    class function CreateFromRTTI(AClassesNames: TArray<String>; ParamsConstructor: TArray<TArrayOfParams>; ADictionaryDest:  TDictionary<String,TObject>; AcallBack: TProc<TObject>): TObject; overload;
    class function CreateFromRTTI(AClassName: String; AParamsConstructor: Array of TValue; ACallBack: Tproc<TObject,TFieldLibRtti,TInstanceLibRtti>): TObject; overload;
    class function ExecuteMethod<T>(Const AObject: TObject; Const AmethodName: String; AMethodParams: Array of TValue ):T; overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  function ParValues(Arg: TArrayOfParams):TArrayOfParams;

implementation

  var
  FClass: TPersistentClass;
  RttiContext: TRttiContext;
  RttiInstanceType: TInstanceLibRtti;
  Instance: TInstanceLibRtti;
  RttiMethod: TRttiMethod;
  FObject: TObject;
  RttiField:TFieldLibRtti;

{ TLib }

function ParValues(Arg: TArrayOfParams):TArrayOfParams;
begin
  Result:= TValue.from(Arg).AsType<TArrayOfParams>;
end;

procedure TLib.AfterConstruction;
begin
  inherited

end;

procedure TLib.BeforeDestruction;
begin
  inherited;

end;

class function TLib.CreateFromRTTI(AClassesNames: TArray<String>;
  ParamsConstructor: TArray<TArrayOfParams>;
  ADictionaryDest: TDictionary<String, TObject>;
  AcallBack: TProc<TObject>): TObject;
var
  I: Integer;
begin
 for I := Low(AClassesNames) to High(AClassesNames) do
  if not ADictionaryDest.ContainsKey(AClassesNames[I]) then
  begin
    FClass:= FindClass(AClassesNames[I]);
    RttiContext := TRttiContext.Create;
    RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
    Instance := RttiInstanceType;
    RttiMethod := RttiInstanceType.GetMethod('Create');
    FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,ParamsConstructor[I]).AsObject;
    ADictionaryDest.Add(AClassesNames[i],FObject);
    if Assigned(AcallBack) then
       AcallBack(FObject);

  end;
end;

class function TLib.CreateFromRTTI(AClassesNames: TArray<String>;
 ParamsConstructor: TArray<TArrayOfParams>;
 ADictionaryDest  :  TDictionary<String,TObject>): TObject;
var
  I: Integer;
begin
 for I := Low(AClassesNames) to High(AClassesNames) do
  if not ADictionaryDest.ContainsKey(AClassesNames[I]) then
  begin
    FClass:= FindClass(AClassesNames[I]);
    RttiContext := TRttiContext.Create;
    RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
    Instance := RttiInstanceType;
    RttiMethod := RttiInstanceType.GetMethod('Create');
    FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,ParamsConstructor[I]).AsObject;
    ADictionaryDest.Add(AClassesNames[i],FObject);
  end;
end;

class function TLib.CreateFromRTTI(AClassName: String; AParamsConstructor: Array of TValue;
  ACallBack: Tproc<TObject,TFieldLibRtti,TInstanceLibRtti>): TObject;
begin
 FClass:= FindClass(AClassName);
 RttiContext := TRttiContext.Create;
 RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
 Instance := RttiInstanceType;
 RttiMethod := RttiInstanceType.GetMethod('Create');
 FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,AParamsConstructor).AsObject;
 Result:= FObject;
  if Assigned(ACallBack) then
    ACallBack(Result,RttiField,RttiInstanceType);

end;

class function TLib.CreateFromRTTI(AClassName: String; AParamsConstructor: Array of TValue; ACallBack: Tproc<TObject>): TObject;
begin
 FClass:= FindClass(AClassName);
 RttiContext := TRttiContext.Create;
 RttiInstanceType := RttiContext.FindType(FClass.UnitName+'.'+FClass.ClassName).AsInstance;
 Instance := RttiInstanceType;
 RttiMethod := RttiInstanceType.GetMethod('Create');
 FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType,AParamsConstructor).AsObject;
 Result:= FObject;
  if Assigned(ACallBack) then
    ACallBack(Result);
end;

class function TLib.ExecuteMethod<T>(const AObject: TObject;
  const AmethodName: String; AMethodParams: array of TValue): T;
var
 RttiContext: TRttiContext;
 RttiInstanceType: TRttiInstanceType;
 RttiMethod: TRttiMethod;
 InstanceOf: TValue;
 FValue: TValue;
begin
 RttiContext := TRttiContext.Create;
 RttiInstanceType := RttiContext.FindType(AObject.UnitName+'.'+AObject.ClassName).AsInstance;
 RttiMethod := RttiInstanceType.GetMethod(AMethodName);
 InstanceOf:= RttiInstanceType.MetaclassType;
 if RttiMethod <> nil then
    FValue:= RttiMethod.Invoke( AObject , AmethodParams);
    Result:= FValue.AsType<T>;
end;

end.

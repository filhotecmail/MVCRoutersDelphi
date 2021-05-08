unit Commom.RTTI.Utils;

interface

uses System.Classes, System.SysUtils, System.VarUtils,
  System.Generics.Collections, System.Generics.Defaults, System.Types, System.Rtti;

type
  TArrayOfParams = array of TValue;
  TStringDinamicArray = Array of String;
  TFieldLibRtti = TRttiField;
  TInstanceLibRtti = TRttiInstanceType;

  TLib = class
  public
    class function CreateFromRTTI(AClassName: string; AParamsConstructor: array of TValue;
      ACallBack: Tproc<TObject>): TObject; overload;

    class function CreateFromRTTI(AClassesNames: TArray<string>; ParamsConstructor: TArray<TArrayOfParams>;
      ADictionaryDest: TDictionary<string, TObject>): TObject; overload;

    class function CreateFromRTTI(AClassesNames: TArray<string>; ParamsConstructor: TArray<TArrayOfParams>;
      ADictionaryDest: TDictionary<string, TObject>; AcallBack: TProc<TObject>): TObject; overload;

    class function CreateFromRTTICallback(AClassName: string; AParamsConstructor: array of TValue;
      ACallBack: Tproc<TObject, TFieldLibRtti, TInstanceLibRtti>): TObject; overload;

    class function ExecuteMethod<T>(const AObject: TObject; const AmethodName: string;
      AMethodParams: array of TValue): T; overload;

 class procedure SetValue(AObject: TObject; AFieldName: String; AValue: TValue);

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

var
  FClass: TPersistentClass;
  RttiContext: TRttiContext;
  RttiInstanceType: TInstanceLibRtti;
  Instance: TInstanceLibRtti;
  RttiMethod: TRttiMethod;
  RttiField: TFieldLibRtti;

{ TLib }

procedure TLib.AfterConstruction;
begin
  inherited;

end;

procedure TLib.BeforeDestruction;
begin
  inherited;

end;

class function TLib.CreateFromRTTI(AClassesNames: TArray<string>; ParamsConstructor: TArray<TArrayOfParams>;
  ADictionaryDest: TDictionary<string, TObject>; AcallBack: TProc<TObject>): TObject;
var
  I: integer;
  FObject: TObject;
begin
  for I := Low(AClassesNames) to High(AClassesNames) do
    if not ADictionaryDest.ContainsKey(AClassesNames[I]) then
    begin
      FClass := FindClass(AClassesNames[I]);
      RttiContext := TRttiContext.Create;
      RttiInstanceType := RttiContext.FindType(FClass.UnitName + '.' + FClass.ClassName).AsInstance;
      Instance := RttiInstanceType;
      RttiMethod := RttiInstanceType.GetMethod('Create');
      FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType, ParamsConstructor[I]).AsObject;
      ADictionaryDest.Add(AClassesNames[i], FObject);
      if Assigned(AcallBack) then
        AcallBack(FObject);

    end;
end;

class function TLib.CreateFromRTTI(AClassesNames: TArray<string>; ParamsConstructor: TArray<TArrayOfParams>;
  ADictionaryDest: TDictionary<string, TObject>): TObject;
var
  I: integer;
  FObject: TObject;
begin
  for I := Low(AClassesNames) to High(AClassesNames) do
    if not ADictionaryDest.ContainsKey(AClassesNames[I]) then
    begin
      FClass := FindClass(AClassesNames[I]);
      RttiContext := TRttiContext.Create;
      RttiInstanceType := RttiContext.FindType(FClass.UnitName + '.' + FClass.ClassName).AsInstance;
      Instance := RttiInstanceType;
      RttiMethod := RttiInstanceType.GetMethod('Create');
      FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType, ParamsConstructor[I]).AsObject;
      ADictionaryDest.Add(AClassesNames[i], FObject);
    end;
end;

class function TLib.CreateFromRTTICallback(AClassName: string; AParamsConstructor: array of TValue;
  ACallBack: Tproc<TObject, TFieldLibRtti, TInstanceLibRtti>): TObject;
  var FObject: TObject;
begin
  FClass := FindClass(AClassName);
  RttiContext := TRttiContext.Create;
  RttiInstanceType := RttiContext.FindType(FClass.UnitName + '.' + FClass.ClassName).AsInstance;
  Instance := RttiInstanceType;
  RttiMethod := RttiInstanceType.GetMethod('Create');
  FObject := RttiMethod.Invoke(RttiInstanceType.MetaclassType, AParamsConstructor).AsObject;
  result := FObject;
  if Assigned(ACallBack) then
    ACallBack(result, RttiField, RttiInstanceType);

end;

class function TLib.CreateFromRTTI(AClassName: string; AParamsConstructor: array of TValue;
  ACallBack: Tproc<TObject>): TObject;
begin
  RttiInstanceType := TRttiContext.Create.FindType(FindClass(AClassName).UnitName + '.' + FindClass(AClassName).ClassName).AsInstance;
  Instance := RttiInstanceType;
  Result := RttiInstanceType.GetMethod('Create').Invoke(RttiInstanceType.MetaclassType, AParamsConstructor).AsObject;
  if Assigned(ACallBack) then
    ACallBack(result);
end;

class function TLib.ExecuteMethod<T>(const AObject: TObject; const AmethodName: string;
  AMethodParams: array of TValue): T;
var
  RttiInstanceType: TRttiInstanceType;
  RttiMethod: TRttiMethod;
  InstanceOf: TValue;
begin
  RttiInstanceType := TRttiContext.Create.FindType(AObject.UnitName + '.' + AObject.ClassName).AsInstance;
  RttiMethod := RttiInstanceType.GetMethod(AMethodName);
  InstanceOf := RttiInstanceType.MetaclassType;
  if RttiMethod <> nil then
    Result := RttiMethod.Invoke(AObject, AmethodParams).AsType<T>;
end;

class procedure TLib.SetValue(AObject: TObject; AFieldName: String; AValue: TValue);
 var FClass: TPersistentClass;
     FObject: TObject;
     RttiContext: TRttiContext;
     RttiInstanceType: TRttiInstanceType;
     RttiMethod: TRttiMethod;
begin
  RttiContext := TRttiContext.Create;
  RttiInstanceType := RttiContext.FindType(AObject.UnitName+'.'+AObject.ClassName).AsInstance;
  RttiInstanceType.GetField(AFieldName).SetValue(AObject,AValue);
end;

end.

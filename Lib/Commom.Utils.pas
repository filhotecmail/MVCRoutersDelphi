unit Commom.Utils;

interface
 uses  Classes,SysUtils,vcl.Dialogs,System.Generics.Collections,System.Generics.Defaults,RTTI,System.VarUtils,System.TypInfo,System.Variants;

  type TFieldsNamesArray = Array of String;

  function _ReadArrayStringSeparadorValue(APatch: Array of String; AKeyName: String; CharSeparador: String):Variant;
  function _ReadArrayStringSeparadorAPatch(APatch: Array of String; Const
  CharSeparador: String; ACallBack: TProc<TDictionary<String,String>>):TDictionary<String,String>;

  type TInvoke = class
   class function _InvokeRttiMethod<T>( AObject: TObject; AMethodName: String; AMethodParams: Array of TValue):T;
  end;

implementation

 function _ReadArrayStringSeparadorAPatch( APatch: Array of String; Const CharSeparador: String; ACallBack: TProc<TDictionary<String,String>>):TDictionary<String,String>;
  var List: TStringList; I: Integer;
  var Dicionario: TDictionary<String,String>;
  var FKey,FValue: String;
 begin
  List := TStringList.Create;
  Dicionario:= TDictionary<String,String>.create;
  try
   for I := Low(APatch) to High(APatch) do
   begin
     ExtractStrings([':'],[], PChar(Trim(APatch[I])), List);
     Dicionario.Add(List[0],List[1]);
     List.Clear;
   end;
   if Assigned(ACallBack) then
      ACallBack(Dicionario);
  finally
   Result:= Dicionario;
   FreeAndNil( List );
   FreeAndNil( Dicionario);
  end;
 end;

 function _ReadArrayStringSeparadorValue( APatch: Array of String; AKeyName: String; CharSeparador: String):Variant;
  var List: TStringList; I: Integer;
  var Dicionario: TDictionary<String,String>;
  var FKey,FValue: String;
 begin
  List := TStringList.Create;
  Dicionario:= TDictionary<String,String>.create;
  try
   for I := Low(APatch) to High(APatch) do
   begin
     ExtractStrings([':'],[], PChar(Trim(APatch[I])), List);
     Dicionario.Add(List[0],List[1]);
     List.Clear;
   end;
  finally
   Result:= Dicionario.Items[AKeyName];
   FreeAndNil( List );
   FreeAndNil( Dicionario  );
  end;
 end;

{ TInvoke }

class function TInvoke._InvokeRttiMethod<T>(AObject: TObject; AMethodName: String;
  AMethodParams: array of TValue): T;
var  RttiContext: TRttiContext;
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

unit System.Helper;

interface
  uses System.classes,System.Generics.Collections,System.SysUtils,Rtti;

  type TClassesHelper = Class helper for TObject

       function Controller(Const MethodName: string; AParams: Array of TValue):TValue;
  end;

implementation

{ TClassesHelper }

function TClassesHelper.Controller(const MethodName: string;
  AParams: array of TValue): TValue;
begin

end;

end.

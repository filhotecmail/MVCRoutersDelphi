unit Controller.IInterfaces;

interface
  Uses System.SysUtils,System.Classes,System.Generics.Collections,Rtti;

   type IController = interface
    ['{210C5CC7-8DEE-4C55-B17E-E0D10229A187}']
    function Render():TValue;
    function Get(const AValues: Tarray<TValue>):TValue;
  end;



  implementation

end.

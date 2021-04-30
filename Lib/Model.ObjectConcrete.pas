unit Model.ObjectConcrete;

interface

uses Model.IInterfaces,system.classes,system.SysUtils;

type TModel = class(TInterfacedObject,IModel)
     function Props(const AProps: Tproc<TProps>):IModel; virtual; Abstract;
     function Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ):IModel; Virtual; Abstract;

  end;

  implementation


end.

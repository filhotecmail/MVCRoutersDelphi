unit Controller.IInterfaces;

interface
  Uses System.SysUtils,System.Classes,System.Generics.Collections,Rtti;

  type TFieldsNames = Array of string;

  Type TProps = class
  private
    FTableName: string;
    FGenerator: String;
    FPrimaryKey: String;
    FFillable: TFieldsNames;
    procedure SetGenerator(const Value: String);
    procedure SetPrimaryKey(const Value: String);
    procedure SetTableName(const Value: string);
    procedure SetFillable(const Value: TFieldsNames);
  published
     property TableName: string read FTableName write SetTableName;
     property PrimaryKey: String read FPrimaryKey write SetPrimaryKey;
     property Generator: String read FGenerator write SetGenerator;
     property Fillable:TFieldsNames read FFillable write SetFillable;
  end;

 type TMessagesErrorType = class
      property MsgFieldrequired: string;
      property MsgValueNotValidade: string;
      property MsgMinimumRequired: String;
      property MsgFieldReadOnly: string;
  end;

  type IController = interface
    ['{210C5CC7-8DEE-4C55-B17E-E0D10229A187}']
    function Render():TValue;
    function Get(const AValues: Tarray<TValue>):TValue;
  end;

  type IModel = Interface
    ['{F882506F-3353-4F30-A373-1B8DC8924475}']
     function Props(const AProps: Tproc<TProps>):IModel;
     function Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ):IModel;
  End;

  type TModel = class(TInterfacedObject,IModel)
     function Props(const AProps: Tproc<TProps>):IModel;
     function Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ):IModel;

  end;

  implementation

{ TModel }

function TModel.Props(const AProps: Tproc<TProps>): IModel;
begin

end;

function TModel.Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ): IModel;
begin

end;

{ TProps }

procedure TProps.SetFillable(const Value: TFieldsNames);
begin
  FFillable := Value;
end;

procedure TProps.SetGenerator(const Value: String);
begin
  FGenerator := Value;
end;

procedure TProps.SetPrimaryKey(const Value: String);
begin
  FPrimaryKey := Value;
end;

procedure TProps.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

end.

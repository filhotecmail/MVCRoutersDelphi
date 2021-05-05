unit Model.IInterfaces;

interface
 Uses System.SysUtils,System.Classes,System.Generics.Collections,Rtti,Data.Db;

  type TFieldsNames = Array of string;
  type TFriendlyName = array of string;

  Type TProps = class
  private
    FTableName: string;
    FGenerator: String;
    FPrimaryKey: String;
    FFillable: TFieldsNames;
    FfriendName: TFriendlyName;
    FFieldTypes: TArray<TFieldType>;
    FRequiredFields: TArray<String>;
    FSizeFields: TArray<Integer>;
    procedure SetFillable(const Value: TFieldsNames);
    procedure SetGenerator(const Value: String);
    procedure SetPrimaryKey(const Value: String);
    procedure SetTableName(const Value: string);
    procedure SetfriendName(const Value: TFriendlyName);
    procedure SetFieldTypes(const Value: TArray<TFieldType>);
    procedure SetRequiredFields(const Value: TArray<String>);
    procedure SetSizeFields(const Value: TArray<Integer>);
  published
     property TableName: string read FTableName write SetTableName;
     property PrimaryKey: String read FPrimaryKey write SetPrimaryKey;
     property Generator: String read FGenerator write SetGenerator;
     property Fillable:TFieldsNames read FFillable write SetFillable;
     property RequiredFields: TArray<String> read FRequiredFields write SetRequiredFields;
     property FriendName: TFriendlyName read FfriendName write SetfriendName;
     property SizeFields: TArray<Integer> read FSizeFields write SetSizeFields;
     property FieldTypes: TArray<TFieldType> read FFieldTypes write SetFieldTypes;
  end;

 type TMessagesErrorType = class
  private
    FMsgValueNotValidade: string;
    FMsgFieldrequired: string;
    FMsgFieldReadOnly: string;
    FMsgMinimumRequired: String;
    procedure SetMsgFieldReadOnly(const Value: string);
    procedure SetMsgFieldrequired(const Value: string);
    procedure SetMsgMinimumRequired(const Value: String);
    procedure SetMsgValueNotValidade(const Value: string);
  published
    property MsgFieldrequired: string read FMsgFieldrequired write SetMsgFieldrequired;
    property MsgValueNotValidade: string read FMsgValueNotValidade write SetMsgValueNotValidade;
    property MsgMinimumRequired: String read FMsgMinimumRequired write SetMsgMinimumRequired;
    property MsgFieldReadOnly: string read FMsgFieldReadOnly write SetMsgFieldReadOnly;
  end;

   type IModel = Interface
    ['{F882506F-3353-4F30-A373-1B8DC8924475}']
     function Props(const AProps: Tproc<TProps>):IModel;
     function Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ):IModel;
  End;

implementation

{ TProps }

procedure TProps.SetFieldTypes(const Value: TArray<TFieldType>);
begin
  FFieldTypes := Value;
end;

procedure TProps.SetFillable(const Value: TFieldsNames);
begin
  FFillable := Value;
end;

procedure TProps.SetfriendName(const Value: TFriendlyName);
begin
  FfriendName := Value;
end;

procedure TProps.SetGenerator(const Value: String);
begin
  FGenerator := Value;
end;

procedure TProps.SetPrimaryKey(const Value: String);
begin
  FPrimaryKey := Value;
end;

procedure TProps.SetRequiredFields(const Value: TArray<String>);
begin
  FRequiredFields := Value;
end;

procedure TProps.SetSizeFields(const Value: TArray<Integer>);
begin
  FSizeFields := Value;
end;

procedure TProps.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

{ TMessagesErrorType }

procedure TMessagesErrorType.SetMsgFieldReadOnly(const Value: string);
begin
  FMsgFieldReadOnly := Value;
end;

procedure TMessagesErrorType.SetMsgFieldrequired(const Value: string);
begin
  FMsgFieldrequired := Value;
end;

procedure TMessagesErrorType.SetMsgMinimumRequired(const Value: String);
begin
  FMsgMinimumRequired := Value;
end;

procedure TMessagesErrorType.SetMsgValueNotValidade(const Value: string);
begin
  FMsgValueNotValidade := Value;
end;

end.

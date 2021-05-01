unit Model.ObjectConcrete;

interface

uses Model.IInterfaces,system.classes,system.SysUtils,Rtti, Observers.IInterfaces,
     System.Generics.Collections;

type TModelAbstract = class Abstract(TInterfacedPersistent,IModel,ISubject)
  strict private
    FAOwner: TObject;
    FObserver: IObservers;
    private
    FPropriedades: TProps;
    FListObserver: TList<IObservers>;
     function Props(const AProps: Tproc<TProps>):IModel; virtual;
     function Rules( const AFieldsNames: TArray<String>; const AfriendlyNames: Tarray<String>;
     AMessagesErrorForFields: TArray<TMessagesErrorType> ):IModel; Virtual;
    procedure SetPropriedades(const Value: TProps);
  public
    Constructor Create(AOwner: TObject; AObserverClass: TCLass); virtual;
    function AddObserver(AObservers: IObservers): ISubject; virtual;
    function RemoveObserver(AObservers: IObservers): ISubject; virtual;
    function NotifyObservers: ISubject; virtual;
    procedure AfterOpen(Obj: TValue); virtual;
    procedure BeforeOpen(Obj: TValue);virtual;
    procedure AfterClose(Obj: TValue);virtual;
    procedure BeforeClose(Obj: TValue); virtual;
    procedure AfterInsert(Obj: TValue);virtual;
    procedure BeforeInsert(Obj: TValue);virtual;
    procedure AfterPost(Obj: TValue);virtual;
    procedure BeforePost(Obj: TValue);virtual;
    procedure AfterEdit(Obj: TValue);virtual;
    procedure BeforeEdit(Obj: TValue);virtual;
    procedure AfterDelete(Obj: TValue); virtual;
    procedure BeforeDelete(Obj: TValue);virtual;
    procedure OnState(Obj: TValue);virtual;
    procedure Aftercancel(Obj: TValue);virtual;
    procedure BeforeCancel(Obj: TValue); virtual;
    procedure OnError(Obj: TValue);virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    published
    property Propriedades:TProps read FPropriedades write SetPropriedades;
    function Get(AParams: TArray<TValue>):TValue; virtual; Abstract;
  end;

  implementation
{ TModelAbstract }

function TModelAbstract.AddObserver(AObservers: IObservers): ISubject;
begin
 Result := self;
 FListObserver.Add(AObservers);
end;

procedure TModelAbstract.Aftercancel(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].Aftercancel(Obj);
end;

procedure TModelAbstract.AfterClose(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterClose(Obj);
end;

procedure TModelAbstract.AfterConstruction;
begin
  inherited;
 FListObserver := TList<IObservers>.create;
 FPropriedades:= TProps.Create;
end;

procedure TModelAbstract.AfterDelete(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterDelete(Obj);
end;

procedure TModelAbstract.AfterEdit(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterEdit(Obj);
end;

procedure TModelAbstract.AfterInsert(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterInsert(Obj);
end;

procedure TModelAbstract.AfterOpen(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterOpen(Obj);
end;

procedure TModelAbstract.AfterPost(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].AfterPost(Obj);
end;

procedure TModelAbstract.BeforeCancel(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeCancel(Obj);
end;

procedure TModelAbstract.BeforeClose(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeClose(Obj);
end;

procedure TModelAbstract.BeforeDelete(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeDelete(Obj);
end;

procedure TModelAbstract.BeforeDestruction;
begin
  inherited;
 FreeAndNil(FListObserver);
 FreeAndNil(FPropriedades);
end;

procedure TModelAbstract.BeforeEdit(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeEdit(Obj);
end;

procedure TModelAbstract.BeforeInsert(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeInsert(Obj);
end;

procedure TModelAbstract.BeforeOpen(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforeOpen(Obj);
end;

procedure TModelAbstract.BeforePost(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].BeforePost(Obj);
end;

constructor TModelAbstract.Create(AOwner: TObject; AObserverClass: TCLass);
begin
 inherited Create;
 FAOwner:= AOwner;
 //FObserver:= AObserverClass;
end;

function TModelAbstract.NotifyObservers: ISubject;
var
  I: Integer;
begin
 Result := Self;
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].Notify;
end;

procedure TModelAbstract.OnError(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].OnError(Obj);
end;

procedure TModelAbstract.OnState(Obj: TValue);
var
  I: Integer;
begin
 for I := 0 to FListObserver.Count -1 do
   FListObserver.Items[I].OnState(Obj);
end;

function TModelAbstract.Props(const AProps: Tproc<TProps>): IModel;
begin
  Result := self;
end;

function TModelAbstract.RemoveObserver(AObservers: IObservers): ISubject;
begin
 Result := self;
 FListObserver.Remove(AObservers);
end;

function TModelAbstract.Rules(const AFieldsNames,
  AfriendlyNames: Tarray<String>;
  AMessagesErrorForFields: TArray<TMessagesErrorType>): IModel;
begin

end;

procedure TModelAbstract.SetPropriedades(const Value: TProps);
begin
  FPropriedades := Value;
end;

end.

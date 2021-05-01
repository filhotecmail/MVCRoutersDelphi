unit Observers.IInterfaces;

interface
 uses System.Classes,System.SysUtils,System.Rtti;

  type IObservers = Interface
  ['{F7AE9BFF-C2A7-41AA-9714-9EFB611DA5F6}']
    procedure Notify;
    procedure AfterOpen(Obj: TValue);
    procedure BeforeOpen(Obj: TValue);
    procedure AfterClose(Obj: TValue);
    procedure BeforeClose(Obj: TValue);
    procedure AfterInsert(Obj: TValue);
    procedure BeforeInsert(Obj: TValue);
    procedure AfterPost(Obj: TValue);
    procedure BeforePost(Obj: TValue);
    procedure AfterEdit(Obj: TValue);
    procedure BeforeEdit(Obj: TValue);
    procedure AfterDelete(Obj: TValue);
    procedure BeforeDelete(Obj: TValue);
    procedure OnState(Obj: TValue);
    procedure Aftercancel(Obj: TValue);
    procedure BeforeCancel(Obj: TValue);
    procedure OnError(Obj: TValue);
  end;

  type ISubject = Interface
      function AddObserver(AObservers: IObservers):ISubject;
      function RemoveObserver(AObservers: IObservers):ISubject;
      function NotifyObservers:ISubject;
      procedure AfterOpen(Obj: TValue);
      procedure BeforeOpen(Obj: TValue);
      procedure AfterClose(Obj: TValue);
      procedure BeforeClose(Obj: TValue);
      procedure AfterInsert(Obj: TValue);
      procedure BeforeInsert(Obj: TValue);
      procedure AfterPost(Obj: TValue);
      procedure BeforePost(Obj: TValue);
      procedure AfterEdit(Obj: TValue);
      procedure BeforeEdit(Obj: TValue);
      procedure AfterDelete(Obj: TValue);
      procedure BeforeDelete(Obj: TValue);
      procedure OnState(Obj: TValue);
      procedure Aftercancel(Obj: TValue);
      procedure BeforeCancel(Obj: TValue);
      procedure OnError(Obj: TValue);
  End;


implementation

end.

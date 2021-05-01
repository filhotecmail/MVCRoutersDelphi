unit Notify.Subscribe;

interface

uses Observers.IInterfaces, System.classes,System.SysUtils,System.Rtti,Vcl.Forms;

   type TObserver = class(TForm,IObservers)
  public
    procedure Notify; virtual; abstract;
    procedure AfterOpen(Obj: TValue);virtual;
    procedure BeforeOpen(Obj: TValue);virtual;
    procedure AfterClose(Obj: TValue);virtual;
    procedure BeforeClose(Obj: TValue);virtual;
    procedure AfterInsert(Obj: TValue);virtual;
    procedure BeforeInsert(Obj: TValue);virtual;
    procedure AfterPost(Obj: TValue);virtual;
    procedure BeforePost(Obj: TValue);virtual;
    procedure AfterEdit(Obj: TValue);virtual;
    procedure BeforeEdit(Obj: TValue);virtual;
    procedure AfterDelete(Obj: TValue);virtual;
    procedure BeforeDelete(Obj: TValue);virtual;
    procedure OnState(Obj: TValue);virtual;
    procedure Aftercancel(Obj: TValue);virtual;
    procedure BeforeCancel(Obj: TValue);virtual;
    procedure OnError(Obj: TValue);virtual;
  end;

implementation

{ TObserver }

procedure TObserver.Aftercancel(Obj: TValue);
begin

end;

procedure TObserver.AfterClose(Obj: TValue);
begin

end;

procedure TObserver.AfterDelete(Obj: TValue);
begin

end;

procedure TObserver.AfterEdit(Obj: TValue);
begin

end;

procedure TObserver.AfterInsert(Obj: TValue);
begin

end;

procedure TObserver.AfterOpen(Obj: TValue);
begin

end;

procedure TObserver.AfterPost(Obj: TValue);
begin

end;

procedure TObserver.BeforeCancel(Obj: TValue);
begin

end;

procedure TObserver.BeforeClose(Obj: TValue);
begin

end;

procedure TObserver.BeforeDelete(Obj: TValue);
begin

end;

procedure TObserver.BeforeEdit(Obj: TValue);
begin

end;

procedure TObserver.BeforeInsert(Obj: TValue);
begin

end;

procedure TObserver.BeforeOpen(Obj: TValue);
begin

end;

procedure TObserver.BeforePost(Obj: TValue);
begin

end;

procedure TObserver.OnError(Obj: TValue);
begin

end;

procedure TObserver.OnState(Obj: TValue);
begin

end;

end.

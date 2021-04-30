unit Controller.ConcreteObj;

interface
  uses System.classes,Controller.IInterfaces,Rtti,Vcl.Forms,System.SysUtils;

type TControllerBase = Class Abstract(TInterfacedPersistent,IController)

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Render( Const AViewName: String; Awoner: TObject ):TValue; virtual;
    function Get(const AValues: Tarray<TValue>):TValue; virtual;
End;

  function View(Const AViewName: String; Awoner: TObject):TObject;

implementation
 { TControllerBase }

 function View(Const AViewName: String; Awoner: TObject):TObject;
 var FrmClass : TFormClass;
     Frm : TForm;
 begin
  Assert( GetClass(AViewName),'View não registrada' );
  FrmClass := TFormClass(FindClass(AViewName));
  Frm      := FrmClass.Create(Application);
  Result:= Frm.Create(Awoner);
  try
   Frm.ShowModal;
  finally
   FreeAndNil( Frm );
  end;
 end;

procedure TControllerBase.AfterConstruction;
begin
  inherited;

end;


procedure TControllerBase.BeforeDestruction;
begin
  inherited;

end;

function TControllerBase.Get(const AValues: Tarray<TValue>): TValue;
begin

end;

function TControllerBase.Render(Const AViewName: String; Awoner: TObject): TValue;
begin
 Result := Self;

end;

end.

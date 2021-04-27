unit Routers.Auth.Midleware;

interface

uses System.classes,System.Generics.Collections,System.Generics.Defaults, Rtti, Controllers.Routers;

  type TAuthMidleware = Class(TMidlwareRoute)
    FUsername: string;
    FPassWord: String;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  End;

implementation


 { TAuthMidleware }

procedure TAuthMidleware.AfterConstruction;
begin
  inherited;
   // Executar a Lógica
   MsgnotValidate:= 'Usuário não autenticado';
   IsValidate := (( FUsername = 'Carlos') and (  FPassWord = '1234' ) );
end;

procedure TAuthMidleware.BeforeDestruction;
begin
  inherited;

end;

initialization
 RegisterClassAlias(TAuthMidleware,'Auth');
 Finalization
  UnRegisterClass( TAuthMidleware );
end.

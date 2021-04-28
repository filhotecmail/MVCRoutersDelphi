unit Routers.Auth.Midleware;

interface

uses System.classes,Routers.Middleware.Abstract;

  type TAuthMiddleware = Class(TMiddlwareRoute)
   private
    FUsername: string;
    FPassWord: String;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  End;

implementation


 { TAuthMidleware }

procedure TAuthMiddleware.AfterConstruction;
begin
  inherited;
   // Executar a Lógica
   FUsername := 'Carlos';
   FPassWord := '1234';
   Msg:= 'Usuário não autenticado';
   IsValidate := (( FUsername = 'Carlos') and (  FPassWord = '1234' ) );
end;

procedure TAuthMiddleware.BeforeDestruction;
begin
  inherited;

end;

initialization
 RegisterClassAlias(TAuthMiddleware,'Auth');
 Finalization
 UnRegisterClass( TAuthMiddleware );
end.

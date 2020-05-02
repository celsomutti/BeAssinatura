unit Controller.Usuarios;

interface

uses System.SysUtils, FireDAC.Comp.Client, Forms, Windows, Common.ENum, Model.UsuariosJornal;

type
  TUsuarioControl = class
  private
    FUsuarios : TUsuarios;
  public
    constructor Create;
    destructor Destroy; override;

    property Usuarios: TUsuarios read FUsuarios write FUsuarios;

    function GetID: Integer;
    function Localizar(aParam: array of variant): TFDQuery;
    function Gravar(): Boolean;
    function ValidaLogin(sLogin: String; sSenha: String): Boolean;
    function AlteraSenha(AUsuarios: TUsuarios): Boolean;
    function ValidaCampos(): Boolean;
    function LoginExiste(sLogin: String): Boolean;
    function SaveData(memTab: TFDMemTable): Boolean;
  end;

implementation

{ TUsuarioControl }

function TUsuarioControl.AlteraSenha(AUsuarios: TUsuarios): Boolean;
begin
  Result := False;
  if AUsuarios.Senha.IsEmpty then
  begin
    Application.MessageBox('Informe a nova senha.', 'Atenção', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  Result := FUsuarios.AlteraSenha(AUsuarios);
end;

constructor TUsuarioControl.Create;
begin
  FUsuarios := TUsuarios.Create;
end;

destructor TUsuarioControl.Destroy;
begin
  FUsuarios.Free;
  inherited;
end;


function TUsuarioControl.GetID: Integer;
begin
  Result := FUsuarios.GetID;
end;

function TUsuarioControl.Gravar: Boolean;
begin
  Result := False;
  if not ValidaCampos() then Exit;
  Result := FUsuarios.Gravar;
end;

function TUsuarioControl.Localizar(aParam: array of variant): TFDQuery;
begin
  Result := FUsuarios.Localizar(aParam);
end;

function TUsuarioControl.LoginExiste(sLogin: String): Boolean;
begin
  Result := FUsuarios.LoginExiste(sLogin);
end;

function TUsuarioControl.SaveData(memTab: TFDMemTable): Boolean;
begin
  Result := Fusuarios.SaveData(memTab);
end;

function TUsuarioControl.ValidaCampos: Boolean;
begin
  Result := False;
  if Fusuarios.Acao = tacExcluir then
  begin
    Result := True;
    Exit;
  end;
  if FUsuarios.Nome.IsEmpty then
  begin
    Application.MessageBox('Informe a nome do usuário.', 'Atenção', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  if FUsuarios.Login.IsEmpty then
  begin
    Application.MessageBox('Informe o login do usuário.', 'Atenção', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
   if FUsuarios.Senha.IsEmpty then
  begin
    Application.MessageBox('Informe a nome do usuário.', 'Atenção', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  if FUsuarios.Acao = Common.ENum.tacIncluir then
  begin
    if LoginExiste(FUsuarios.Login) then
    begin
      Application.MessageBox('Login já cadastrado.', 'Atenção', MB_OK + MB_ICONASTERISK);
      Exit;
    end;
  end;
  Result := True;
end;

function TUsuarioControl.ValidaLogin(sLogin, sSenha: String): Boolean;
begin
  Result := False;
  if sLogin.IsEmpty then
  begin
    Application.MessageBox('Informe o login do usuário.', 'Atenção', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  if sSenha.IsEmpty then
  begin
    Application.MessageBox('Informe a nome do usuário.', 'Atenção', MB_OK + MB_ICONASTERISK);
    Exit;
  end;
  Result := FUsuarios.ValidaLogin(sLogin, sSenha);
end;


end.

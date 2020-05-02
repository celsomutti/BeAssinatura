unit Model.UsuariosJornal;

interface

uses Common.ENum, FireDAC.Comp.Client, Controller.Sistema, DAO.Conexao, FireDAC.Comp.DataSet;

type
  TUsuarios = class
  private
    FCodigo: integer;
    FNome: String;
    FLogin: String;
    FSenha: String;
    FGrupo: String;
    FAtivo: Boolean;
    FAcao: TAcao;

    FConexao : TConexao;

    function Inserir(): Boolean;
    function Alterar(): Boolean;
    function Excluir(): Boolean;
  public
    constructor Create;

    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
    property Grupo: String read FGrupo write FGrupo;
    property Ativo: Boolean read FAtivo write FAtivo;
    property Acao: TAcao read FAcao write FAcao;

    function GetID: Integer;
    function Localizar(aParam: array of variant): TFDQuery;
    function Gravar(): Boolean;
    function ValidaLogin(sLogin: String; sSenha: String): Boolean;
    function AlteraSenha(AUsuarios: TUsuarios): Boolean;
    function LoginExiste(sLogin: String): Boolean;
    function SaveData(memTab: TFDMemTable): Boolean;

  end;

  const
    TABLENAME = 'login_usuarios';


implementation

{ TUsuarios }

function TUsuarios.Alterar: Boolean;
var
  FDQuery : TFDQuery;
begin
  try
    REsult := False;
    FDQuery := TSistemaControl.GetInstance.Conexao.ReturnQuery;
    FDQuery.ExecSQL('UPDATE ' + TABLENAME + ' SET '+
                    'nom_usuario = :pnom_usuario, des_login = :pdes_login, des_senha = :pdes_senha, cod_agente = :pcod_agente, ' +
                    'dom_ativo = :pdom_ativo ' +
                    'WHERE id_usuario = :pid_usuario;', [Self.FNome, Self.FLogin, Self.FSenha, Self.FGrupo,
                     Self.FAtivo, Self.FCodigo]);
    Result := True;
  finally
    FDQuery.Free;
  end;

end;

function TUsuarios.AlteraSenha(AUsuarios: TUsuarios): Boolean;
var
  FDQuery : TFDQuery;
begin
  try
    REsult := False;
    FDQuery := TSistemaControl.GetInstance.Conexao.ReturnQuery;
    FDQuery.ExecSQL('UPDATE ' + TABLENAME + ' SET '+
                    'des_senha = :pdes_senha ' +
                    'WHERE id_usuario = :pid_usuario;', [Self.FSenha, Self.FCodigo]);
    Result := True;
  finally
    FDQuery.Free;
  end;

end;

constructor TUsuarios.Create;
begin
  FConexao := TConexao.Create;
end;

function TUsuarios.Excluir: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FDQuery := FConexao.ReturnQuery();
    FDQuery.ExecSQL('delete from ' + TABLENAME + ' where id_usuario = :pid_usuario', [Self.FCodigo]);
    Result := True;
  finally
    FDquery.Free;
  end;
end;

function TUsuarios.GetID: Integer;
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery := FConexao.ReturnQuery();
    FDQuery.Open('select coalesce(max(id_usuario),0) + 1 from ' + TABLENAME);
    try
      Result := FDQuery.Fields[0].AsInteger;
    finally
      FDQuery.Close;
    end;
  finally
    FDQuery.Free;
  end;
end;

function TUsuarios.Gravar: Boolean;
begin
  Result := False;
  case FAcao of
    Common.ENum.tacIncluir: Result := Self.Inserir();
    Common.ENum.tacAlterar: Result := Self.Alterar();
    Common.ENum.tacExcluir: Result := Self.Excluir();
  end;
end;

function TUsuarios.Inserir: Boolean;
var
  FDQuery : TFDQuery;
begin
  try
    Result := False;
    FDQuery := FConexao.ReturnQuery();
    Self.FCodigo := GetId();
    FDQuery.ExecSQL('INSERT INTO ' + TABLENAME + ' '+
                    '(id_usuario, nom_usuario, des_login, des_senha, cod_agente, dom_ativo)' +
                    'VALUES ' +
                    '(:pid_usuario, :pnom_usuario, :pdes_login, :pdes_senha, :pcod_agente,:pdom_ativo);' ,
                    [Self.FCodigo, Self.FNome, Self.FLogin, Self.FSenha, Self.FGrupo, Self.FAtivo]);
    Result := True;
  finally
    FDQuery.Free;
  end;

end;

function TUsuarios.Localizar(aParam: array of variant): TFDQuery;
var
  FDQuery: TFDQuery;
begin
  FDQuery := FConexao.ReturnQuery();
  if Length(aParam) < 2 then Exit;
  FDQuery.SQL.Clear;

  FDQuery.SQL.Add('SELECT * FROM ' + TABLENAME);
  if aParam[0] = 'CODIGO' then
  begin
    FDQuery.SQL.Add('WHERE id_usuario = :pid_usuario');
    FDQuery.ParamByName('pid_usuario').AsInteger := aParam[1];
  end;
  if aParam[0] = 'LOGIN' then
  begin
    FDQuery.SQL.Add('WHERE des_login = :pdes_login');
    FDQuery.ParamByName('pdes_login').AsString := aParam[1];
  end;
  if aParam[0] = 'NOME' then
  begin
    FDQuery.SQL.Add('WHERE nom_usuario LIKE :pnom_usuario');
    FDQuery.ParamByName('pnom_usuario').AsString := aParam[1];
  end;
  if aParam[0] = 'FILTRO' then
  begin
    FDQuery.SQL.Add('WHERE ' + aParam[1]);
  end;
  if aParam[0] = 'APOIO' then
  begin
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add('SELECT  ' + aParam[1] + ' FROM ' + TABLENAME + ' ' + aParam[2]);
  end;
  FDQuery.Open();
  Result := FDQuery;
end;

function TUsuarios.LoginExiste(sLogin: String): Boolean;
var
  FDQuery : TFDQuery;
begin
  try
    Result := False;
    FDquery := FConexao.ReturnQuery();
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add('SELECT * FROM ' + TABLENAME);
    FDQuery.SQL.Add(' WHERE des_login = :pdes_login');
    FDQuery.ParamByName('pdes_login').AsString := sLogin;
    FDQuery.Open();
    Result  := (not FDQuery.IsEmpty);
  finally
    FDquery.Free;
  end;
end;

function TUsuarios.SaveData(memTab: TFDMemTable): Boolean;
var
  fdQuery : TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    fdQuery := FConexao.ReturnQuery();
    fdQuery.SQL.Add('select * from ' + TABLENAME);
    fdQuery.Open();
    fdQuery.CopyDataSet(memTab, [coRestart, coEdit, coAppend]);
    fdQuery.Close;
    Result := True;
  finally
    fdQuery.Free;
    FConexao.Free;
  end;end;

function TUsuarios.ValidaLogin(sLogin, sSenha: String): Boolean;
var
  FDquery : TFDQuery;
begin
  try
    Result := False;
    FDquery := FConexao.ReturnQuery();
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add('SELECT des_senha FROM ' + TABLENAME);
    FDQuery.SQL.Add(' WHERE des_login = :pdes_login');
    FDQuery.ParamByName('pdes_login').AsString := sLogin;
    FDQuery.Open();
    if FDquery.IsEmpty then Exit;
    if FDQuery.FieldByName('des_senha').AsString <> sSenha then Exit;
    Result  :=  True;
  finally
    FDquery.Free;
  end;
end;

end.

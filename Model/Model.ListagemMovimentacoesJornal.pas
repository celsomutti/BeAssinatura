unit Model.ListagemMovimentacoesJornal;

interface

uses FireDAC.Comp.Client, System.SysUtils, DAO.Conexao, Controller.Sistema, Common.ENum, Common.Utils, System.DateUtils,
  Model.PlanilhaMovimentacaoJornal;

type
    TMovimentacoes = class
  private
    FProduto: String;
    FBairro: String;
    FCodigo: String;
    FAgente: Integer;
    FComplemento: String;
    FModalidade: Integer;
    FNome: String;
    FEndereco: String;
    FEdicao: TDateTime;
    FAcao: TAcao;
    FString: String;
    FID: Integer;

    FConexao : TConexao;


    function Insert(): Boolean;
    function Update(): Boolean;
    function Delete(): Boolean;

  public
    constructor Create();
    property ID: Integer read FID write FID;
    property Agente: Integer read FAgente write FAgente;
    property Status: String read FString write FString;
    property Edicao: TDateTime read FEdicao write FEdicao;
    property Endereco: String read FEndereco write FEndereco;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Codigo: String read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Produto: String read FProduto write FProduto;
    property Modalidade: Integer read FModalidade write FModalidade;
    property Acao: TAcao read FAcao write FAcao;

    function Gravar(): Boolean;
    function DeleteEdicao(): Boolean;
    function Localizar(aParam: array of variant): TFDQuery;
    function QueryInsertMode(): TFDQuery;
  end;
const
  TABLENAME = 'listagem_movimentacoes';
  SQLINSERT = 'INSERT INTO ' + TABLENAME + '(cod_agente, dat_edicao, des_status, des_endereco, des_complemento, ' +
              'des_bairro, cod_assinante, nom_assinante, des_produto, cod_modalidade) ' +
              'VALUES ' +
              '(:cod_agente, :dat_edicao, :des_status, :des_endereco, :des_complemento, :des_bairro, ' +
              ':cod_assinante, :nom_assinante, :des_produto, :cod_modalidade);';
  SQLUPDATE = 'UPDATE ' + TABLENAME + 'SET cod_agente = :cod_agente, dat_edicao = :dat_edicao, ' +
              'des_status = :des_status, des_endereco = :des_endereco, des_complemento = :des_complemento, ' +
              'des_bairro = :des_bairro, cod_assinante = :cod_assinante, nom_assinante = :nom_assinante, ' +
              'des_produto = :des_produto, cod_modalidade = :cod_modalidade '+
              'WHERE id_registro = :id_registro;';

implementation

{ TMovimentacoes }

constructor TMovimentacoes.Create;
begin
  FConexao := TConexao.Create;
end;

function TMovimentacoes.Delete: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FDQuery := FConexao.ReturnQuery();
    FDQuery.ExecSQL('delete from ' + TABLENAME + ' WHERE id_registro = :pid_registro', [FID]);
    Result := True;
  finally
    FDquery.Free;
  end;
end;

function TMovimentacoes.DeleteEdicao: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FDQuery := FConexao.ReturnQuery();
    FDQuery.ExecSQL('delete from ' + TABLENAME + ' WHERE dat_edicao = :pdat_edicao', [FEdicao]);
    FEdicao := IncDaY(FEdicao - 7);
    FDQuery.ExecSQL('delete from ' + TABLENAME + ' WHERE dat_edicao <= :pdat_edicao', [FEdicao]);
    Result := True;
  finally
    FDquery.Free;
  end;
end;

function TMovimentacoes.Gravar: Boolean;
begin
  case FAcao of
    tacIncluir: Result := Self.Insert();
    tacAlterar: Result := Self.Update();
    tacExcluir: Result := Self.Delete();
    tacDeleteData: Result := Self.DeleteEdicao();
  end;
end;

function TMovimentacoes.Insert: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery;
    FDQuery.ExecSQL(SQLINSERT,[Self.FAgente,Self.FEdicao, Self.FEdicao, Self.FEndereco, Self.FComplemento, Self.FBairro,
                    Self.FCodigo, Self.Nome, Self.FProduto, Self.FModalidade]);
    Result := True;
  finally
    FDQuery.Free;
    FConexao.Free;
  end;
end;

function TMovimentacoes.Localizar(aParam: array of variant): TFDQuery;
var
  FDQuery: TFDQuery;
begin
  try
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery();
    if Length(aParam) < 2 then Exit;
    FDQuery.SQL.Clear;

    FDQuery.SQL.Add('select * from ' + TABLENAME);
    if aParam[0] = 'ID' then
    begin
      FDQuery.SQL.Add('WHERE id_registro = :pid_registro');
      FDQuery.ParamByName('pid_registro').AsInteger := aParam[1];
    end;
    if aParam[0] = 'AGENTE' then
    begin
      FDQuery.SQL.Add('WHERE cod_agente = :pcod_agente');
      FDQuery.ParamByName('pcod_agente').AsString := aParam[1];
    end;
    if aParam[0] = 'EDICAO' then
    begin
      FDQuery.SQL.Add('WHERE dat_edicao = :pdat_edicao');
      FDQuery.ParamByName('pdat_edicao').AsDate := aParam[1];
    end;
    if aParam[0] = 'CODIGO' then
    begin
      FDQuery.SQL.Add('WHERE cod_assinatura = :pcod_assinatura');
      FDQuery.ParamByName('pcod_assinatura').AsString := aParam[1];
    end;
    if aParam[0] = 'NOME' then
    begin
      FDQuery.SQL.Add('WHERE nom_assinante like :pnom_assinante');
      FDQuery.ParamByName('pnom_assinante').AsString := aParam[1];
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
  finally
    FConexao.Free;
  end;
end;

function TMovimentacoes.QueryInsertMode: TFDQuery;
var
  FDQuery: TFDQuery;
begin
  FConexao:= TConexao.Create;
  FDQuery := FConexao.ReturnQuery();
  FDQuery.SQL.Text := SQLINSERT;
  Result := FDQuery;
end;

function TMovimentacoes.Update: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery;
    FDQuery.ExecSQL(SQLUPDATE,[Self.FAgente,Self.FEdicao, Self.FEdicao, Self.FEndereco, Self.FComplemento, Self.FBairro,
                    Self.FCodigo, Self.Nome, Self.FProduto, Self.FModalidade, Self.FID]);
    Result := True;
  finally
    FDQuery.Free;
    FConexao.Free;
  end;

end;

end.

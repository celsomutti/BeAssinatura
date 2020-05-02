unit Model.ListagemAssinantesJornal;

interface

uses Common.ENum, FireDAC.Comp.Client, DAO.Conexao, Generics.Collections, Controller.PlanilhaListagemJornal,
     Model.PlanilhaListagemJornal,FireDAC.Comp.DataSet, Data.DB, System.SysUtils;

type
  TListagemAssinantesJornal = class
  private
    FProduto: String;
    FBairro: String;
    FCodigo: String;
    FCEP: String;
    FID: Integer;
    FNumero: String;
    FAgente: Integer;
    FEdicao: TDateTime;
    FQuantidade: Integer;
    FComplemento: String;
    FModalidade: Integer;
    FREferencia: String;
    FNome: String;
    FEndereco: String;
    FAcao: TAcao;
    FDescricaoModalidade: String;
    FConexao : TConexao;

    function Insert(): Boolean;
    function Update(): Boolean;
    function Delete(): Boolean;
    function Search(aParam: Array of variant): TFDQuery;
  public
    property ID: Integer read FID write FID;
    property Agente: Integer read FAgente write FAgente;
    property Edicao: TDateTime read FEdicao write FEdicao;
    property Codigo: String read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Endereco: String read FEndereco write FEndereco;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property CEP: String read FCEP write FCEP;
    property Referencia: String read FREferencia write FReferencia;
    property Produto: String read FProduto write FProduto;
    property Modalidade: Integer read FModalidade write FModalidade;
    property DescricaoModalidade: String read FDescricaoModalidade write FDescricaoModalidade;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Acao: TAcao read FAcao write FAcao;
    function Localizar(aParam: array of variant): TFDQuery;
    function Gravar(): Boolean;
    function SaveData(mtbLista: TFDMemTable): Boolean;
    function DeleteEdicao(): Boolean;
    function DeleteAll(): Boolean;
    function QueryInsertMode(): TFDQuery;
  end;
const
  TABLENAME = 'listagem_jornal';
  SQLINSERT = 'insert into ' + TABLENAME + '('+
    'cod_agente, dat_edicao, cod_assinatura, nom_assinante, des_endereco, num_endereco, des_complemento, ' +
    'des_bairro, num_cep, des_referencia, des_produto, cod_modalidade, des_modalidade, qtd_exemplares) '+
    'VALUES ' +
    '(:pcod_agente, :pdat_edicao, :pcod_assinatura, :pnom_assinante, :pdes_endereco, :pnum_endereco, ' +
    ':pdes_complemento, :pdes_bairro, :pnum_cep, :pdes_referencia, :pdes_produto, :pcod_modalidade, ' +
    ':pdes_modalidade, :pqtd_exemplares);';
  SQLUPDATE = 'update ' + TABLENAME  + 'set ' +
    'cod_agente = :pcod_agente, dat_edicao = :pdat_edicao, cod_assinatura = :pcod_assinatura, ' +
    'nom_assinante = :pnom_assinante, des_endereco = :pdes_endereco, num_endereco = :pnum_endereco, ' +
    'des_complemento = :pdes_complemento, des_bairro = :pdes_bairro, num_cep = :pnum_cep, ' +
    'des_referencia = :pdes_referencia, des_produto = :pdes_produto, cod_modalidade = :pcod_modalidade, ' +
    'des_modalidade = :pdes_modalidade, qtd_exemplares = :pqtd_exemplares ' +
    'WHERE id_registro = :pid_registro;';


implementation

{ TListagemAssinantesJornal }

uses dataModule;

function TListagemAssinantesJornal.Delete: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery();
    FDQuery.ExecSQL('delete from ' + TABLENAME + ' WHERE id_registro = p:id_registro', [Self.ID]);
    Result := True;
  finally
    FDquery.Free;
    FConexao.Free;
  end;
end;

function TListagemAssinantesJornal.DeleteAll: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery();
    FDQuery.ExecSQL('delete from ' + TABLENAME);
    Result := True;
  finally
    FConexao.Free;
    FDquery.Free;
  end;
end;

function TListagemAssinantesJornal.DeleteEdicao: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery();
    FDQuery.ExecSQL('delete from ' + TABLENAME + ' WHERE dat_edicao = :pdat_edicao', [Self.Edicao]);
    Result := True;
  finally
    FConexao.Free;
    FDquery.Free;
  end;
end;

function TListagemAssinantesJornal.Gravar: Boolean;
begin
  case FAcao of
    tacIncluir: Result := Self.Insert();
    tacAlterar: Result := Self.Update();
    tacExcluir: Result := Self.Delete();
    tacDeleteData: Result := Self.DeleteEdicao();
    tacDeleteAll: Result := Self.DeleteAll();
  end;
end;

function TListagemAssinantesJornal.SaveData(mtbLista: TFDMemTable): Boolean;
var
  fdQuery : TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    fdQuery := FConexao.ReturnQuery();
    fdQuery.SQL.Add('select * from ' + TABLENAME);
    fdQuery.Open();
    fdQuery.CopyDataSet(mtbLista, [coAppend]);
    fdQuery.Close;
    Result := True;
  finally
    fdQuery.Free;
    FConexao.Free;
  end;
end;

function TListagemAssinantesJornal.Insert: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery;
    FDQuery.ExecSQL(SQLINSERT,[Self.Agente, Self.Edicao, Self.Codigo, Self.Nome, Self.Endereco,
                          Self.Numero, Self.Complemento, Self.Bairro, Self.CEP, Self.Referencia,
                          Self.Produto, Self.Modalidade, Self.DescricaoModalidade, Self.Quantidade]);
    Result := True;
  finally
    FDQuery.Free;
    FConexao.Free;
  end;

end;

function TListagemAssinantesJornal.Localizar(aParam: array of variant): TFDQuery;
begin
  Result := Self.Search(aParam);
end;

function TListagemAssinantesJornal.QueryInsertMode: TFDQuery;
var
  FDQuery: TFDQuery;
begin
  FConexao:= TConexao.Create;
  FDQuery := FConexao.ReturnQuery();
  FDQuery.SQL.Text := SQLINSERT;
  Result := FDQuery;
end;

function TListagemAssinantesJornal.Search(aParam: array of variant): TFDQuery;
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

function TListagemAssinantesJornal.Update: Boolean;
var
  FDQuery: TFDQuery;
begin
  try
    Result := False;
    FConexao:= TConexao.Create;
    FDQuery := FConexao.ReturnQuery;
    FDQuery.ExecSQL(SQLUPDATE,[Self.Agente, Self.Edicao, Self.Codigo, Self.Nome, Self.Endereco,
                          Self.Numero, Self.Complemento, Self.Bairro, Self.CEP, Self.Referencia,
                          Self.Produto, Self.Modalidade, Self.DescricaoModalidade, Self.Quantidade, Self.ID]);
    Result := True;
  finally
    FDQuery.Free;
    FConexao.Free;
  end;
end;

end.

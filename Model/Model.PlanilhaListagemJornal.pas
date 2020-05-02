unit Model.PlanilhaListagemJornal;

interface

uses System.Generics.Collections, System.Classes, System.SysUtils, Forms, Windows, Common.Utils;

type
  /// <version>1.0</version>
  /// <since>09/2019</since>
  /// <author>Celso Mutti</author>
  TPlanilhaListagemJornal = class
  private
    FAgente: String;
    FNomeAgente: String;
    FEndereco: String;
    FNumero: String;
    FComplemento: String;
    FBairro: String;
    FCEP: String;
    FProduto: String;
    FQuantidade: String;
    FCodigo: String;
    FNome: String;
    FModalidade: String;
    FDescricaoModalidade: String;
    FReferencia: String;
  public
    property Agente: String read FAgente write FAgente;
    property NomeAgente: String read FNomeAgente write FNomeAgente;
    property Endereco: String read FEndereco write FEndereco;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property CEP: String read FCEP write FCEP;
    property Produto: String read FProduto write FProduto;
    property Quantidade: String read FQuantidade write FQuantidade;
    property Codigo: String read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Modalidade: String read FModalidade write FModalidade;
    property DescricaoModalidade: String read FDescricaoModalidade write FDescricaoModalidade;
    property Referencia: String read FReferencia write FReferencia;
    function GetPlanilha(FFile: String): TObjectList<TPlanilhaListagemJornal>;
  end;

implementation

function TPlanilhaListagemJornal.GetPlanilha(FFile: String): TObjectList<TPlanilhaListagemJornal>;
var
  ArquivoCSV: TextFile;
  sLinha: String;
  sDetalhe: TStringList;
  lista : TObjectList<TPlanilhaListagemJornal>;
  i : Integer;
begin
  lista := TObjectList<TPlanilhaListagemJornal>.Create;
  if not FileExists(FFile) then
  begin
    TUtils.Dialog('Atenção', 'Arquivo ' + FFile + ' não foi encontrado!', 0);
    Exit;
  end;
  AssignFile(ArquivoCSV, FFile);
  if FFile.IsEmpty then Exit;
  sDetalhe := TStringList.Create;
  sDetalhe.StrictDelimiter := True;
  sDetalhe.Delimiter := ';';
  Reset(ArquivoCSV);
  Readln(ArquivoCSV, sLinha);
  sDetalhe.DelimitedText := sLinha;
  if Pos('DETALHADA',sLinha) = 0 then
  begin
    TUtils.Dialog('Atenção', 'Arquivo informado não foi identificado como a Planilha de Assinaturas do Jornal!', 0);
    Exit;
  end;
  i := 0;
  while not Eoln(ArquivoCSV) do
  begin
    Readln(ArquivoCSV, sLinha);
    sDetalhe.DelimitedText := sLinha + ';';
    if TUtils.ENumero(sDetalhe[0]) then
    begin
      lista.Add(TPlanilhaListagemJornal.Create);
      i := lista.Count - 1;
      lista[i].Agente := sDetalhe[0];
      lista[i].NomeAgente := sDetalhe[1];
      lista[i].Endereco := sDetalhe[2];
      lista[i].Numero := sDetalhe[3];
      lista[i].Complemento := sDetalhe[4];
      lista[i].Bairro := sDetalhe[5];
      lista[i].CEP := sDetalhe[6];
      lista[i].Produto := sDetalhe[7];
      lista[i].Quantidade := sDetalhe[8];
      lista[i].Codigo := sDetalhe[9];
      lista[i].Nome := sDetalhe[10];
      lista[i].Modalidade := sDetalhe[11];
      lista[i].DescricaoModalidade := sDetalhe[12];
      lista[i].Referencia := sDetalhe[13];
    end;
  end;
  Result := lista;
  CloseFile(ArquivoCSV);
end;

end.

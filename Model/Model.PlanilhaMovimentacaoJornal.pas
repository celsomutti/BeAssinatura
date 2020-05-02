unit Model.PlanilhaMovimentacaoJornal;

interface

uses Generics.Collections, System.Classes, System.SysUtils, Common.Utils;

type
  TPlanilhaListagem = class
  private
    FLogradouro: String;
    FCodigoAssinante: String;
    FBairro: String;
    FNomeAssinante: String;
    FSiglaProduto: String;
    FComplemento: String;
    FModalidade: String;
    FDescricaoStatus: String;
    FDescricaoAgente: String;
    FCodigoAgente: String;
  public
    property CodigoAgente: String read FCodigoAgente write FCodigoAgente;
    property DescricaoAgente: String read FDescricaoAgente write FDescricaoAgente;
    property DescricaoStatus: String read FDescricaoStatus write FDescricaoStatus;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property CodigoAssinante: String read FCodigoAssinante write FCodigoAssinante;
    property NomeAssinante: String read FNomeAssinante write FNomeAssinante;
    property SiglaProduto: String read FSiglaProduto write FSiglaProduto;
    property Modalidade: String read FModalidade write FModalidade;

    function GetPlanilha(FFile: String): TObjectList<TPlanilhaListagem>;
  end;

implementation

{ TPlanilhaListagem }

function TPlanilhaListagem.GetPlanilha(FFile: String): TObjectList<TPlanilhaListagem>;
var
  ArquivoCSV: TextFile;
  sLinha: String;
  sDetalhe: TStringList;
  lista : TObjectList<TPlanilhaListagem>;
  i : Integer;
begin
  lista := TObjectList<TPlanilhaListagem>.Create;
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
  if Pos('LISTAGEM DE MOVIMENTA',sLinha) = 0 then
  begin
    TUtils.Dialog('Atenção', 'Arquivo informado não foi identificado como a Planilha de Movimentações Assinaturas do Jornal!', 0);
    Exit;
  end;
  i := 0;
  while not Eoln(ArquivoCSV) do
  begin
    Readln(ArquivoCSV, sLinha);
    sDetalhe.DelimitedText := sLinha + ';';
    if TUtils.ENumero(sDetalhe[0]) then
    begin
      lista.Add(TPlanilhaListagem.Create);
      i := lista.Count - 1;
      lista[i].CodigoAgente := sDetalhe[0];
      lista[i].DescricaoAgente := sDetalhe[1];
      lista[i].DescricaoStatus := sDetalhe[2];
      lista[i].Logradouro := sDetalhe[3];
      lista[i].Complemento := sDetalhe[4];
      lista[i].Bairro := sDetalhe[5];
      lista[i].CodigoAssinante := sDetalhe[6];
      lista[i].NomeAssinante := sDetalhe[7];
      lista[i].SiglaProduto := sDetalhe[8];
      lista[i].Modalidade := sDetalhe[9];
    end;
  end;
  Result := lista;
  CloseFile(ArquivoCSV);
end;

end.

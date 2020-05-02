unit Controller.ListagemMovimentacoesJornal;

interface

uses System.SysUtils, FireDAC.Comp.Client, Common.ENum, Controller.Sistema, Model.ListagemMovimentacoesJornal,
  Controller.PlanilhaMovimentacoesJornal, Generics.Collections, System.Classes, Common.Utils, System.DateUtils,
  Model.PlanilhaMovimentacaoJornal;

type
  TListagemMovimentacoesJornalControl = class
  private
    FListagem : TMovimentacoes;
  public
    constructor Create();
    destructor Destroy(); override;
    property Lista: TMovimentacoes read FListagem write FListagem;
    function Localizar(aParam: array of variant): TFDQuery;
    function Gravar(): Boolean;
    function ImportData(sFile: String; dateData: TDate): Boolean;

    function DeleteEdicao(): Boolean;
  end;

implementation

{ TListagemMovimentacoesJornalControl }

constructor TListagemMovimentacoesJornalControl.Create;
begin
  FListagem := TMovimentacoes.Create;
end;

function TListagemMovimentacoesJornalControl.DeleteEdicao: Boolean;
begin
  if not Flistagem.DeleteEdicao() then
  begin
    TUtils.Dialog('Atenção', 'Erro ao excluir a data do banco de dados!', 0);
  end;
end;

destructor TListagemMovimentacoesJornalControl.Destroy;
begin
  FListagem.Free;
  inherited;
end;

function TListagemMovimentacoesJornalControl.Gravar: Boolean;
begin
  Result := False;
  Result := FListagem.Gravar;
end;

function TListagemMovimentacoesJornalControl.ImportData(sFile: String; dateData: TDate): Boolean;
var
  FPlanilha: TPlanilhaListagem;
  FDados: TObjectList<TPlanilhaListagem>;
  i: Integer;
  fdMovimento : TFDQuery;
begin
  try
    try
      Result := False;
      FPlanilha := TPlanilhaListagem.Create;
      fdMovimento := FListagem.QueryInsertMode();
      Flistagem.Edicao := IncDay(dateData, -7);
      FListagem.DeleteEdicao();
      FDados := TObjectList<TPlanilhaListagem>.Create;
      FDados := FPlanilha.GetPlanilha(sFile);
      if FDados = nil then Exit;
      if FDados.Count = 0 then Exit;
      for i := 0 to FDados.Count - 1 do
      begin
        fdMovimento.Params.ArraySize := i + 1;
        fdMovimento.ParamByName('cod_agente').AsIntegers[i] :=  StrToIntDef(FDados[i].CodigoAgente,0);
        fdMovimento.ParamByName('dat_edicao').AsDateTimes[i] := dateData;
        fdMovimento.ParamByName('des_status').AsStrings[i] := FDados[i].DescricaoStatus;
        fdMovimento.ParamByName('des_endereco').AsStrings[i] := FDados[i].Logradouro;
        fdMovimento.ParamByName('des_complemento').AsStrings[i] := FDados[i].Complemento;
        fdMovimento.ParamByName('des_bairro').AsStrings[i] := FDados[i].Bairro;
        fdMovimento.ParamByName('cod_assinante').AsStrings[i] := FDados[i].CodigoAssinante;
        fdMovimento.ParamByName('nom_assinante').AsStrings[i] := FDados[i].NomeAssinante;
        fdMovimento.ParamByName('des_produto').AsStrings[i] := FDados[i].SiglaProduto;
        fdMovimento.ParamByName('cod_modalidade').AsIntegers[i] := StrToIntDef(FDados[i].Modalidade,0);
      end;
      fdMovimento.Execute(i,0);
      Result := True;
    Except
      on E: Exception do
        begin
          TUtils.Dialog('Erro', 'Classe: ' + E.ClassName + chr(13) + 'Mensagem: ' + E.Message, 0);
        end;
    end;
  finally
    FPlanilha.Free;
    fdMovimento.Free;
  end;
end;

function TListagemMovimentacoesJornalControl.Localizar(aParam: array of variant): TFDQuery;
begin
  Result := FListagem.Localizar(aParam);
end;

end.

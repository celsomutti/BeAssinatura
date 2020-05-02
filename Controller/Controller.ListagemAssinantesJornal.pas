unit Controller.ListagemAssinantesJornal;

interface

uses System.SysUtils, FireDAC.Comp.Client, Common.ENum, Controller.Sistema, Model.ListagemAssinantesJornal,
  Controller.PlanilhaListagemJornal, Generics.Collections, Model.PlanilhaListagemJornal, System.Classes;

type
  TListagemAssinantesJornalControl = class
  private
    FListagem : TListagemAssinantesJornal;
    fdAssinaturas: TFDQuery;
  public
    constructor Create();
    destructor Destroy(); override;
    property Lista: TListagemAssinantesJornal read FListagem write FListagem;
    function Localizar(aParam: array of variant): TFDQuery;
    function Gravar(): Boolean;
    function ImportData(sFile: String; dateData: TDate): Boolean;

    function DeleteEdicao(): Boolean;
    function DeleteAll(): Boolean;
  end;

implementation

{ TListagemAssinantesJornalControl }

uses dataModule, Common.Utils;

constructor TListagemAssinantesJornalControl.Create;
begin
  FListagem := TListagemAssinantesJornal.Create;
end;

function TListagemAssinantesJornalControl.DeleteAll: Boolean;
begin
  if not Flistagem.DeleteAll() then
  begin
    TUtils.Dialog('Atenção', 'Erro ao limpar o banco de dados!', 0);
  end;
end;

function TListagemAssinantesJornalControl.DeleteEdicao: Boolean;
begin
  if not Flistagem.DeleteEdicao() then
  begin
    TUtils.Dialog('Atenção', 'Erro ao excluir a data do banco de dados!', 0);
  end;
end;

destructor TListagemAssinantesJornalControl.Destroy;
begin
  FListagem.Free;
  inherited;
end;

function TListagemAssinantesJornalControl.Gravar: Boolean;
begin
  Result := False;
  Result := FListagem.Gravar;
end;

function TListagemAssinantesJornalControl.ImportData(sFile: String; dateData: TDate): Boolean;
var
  FPlanilha: TPlanilhaListagemJornalControl;
  idiaSemana : Integer;
  FDados: TObjectList<TPlanilhaListagemJornal>;
  i: Integer;
  fdAssinaturas : TFDQuery;
begin
  try
    try
      Result := False;
      FPlanilha := TPlanilhaListagemJornalControl.Create;
      fdAssinaturas := FListagem.QueryInsertMode();
      idiaSemana := DayOfWeek(dateData);
      if idiaSemana in [3,4,5,6,7] then
      begin
        FListagem.DeleteAll();
      end
      else
      begin
        Flistagem.Edicao := dateData;;
        FListagem.DeleteEdicao();
      end;
      FDados := TObjectList<TPlanilhaListagemJornal>.Create;
      FDados := FPlanilha.GetPlanilha(sFile);
      if FDados = nil then Exit;
      if FDados.Count = 0 then Exit;
      for i := 0 to FDados.Count - 1 do
      begin
        fdAssinaturas.Params.ArraySize := i + 1;
        fdAssinaturas.ParamByName('pcod_agente').AsIntegers[i] :=  StrToIntDef(FDados[i].Agente,0);
        fdAssinaturas.ParamByName('pdat_edicao').AsDateTimes[i] := dateData;
        fdAssinaturas.ParamByName('pcod_assinatura').AsStrings[i] := FDados[i].Codigo;
        fdAssinaturas.ParamByName('pnom_assinante').AsStrings[i] := FDados[i].Nome;
        fdAssinaturas.ParamByName('pdes_endereco').AsStrings[i] := FDados[i].Endereco;
        fdAssinaturas.ParamByName('pnum_endereco').AsStrings[i] := FDados[i].Numero;
        fdAssinaturas.ParamByName('pdes_complemento').AsStrings[i] := FDados[i].Complemento;
        fdAssinaturas.ParamByName('pdes_bairro').AsStrings[i] := FDados[i].Bairro;
        fdAssinaturas.ParamByName('pnum_cep').AsStrings[i] := FDados[i].CEP;
        fdAssinaturas.ParamByName('pdes_referencia').AsStrings[i] := FDados[i].Referencia;
        fdAssinaturas.ParamByName('pdes_produto').AsStrings[i] := FDados[i].Produto;
        fdAssinaturas.ParamByName('pcod_modalidade').AsIntegers[i] := StrToIntDef(FDados[i].Modalidade,1);
        fdAssinaturas.ParamByName('pdes_modalidade').AsStrings[i] := FDados[i].DescricaoModalidade;
        fdAssinaturas.ParamByName('pqtd_exemplares').AsIntegers[i] := StrToIntDef(FDados[i].Quantidade,1);
      end;
      fdAssinaturas.Execute(i,0);
      Result := True;
    Except
      on E: Exception do
        begin
          TUtils.Dialog('Erro', 'Classe: ' + E.ClassName + chr(13) + 'Mensagem: ' + E.Message, 0);
        end;
    end;
  finally
    FPlanilha.Free;
    fdAssinaturas.Free;
  end;
end;

function TListagemAssinantesJornalControl.Localizar(aParam: array of variant): TFDQuery;
begin
  Result := FListagem.Localizar(aParam);
end;

end.

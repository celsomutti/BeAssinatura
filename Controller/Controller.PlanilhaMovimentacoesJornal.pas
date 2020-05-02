unit Controller.PlanilhaMovimentacoesJornal;

interface

uses System.SysUtils, Generics.Collections, Model.PlanilhaMovimentacaoJornal;

implementation

type
  TPlanilhaMovimentacoeslControl = class
  public
    constructor Create;
    destructor Destroy; override;
    function GetPlanilha(FFile: String): TObjectList<TPlanilhaListagem>;
  private
    FPlanilha: TPlanilhaListagem;

  end;

{ TPlanilhaMovimentacoeslControl }

constructor TPlanilhaMovimentacoeslControl.Create;
begin
  FPlanilha := TPlanilhaListagem.Create;
end;

destructor TPlanilhaMovimentacoeslControl.Destroy;
begin
  FPlanilha.Free;
  inherited;
end;

function TPlanilhaMovimentacoeslControl.GetPlanilha(FFile: String): TObjectList<TPlanilhaListagem>;
begin
  Result := FPlanilha.GetPlanilha(FFile);
end;

end.

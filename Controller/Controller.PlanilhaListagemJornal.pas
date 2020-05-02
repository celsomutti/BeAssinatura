unit Controller.PlanilhaListagemJornal;

interface

uses System.SysUtils, Generics.Collections, Model.PlanilhaListagemJornal;

type
  TPlanilhaListagemJornalControl = class
  public
    constructor Create;
    destructor Destroy; override;
    function GetPlanilha(FFile: String): TObjectList<TPlanilhaListagemJornal>;
  private
    FPlanilha: TPlanilhaListagemJornal;
  end;

implementation

constructor TPlanilhaListagemJornalControl.Create;
begin
  FPlanilha := TPlanilhaListagemJornal.Create;
end;

destructor TPlanilhaListagemJornalControl.Destroy;
begin
  FPlanilha.Free;
  inherited;
end;

function TPlanilhaListagemJornalControl.GetPlanilha(FFile: String): TObjectList<TPlanilhaListagemJornal>;
begin
  Result := FPlanilha.GetPlanilha(FFile);
end;

end.

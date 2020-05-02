program BEeAssinatura;

uses
  Vcl.Forms,
  View.Main in 'View\View.Main.pas' {view_Main},
  Vcl.Themes,
  Vcl.Styles,
  Common.ENum in 'Common\Common.ENum.pas',
  Common.Utils in 'Common\Common.Utils.pas',
  Global.Parametros in 'Common\Global.Parametros.pas',
  View.ImportacaoAssinaturas in 'View\View.ImportacaoAssinaturas.pas' {view_ImportacaoAssinaturas},
  View.ImportacaoMovimentacao in 'View\View.ImportacaoMovimentacao.pas' {view_ImportacaoMovimentacao},
  dataModule in 'Common\dataModule.pas' {Data_Module: TDataModule},
  Model.ListagemAssinantesJornal in 'Model\Model.ListagemAssinantesJornal.pas',
  DAO.Conexao in 'DAO\DAO.Conexao.pas',
  Controller.ListagemAssinantesJornal in 'Controller\Controller.ListagemAssinantesJornal.pas',
  Controller.Sistema in 'Controller\Controller.Sistema.pas',
  Controller.PlanilhaListagemJornal in 'Controller\Controller.PlanilhaListagemJornal.pas',
  Model.PlanilhaListagemJornal in 'Model\Model.PlanilhaListagemJornal.pas',
  View.Dialog in 'View\View.Dialog.pas' {view_Dialog},
  Model.ListagemMovimentacoesJornal in 'Model\Model.ListagemMovimentacoesJornal.pas',
  Model.PlanilhaMovimentacaoJornal in 'Model\Model.PlanilhaMovimentacaoJornal.pas',
  Controller.ListagemMovimentacoesJornal in 'Controller\Controller.ListagemMovimentacoesJornal.pas',
  Controller.PlanilhaMovimentacoesJornal in 'Controller\Controller.PlanilhaMovimentacoesJornal.pas',
  View.CadastroControleUsuarios in 'View\View.CadastroControleUsuarios.pas' {view_CadastroControleUsuarios},
  Model.UsuariosJornal in 'Model\Model.UsuariosJornal.pas',
  Controller.Usuarios in 'Controller\Controller.Usuarios.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'BEeAssinatura';
  Application.CreateForm(Tview_Main, view_Main);
  Application.CreateForm(TData_Module, Data_Module);
  Application.Run;
end.

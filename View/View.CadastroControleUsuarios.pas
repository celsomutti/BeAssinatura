unit View.CadastroControleUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, System.Actions,
  Vcl.ActnList, Common.Utils, Vcl.Menus;

type
  Tview_CadastroControleUsuarios = class(TForm)
    panelTitle: TPanel;
    lblTitle: TLabel;
    dataSourceUsuarios: TDataSource;
    DBGrid1: TDBGrid;
    panelButtonImportar: TPanel;
    speedButtonSair: TSpeedButton;
    aclUsuarios: TActionList;
    actSair: TAction;
    imageLogo: TImage;
    actGravar: TAction;
    panelGravar: TPanel;
    speedButtonGravar: TSpeedButton;
    popupMenuUsuarios: TPopupMenu;
    actAtivar: TAction;
    actDesativar: TAction;
    Ativarusurio1: TMenuItem;
    Desativar1: TMenuItem;
    procedure actSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actGravarExecute(Sender: TObject);
    procedure actAtivarExecute(Sender: TObject);
    procedure actDesativarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure SaveDB;
    procedure DesativarUsuario;
    procedure AtivarUsuario;
  public
    { Public declarations }
  end;

var
  view_CadastroControleUsuarios: Tview_CadastroControleUsuarios;

implementation

{$R *.dfm}

uses dataModule;

procedure Tview_CadastroControleUsuarios.actAtivarExecute(Sender: TObject);
begin
  AtivarUsuario;
end;

procedure Tview_CadastroControleUsuarios.actDesativarExecute(Sender: TObject);
begin
  DesativarUsuario;
end;

procedure Tview_CadastroControleUsuarios.actGravarExecute(Sender: TObject);
begin
  SaveDB;
end;

procedure Tview_CadastroControleUsuarios.actSairExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure Tview_CadastroControleUsuarios.AtivarUsuario;
begin
  if Data_Module.memTableUsuariosdom_ativo.AsInteger = 1 then
  begin
    TUtils.Dialog( 'Atenção', 'Usuário já está ativo!',2);
    Exit;
  end;
  Data_Module.memTableUsuarios.Edit;
  Data_Module.memTableUsuariosdom_ativo.AsInteger := 1;
  Data_Module.memTableUsuarios.Post;
end;

procedure Tview_CadastroControleUsuarios.DesativarUsuario;
begin
  if Data_Module.memTableUsuariosdom_ativo.AsInteger = 0 then
  begin
    TUtils.Dialog( 'Atenção', 'Usuário já está inativo!',2);
    Exit;
  end;
  Data_Module.memTableUsuarios.Edit;
  Data_Module.memTableUsuariosdom_ativo.AsInteger := 0;
  Data_Module.memTableUsuarios.Post;
end;

procedure Tview_CadastroControleUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Data_Module.memTableUsuarios.Active then Data_Module.memTableUsuarios.Close;
  Action := caFree;
  view_CadastroControleUsuarios := nil;
end;

procedure Tview_CadastroControleUsuarios.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Data_Module.memTableUsuarios.Tag = 1 then
  begin
    CanClose := TUtils.Dialog( 'Sair', 'Dados de usuários foram alterados. Deseja sair sem gravar no banco de dados?',3) = IDOK;
  end;
end;

procedure Tview_CadastroControleUsuarios.FormShow(Sender: TObject);
begin
  lblTitle.Caption := Self.Caption;
  Data_Module.PopuleUsuarios;
end;

procedure Tview_CadastroControleUsuarios.SaveDB;
begin
  if Data_Module.memTableUsuarios.Tag = 0 then
  begin
    TUtils.Dialog( 'Atenção', 'Nehuma informação foi alterada!',0);
    Exit;
  end;
  if TUtils.Dialog( 'Gravar', 'Confirma gravar as alterações no banco de dados ?',3) = IDOK then
  begin
    if not Data_Module.SaveUsuarios() then
    begin
      TUtils.Dialog( 'Erro', 'Ocorreu um problema ao gravar no banco de dados!',2);
    end
    else
    begin
      Data_Module.PopuleUsuarios;
    end;
  end;
end;

end.

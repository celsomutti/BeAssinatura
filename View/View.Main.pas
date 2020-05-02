unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, dxGDIPlusClasses, Vcl.StdCtrls, Common.Utils, System.Actions, Vcl.ActnList,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.CategoryButtons, Controller.Sistema;

type
  Tview_Main = class(TForm)
    panelTitle: TPanel;
    panelLogo: TPanel;
    imageLogo: TImage;
    lblTitle: TLabel;
    lblInternalName: TLabel;
    imageClock: TImage;
    lblClock: TLabel;
    lblDate: TLabel;
    Timer: TTimer;
    panelControlForm: TPanel;
    actionListMain: TActionList;
    imageListMain: TImageList;
    actMinimizar: TAction;
    actFechar: TAction;
    panelMenu: TPanel;
    CategoryButtons1: TCategoryButtons;
    imageListMenu: TImageList;
    actAssinaturas: TAction;
    actMovimentacoes: TAction;
    actUsuarosApp: TAction;
    speedButtonMinimizar: TSpeedButton;
    speedButtonFechar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actMinimizeExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actAssinaturasExecute(Sender: TObject);
    procedure actMovimentacoesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actUsuarosAppExecute(Sender: TObject);
    procedure speedButtonMinimizarClick(Sender: TObject);
    procedure speedButtonFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayClock(datDate: TDateTime);
  public
    { Public declarations }
  end;

var
  view_Main: Tview_Main;

implementation

{$R *.dfm}

uses View.ImportacaoAssinaturas, View.ImportacaoMovimentacao, View.CadastroControleUsuarios;

procedure Tview_Main.actAssinaturasExecute(Sender: TObject);
begin
  if not Assigned(view_ImportacaoAssinaturas) then
  begin
    view_ImportacaoAssinaturas := Tview_ImportacaoAssinaturas.Create(Application);
  end;
  imageListMenu.GetIcon(0, view_ImportacaoAssinaturas.imageLogo.Picture.Icon);
  view_ImportacaoAssinaturas.Show;
end;

procedure Tview_Main.actFecharExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure Tview_Main.actMinimizeExecute(Sender: TObject);
begin
  Self.WindowState := wsMinimized;
end;

procedure Tview_Main.actMovimentacoesExecute(Sender: TObject);
begin
  if not Assigned(view_ImportacaoMovimentacao) then
  begin
    view_ImportacaoMovimentacao := Tview_ImportacaoMovimentacao.Create(Application);
  end;
  imageListMenu.GetIcon(1, view_ImportacaoMovimentacao.imageLogo.Picture.Icon);
  view_ImportacaoMovimentacao.Show;
end;

procedure Tview_Main.actUsuarosAppExecute(Sender: TObject);
begin
if not Assigned(view_CadastroControleUsuarios) then
  begin
    view_CadastroControleUsuarios := Tview_CadastroControleUsuarios.Create(Application);
  end;
  imageListMenu.GetIcon(2, view_CadastroControleUsuarios.imageLogo.Picture.Icon);
  view_CadastroControleUsuarios.Show;
end;

procedure Tview_Main.DisplayClock(datDate: TDateTime);
begin
  lblClock.Caption := FormatDateTime('hh:mm:ss', datDate);
  lblDate.Caption := FormatDateTime('dddd, dd/mm/yyyy', datDate);
end;

procedure Tview_Main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := TUtils.Dialog('Sair', 'Confirma sair da aplicação?', 3) = IDOK;
end;

procedure Tview_Main.FormCreate(Sender: TObject);
begin
  TSistemaControl.GetInstance();
  if not TSistemaControl.GetInstance().Start then
  begin
    TUtils.Dialog('Atenção', 'Arquivo de inicialização não foi encontrado! Entre em contato com o suporte.', 2);
    Application.Terminate;
  end;
end;

procedure Tview_Main.FormShow(Sender: TObject);
begin
  Self.Top := Screen.WorkAreaTop;
  Self.Left := Screen.WorkAreaLeft;
  Self.Width := Screen.WorkAreaWidth;
  Self.Height := Screen.WorkAreaHeight;
  lblTitle.Caption :=  Application.Title;
  lblInternalName.Caption := TUtils.Sistema('InternalName');

  DisplayClock(Now());
end;

procedure Tview_Main.speedButtonFecharClick(Sender: TObject);
begin
  actFecharExecute(Self);
end;

procedure Tview_Main.speedButtonMinimizarClick(Sender: TObject);
begin
  actMinimizeExecute(Self);
end;

procedure Tview_Main.TimerTimer(Sender: TObject);
begin
  DisplayClock(Now());
end;

end.

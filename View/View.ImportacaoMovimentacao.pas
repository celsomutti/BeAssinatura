unit View.ImportacaoMovimentacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Buttons, Vcl.ComCtrls,
  System.DateUtils, Controller.ListagemMovimentacoesJornal;
type
  Tview_ImportacaoMovimentacao = class(TForm)
    panelTitle: TPanel;
    lblTitle: TLabel;
    panelButtonImportar: TPanel;
    panelButtonSair: TPanel;
    aclMovimento: TActionList;
    actImportar: TAction;
    actSair: TAction;
    speedButtonImportar: TSpeedButton;
    speedButtonSair: TSpeedButton;
    lblArquivo: TLabel;
    editArquivo: TEdit;
    lblData: TLabel;
    dateTimePickerData: TDateTimePicker;
    speedButtonArquivo: TSpeedButton;
    actAbrir: TAction;
    lblNotice: TLabel;
    imageLogo: TImage;
    procedure actSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actAbrirExecute(Sender: TObject);
    procedure actImportarExecute(Sender: TObject);
  private
    { Private declarations }
     procedure ImportData;
    procedure ClearForm;
    function ValidateProcess(): Boolean;
  public
    { Public declarations }
  end;

var
  view_ImportacaoMovimentacao: Tview_ImportacaoMovimentacao;

implementation

{$R *.dfm}

uses dataModule, Common.Utils;

procedure Tview_ImportacaoMovimentacao.actAbrirExecute(Sender: TObject);
begin
  if Data_Module.FileOpenDialog.Execute then
  begin
    editArquivo.Text := Data_Module.FileOpenDialog.FileName;
  end;
end;

procedure Tview_ImportacaoMovimentacao.actImportarExecute(Sender: TObject);
begin
  ImportData;
end;

procedure Tview_ImportacaoMovimentacao.actSairExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure Tview_ImportacaoMovimentacao.ClearForm;
begin
  editArquivo.Clear;
  dateTimePickerData.Date := IncDay(Now(),1);
  editArquivo.SetFocus;
  lblNotice.Visible := False;
end;

procedure Tview_ImportacaoMovimentacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_ImportacaoMovimentacao := Nil;
end;

procedure Tview_ImportacaoMovimentacao.FormShow(Sender: TObject);
begin
  lblTitle.Caption := Self.Caption;
  ClearForm;
end;

procedure Tview_ImportacaoMovimentacao.ImportData;
var
  FListagem: TListagemMovimentacoesJornalControl;
begin
  if not ValidateProcess() then Exit;

  if TUtils.Dialog( 'Importar', 'Confirma a importação do arquivo ?',3) = IDOK then
  begin
    lblNotice.Visible := True;
    lblNotice.Refresh;
    FListagem := TListagemMovimentacoesJornalControl.Create;
    if not FListagem.ImportData(editArquivo.Text, dateTimePickerData.Date) then
    begin
      TUtils.Dialog('Atenção', 'Operação NÃO foi concluída!', 2);
    end
    else
    begin
      TUtils.Dialog('Sucesso', 'Operação concluída!', 1);
    end;
    ClearForm;
    FListagem.Free;
  end;
end;

function Tview_ImportacaoMovimentacao.ValidateProcess: Boolean;
begin
  Result := False;
  if editArquivo.Text = '' then
  begin
    TUtils.Dialog('Atenção', 'Informe o arquivo de planilha a ser importado!', 0);
    editArquivo.SetFocus;
    Exit;
  end;
  Result := True;
end;

end.

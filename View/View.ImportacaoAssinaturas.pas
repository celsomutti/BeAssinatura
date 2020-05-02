unit View.ImportacaoAssinaturas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.WinXPickers, Vcl.WinXCtrls, Controller.ListagemAssinantesJornal,
  System.DateUtils;

type
  Tview_ImportacaoAssinaturas = class(TForm)
    actionListImportacao: TActionList;
    actionImportar: TAction;
    panelTitle: TPanel;
    lblTitle: TLabel;
    panelButtonImportar: TPanel;
    panelButtonSair: TPanel;
    speedButtonImportar: TSpeedButton;
    speedButtonSair: TSpeedButton;
    actSair: TAction;
    lblArquivo: TLabel;
    editArquivo: TEdit;
    actAbrirArquivo: TAction;
    lblData: TLabel;
    dateTimePickerData: TDateTimePicker;
    lblNotice: TLabel;
    speedButtonArquivo: TSpeedButton;
    imageLogo: TImage;
    procedure FormShow(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actAbrirArquivoExecute(Sender: TObject);
    procedure actionImportarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure ImportData;
    procedure ClearForm;
    function ValidateProcess(): Boolean;
  public
    { Public declarations }
  end;

var
  view_ImportacaoAssinaturas: Tview_ImportacaoAssinaturas;

implementation

{$R *.dfm}

uses dataModule, System.Threading, Common.Utils;

procedure Tview_ImportacaoAssinaturas.actAbrirArquivoExecute(Sender: TObject);
begin
  if Data_Module.FileOpenDialog.Execute then
  begin
    editArquivo.Text := Data_Module.FileOpenDialog.FileName;
  end;
end;

procedure Tview_ImportacaoAssinaturas.actionImportarExecute(Sender: TObject);
begin
  ImportData;
end;

procedure Tview_ImportacaoAssinaturas.actSairExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure Tview_ImportacaoAssinaturas.ClearForm;
begin
  editArquivo.Clear;
  dateTimePickerData.Date := IncDay(Now(),1);
  editArquivo.SetFocus;
  lblNotice.Visible := False;
end;

procedure Tview_ImportacaoAssinaturas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_ImportacaoAssinaturas := Nil;
end;

procedure Tview_ImportacaoAssinaturas.FormShow(Sender: TObject);
begin
  lblTitle.Caption := Self.Caption;
  ClearForm;
end;

procedure Tview_ImportacaoAssinaturas.ImportData;
var
  FListagem: TListagemAssinantesJornalControl;
begin
  if not ValidateProcess() then Exit;

  if TUtils.Dialog( 'Importar', 'Confirma a importação do arquivo ?',3) = IDOK then
  begin
    lblNotice.Visible := True;
    lblNotice.Refresh;
    FListagem := TListagemAssinantesJornalControl.Create;
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


function Tview_ImportacaoAssinaturas.ValidateProcess: Boolean;
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

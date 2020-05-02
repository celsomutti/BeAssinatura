unit View.Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, System.UITypes;

type
  Tview_Dialog = class(TForm)
    panelTitle: TPanel;
    imageListDialog: TImageList;
    labelDialogTitle: TLabel;
    aclDialog: TActionList;
    actOK: TAction;
    actCancelar: TAction;
    panelIcon: TPanel;
    imageIcon: TImage;
    panelBackGround: TPanel;
    panelOK: TPanel;
    speedButtonOK: TSpeedButton;
    panelCancelar: TPanel;
    speedButtonCancelar: TSpeedButton;
    labelMensagem: TLabel;
    procedure actOKExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetupDialog;
  public
    { Public declarations }
    Tipo: Integer;
    Titulo: String;
    Mensagem: String;
    Resultado: Integer;
  end;

var
  view_Dialog: Tview_Dialog;

implementation

{$R *.dfm}

procedure Tview_Dialog.actCancelarExecute(Sender: TObject);
begin
  Resultado := mrCancel;
  Close;
end;

procedure Tview_Dialog.actOKExecute(Sender: TObject);
begin
  Resultado := mrOk;
  Close;
end;

procedure Tview_Dialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    actOKExecute(Self);
  end
  else if Key = #27 then
  begin
    actCancelarExecute(Self);
  end;
  Key := #0;
end;

procedure Tview_Dialog.FormShow(Sender: TObject);
begin
  SetupDialog;
end;

procedure Tview_Dialog.SetupDialog;
begin
  if Tipo = 0 then
  begin
    panelIcon.Color := clYellow;
    panelOK.Visible := False;
  end
  else if Tipo = 1 then
  begin
    panelCancelar.Visible := False;
  end
  else if Tipo = 2 then
  begin
    panelIcon.Color := clRed;
    panelOK.Visible := False;
  end
  else
  begin
    panelIcon.Color := clMenuHighlight;
  end;
  imageListDialog.GetIcon(Tipo,imageIcon.Picture.Icon);
  labelDialogTitle.Caption := Titulo;
  labelMensagem.Caption := Mensagem;
  Beep;
end;

end.

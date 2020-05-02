unit dataModule;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, Vcl.Dialogs, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.Usuarios, Common.Utils,
  Windows, Common.ENum;

type
  TData_Module = class(TDataModule)
    imageList_16_16: TImageList;
    FileOpenDialog: TFileOpenDialog;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    memTableUsuarios: TFDMemTable;
    memTableUsuariosid_usuario: TIntegerField;
    memTableUsuariosnom_usuario: TStringField;
    memTableUsuariosdes_login: TStringField;
    memTableUsuariosdes_senha: TStringField;
    memTableUsuarioscod_agente: TStringField;
    memTableUsuariosdom_ativo: TSmallintField;
    procedure memTableUsuariosBeforeDelete(DataSet: TDataSet);
    procedure memTableUsuariosAfterDelete(DataSet: TDataSet);
    procedure memTableUsuariosBeforePost(DataSet: TDataSet);
    procedure memTableUsuariosAfterPost(DataSet: TDataSet);
    procedure memTableUsuariosAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    function ValidateUsuario(): Boolean;
    function DeleteUser(iID: Integer): Boolean;
  public
    { Public declarations }
    function PopuleUsuarios(): Boolean;
    function SaveUsuarios(): Boolean;
  end;

var
  Data_Module: TData_Module;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TData_Module }

function TData_Module.DeleteUser(iID: Integer): Boolean;
var
  usuario : TUsuarioControl;
begin
  try
    Result := False;
    usuario := TUsuarioControl.Create;
    usuario.Usuarios.Codigo := iID;
    usuario.Usuarios.Acao := tacExcluir;
    Result := usuario.Gravar();
  finally
    usuario.Free;
  end;
end;

procedure TData_Module.memTableUsuariosAfterDelete(DataSet: TDataSet);
begin
  PopuleUsuarios;
end;

procedure TData_Module.memTableUsuariosAfterInsert(DataSet: TDataSet);
begin
  if memTableUsuarios.Tag = -1 then Exit;
  memTableUsuariosid_usuario.AsInteger := 0;
  memTableUsuariosdom_ativo.AsInteger := 1;
end;

procedure TData_Module.memTableUsuariosAfterPost(DataSet: TDataSet);
begin
  if memTableUsuarios.Tag = -1 then Exit;
  memTableUsuarios.Tag := 1;
end;

procedure TData_Module.memTableUsuariosBeforeDelete(DataSet: TDataSet);
begin
  if memTableUsuarios.Tag = -1 then Exit;
  if TUtils.Dialog( 'Excluir', 'Confirma exclusão do usuário ?',3) = IDCANCEL then
  begin
   Abort;
  end;
  if not DeleteUser(memTableUsuariosid_usuario.AsInteger) then
  begin
    TUtils.Dialog('Erro', 'Erro ao excluir o usuário',2);
    Abort;
  end

end;

procedure TData_Module.memTableUsuariosBeforePost(DataSet: TDataSet);
begin
  if memTableUsuarios.Tag = -1 then Exit;
  if not ValidateUsuario() then Abort;
end;

function TData_Module.PopuleUsuarios: Boolean;
var
  usuarios : TUsuarioControl;
  aParam: array of variant;
begin
  try
    usuarios := TUsuarioControl.Create;
    SetLength(aParam,3);
    aParam := ['APOIO', '*', ''];
    if memTableUsuarios.Active then memTableUsuarios.Close;
    memTableUsuarios.Open;
    memTableUsuarios.Tag := -1;
    memTableUsuarios.CopyDataSet(usuarios.Localizar(aParam),[coRestart, coAppend]);
    memTableUsuarios.Tag := 0;
  finally
    usuarios.Free;
  end;
end;

function TData_Module.SaveUsuarios: Boolean;
var
  usuarios : TUsuarioControl;
begin
  try
    Result := False;
    usuarios := TUsuarioControl.Create;
    Result := usuarios.SaveData(memTableUsuarios);
    memTableUsuarios.Tag := 0;
  finally
    usuarios.Free;
  end;
end;

function TData_Module.ValidateUsuario: Boolean;
var
  usuario : TUsuarioControl;
  iID: Integer;
begin
  try
    Result := False;
    usuario := TUsuarioControl.Create;
    if memTableUsuariosnom_usuario.AsString.IsEmpty then
    begin
      TUtils.Dialog('Atenção', 'Informe o nome do usuário.',0);
      Exit;
    end;
    if memTableUsuariosdes_login.AsString.IsEmpty then
    begin
      TUtils.Dialog('Atenção', 'Informe o login do usuário.',0);
      Exit;
    end;
    if memTableUsuariosdes_senha.AsString.IsEmpty then
    begin
      TUtils.Dialog('Atenção', 'Informe uma senha.',0);
      Exit;
    end;
    if memTableUsuarioscod_agente.AsString.IsEmpty then
    begin
      TUtils.Dialog('Atenção', 'Informe oos códigos dod roteiros.',0);
      Exit;
    end;
    if memTableUsuariosid_usuario.AsInteger = 0 then
    begin
      iID := usuario.GetID;
      memTableUsuariosid_usuario.AsInteger := iID;
    end;
    Result := True;
  finally
    usuario.Free;
  end;
end;

end.

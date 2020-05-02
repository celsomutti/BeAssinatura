unit Controller.Sistema;

interface

uses
  System.SysUtils, VCL.Forms, System.Classes, DAO.Conexao, Common.Utils, Global.Parametros;

  type
    TSistemaControl = class
    private

      FConexao: TConexao;
      FStart: Boolean;

      class var FInstante : TSistemaControl;

    public

      constructor Create;
      destructor Destroy; override;

      class function GetInstance: TSistemaControl;

      property Conexao: TConexao read FConexao write FConexao;
      property Start: Boolean read FStart write FStart;
      function StartGlobal(): Boolean;
      function SaveParamINI(sSection: String; sKey: String; sValue: String): Boolean;
      function ReturSkin(iIndex: Integer): String;
      function LoadSkinsINI(): TStringList;
    end;
const
  INIFILE = 'database.ini';

implementation

{ TSistemaControl }

constructor TSistemaControl.Create;
begin
  FStart := StartGlobal;
  if FStart then FConexao := TConexao.Create;
end;

destructor TSistemaControl.Destroy;
begin
  FConexao.Free;
  inherited;
end;

class function TSistemaControl.GetInstance: TSistemaControl;
begin
  if not Assigned(Self.FInstante) then
  begin
    Self.FInstante := TSistemaControl.Create();
  end;
  Result := Self.FInstante;
end;

function TSistemaControl.LoadSkinsINI: TStringList;
var
  sSkinIni : String;
  lLista: TStringList;
  iIndex : Integer;
  sSkin: String;
begin
  sSkinINI := ExtractFilePath(Application.ExeName) + '\skins.ini';
  if not FileExists(sSkinINI) then Exit;
  iIndex := 0;
  lLista := TStringlist.Create();
  sSkin := 'NONE';
  while not sSKin.IsEmpty do
  begin
    sSkin := Common.Utils.TUtils.LeIni(sSkinINI,'Skin',iIndex.ToString);
    if not sSkin.IsEmpty then
    begin
      lLista.Add(sSkin);
    end;
    iIndex := iIndex + 1;
  end;
  Result := lLista;
end;

function TSistemaControl.ReturSkin(iIndex: Integer): String;
var
  sSkinIni : String;
  sSkin: String;
begin
  sSkin := '';
  sSkinINI := ExtractFilePath(Application.ExeName) + '\skins.ini';
  if not FileExists(sSkinINI) then Exit;
  Result := Common.Utils.TUtils.LeIni(sSkinINI,'Skin',iIndex.ToString);
end;

function TSistemaControl.SaveParamINI(sSection, sKey, sValue: String): Boolean;
begin
  Result := False;
  Common.Utils.TUtils.GravaIni(Global.Parametros.pFileIni,sSection,sKey,sValue);
  Result := True;
end;

function TSistemaControl.StartGlobal: Boolean;
begin
  Result := False;
  Global.Parametros.pFileIni := ExtractFilePath(Application.ExeName) + '\' + INIFILE;
  if not FileExists(Global.Parametros.pFileIni) then Exit;
  Global.Parametros.pDriverID := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','DriverID');
  Global.Parametros.pServer := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','HostName');
  Global.Parametros.pDatabase := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','Database');
  Global.Parametros.pPort := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','Port');
  Global.Parametros.pKBD := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','KBD');
  Global.Parametros.pUBD := Common.Utils.TUtils.DesCriptografa(Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','UBD'),StrToIntDef(Global.Parametros.pKBD,0));
  Global.Parametros.pPBD := Common.Utils.TUtils.DesCriptografa(Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','PBD'),StrToIntDef(Global.Parametros.pKBD,0));
  Global.Parametros.pSkin := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Database','Skin');
  Global.Parametros.pLastUser := Common.Utils.TUtils.LeIni(Global.Parametros.pFileIni,'Login','LastUser');
  Result := True;
end;

end.

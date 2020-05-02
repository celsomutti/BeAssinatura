unit DAO.Conexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait, Global.Parametros;

  type
    TConexao = class
    private
      FConn: TFDConnection;
      procedure SetupConnection;
    public
      constructor Create;
      destructor Destroy; override;
      function GetConn: TFDConnection;
      function ReturnQuery: TFDQuery;
    end;

implementation

{ TConexao }

constructor TConexao.Create;
begin
  Fconn := TFDConnection.Create(nil);
  Self.SetupConnection();
end;

destructor TConexao.Destroy;
begin
  FConn.Free;
  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;

function TConexao.ReturnQuery: TFDQuery;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FConn;
  Result := FDQuery;
end;

procedure TConexao.SetupConnection;
begin
  FConn.LoginPrompt := False;
  FConn.ConnectionString := 'DriverID=' + Global.Parametros.pDriverID +
                            ';Server=' + Global.Parametros.pServer +
                            ';Database=' + Global.Parametros.pDatabase +
                            ';Port=' + Global.Parametros.pPort +
                            ';User_name=' + Global.Parametros.pUBD +
                            ';Password=' + Global.Parametros.pPBD;
end;

end.

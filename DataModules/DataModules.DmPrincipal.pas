unit DataModules.DmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Dialogs, FireDAC.VCLUI.Login, FireDAC.Comp.UI, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDmDatabase = class(TDataModule)
    Connection: TFDConnection;
    Link: TFDPhysMySQLDriverLink;
    LoginDialog: TFDGUIxLoginDialog;
  private
    { Private declarations }
  public
    { Public declarations }
    function ConnectDatabase: Boolean;
  end;

var
  DmDatabase: TDmDatabase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmDatabase }

uses
  Models.Connection,
  Services.Connection;

function TDmDatabase.ConnectDatabase: Boolean;
var
  LConnection: TConnection;
  LSvcConnection: TConnectionService;

  function Connect: Boolean;
  begin
    Result := False;
    try

      if Connection.LoginPrompt then
      begin
        Connection.Connected := True;

        LConnection.Database := LoginDialog.ConnectionDef.AsString['Database'];
        LConnection.UserName := LoginDialog.ConnectionDef.AsString['User_Name'];
        LConnection.Password := LoginDialog.ConnectionDef.AsString['Password'];
        LConnection.Server := LoginDialog.ConnectionDef.AsString['Server'];
        LConnection.Port := LoginDialog.ConnectionDef.AsInteger['Port'];

        if LConnection.Port = 0 then
          LConnection.Port := 3306;

        if LConnection.Database = EmptyStr then
        begin
          ShowMessage('O Database não pode ficar em branco!' +
            sLineBreak + 'O sistema será fechado.');
          Exit;
        end;

        LSvcConnection.SaveConnection(LConnection)
      end else
      begin
        Connection.ResultConnectionDef.AsString['Database'] := LConnection.Database;
        Connection.ResultConnectionDef.AsString['User_Name'] := LConnection.UserName;
        Connection.ResultConnectionDef.AsString['Password'] := LConnection.Password;
        Connection.ResultConnectionDef.AsInteger['Port'] := LConnection.Port;
        Connection.ResultConnectionDef.AsString['Server'] := LConnection.Server;

        Connection.Connected := True;
      end;

      Result := True;
    except on E: Exception do
      ShowMessage(
        string.Format('Falha na tentativa de conexão com o banco de dados:  %s' +
                       sLineBreak +
                      'A aplicação será finalizada!',
        [E.Message]));
    end;
  end;

begin
  Result := False;
  LSvcConnection := TConnectionService.Create;

  try
    LConnection := LSvcConnection.GetConnection;

    if LConnection.DllPath = EmptyStr  then
    begin
      ShowMessage('Não encontrado o caminho para a libmysql.dll' + sLineBreak +
       'Informe o caminho completo em ConnSys.ini [Exemplo: LibMySQL=C:\temp\libmysql.dll]' + sLineBreak +
       'O sistema será finalizado!');
      Exit;
    end;

    Link.VendorLib := LConnection.DllPath;
    Connection.LoginPrompt := LConnection.Database = EmptyStr;
    Result := Connect;
  finally
    FreeAndNil(LSvcConnection);
    FreeAndNil(LConnection);
  end;

end;

end.

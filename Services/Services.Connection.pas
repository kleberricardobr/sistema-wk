unit Services.Connection;

interface

uses Models.Connection,
     IniFiles,
     SysUtils,
     Vcl.Forms;

const
  FILE_NAME = 'ConnSys.ini';
  SECTION_NAME = 'CONNECTION';

type
  TConnectionService = class
  private
    FFileFullPath: string;
    FIniFile: TIniFile;

  public
    destructor Destroy; override;
    constructor Create;
    procedure SaveConnection(AConnection: TConnection);
    function GetConnection: TConnection;
  end;

implementation

{ TConnectionService }

constructor TConnectionService.Create;
begin
  FFileFullPath := ExtractFilePath(Application.ExeName) + FILE_NAME;
  FIniFile := TIniFile.Create(FFileFullPath);
end;

destructor TConnectionService.Destroy;
begin
  FreeAndNil(FIniFile);
  inherited;
end;

function TConnectionService.GetConnection: TConnection;
begin
  Result := TConnection.Create;

  if not FileExists(FFileFullPath) then
  begin
    FIniFile.WriteString(SECTION_NAME, 'LibMySQL', '');
    Exit;
  end;

  with Result do
  begin
    Database := FIniFile.ReadString(SECTION_NAME, 'Database', '');
    UserName := FIniFile.ReadString(SECTION_NAME, 'UserName', '');
    Password := FIniFile.ReadString(SECTION_NAME, 'Password', '');
    Port := FIniFile.ReadInteger(SECTION_NAME, 'Port', 3306);
    Server := FIniFile.ReadString(SECTION_NAME, 'Server', '');
    DllPath := FIniFile.ReadString(SECTION_NAME, 'LibMySQL', '');
  end;
end;

procedure TConnectionService.SaveConnection(AConnection: TConnection);
begin
  with FIniFile, AConnection do
  begin
    WriteString(SECTION_NAME, 'Database', Database);
    WriteString(SECTION_NAME, 'UserName', UserName);
    WriteString(SECTION_NAME, 'Password', Password);
    WriteInteger(SECTION_NAME, 'Port', Port);
    WriteString(SECTION_NAME, 'Server', Server);
    WriteString(SECTION_NAME, 'LibMySQL', DllPath);
  end;
end;

end.

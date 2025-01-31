unit Models.Connection;

interface

type
  TConnection = class
  private
    FDatabase: string;
    FUserName: string;
    FPassword: string;
    FServer: string;
    FPort: Integer;
    FDllPath: string;
  public
    property Database: string read FDatabase write FDatabase;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property Server: string read FServer write FServer;
    property Port: Integer read FPort write FPort;
    property DllPath: string read FDllPath write FDllPath;
  end;

implementation

{ TConnection }

end.

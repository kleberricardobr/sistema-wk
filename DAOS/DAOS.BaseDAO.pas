unit DAOS.BaseDAO;

interface

uses Firedac.Comp.Client,
     DataModules.DmPrincipal;

type
  TBaseDAO = class(TInterfacedObject)
    FConnection: TFDConnection;
    FQuery: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBaseDAO }

uses SysUtils;

constructor TBaseDAO.Create;
begin
  FConnection := DmDatabase.Connection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Self.FConnection;
end;

destructor TBaseDAO.Destroy;
begin
  FreeAndNil(Self.FQuery);
  inherited;
end;

end.

unit Services.ClienteService;

interface

uses Interfaces.Services.ClienteServiceInterface,
     Interfaces.DAOS.ClienteDAOInterface,
     Models.Cliente;

type
  TClienteService = class(TInterfacedObject, IClienteService)
  private
    FClienteDAO: IClienteDAO;
  public
    constructor Create(AClienteDAO: IClienteDAO);
    function GetClienteByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteService }

constructor TClienteService.Create(AClienteDAO: IClienteDAO);
begin
  Self.FClienteDAO := AClienteDAO;
end;

function TClienteService.GetClienteByCodigo(ACodigo: Integer): TCliente;
begin
  Result := FClienteDAO.GetClienteByCodigo(ACodigo);
end;

end.

unit Controllers.ClienteController;

interface

uses Interfaces.Controllers.ClienteControllerInterface,
     Interfaces.Services.ClienteServiceInterface,
     Models.Cliente;

type
  TClienteController = class(TInterfacedObject, IClienteController)
  private
    FClienteService: IClienteService;
  public
    constructor Create(AClienteService: IClienteService);
    function GetClienteByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteController }

constructor TClienteController.Create(AClienteService: IClienteService);
begin
  Self.FClienteService := AClienteService;
end;

function TClienteController.GetClienteByCodigo(ACodigo: Integer): TCliente;
begin
  Result := Self.FClienteService.GetClienteByCodigo(ACodigo);
end;

end.

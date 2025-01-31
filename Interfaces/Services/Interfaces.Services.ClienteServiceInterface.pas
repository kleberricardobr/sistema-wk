unit Interfaces.Services.ClienteServiceInterface;

interface

uses Models.Cliente;

type
  IClienteService = interface
    function GetClienteByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

end.

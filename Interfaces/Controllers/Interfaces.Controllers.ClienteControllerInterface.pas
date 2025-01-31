unit Interfaces.Controllers.ClienteControllerInterface;

interface

uses Models.Cliente;

type
  IClienteController = interface
    function GetClienteByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

end.

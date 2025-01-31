unit Interfaces.DAOS.ClienteDAOInterface;

interface

uses Models.Cliente;

type
  IClienteDAO = interface
    function GetClienteByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

end.

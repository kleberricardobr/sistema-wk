unit Interfaces.DAOS.PedidoDAOInterface;

interface

uses Models.Pedido;

type
  IPedidoDAO = interface
    function GetPedidoByCodigo(ACodigo: Integer): TPedido;
    procedure AtualizarPedido(APedido: TPedido);
    procedure SalvarPedido(APedido: TPedido);
    procedure DeletarPedido(ACodigo: Integer);
  end;

implementation

end.

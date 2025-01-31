unit Interfaces.Controllers.PedidoControllerInterface;

interface

uses Models.Pedido;

type
  IPedidoController = interface
    function GetPedidoByCodigo(ACodigo: Integer): TPedido;
    procedure DeletarPedido(ACodigo: Integer);
    procedure AtualizarPedido(APedido: TPedido);
    procedure SalvarPedido(APedido: TPedido);
  end;

implementation

end.

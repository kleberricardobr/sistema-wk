unit Interfaces.Services.PedidoServiceInterface;

interface

uses Models.Pedido;

type
  IPedidoService = interface
    function GetPedidoByCodigo(ACodigo: Integer): TPedido;
    procedure AtualizarPedido(APedido: TPedido);
    procedure SalvarPedido(APedido: TPedido);
    procedure DeletarPedido(ACodigo: Integer);
  end;

implementation

end.

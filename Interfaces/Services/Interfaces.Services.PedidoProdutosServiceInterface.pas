unit Interfaces.Services.PedidoProdutosServiceInterface;

interface

uses  Generics.Collections,
      Models.PedidoProduto;

type
  IPedidoProdutosService = interface
    function GetPedidoProdutosByCodigoPedido(ACodigo: Integer): TObjectList<TPedidoProduto>;
    procedure DeletarTodos(ACodigoPedido: Integer);
    procedure DeletarByID(AID: Integer);
    procedure SalvarProdutos(AListaPedidoProduto: TObjectList<TPedidoProduto>;
      ACodigoPedido: Integer);
  end;

implementation

end.

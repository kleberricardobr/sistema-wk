unit Interfaces.DAOS.PedidoProdutosDAOInterface;

interface

uses Generics.Collections,
     Models.PedidoProduto;

type
  IPedidoProdutosDAO = interface
    function GetPedidoProdutosByCodigoPedido(ACodigo: Integer): TObjectList<TPedidoProduto>;
    procedure SalvarProduto(APedidoProduto: TPedidoProduto; ANumeroPedido: Integer);
    procedure DeletarTodos(ACodidoPedido: Integer);
    procedure DeletarByID(AID: Integer);
  end;

implementation

end.

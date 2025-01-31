unit Interfaces.Controllers.PedidoProdutoControllerInterface;

interface

uses Models.PedidoProduto;

type
  IPedidoProdutoController = interface
    procedure AtualizaProduto(APedidoProduto: TPedidoProduto);
  end;

implementation

end.

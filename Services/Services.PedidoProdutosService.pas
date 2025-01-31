unit Services.PedidoProdutosService;

interface

uses Interfaces.Services.PedidoProdutosServiceInterface,
     Interfaces.DAOS.PedidoProdutosDAOInterface,
     Models.PedidoProduto,
     Generics.Collections;

type
  TPedidoProdutoService = class(TInterfacedObject, IPedidoProdutosService)
  private
    FPedidoProdutosDAO: IPedidoProdutosDAO;
  public
    constructor Create(APedidoProdutosDAO: IPedidoProdutosDAO);
    function GetPedidoProdutosByCodigoPedido(ACodigo: Integer): TObjectList<TPedidoProduto>;
    procedure DeletarTodos(ACodigoPedido: Integer);
    procedure DeletarByID(AID: Integer);
    procedure SalvarProdutos(AListaPedidoProduto: TObjectList<TPedidoProduto>;
      ACodigoPedido: Integer);
  end;

implementation

{ TPedidoProdutoService }

constructor TPedidoProdutoService.Create(
  APedidoProdutosDAO: IPedidoProdutosDAO);
begin
  Self.FPedidoProdutosDAO := APedidoProdutosDAO;
end;

procedure TPedidoProdutoService.DeletarByID(AID: Integer);
begin
  Self.FPedidoProdutosDAO.DeletarByID(AID);
end;

procedure TPedidoProdutoService.DeletarTodos(ACodigoPedido: Integer);
begin
  Self.FPedidoProdutosDAO.DeletarTodos(ACodigoPedido);
end;

function TPedidoProdutoService.GetPedidoProdutosByCodigoPedido(
  ACodigo: Integer): TObjectList<TPedidoProduto>;
begin
  Result := Self.FPedidoProdutosDAO.GetPedidoProdutosByCodigoPedido(ACodigo);
end;

procedure TPedidoProdutoService.SalvarProdutos(
  AListaPedidoProduto: TObjectList<TPedidoProduto>; ACodigoPedido: Integer);
var
  I: Integer;
begin
  // A Transaction está controlada pelo Service do Pedido
  for I := 0 to Pred(AListaPedidoProduto.Count) do
    Self.FPedidoProdutosDAO.SalvarProduto(AListaPedidoProduto.Items[I],
      ACodigoPedido);
end;

end.

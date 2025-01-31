unit Controllers.PedidoProdutoController;

interface

uses Interfaces.Controllers.PedidoProdutoControllerInterface,
     Interfaces.Services.PedidoProdutosServiceInterface,
     Models.PedidoProduto;

type
  TPedidoProdutoController = class(TInterfacedObject, IPedidoProdutoController)
  private
    FPedidoProdutoService: IPedidoProdutosService;
  public
    constructor Create(APedidoProdutoService: IPedidoProdutosService);
  end;

implementation

{ TPedidoProdutoController }

procedure TPedidoProdutoController.AtualizaProduto(
  APedidoProduto: TPedidoProduto);
begin
  Self.FPedidoProdutoService.Atualizar(APedidoProduto);
end;

constructor TPedidoProdutoController.Create(
  APedidoProdutoService: IPedidoProdutosService);
begin
  Self.FPedidoProdutoService := APedidoProdutoService;
end;

end.

unit Controllers.PedidoController;

interface

uses Interfaces.Controllers.PedidoControllerInterface,
     Interfaces.Services.PedidoServiceInterface,
     Interfaces.Services.PedidoProdutosServiceInterface,
     Models.Pedido;

type
  TPedidoController = class(TInterfacedObject, IPedidoController)
  private
    FPedidoService: IPedidoService;
    FPedidoProdutoService: IPedidoProdutosService;
  public
    constructor Create(APedidoService: IPedidoService;
       APedidoProdutoService: IPedidoProdutosService);
    function GetPedidoByCodigo(ACodigo: Integer): TPedido;
    procedure DeletarPedido(ACodigo: Integer);
    procedure SalvarPedido(APedido: TPedido);
    procedure AtualizarPedido(APedido: TPedido);
  end;

implementation

{ TPedidoController }

uses DataModules.DmPrincipal, SysUtils;

procedure TPedidoController.AtualizarPedido(APedido: TPedido);
begin
  DmDatabase.Connection.StartTransaction;
  try
    // Remove todos os produtos e incluir os novos
    Self.FPedidoProdutoService.DeletarTodos(APedido.NumeroPedido);
    Self.FPedidoProdutoService.SalvarProdutos(APedido.PedidoProdutos, APedido.NumeroPedido);

    // Autaliza o cabeçalho como novo total
    Self.FPedidoService.AtualizarPedido(APedido);

    DmDatabase.Connection.Commit;
  except On E: Exception do
    begin
      DmDatabase.Connection.Rollback;
      raise;
    end;
  end;
end;

constructor TPedidoController.Create(APedidoService: IPedidoService;
  APedidoProdutoService: IPedidoProdutosService);
begin
  Self.FPedidoService := APedidoService;
  Self.FPedidoProdutoService := APedidoProdutoService;
end;

procedure TPedidoController.DeletarPedido(ACodigo: Integer);
begin
  Self.FPedidoService.DeletarPedido(ACodigo);
end;

function TPedidoController.GetPedidoByCodigo(ACodigo: Integer): TPedido;
begin
  Result := Self.FPedidoService.GetPedidoByCodigo(ACodigo);
end;

procedure TPedidoController.SalvarPedido(APedido: TPedido);
begin
  Self.FPedidoService.SalvarPedido(APedido);
end;

end.

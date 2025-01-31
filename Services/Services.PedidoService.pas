unit Services.PedidoService;

interface

uses Interfaces.Services.PedidoServiceInterface,
     Interfaces.Services.PedidoProdutosServiceInterface,
     Interfaces.DAOS.PedidoDAOInterface,
     Models.PedidoProduto,
     Models.Pedido;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)
  private
    FPedidoProdutosServices: IPedidoProdutosService;
    FPedidoDAO: IPedidoDAO;
  public
    constructor Create(APedidoProdutosServices: IPedidoProdutosService;
      APedidoDAO: IPedidoDAO);
    function GetPedidoByCodigo(ACodigo: Integer): TPedido;
    procedure AtualizarPedido(APedido: TPedido);
    procedure SalvarPedido(APedido: TPedido);
    procedure DeletarPedido(ACodigo: Integer);
  end;

implementation

{ TPedidoService }

uses Generics.Collections,
     DataModules.DmPrincipal,
     SysUtils;

procedure TPedidoService.AtualizarPedido(APedido: TPedido);
begin
  Self.FPedidoDAO.AtualizarPedido(APedido);
end;

constructor TPedidoService.Create(
  APedidoProdutosServices: IPedidoProdutosService; APedidoDAO: IPedidoDAO);
begin
  Self.FPedidoProdutosServices := APedidoProdutosServices;
  Self.FPedidoDAO := APedidoDAO;
end;

procedure TPedidoService.DeletarPedido(ACodigo: Integer);
begin
  Self.FPedidoDAO.DeletarPedido(ACodigo);
end;

function TPedidoService.GetPedidoByCodigo(ACodigo: Integer): TPedido;
var
  LPedidoProdutos: TObjectList<TPedidoProduto>;
begin
  Result := Self.FPedidoDAO.GetPedidoByCodigo(ACodigo);
  if not Assigned(Result) then
    Exit;

  Result.PedidoProdutos := Self.FPedidoProdutosServices.
                             GetPedidoProdutosByCodigoPedido(ACodigo);
end;

procedure TPedidoService.SalvarPedido(APedido: TPedido);
begin
  DmDatabase.Connection.StartTransaction;

  try
    Self.FPedidoDAO.SalvarPedido(APedido);

    Self.FPedidoProdutosServices.SalvarProdutos(APedido.PedidoProdutos,
      APedido.NumeroPedido);

    DmDatabase.Connection.Commit;
  except on E: Exception do
    begin
      DmDatabase.Connection.Rollback;
      raise;
    end;
  end;


end;

end.

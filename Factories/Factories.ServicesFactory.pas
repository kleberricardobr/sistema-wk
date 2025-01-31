unit Factories.ServicesFactory;

interface

uses Interfaces.Services.ProdutoServiceInterface,
     Interfaces.Services.ClienteServiceInterface,
     Interfaces.Services.PedidoServiceInterface,
     Interfaces.Services.PedidoProdutosServiceInterface,
     Services.PedidoService,
     Services.PedidoProdutosService,
     Services.ProdutoService,
     Services.ClienteService,
     Factories.DAOSFactory;

type
  TServicesFactory = class
  public
    class function NewProdutoService: IProdutoService;
    class function NewClienteService: IClienteService;
    class function NewPedidoService: IPedidoService;
    class function NewPedidoProdutosServive: IPedidoProdutosService;
  end;

implementation

{ TServicesFactory }

class function TServicesFactory.NewClienteService: IClienteService;
begin
  Result := TClienteService.Create(TDAOSFactory.NewClienteDAO);
end;

class function TServicesFactory.NewPedidoProdutosServive: IPedidoProdutosService;
begin
  Result := TPedidoProdutoService.Create(TDAOSFactory.NewPedidoProdutosDAO);
end;

class function TServicesFactory.NewPedidoService: IPedidoService;
begin
  Result := TPedidoService.Create(Self.NewPedidoProdutosServive,
    TDAOSFactory.NewPedidoDAO);
end;

class function TServicesFactory.NewProdutoService: IProdutoService;
begin
  Result := TProdutoService.Create(TDAOSFactory.NewProdutoDAO);
end;

end.

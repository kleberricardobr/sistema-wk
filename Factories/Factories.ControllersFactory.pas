unit Factories.ControllersFactory;

interface

uses Interfaces.Controllers.PedidoProdutoControllerInterface,
     Interfaces.Controllers.ClienteControllerInterface,
     Interfaces.Controllers.PedidoControllerInterface,
     Interfaces.Controllers.ProdutoControllerInterface,
     Controllers.PedidoController,
     Controllers.ClienteController,
     Controllers.ProdutoController,
     Factories.ServicesFactory;

type
  TControllersFactory = class
  public
    class function NewProdutoController: IProdutoController;
    class function NewClienteController: TClienteController;
    class function NewPedidoController: IPedidoController;
  end;

implementation

{ TControllersFactory }

class function TControllersFactory.NewClienteController: TClienteController;
begin
  Result := TClienteController.Create(TServicesFactory.NewClienteService);
end;

class function TControllersFactory.NewPedidoController: IPedidoController;
begin
  Result := TPedidoController.Create(TServicesFactory.NewPedidoService,
    TServicesFactory.NewPedidoProdutosServive);
end;

class function TControllersFactory.NewProdutoController: IProdutoController;
begin
  Result := TProdutoController.Create(TServicesFactory.NewProdutoService);
end;

end.

program SistemaWK;

uses
  Vcl.Forms,
  DataModules.DmPrincipal in 'DataModules\DataModules.DmPrincipal.pas' {DmDatabase: TDataModule},
  Views.Principal in 'Views\Views.Principal.pas' {FrmPrincipal},
  Models.Connection in 'Models\Models.Connection.pas',
  Services.Connection in 'Services\Services.Connection.pas',
  Models.Produto in 'Models\Models.Produto.pas',
  Models.Cliente in 'Models\Models.Cliente.pas',
  Models.Pedido in 'Models\Models.Pedido.pas',
  Models.PedidoProduto in 'Models\Models.PedidoProduto.pas',
  Interfaces.Controllers.ProdutoControllerInterface in 'Interfaces\Controllers\Interfaces.Controllers.ProdutoControllerInterface.pas',
  Interfaces.Controllers.PedidoControllerInterface in 'Interfaces\Controllers\Interfaces.Controllers.PedidoControllerInterface.pas',
  Interfaces.Controllers.ClienteControllerInterface in 'Interfaces\Controllers\Interfaces.Controllers.ClienteControllerInterface.pas',
  Interfaces.Services.PedidoServiceInterface in 'Interfaces\Services\Interfaces.Services.PedidoServiceInterface.pas',
  Interfaces.Services.PedidoProdutosServiceInterface in 'Interfaces\Services\Interfaces.Services.PedidoProdutosServiceInterface.pas',
  Interfaces.Services.ClienteServiceInterface in 'Interfaces\Services\Interfaces.Services.ClienteServiceInterface.pas',
  Interfaces.Services.ProdutoServiceInterface in 'Interfaces\Services\Interfaces.Services.ProdutoServiceInterface.pas',
  Interfaces.DAOS.ClienteDAOInterface in 'Interfaces\DAOS\Interfaces.DAOS.ClienteDAOInterface.pas',
  Interfaces.DAOS.ProdutoDAOInterface in 'Interfaces\DAOS\Interfaces.DAOS.ProdutoDAOInterface.pas',
  Interfaces.DAOS.PedidoDAOInterface in 'Interfaces\DAOS\Interfaces.DAOS.PedidoDAOInterface.pas',
  Interfaces.DAOS.PedidoProdutosDAOInterface in 'Interfaces\DAOS\Interfaces.DAOS.PedidoProdutosDAOInterface.pas',
  DAOS.BaseDAO in 'DAOS\DAOS.BaseDAO.pas',
  DAOS.ClienteDAO in 'DAOS\DAOS.ClienteDAO.pas',
  DAOS.ProdutoDAO in 'DAOS\DAOS.ProdutoDAO.pas',
  DAOS.PedidoDAO in 'DAOS\DAOS.PedidoDAO.pas',
  DAOS.PedidoProdutosDAO in 'DAOS\DAOS.PedidoProdutosDAO.pas',
  Services.ClienteService in 'Services\Services.ClienteService.pas',
  Services.ProdutoService in 'Services\Services.ProdutoService.pas',
  Services.PedidoProdutosService in 'Services\Services.PedidoProdutosService.pas',
  Services.PedidoService in 'Services\Services.PedidoService.pas',
  Controllers.ProdutoController in 'Controllers\Controllers.ProdutoController.pas',
  Controllers.ClienteController in 'Controllers\Controllers.ClienteController.pas',
  Controllers.PedidoController in 'Controllers\Controllers.PedidoController.pas',
  Interfaces.Controllers.PedidoProdutoControllerInterface in 'Interfaces\Controllers\Interfaces.Controllers.PedidoProdutoControllerInterface.pas',
  Factories.DAOSFactory in 'Factories\Factories.DAOSFactory.pas',
  Factories.ServicesFactory in 'Factories\Factories.ServicesFactory.pas',
  Factories.ControllersFactory in 'Factories\Factories.ControllersFactory.pas',
  Views.IncluirProduto in 'Views\Views.IncluirProduto.pas' {frmQuantidadeUnitario},
  Views.BuscarPedido in 'Views\Views.BuscarPedido.pas' {FrmBuscaPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmDatabase, DmDatabase);
  if not DmDatabase.ConnectDatabase then
  begin
    Application.Terminate;
    Exit;
  end;

  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.

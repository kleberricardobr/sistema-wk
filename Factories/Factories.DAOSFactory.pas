unit Factories.DAOSFactory;

interface

uses DAOS.PedidoProdutosDAO,
     DAOS.PedidoDAO,
     DAOS.ProdutoDAO,
     DAOS.ClienteDAO,
     Interfaces.DAOS.PedidoProdutosDAOInterface,
     Interfaces.DAOS.PedidoDAOInterface,
     Interfaces.DAOS.ProdutoDAOInterface,
     Interfaces.DAOS.ClienteDAOInterface;

type
  TDAOSFactory = class
  public
    class function NewPedidoProdutosDAO: IPedidoProdutosDAO;
    class function NewPedidoDAO: IPedidoDAO;
    class function NewProdutoDAO: IProdutoDAO;
    class function NewClienteDAO: IClienteDAO;
  end;

implementation

{ TDAOSFactory }

class function TDAOSFactory.NewClienteDAO: IClienteDAO;
begin
  Result := TClienteDAO.Create;
end;

class function TDAOSFactory.NewPedidoDAO: IPedidoDAO;
begin
  Result := TPedidoDAO.Create;
end;

class function TDAOSFactory.NewPedidoProdutosDAO: IPedidoProdutosDAO;
begin
  Result := TPedidoProdutosDAO.Create;
end;

class function TDAOSFactory.NewProdutoDAO: IProdutoDAO;
begin
  Result := TProdutoDAO.Create;
end;

end.

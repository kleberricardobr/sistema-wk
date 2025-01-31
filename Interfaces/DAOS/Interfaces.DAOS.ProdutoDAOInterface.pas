unit Interfaces.DAOS.ProdutoDAOInterface;

interface

uses Models.Produto;

type
  IProdutoDAO = interface
    function GetProdutoByCodigo(ACodigo: Integer): TProduto;
  end;

implementation

end.

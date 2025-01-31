unit Interfaces.Controllers.ProdutoControllerInterface;

interface

uses Models.Produto;

type
  IProdutoController = interface
    function GetProdutoByCodigo(ACodigo: Integer): TProduto;
  end;

implementation

end.

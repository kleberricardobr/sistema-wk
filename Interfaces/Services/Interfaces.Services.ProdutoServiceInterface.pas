unit Interfaces.Services.ProdutoServiceInterface;

interface

uses Models.Produto;

type
  IProdutoService = interface
    function GetProdutoByCodigo(ACodigo: Integer): TProduto;
  end;

implementation

end.

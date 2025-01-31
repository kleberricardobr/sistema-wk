unit Services.ProdutoService;

interface

uses Interfaces.Services.ProdutoServiceInterface,
     Interfaces.DAOS.ProdutoDAOInterface,
     Models.Produto;

type
  TProdutoService = class(TInterfacedObject, IProdutoService)
  private
    FProdutoDAO: IProdutoDAO;
  public
    constructor Create(AProdutoDAO: IProdutoDAO);
    function GetProdutoByCodigo(ACodigo: Integer): TProduto;
  end;

implementation

{ TProdutoService }

constructor TProdutoService.Create(AProdutoDAO: IProdutoDAO);
begin
  FProdutoDAO := AProdutoDAO;
end;

function TProdutoService.GetProdutoByCodigo(ACodigo: Integer): TProduto;
begin
  Result := FProdutoDAO.GetProdutoByCodigo(ACodigo);
end;

end.

unit Controllers.ProdutoController;

interface

uses Models.Produto,
     Interfaces.Controllers.ProdutoControllerInterface,
     Interfaces.Services.ProdutoServiceInterface;

type
  TProdutoController = class(TInterfacedObject, IProdutoController)
  private
    FProdutoService: IProdutoService;
  public
    constructor Create(AProdutoService: IProdutoService);
    function GetProdutoByCodigo(ACodigo: Integer): TProduto;
  end;

implementation

{ TProdutoController }

constructor TProdutoController.Create(AProdutoService: IProdutoService);
begin
  Self.FProdutoService := AProdutoService;
end;

function TProdutoController.GetProdutoByCodigo(ACodigo: Integer): TProduto;
begin
  Result := Self.FProdutoService.GetProdutoByCodigo(ACodigo);
end;

end.

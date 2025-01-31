unit Models.PedidoProduto;

interface

uses Models.Produto;

type
  TPedidoProduto = class
  private
    FID: Integer;
    FProduto: TProduto;
    FQuantidade: Double;
    FVrUnitario: Double;
    FVrTotal: Double;
    procedure AtualizaValorTotal;
    procedure SetQuantidade(const Value: Double);
    procedure SetVrUnitario(const Value: Double);
  public
    constructor Create(AProduto: TProduto);
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Produto: TProduto read FProduto;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property VrUnitario: Double read FVrUnitario write SetVrUnitario;
    property VrTotal: Double read FVrTotal write FVrTotal;
  end;

implementation

{ TPedidoProdutos }

uses SysUtils;

procedure TPedidoProduto.AtualizaValorTotal;
begin
  Self.FVrTotal := Self.FQuantidade * Self.FVrUnitario;
end;

constructor TPedidoProduto.Create(AProduto: TProduto);
begin
  Self.FProduto := AProduto;
  Self.VrUnitario := Self.Produto.PrecoVenda;
end;

destructor TPedidoProduto.Destroy;
begin
  FreeAndNil(FProduto);
  inherited;
end;

procedure TPedidoProduto.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
  AtualizaValorTotal;
end;

procedure TPedidoProduto.SetVrUnitario(const Value: Double);
begin
  FVrUnitario := Value;
  AtualizaValorTotal;
end;

end.

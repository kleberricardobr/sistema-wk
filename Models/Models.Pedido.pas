unit Models.Pedido;

interface

uses SysUtils,
     Generics.Collections,
     Models.Cliente,
     Models.PedidoProduto;

type
  TPedido = class
  private
    FCliente: TCliente;
    FDataEmissao: TDateTime;
    FNumeroPedido: Integer;
    FListaPedidoProdutos: TObjectList<TPedidoProduto>;
    FValorTotal: Double;
    procedure SetListaPedidoProdutos(const Value: TObjectList<TPedidoProduto>);
  public
    constructor Create(ACliente: TCliente; ANumeroPedido: Integer);
    destructor Destroy; override;
    procedure AdicionarProduto(APedidoProdutos: TPedidoProduto);
    procedure RemoverItem(AId: Integer);
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property Cliente: TCliente read FCliente;
    property PedidoProdutos: TObjectList<TPedidoProduto>
      read FListaPedidoProdutos write SetListaPedidoProdutos;
  end;

implementation

{ TPedido }

procedure TPedido.AdicionarProduto(APedidoProdutos: TPedidoProduto);
begin
  if not Assigned(Self.FListaPedidoProdutos) then
    Self.FListaPedidoProdutos := TObjectList<TPedidoProduto>.Create(True);

  Self.FListaPedidoProdutos.Add(APedidoProdutos)
end;

constructor TPedido.Create(ACliente: TCliente; ANumeroPedido: Integer);
begin
  Self.FDataEmissao := Now;
  Self.FCliente := ACliente;
  Self.FNumeroPedido := ANumeroPedido;
end;

destructor TPedido.Destroy;
begin
  FreeAndNil(Self.FCliente);
  FreeAndNil(Self.FListaPedidoProdutos);
  inherited;
end;

procedure TPedido.RemoverItem(AId: Integer);
var
  I: Integer;
begin
  for I := 0 to Pred(Self.FListaPedidoProdutos.Count) do
  begin
    if Self.FListaPedidoProdutos.Items[I].ID = AId then
    begin
      Self.FListaPedidoProdutos.Remove(Self.FListaPedidoProdutos.Items[I]);
      Break;
    end;           
  end;
end;

procedure TPedido.SetListaPedidoProdutos(
  const Value: TObjectList<TPedidoProduto>);
begin
  FListaPedidoProdutos := Value;
end;

end.

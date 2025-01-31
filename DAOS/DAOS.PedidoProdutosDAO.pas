unit DAOS.PedidoProdutosDAO;

interface

uses SysUtils,
     Generics.Collections,
     Firedac.Stan.Param,
     Models.PedidoProduto,
     Models.Produto,
     DAOS.BaseDAO,
     Interfaces.DAOS.PedidoProdutosDAOInterface;

type
  TPedidoProdutosDAO = class(TBaseDAO, IPedidoProdutosDAO)
  public
    function GetPedidoProdutosByCodigoPedido(ACodigo: Integer): TObjectList<TPedidoProduto>;
    procedure SalvarProduto(APedidoProduto: TPedidoProduto; ACodigoPedido: Integer);
    procedure DeletarTodos(ACodidoPedido: Integer);
    procedure DeletarByID(AID: Integer);
  end;

implementation

{ TPedidoProdutosDAO }


procedure TPedidoProdutosDAO.DeletarByID(AID: Integer);
begin
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('delete from pedido_produtos');
    Add('where id = :id');
    ParamByName('id').AsInteger := AID;
    ExecSQL;

    if RowsAffected = 0 then
      raise Exception.Create('Nenhum registro afetado!');
  finally
    Clear;
    Close;
  end;
end;

procedure TPedidoProdutosDAO.DeletarTodos(ACodidoPedido: Integer);
begin
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('delete from pedido_produtos');
    Add('where numero_pedido = :numero_pedido');
    ParamByName('numero_pedido').AsInteger := ACodidoPedido;
    ExecSQL;

    if RowsAffected = 0 then
      raise Exception.Create('Nenhum registro afetado!');
  finally
    Clear;
    Close;
  end;
end;

function TPedidoProdutosDAO.GetPedidoProdutosByCodigoPedido(
  ACodigo: Integer): TObjectList<TPedidoProduto>;
var
  LPedProd: TPedidoProduto;
  LProduto: TProduto;
begin
  Result := TObjectList<TPedidoProduto>.Create;

  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('select ped.id,');
    Add('       ped.codigo_produto,');
    Add('       ped.quantidade,');
    Add('       ped.vr_unitario,');
    Add('       ped.vr_total,');
    Add('       prod.descricao,');
    Add('       prod.preco_venda');
    Add('from pedido_produtos ped');
    Add('  inner join produto prod on (prod.codigo = ped.codigo_produto)');
    Add('where ped.numero_pedido = :numero_pedido');
    ParamByName('numero_pedido').AsInteger := ACodigo;
    Add('order by ped.id');
    Open;

    while not Eof do
    begin
      LProduto := TProduto.Create;
      LProduto.Codigo := FieldByName('codigo_produto').AsInteger;
      LProduto.Descricao := FieldByName('descricao').AsString;
      LProduto.PrecoVenda := FieldByName('preco_venda').AsFloat;

      LPedProd := TPedidoProduto.Create(LProduto);
      LPedProd.ID := FieldByName('id').AsInteger;
      LPedProd.Quantidade := FieldByName('quantidade').AsFloat;
      LPedProd.VrUnitario := FieldByName('vr_unitario').AsFloat;
      LPedProd.VrTotal := FieldByName('vr_total').AsFloat;

      Result.Add(LPedProd);
      Next;
    end;

  finally
    Clear;
    Close;
  end;
end;

procedure TPedidoProdutosDAO.SalvarProduto(APedidoProduto: TPedidoProduto;
  ACodigoPedido: Integer);
begin
  // A Transaction está controlada pelo Service do Pedido
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('insert into pedido_produtos(numero_pedido,');
    Add('                            codigo_produto,');
    Add('                            quantidade,');
    Add('                            vr_unitario,');
    Add('                            vr_total)');
    Add('values(:numero_pedido,');
    Add('       :codigo_produto,');
    Add('       :quantidade,');
    Add('       :vr_unitario,');
    Add('       :vr_total)');

    ParamByName('numero_pedido').AsInteger := ACodigoPedido;
    ParamByName('codigo_produto').AsInteger := APedidoProduto.Produto.Codigo;
    ParamByName('quantidade').AsFloat := APedidoProduto.Quantidade;
    ParamByName('vr_unitario').AsFloat := APedidoProduto.VrUnitario;
    ParamByName('vr_total').AsFloat := APedidoProduto.VrTotal;

    ExecSQL;


    Clear;
    Add('select LAST_INSERT_ID() as id');
    Open;

    APedidoProduto.ID := FieldByName('id').AsInteger;
  finally
    Clear;
    Close;
  end;
end;

end.

unit DAOS.PedidoDAO;

interface

uses SysUtils,
     Firedac.Stan.Param,
     Models.Pedido,
     Models.Cliente,
     Models.Produto,
     Models.PedidoProduto,
     DAOS.BaseDAO,
     Interfaces.DAOS.PedidoDAOInterface;

type
  TPedidoDAO = class(TBaseDAO, IPedidoDAO)
  public
    function GetPedidoByCodigo(ACodigo: Integer): TPedido;
    procedure AtualizarPedido(APedido: TPedido);
    procedure SalvarPedido(APedido: TPedido);
    procedure DeletarPedido(ACodigo: Integer);
  end;

implementation

{ TPedidoDAO }

procedure TPedidoDAO.AtualizarPedido(APedido: TPedido);
begin
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('update pedido');
    Add('   set valor_total = :valor_total');
    Add('where numero_pedido = :numero_pedido');
    ParamByName('numero_pedido').AsInteger := APedido.NumeroPedido;
    ParamByName('valor_total').AsFloat := APedido.ValorTotal;
    ExecSQL;

    if RowsAffected = 0 then
      raise Exception.Create('Pedido não encontrado!');

  finally
    Clear;
    Close;
  end;
end;

procedure TPedidoDAO.DeletarPedido(ACodigo: Integer);
begin
  FQuery.Connection.StartTransaction;
  try
    with FQuery, FQuery.SQL do
    begin
      Clear;
      Add('delete from pedido_produtos');
      Add('where numero_pedido = :numero_pedido');
      ParamByName('numero_pedido').AsInteger := ACodigo;
      ExecSQL;

      Clear;
      Add('delete from pedido');
      Add('where numero_pedido = :numero_pedido');
      ParamByName('numero_pedido').AsInteger := ACodigo;
      ExecSQL;

      Connection.Commit;
    end;
  except on E: Exception do
    begin
      FQuery.Connection.Rollback;
      raise;
    end;
  end;
end;

function TPedidoDAO.GetPedidoByCodigo(ACodigo: Integer): TPedido;
var
  LCliente: TCliente;
begin
  Result := nil;

  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('select ped.data_emissao,');
    Add('       ped.codigo_cliente,');
    Add('       cli.nome,');
    Add('       ped.valor_total');
    Add('from pedido ped');
    Add('  inner join cliente cli on (cli.codigo = ped.codigo_cliente)');
    Add('where numero_pedido = :numero_pedido');
    ParamByName('numero_pedido').AsInteger := ACodigo;
    Open;

    if not Eof then
    begin
      LCliente := TCliente.Create;
      LCliente.Codigo := FieldByName('codigo_cliente').AsInteger;
      LCliente.Nome := FieldByName('nome').AsString;

      Result := TPedido.Create(LCliente, ACodigo);
      Result.DataEmissao := FieldByName('data_emissao').AsDateTime;
      Result.ValorTotal := FieldByName('valor_total').AsFloat;
    end;

  finally
    Clear;
    Close;
  end;
end;

procedure TPedidoDAO.SalvarPedido(APedido: TPedido);
begin
  // A Transaction é controlada pelo Service
  // uma vez que também é necessário incluir os Produtos
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('insert into pedido(data_emissao, codigo_cliente, valor_total)');
    Add('values(:data_emissao, :codigo_cliente, :valor_total)');
    ParamByName('data_emissao').AsDateTime := APedido.DataEmissao;
    ParamByName('codigo_cliente').AsInteger := APedido.Cliente.Codigo;
    ParamByName('valor_total').AsFloat := APedido.ValorTotal;
    ExecSQL;

    Clear;
    Add('select LAST_INSERT_ID() as id');
    Open;

    APedido.NumeroPedido := FieldByName('id').AsInteger;
  finally
    Clear;
    Close;
  end;
end;

end.

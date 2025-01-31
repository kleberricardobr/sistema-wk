unit DAOS.ProdutoDAO;

interface

uses Firedac.Stan.Param,
     Models.Produto,
     Interfaces.DAOS.ProdutoDAOInterface,
     DAOS.BaseDAO;


type
  TProdutoDAO = class(TBaseDAO, IProdutoDAO)
  public
    function GetProdutoByCodigo(ACodigo: Integer): TProduto;
  end;


implementation

{ TProdutoDAO }

function TProdutoDAO.GetProdutoByCodigo(ACodigo: Integer): TProduto;
begin
  Result := nil;
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('select descricao,');
    Add('       preco_venda');
    Add('from produto');
    Add('where codigo = :codigo');
    ParamByName('codigo').AsInteger := ACodigo;
    Open;

    if not Eof then
    begin
      Result := TProduto.Create;
      with Result do
      begin
        Codigo := ACodigo;
        Descricao := FieldByName('descricao').AsString;
        PrecoVenda := FieldByName('preco_venda').AsFloat;
      end;
    end;
  finally
    Clear;
    Close;
  end;
end;

end.

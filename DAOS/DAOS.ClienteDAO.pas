unit DAOS.ClienteDAO;

interface

uses Firedac.Stan.Param,
     Models.Cliente,
     Interfaces.DAOS.ClienteDAOInterface,
     DAOS.BaseDAO;

type
  TClienteDAO = class(TBaseDAO, IClienteDAO)
  public
    function GetClienteByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteDAO }

function TClienteDAO.GetClienteByCodigo(ACodigo: Integer): TCliente;
begin
  Result := nil;
  with FQuery, FQuery.SQL do
  try
    Clear;
    Add('select nome,');
    Add('       cidade,');
    Add('       uf');
    Add('from cliente');
    Add('where codigo = :codigo');
    ParamByName('codigo').AsInteger := ACodigo;
    Open;

    if not Eof then
    begin
      Result := TCliente.Create;
      with Result do
      begin
        Codigo := ACodigo;
        Nome := FieldByName('nome').AsString;
        Cidade := FieldByName('cidade').AsString;
        UF := FieldByName('uf').AsString;
      end;
    end;
  finally
    Clear;
    Close;
  end;
end;

end.

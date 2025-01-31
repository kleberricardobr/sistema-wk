unit Models.Produto;

interface

type
  TProduto = class
  private
    FDescricao: string;
    FCodigo: Integer;
    FPrecoVenda: Double;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;
  end;

implementation

end.

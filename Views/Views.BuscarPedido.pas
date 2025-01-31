unit Views.BuscarPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Interfaces.Controllers.PedidoControllerInterface,
  Factories.ControllersFactory, Models.Pedido;

type
  TFrmBuscaPedido = class(TForm)
    btnBuscarPedido: TButton;
    btnCancelar: TButton;
    lblNumeroPedido: TLabel;
    edtCodigo: TEdit;
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarPedidoClick(Sender: TObject);
  private
    FPedidoController: IPedidoController;
    FNumeroPedido: Integer;
    FPedido: TPedido;
    FOperacaoExclusao: Boolean;
    procedure SetNumeroPedido(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    class function BuscarPedido: TPedido;
    class procedure DeletarPedido;
    property OperacaoExclusao: Boolean read FOperacaoExclusao
      write FOperacaoExclusao;
    property NumeroPedido: Integer read FNumeroPedido
      write SetNumeroPedido;
    property Pedido: TPedido read FPedido;
  end;

var
  FrmBuscaPedido: TFrmBuscaPedido;

implementation

{$R *.dfm}

procedure TFrmBuscaPedido.btnBuscarPedidoClick(Sender: TObject);

  procedure ExcluirPedido;
  begin
    try
      Self.FPedidoController.DeletarPedido(Self.FPedido.NumeroPedido);
    except on E: Exception do
      ShowMessage('Falha na tentativa de exclusão de pedido: %s' + E.Message);
    end
  end;

begin
  Self.NumeroPedido := StrToIntDef(Trim(edtCodigo.Text), 0);
  if Self.NumeroPedido <= 0 then
  begin
    ShowMessage('Informe um número de pedido válido!');
    edtCodigo.SetFocus;
    Abort;
  end;

  Self.FPedido := FPedidoController.GetPedidoByCodigo(Self.FNumeroPedido);
  if not Assigned(Self.FPedido) then
  begin
    ShowMessage('Pedido não encontrado');
    edtCodigo.SetFocus;
    Abort;
  end;

  if not FOperacaoExclusao then
  begin
    ModalResult := mrOk;
    Exit;
  end;

  try
   if MessageDlg('Confirma exclusão do pedido?', mtConfirmation,
      [mbYes, mbNo], 0, mbNo) = mrYes then
   begin
     ExcluirPedido;
     ShowMessage('Pedido excluído com sucesso!');
     ModalResult := mrOk;
   end;
  finally
    FreeAndNil(Self.FPedido);
  end;
end;

procedure TFrmBuscaPedido.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

class function TFrmBuscaPedido.BuscarPedido: TPedido;
begin
  Result := nil;

  with TFrmBuscaPedido.Create(nil) do
  try
    OperacaoExclusao := False;
    if ShowModal = mrOk then
      Result := Pedido;
  finally
    Release;
  end;
end;

class procedure TFrmBuscaPedido.DeletarPedido;
begin
  with TFrmBuscaPedido.Create(nil) do
  try
    OperacaoExclusao := True;
    btnBuscarPedido.Caption := 'Excluir Pedido';
    ShowModal;
  finally
    Release;
  end;
end;

procedure TFrmBuscaPedido.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(edtCodigo, True, True);
  end;
end;

procedure TFrmBuscaPedido.FormCreate(Sender: TObject);
begin
  FPedidoController := TControllersFactory.NewPedidoController;
end;

procedure TFrmBuscaPedido.SetNumeroPedido(const Value: Integer);
begin
  FNumeroPedido := Value;
end;

end.

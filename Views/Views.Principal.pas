unit Views.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  Vcl.StdCtrls, Interfaces.Controllers.PedidoProdutoControllerInterface,
  Interfaces.Controllers.PedidoControllerInterface,
  Interfaces.Controllers.ClienteControllerInterface,
  Interfaces.Controllers.ProdutoControllerInterface,
  Factories.ControllersFactory, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, Models.Produto, Models.Cliente, Models.Pedido;

type
  TFrmPrincipal = class(TForm)
    pnEntrada: TPanel;
    lblCodCliente: TLabel;
    lblCodProduto: TLabel;
    edCodCliente: TEdit;
    edCodProduto: TEdit;
    pnDados: TPanel;
    pnCliente: TPanel;
    lblCliente: TLabel;
    btnBuscarCliente: TButton;
    btnBuscarProduto: TButton;
    pnGrid: TPanel;
    gridPedido: TDBGrid;
    dsPedido: TDataSource;
    memPedido: TFDMemTable;
    memPedidoCodProduto: TIntegerField;
    memPedidoDescricaoProduto: TStringField;
    memPedidoQuantidade: TFloatField;
    memPedidoVrUnitario: TFloatField;
    memPedidoVrTotal: TFloatField;
    lblTotal: TLabel;
    btnConsultarPedido: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    memPedidoID: TIntegerField;
    btnExcluirPedido: TButton;
    procedure edCodProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodClienteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure memPedidoAfterClose(DataSet: TDataSet);
    procedure memPedidoAfterOpen(DataSet: TDataSet);
    procedure memPedidoCalcFields(DataSet: TDataSet);
    procedure gridPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memPedidoQuantidadeSetText(Sender: TField; const Text: string);
    procedure memPedidoVrUnitarioSetText(Sender: TField; const Text: string);
    procedure gridPedidoColEnter(Sender: TObject);
    procedure gridPedidoColExit(Sender: TObject);
    procedure gridPedidoExit(Sender: TObject);
    procedure memPedidoAfterPost(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirPedidoClick(Sender: TObject);
    procedure btnConsultarPedidoClick(Sender: TObject);
    procedure memPedidoAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    FProdutoController: IProdutoController;
    FClienteController: IClienteController;
    FPedidoController: IPedidoController;
    FCliente: TCliente;
    FNumeroPedido: Integer;
    procedure InicializaControllers;
    procedure AdicionarProdutoGrid(AProduto: TProduto; AQuantidade: Double;
      AUnitario: Double);
    procedure SetCliente(ACliente: TCliente);
    function GetPedidoFromDataset: TPedido;
    function GetTotal: Double;
    procedure EnableMainButtons;
    procedure SetTotal(AValue: Double);
    procedure PedidoToDataset(APedido: TPedido);
    procedure HabilitaPanelDados;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses DAOS.ClienteDAO, DAOS.PedidoDAO,
  Views.IncluirProduto, Models.PedidoProduto, Views.BuscarPedido,
  System.UITypes;

procedure TFrmPrincipal.btnBuscarClienteClick(Sender: TObject);
begin
  if Trim(edCodCliente.Text) = EmptyStr then
    Exit;

  if Assigned(FCliente) then
    FreeAndNil(FCliente);

  if FNumeroPedido <> 0 then
  begin
    edCodCliente.Clear;
    ShowMessage('Atenção! Não é permido alterar cliente de pedido já gravado!');
    Abort;
  end;

  try
    FCliente := Self.FClienteController.
                GetClienteByCodigo(StrToIntDef(edCodCliente.Text, 0));

    if not Assigned(FCliente) then
    begin
      ShowMessage('Cliente não encontrado');
      Exit;
    end;

    SetCliente(FCliente);

    if Sender = nil then
      edCodProduto.SetFocus;
  except on E: Exception do
    ShowMessage(
      string.Format('Falha ao buscar cliente: %s', [E.Message])
    )
  end;
end;

procedure TFrmPrincipal.SetCliente(ACliente: TCliente);
begin
  lblCliente.Caption := string.Format('Cliente: %d - %s',
        [ACliente.Codigo, ACliente.Nome]);
  pnCliente.Visible := True;
end;

procedure TFrmPrincipal.btnBuscarProdutoClick(Sender: TObject);
var
  LProduto: TProduto;
  LQuantidade: Double;
  LUnitario: Double;
begin
  if Trim(edCodProduto.Text) = EmptyStr then
    Exit;

  try
    LProduto := Self.FProdutoController.
                GetProdutoByCodigo(StrToIntDef(edCodProduto.Text, 0));
  except on E: Exception do
    ShowMessage(
      string.Format('Falha ao buscar produto: %s', [E.Message]))
  end;


  if not Assigned(LProduto) then
  begin
    ShowMessage('Produto não encontrado!');
    Exit;
  end;

  if not TfrmQuantidadeUnitario.SelProduto(LProduto, LQuantidade, LUnitario) then
    Exit;

  try
    HabilitaPanelDados;

    AdicionarProdutoGrid(LProduto, LQuantidade, LUnitario);
    edCodProduto.Clear;
    edCodProduto.SetFocus;
  finally
    FreeAndNil(LProduto);
  end;
end;

procedure TFrmPrincipal.HabilitaPanelDados;
begin
  btnExcluirPedido.Enabled := False;
  btnConsultarPedido.Enabled := False;
  pnDados.Enabled := True;
  btnCancelar.Enabled := True;
  btnGravar.Enabled := True;
end;

procedure TFrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  if (Sender <> nil) and (MessageDlg(
    'A operação será perdida. Deseja realmente continuar?',
    mtConfirmation, [mbYes, mbNo], 0, mbNo ) = mrNo) then
  Exit;

  FNumeroPedido := 0;
  memPedido.Close;
  edCodCliente.Clear;
  edCodProduto.Clear;
  pnCliente.Visible := False;
  lblTotal.Caption := '';
  btnGravar.Enabled := False;
  btnCancelar.Enabled := False;
  pnDados.Enabled := False;
  EnableMainButtons;
end;

procedure TFrmPrincipal.btnConsultarPedidoClick(Sender: TObject);
var
  LPedido: TPedido;
begin
  LPedido := TFrmBuscaPedido.BuscarPedido;
  if not Assigned(LPedido) then
    Exit;

  if Assigned(FCliente) then
    FreeAndNil(FCliente);

  { Faz um cópia dos daos principais do Cliente,
    pois o objeto cliente contido no pedido será destruído
    no finally }
  FCliente := TCliente.Create;
  FCliente.Codigo := LPedido.Cliente.Codigo;
  FCliente.Nome := LPedido.Cliente.Nome;

  try
    FNumeroPedido := LPedido.NumeroPedido;
    SetCliente(LPedido.Cliente);
    PedidoToDataset(LPedido);
    SetTotal(LPedido.ValorTotal);
    HabilitaPanelDados;
  finally
    FreeAndNil(LPedido);
  end;
end;

procedure TFrmPrincipal.PedidoToDataset(APedido: TPedido);
var
  I: Integer;
  LPedProd: TPedidoProduto;
begin
  memPedido.Close;
  memPedido.Open;

  for I := 0 to Pred(APedido.PedidoProdutos.Count) do
  begin
    LPedProd := APedido.PedidoProdutos.Items[I];

    memPedido.Append;
    memPedidoCodProduto.AsInteger := LPedProd.Produto.Codigo;
    memPedidoDescricaoProduto.AsString := LPedProd.Produto.Descricao;
    memPedidoQuantidade.AsFloat := LPedProd.Quantidade;
    memPedidoVrUnitario.AsFloat := LPedProd.VrUnitario;
    memPedido.Post;
  end;
end;

procedure TFrmPrincipal.btnExcluirPedidoClick(Sender: TObject);
begin
  TFrmBuscaPedido.DeletarPedido;
end;

procedure TFrmPrincipal.btnGravarClick(Sender: TObject);
var
  LPedido: TPedido;
  LMenssagem: string;

  procedure GravarNovoPedido;
  begin
    LMenssagem := 'gravado';
    Self.FPedidoController.SalvarPedido(LPedido)
  end;

  procedure AtualizaPedidoExistente;
  begin
    LMenssagem := 'alterado';
    LPedido.NumeroPedido := FNumeroPedido;
    Self.FPedidoController.AtualizarPedido(LPedido);
  end;


begin
  LPedido := GetPedidoFromDataset;
  try
    try
      if FNumeroPedido = 0 then
        GravarNovoPedido
      else
        AtualizaPedidoExistente;

      ShowMessage(
        string.Format('Pedido (Nr: %d) %s com sucesso!',
         [LPedido.NumeroPedido, LMenssagem]));

      btnCancelarClick(nil);
    except on E: Exception do
      ShowMessage(
        string.Format('Falha ao gravar pedido: %s', [E.Message])
      )
    end;
  finally
    FreeAndNil(LPedido);
    //FCliente já foi liberado com o Pedido
    FCliente := nil;
  end;
end;

function TFrmPrincipal.GetPedidoFromDataset: TPedido;
var
  LPedidoProduto: TPedidoProduto;
  LProduto: TProduto;
  LTotal: Double;
  Bm: TBookMark;
begin
  if (memPedido.RecordCount = 0) then
  begin
    ShowMessage('Não é possível incluir pedido sem itens.');
    Abort;
  end;

  LTotal := GetTotal;
  if LTotal <= 0 then
  begin
    ShowMessage('Valor total inválido.');
    Abort;
  end;

  Result := TPedido.Create(FCliente, 0);
  Result.ValorTotal := LTotal;
  Result.DataEmissao := Now;

  Bm := memPedido.GetBookmark;
  memPedido.DisableControls;

  try
    memPedido.First;
    while not memPedido.Eof do
    begin
      LProduto := TProduto.Create;
      LProduto.Codigo := memPedidoCodProduto.AsInteger;
      LPedidoProduto := TPedidoProduto.Create(LProduto);
      LPedidoProduto.Quantidade := memPedidoQuantidade.AsFloat;
      LPedidoProduto.VrUnitario := memPedidoVrUnitario.AsFloat;
      LPedidoProduto.VrTotal := memPedidoVrTotal.AsFloat;

      Result.AdicionarProduto(LPedidoProduto);

      memPedido.Next;
    end;

  finally
    memPedido.GotoBookmark(Bm);
    memPedido.FreeBookmark(Bm);
    memPedido.EnableControls;
  end;

end;

procedure TFrmPrincipal.AdicionarProdutoGrid(AProduto: TProduto; AQuantidade: Double;
 AUnitario: Double);
begin
  memPedido.Active := True;
  memPedido.Append;
  memPedidoCodProduto.AsInteger := AProduto.Codigo;
  memPedidoDescricaoProduto.AsString := AProduto.Descricao;
  memPedidoQuantidade.AsFloat := AQuantidade;
  memPedidoVrUnitario.AsFloat := AUnitario;
  memPedido.Post;
end;

procedure TFrmPrincipal.edCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (Trim(edCodCliente.Text) <> EmptyStr) then
  begin
    Key := #0;
    btnBuscarClienteClick(nil);
  end;
end;

procedure TFrmPrincipal.edCodClienteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EnableMainButtons;
end;

procedure TFrmPrincipal.EnableMainButtons;
begin
  btnBuscarCliente.Enabled := Trim(edCodCliente.Text) <> EmptyStr;
  btnConsultarPedido.Enabled := (not btnBuscarCliente.Enabled) and
                                (not btnGravar.Enabled);
  btnExcluirPedido.Enabled := (not btnBuscarCliente.Enabled) and
                              (not btnGravar.Enabled);
end;

procedure TFrmPrincipal.edCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (Trim(edCodProduto.Text) <> EmptyStr) then
  begin
    Key := #0;
    btnBuscarProdutoClick(nil);
  end;
end;

procedure TFrmPrincipal.edCodProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  btnBuscarProduto.Enabled := Trim(edCodProduto.Text) <> EmptyStr;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  InicializaControllers;
  EnableMainButtons;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(FCliente) then
    FreeAndNil(FCliente);
end;

procedure TFrmPrincipal.gridPedidoColEnter(Sender: TObject);
begin
  if (gridPedido.SelectedField = memPedidoQuantidade) or
    (gridPedido.SelectedField = memPedidoVrUnitario) then
    gridPedido.Options := gridPedido.Options + [dgEditing];
end;

procedure TFrmPrincipal.gridPedidoColExit(Sender: TObject);
begin
  gridPedido.Options := gridPedido.Options - [dgEditing]
end;

procedure TFrmPrincipal.gridPedidoExit(Sender: TObject);
begin
  gridPedido.Options := gridPedido.Options - [dgRowSelect];
end;

procedure TFrmPrincipal.gridPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
  begin
    Key := 0;
    Exit;
  end;

  if (Key = VK_DOWN) then
  begin
    gridPedido.Options := gridPedido.Options - [dgEditing];
    Exit;
  end;

  if (Key = VK_DELETE) and (
    MessageDlg('Confirma exclusão de item?',
    TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes
  ) then begin
    memPedido.Delete;

    if memPedido.RecordCount = 0 then
    begin
      memPedido.Close;
      edCodProduto.SetFocus;
    end;

    Exit;
  end;


  if Key = VK_RETURN then
  begin
    if gridPedido.SelectedField <> memPedidoVrUnitario then
      gridPedido.SelectedField := memPedidoQuantidade;

    gridPedido.Options := gridPedido.Options + [dgEditing]
  end;
end;

procedure TFrmPrincipal.InicializaControllers;
begin
  FProdutoController := TControllersFactory.NewProdutoController;
  FClienteController := TControllersFactory.NewClienteController;
  FPedidoController := TControllersFactory.NewPedidoController;
end;

procedure TFrmPrincipal.memPedidoAfterClose(DataSet: TDataSet);
begin
  gridPedido.Enabled := False;
end;

procedure TFrmPrincipal.memPedidoAfterDelete(DataSet: TDataSet);
begin
  SetTotal(GetTotal);
end;

procedure TFrmPrincipal.memPedidoAfterOpen(DataSet: TDataSet);
begin
  gridPedido.Enabled := True;
end;

procedure TFrmPrincipal.memPedidoAfterPost(DataSet: TDataSet);
begin
  SetTotal(GetTotal);
end;

procedure TFrmPrincipal.SetTotal(AValue: Double);
begin
  lblTotal.Caption := 'Valor Total: R$ ' +
                       FormatFloat('0.00', AValue);
end;

function TFrmPrincipal.GetTotal: Double;
var
  LBm: TBookmark;
begin
  Result := 0;
  LBm := memPedido.GetBookmark;
  memPedido.DisableControls;

  try
    memPedido.First;
    while not memPedido.Eof do
    begin
      Result := Result + memPedidoVrTotal.AsFloat;
      memPedido.Next;
    end;
  finally
    memPedido.EnableControls;
    memPedido.GotoBookmark(LBm);
    memPedido.FreeBookmark(LBm)
  end;
end;

procedure TFrmPrincipal.memPedidoCalcFields(DataSet: TDataSet);
begin
  memPedidoVrTotal.AsFloat := memPedidoQuantidade.AsFloat *
                              memPedidoVrUnitario.AsFloat;
end;

procedure TFrmPrincipal.memPedidoQuantidadeSetText(Sender: TField;
  const Text: string);
begin
  if StrToFloatDef(Text, 0) <= 0 then
  begin
    ShowMessage('Informe um valor maior que zero');
    Abort;
  end;

  Sender.AsString := Text;
end;

procedure TFrmPrincipal.memPedidoVrUnitarioSetText(Sender: TField;
  const Text: string);
begin
  if StrToFloatDef(Text, 0) <= 0 then
  begin
    ShowMessage('Informe um valor maior que zero');
    Abort;
  end;

  Sender.AsString := Text;
end;

end.

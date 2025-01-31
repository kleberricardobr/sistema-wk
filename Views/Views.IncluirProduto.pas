unit Views.IncluirProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Models.Produto,
  Vcl.NumberBox;

type
  TfrmQuantidadeUnitario = class(TForm)
    lblProduto: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtQuantidade: TEdit;
    edtUnitario: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnitarioKeyPress(Sender: TObject; var Key: Char);
  private
    FUnitario: Double;
    FQuantidade: Double;
    procedure SetUnitario(const Value: Double);
    { Private declarations }
  public
    { Public declarations }
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Unitario: Double read FUnitario write SetUnitario;
    class function SelProduto(AProduto: TProduto;
      var AQuantidade: Double; var AUnitario: Double): Boolean;
  end;

var
  frmQuantidadeUnitario: TfrmQuantidadeUnitario;

implementation

{$R *.dfm}


procedure TfrmQuantidadeUnitario.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TfrmQuantidadeUnitario.btnOkClick(Sender: TObject);
begin
  FQuantidade := StrToFloatDef(edtQuantidade.Text, 0);
  if FQuantidade <= 0 then
  begin
    ShowMessage('Informe uma quantidade maior que zero');
    edtQuantidade.SetFocus;
    Abort;
  end;

  FUnitario := StrToFloatDef(edtUnitario.Text, 0);
  if FUnitario <= 0 then
  begin
    ShowMessage('Informe um  valor unitário que zero');
    edtUnitario.SetFocus;
    Abort;
  end;

  ModalResult := mrOk;
end;

procedure TfrmQuantidadeUnitario.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(edtQuantidade, True, True);
  end;

  if not CharInSet(Key, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
    Key := #0;
end;

procedure TfrmQuantidadeUnitario.edtUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(edtUnitario, True, True);
  end;

  if not CharInSet(Key, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
    Key := #0;
end;

class function TfrmQuantidadeUnitario.SelProduto(
  AProduto: TProduto; var AQuantidade: Double;
    var AUnitario: Double): Boolean;
begin
  Result := False;

  with TfrmQuantidadeUnitario.Create(nil) do
  try
    Unitario := AProduto.PrecoVenda;

    lblProduto.Caption := string.Format(
      '%d - %s',
      [AProduto.Codigo, AProduto.Descricao]
    );

    Result := ShowModal = mrOk;
    if Result then
    begin
      AQuantidade := Quantidade;
      AUnitario := Unitario;
    end;

  finally
    Release;
  end;
end;

procedure TfrmQuantidadeUnitario.SetUnitario(const Value: Double);
begin
  FUnitario := Value;
  edtUnitario.Text := FloatToStr(Value);
end;

end.

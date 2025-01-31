object FrmBuscaPedido: TFrmBuscaPedido
  Left = 0
  Top = 0
  ActiveControl = edtCodigo
  Caption = 'Informe o n'#250'mero do pedido'
  ClientHeight = 140
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lblNumeroPedido: TLabel
    Left = 16
    Top = 32
    Width = 152
    Height = 28
    Caption = 'N'#250'mero Pedido:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnBuscarPedido: TButton
    Left = 32
    Top = 104
    Width = 107
    Height = 25
    Caption = 'Buscar Pedido'
    TabOrder = 1
    OnClick = btnBuscarPedidoClick
  end
  object btnCancelar: TButton
    Left = 160
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object edtCodigo: TEdit
    Left = 174
    Top = 29
    Width = 121
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtCodigoKeyPress
  end
end

object frmQuantidadeUnitario: TfrmQuantidadeUnitario
  Left = 0
  Top = 0
  ActiveControl = edtQuantidade
  BorderIcons = [biSystemMenu]
  Caption = 'Informe Quantidade e Unit'#225'rio'
  ClientHeight = 245
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblProduto: TLabel
    Left = 16
    Top = 16
    Width = 593
    Height = 49
    AutoSize = False
    Caption = 'Produto Codigo / Descricao'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 16
    Top = 104
    Width = 112
    Height = 28
    Caption = 'Quantidade: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 152
    Width = 75
    Height = 28
    Caption = 'Unit'#225'rio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtQuantidade: TEdit
    Left = 134
    Top = 105
    Width = 121
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtQuantidadeKeyPress
  end
  object edtUnitario: TEdit
    Left = 134
    Top = 147
    Width = 121
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnKeyPress = edtUnitarioKeyPress
  end
  object btnOk: TButton
    Left = 16
    Top = 212
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 118
    Top = 212
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end

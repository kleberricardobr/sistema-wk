object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Sistema WK'
  ClientHeight = 644
  ClientWidth = 1049
  Color = clBtnFace
  Constraints.MaxWidth = 1065
  Constraints.MinHeight = 683
  Constraints.MinWidth = 1065
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnEntrada: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1049
    Height = 121
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 0
    object lblCodCliente: TLabel
      Left = 16
      Top = 14
      Width = 134
      Height = 28
      Caption = 'C'#243'digo Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblCodProduto: TLabel
      Left = 16
      Top = 69
      Width = 146
      Height = 28
      Caption = 'C'#243'digo Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edCodCliente: TEdit
      Left = 170
      Top = 9
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
      OnKeyPress = edCodClienteKeyPress
      OnKeyUp = edCodClienteKeyUp
    end
    object edCodProduto: TEdit
      Left = 170
      Top = 66
      Width = 121
      Height = 36
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edCodProdutoKeyPress
      OnKeyUp = edCodProdutoKeyUp
    end
    object btnBuscarCliente: TButton
      Left = 297
      Top = 17
      Width = 88
      Height = 25
      Caption = 'Buscar Cliente'
      Enabled = False
      TabOrder = 1
      OnClick = btnBuscarClienteClick
    end
    object btnBuscarProduto: TButton
      Left = 297
      Top = 72
      Width = 88
      Height = 25
      Caption = 'Incluir Produto'
      Enabled = False
      TabOrder = 3
      OnClick = btnBuscarProdutoClick
    end
    object btnConsultarPedido: TButton
      Left = 928
      Top = 72
      Width = 105
      Height = 25
      Caption = 'Consultar Pedido'
      Enabled = False
      TabOrder = 4
      OnClick = btnConsultarPedidoClick
    end
    object btnExcluirPedido: TButton
      Left = 816
      Top = 72
      Width = 105
      Height = 25
      Caption = 'Excluir Pedido'
      Enabled = False
      TabOrder = 5
      OnClick = btnExcluirPedidoClick
    end
  end
  object pnDados: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 121
    Width = 1049
    Height = 523
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Enabled = False
    TabOrder = 1
    ExplicitLeft = 5
    ExplicitHeight = 486
    object lblTotal: TLabel
      Left = 1
      Top = 377
      Width = 1047
      Height = 28
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 6
    end
    object pnCliente: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 1047
      Height = 64
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      Visible = False
      object lblCliente: TLabel
        Left = 56
        Top = 13
        Width = 921
        Height = 44
        AutoSize = False
        Caption = 'Cliente: %s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
    object pnGrid: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 65
      Width = 1047
      Height = 312
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 1
      object gridPedido: TDBGrid
        Left = 1
        Top = 1
        Width = 1045
        Height = 310
        Align = alClient
        DataSource = dsPedido
        Enabled = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnColEnter = gridPedidoColEnter
        OnColExit = gridPedidoColExit
        OnExit = gridPedidoExit
        OnKeyDown = gridPedidoKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'C'#243'd. Produto'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Descri'#231#227'o Produto'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Vr. Unit'#225'rio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VrTotal'
            ReadOnly = True
            Visible = True
          end>
      end
    end
    object btnGravar: TButton
      Left = 952
      Top = 488
      Width = 81
      Height = 25
      Caption = 'Gravar Pedido'
      Enabled = False
      TabOrder = 2
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 862
      Top = 488
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object dsPedido: TDataSource
    DataSet = memPedido
    Left = 809
    Top = 306
  end
  object memPedido: TFDMemTable
    AfterOpen = memPedidoAfterOpen
    AfterClose = memPedidoAfterClose
    AfterPost = memPedidoAfterPost
    AfterDelete = memPedidoAfterDelete
    OnCalcFields = memPedidoCalcFields
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 897
    Top = 322
    object memPedidoCodProduto: TIntegerField
      DisplayWidth = 18
      FieldName = 'C'#243'd. Produto'
    end
    object memPedidoDescricaoProduto: TStringField
      DisplayWidth = 111
      FieldName = 'Descri'#231#227'o Produto'
      Size = 100
    end
    object memPedidoQuantidade: TFloatField
      DisplayWidth = 11
      FieldName = 'Quantidade'
      OnSetText = memPedidoQuantidadeSetText
      DisplayFormat = '0.00'
    end
    object memPedidoVrUnitario: TFloatField
      DisplayWidth = 11
      FieldName = 'Vr. Unit'#225'rio'
      OnSetText = memPedidoVrUnitarioSetText
      DisplayFormat = '0.00'
    end
    object memPedidoVrTotal: TFloatField
      DisplayLabel = 'Total'
      FieldKind = fkCalculated
      FieldName = 'VrTotal'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object memPedidoID: TIntegerField
      FieldName = 'ID'
    end
  end
end

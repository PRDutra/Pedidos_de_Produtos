object fmCadastroPedido: TfmCadastroPedido
  Left = 0
  Top = 0
  Caption = 'Cadastro Pedido'
  ClientHeight = 534
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    802
    534)
  TextHeight = 15
  object lbTitulo: TLabel
    Left = 0
    Top = 0
    Width = 802
    Height = 21
    Align = alTop
    Alignment = taCenter
    Caption = 'Pedidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 61
  end
  object lbTituloGrid: TLabel
    Left = 0
    Top = 177
    Width = 802
    Height = 21
    Align = alTop
    Alignment = taCenter
    Caption = 'Itens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 37
  end
  object pndadosBasicos: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 24
    Width = 796
    Height = 150
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 792
    object lbNroPedido: TLabel
      Left = 30
      Top = 59
      Width = 63
      Height = 15
      Caption = 'Nro. Pedido'
    end
    object lbNomeCliente: TLabel
      Left = 3
      Top = 88
      Width = 90
      Height = 15
      Caption = 'Nome do Cliente'
    end
    object lbEndereco: TLabel
      Left = 44
      Top = 117
      Width = 49
      Height = 15
      Caption = 'Endere'#231'o'
    end
    object lbCidade: TLabel
      Left = 459
      Top = 117
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object lbUF: TLabel
      Left = 641
      Top = 117
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object edtNroPedido: TDBEdit
      Left = 98
      Top = 56
      Width = 121
      Height = 23
      DataField = 'NroPedido'
      DataSource = dsPedido
      ReadOnly = True
      TabOrder = 0
    end
    object edtNomeCliente: TDBEdit
      Left = 99
      Top = 85
      Width = 683
      Height = 23
      DataField = 'Cliente'
      DataSource = dsPedido
      TabOrder = 1
    end
    object edtRua: TDBEdit
      Left = 98
      Top = 114
      Width = 337
      Height = 23
      DataField = 'Endereco'
      DataSource = dsPedido
      TabOrder = 2
    end
    object edtNomeCidade: TDBEdit
      Left = 500
      Top = 114
      Width = 121
      Height = 23
      DataField = 'Cidade'
      DataSource = dsPedido
      TabOrder = 3
    end
    object edtUF: TDBEdit
      Left = 661
      Top = 114
      Width = 121
      Height = 23
      DataField = 'UF'
      DataSource = dsPedido
      TabOrder = 4
      OnKeyPress = edtUFKeyPress
    end
  end
  object gridItens: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 201
    Width = 796
    Height = 160
    Align = alTop
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Produto'
        Width = 419
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Quantidade'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorUnitario'
        Title.Caption = 'Valor Unit.'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorTotal'
        Title.Caption = 'Valor Total'
        Width = 110
        Visible = True
      end>
  end
  object pnTotal: TPanel
    Left = 0
    Top = 364
    Width = 802
    Height = 37
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 798
    object lbTotal: TLabel
      Left = 589
      Top = 8
      Width = 71
      Height = 17
      Caption = 'Valor Total.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotalProdutos: TDBEdit
      Left = 666
      Top = 7
      Width = 121
      Height = 23
      DataField = 'TotalItens'
      DataSource = dsItens
      TabOrder = 0
    end
  end
  object lbItem: TPanel
    Left = 0
    Top = 401
    Width = 802
    Height = 88
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 798
    object lbTituloItem: TLabel
      Left = 1
      Top = 1
      Width = 800
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Lan'#231'amento de Item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 126
    end
    object lbProduto: TLabel
      Left = 5
      Top = 34
      Width = 43
      Height = 15
      Caption = 'Produto'
    end
    object lbQuantidade: TLabel
      Left = 428
      Top = 34
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lbVlUnitItem: TLabel
      Left = 597
      Top = 34
      Width = 71
      Height = 15
      Caption = 'Valor Unit'#225'rio'
    end
    object edtProduto: TDBEdit
      Left = 54
      Top = 31
      Width = 337
      Height = 23
      DataField = 'Produto'
      DataSource = dsItens
      TabOrder = 0
    end
    object edtQtd: TDBEdit
      Left = 496
      Top = 31
      Width = 94
      Height = 23
      DataField = 'Quantidade'
      DataSource = dsItens
      TabOrder = 1
    end
    object edtValorUnit: TDBEdit
      Left = 674
      Top = 31
      Width = 121
      Height = 23
      DataField = 'ValorUnitario'
      DataSource = dsItens
      TabOrder = 2
      OnKeyDown = edtValorUnitKeyDown
      OnKeyPress = edtValorUnitKeyPress
    end
    object dbNavegador: TDBNavigator
      Left = 288
      Top = 58
      Width = 240
      Height = 25
      DataSource = dsItens
      Hints.Strings = (
        'Primeiro registro'
        'Registro anterior'
        'Pr'#243'ximo registro'
        #218'ltimo registro'
        'Inserir registro'
        'Apagar registro'
        'Editar registro'
        'P'#243's-edi'#231#227'o'
        'Cancelar edi'#231#227'o'
        'Atualizar dados'
        'Aplicar atualiza'#231#245'es'
        'Cancelar atualiza'#231#245'es')
      ConfirmDelete = False
      TabOrder = 3
    end
  end
  object btnGravarPedido: TButton
    Left = 632
    Top = 495
    Width = 150
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = 'Gravar Pedido'
    TabOrder = 4
    OnClick = btnGravarPedidoClick
    ExplicitLeft = 628
    ExplicitTop = 494
  end
  object btnCancelarPedido: TButton
    Left = 476
    Top = 495
    Width = 150
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar Pedido'
    TabOrder = 5
    OnClick = btnCancelarPedidoClick
    ExplicitLeft = 472
    ExplicitTop = 494
  end
  object qryPedido: TFDMemTable
    AfterPost = qryPedidoAfterPost
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 752
    Top = 224
    object qryPedidoNroPedido: TIntegerField
      FieldName = 'NroPedido'
    end
    object qryPedidoCliente: TStringField
      FieldName = 'Cliente'
      Size = 200
    end
    object qryPedidoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 100
    end
    object qryPedidoCidade: TStringField
      FieldName = 'Cidade'
      Size = 100
    end
    object qryPedidoUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object qryPedidoValor: TCurrencyField
      FieldName = 'Valor'
    end
  end
  object dsPedido: TDataSource
    DataSet = qryPedido
    Left = 752
    Top = 256
  end
  object qryItens: TFDMemTable
    BeforePost = qryItensBeforePost
    AfterPost = qryItensAfterPost
    OnCalcFields = qryItensCalcFields
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 752
    Top = 288
    object qryItensNroPedido: TIntegerField
      FieldName = 'NroPedido'
    end
    object qryItensProduto: TStringField
      FieldName = 'Produto'
      Size = 200
    end
    object qryItensQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object qryItensValorUnitario: TCurrencyField
      FieldName = 'ValorUnitario'
      OnGetText = qryItensValorUnitarioGetText
    end
    object qryItensValorTotal: TCurrencyField
      FieldKind = fkInternalCalc
      FieldName = 'ValorTotal'
    end
    object qryItensTotalItens: TAggregateField
      FieldName = 'TotalItens'
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'Sum(ValorTotal)'
    end
  end
  object dsItens: TDataSource
    DataSet = qryItens
    Left = 752
    Top = 320
  end
end

object formMain: TformMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Desafio Delphi'
  ClientHeight = 476
  ClientWidth = 988
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lbTitulo: TLabel
    Left = 0
    Top = 0
    Width = 988
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 21
    Width = 988
    Height = 276
    Align = alClient
    DataSource = dsVenda
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NroPedido'
        Title.Caption = 'Nro. Pedido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cliente'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Endereco'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor'
        Width = 100
        Visible = True
      end>
  end
  object rbImpressaoVenda: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 355
    Width = 982
    Height = 118
    Align = alBottom
    Caption = 'Impress'#227'o de Venda'
    TabOrder = 1
    ExplicitTop = 354
    ExplicitWidth = 978
    object rbCondVenda: TRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 787
      Height = 93
      Align = alClient
      Caption = 'Condi'#231#227'o de Pagamento'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'A vista sem desconto'
        'A vista com desconto 5%'
        'A vista com desconto 10%'
        'A vista com desconto de (Informar %)'
        'Acr'#233'scimo de 10%'
        'Acr'#233'scimo de 12%'
        'Acr'#233'scimo de (Informar %)')
      TabOrder = 0
      OnClick = rbCondVendaClick
      ExplicitWidth = 783
    end
    object pnDireita: TPanel
      Left = 795
      Top = 17
      Width = 185
      Height = 99
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 791
      DesignSize = (
        185
        99)
      object gbCondPersonalizada: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 179
        Height = 56
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Condi'#231#227'o Personalizada'
        TabOrder = 0
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 184
        ExplicitHeight = 62
        object lbPercent: TLabel
          Left = 80
          Top = 32
          Width = 10
          Height = 15
          Caption = '%'
        end
        object edtPercentVenda: TSpinEdit
          Left = 94
          Top = 29
          Width = 77
          Height = 24
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
      end
      object btnSimularVenda: TButton
        AlignWithMargins = True
        Left = 3
        Top = 71
        Width = 179
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Simular Venda em Memo'
        TabOrder = 1
        OnClick = btnSimularVendaClick
      end
    end
  end
  object pnBotoes: TPanel
    Left = 0
    Top = 297
    Width = 988
    Height = 55
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 296
    ExplicitWidth = 984
    object btnNovo: TButton
      Left = 277
      Top = 8
      Width = 140
      Height = 33
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 420
      Top = 8
      Width = 140
      Height = 33
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnExcluir: TButton
      Left = 563
      Top = 8
      Width = 140
      Height = 33
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
  end
  object dsVenda: TDataSource
    DataSet = qryVenda
    Left = 928
    Top = 192
  end
  object qryVenda: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 928
    Top = 224
    object qryVendaNroPedido: TIntegerField
      FieldName = 'NroPedido'
    end
    object qryVendaCliente: TStringField
      FieldName = 'Cliente'
      Size = 200
    end
    object qryVendaEndereco: TStringField
      FieldName = 'Endereco'
      Size = 100
    end
    object qryVendaCidade: TStringField
      FieldName = 'Cidade'
      Size = 100
    end
    object qryVendaUF: TStringField
      FieldName = 'UF'
      Size = 100
    end
    object qryVendaValor: TCurrencyField
      FieldName = 'Valor'
    end
    object qryVendaUltimoID: TAggregateField
      FieldName = 'UltimoID'
      Active = True
      DisplayName = ''
      Expression = 'Max(NroPedido)'
    end
  end
  object qryItens: TFDMemTable
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 928
    Top = 256
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
end

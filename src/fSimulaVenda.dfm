object fmSimulaVenda: TfmSimulaVenda
  Left = 0
  Top = 0
  Caption = 'Desafio Delphi'
  ClientHeight = 448
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object mnDadosVenda: TMemo
    Left = 0
    Top = 0
    Width = 890
    Height = 403
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 886
    ExplicitHeight = 402
  end
  object pnRodape: TPanel
    Left = 0
    Top = 403
    Width = 890
    Height = 45
    Align = alBottom
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 402
    ExplicitWidth = 886
    DesignSize = (
      886
      41)
    object btnVoltar: TButton
      Left = 714
      Top = 4
      Width = 153
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Voltar'
      TabOrder = 0
      OnClick = btnVoltarClick
      ExplicitLeft = 710
    end
  end
end

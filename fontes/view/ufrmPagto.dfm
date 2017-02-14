object F_Pagto: TF_Pagto
  Left = 192
  Top = 114
  Width = 569
  Height = 368
  Caption = 'F_Pagto'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  DesignSize = (
    561
    334)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelValorPagto: TLabel
    Left = 4
    Top = 4
    Width = 55
    Height = 13
    Caption = 'Valor Pagto'
  end
  object LabelValorEntrada: TLabel
    Left = 4
    Top = 28
    Width = 64
    Height = 13
    Caption = 'Valor Entrada'
  end
  object LabelValorParcelado: TLabel
    Left = 4
    Top = 52
    Width = 75
    Height = 13
    Caption = 'Valor Parcelado'
  end
  object LabelParcelamento: TLabel
    Left = 4
    Top = 124
    Width = 65
    Height = 13
    Caption = 'Parcelamento'
  end
  object LabelTipoDocto: TLabel
    Left = 4
    Top = 76
    Width = 53
    Height = 13
    Caption = 'Tipo Docto'
  end
  object LabelQtdeParcela: TLabel
    Left = 4
    Top = 100
    Width = 62
    Height = 13
    Caption = 'Qtde Parcela'
  end
  object LabelTroco: TLabel
    Left = 216
    Top = 28
    Width = 55
    Height = 13
    Caption = 'Valor Troco'
  end
  object LabelTotalParcelado: TLabel
    Left = 216
    Top = 52
    Width = 75
    Height = 13
    Caption = 'Total Parcelado'
  end
  object EditValorPagto: TEdit
    Left = 88
    Top = 4
    Width = 121
    Height = 21
    TabStop = False
    BorderStyle = bsNone
    Color = clSilver
    ReadOnly = True
    TabOrder = 0
  end
  object EditValorEntrada: TEdit
    Left = 88
    Top = 28
    Width = 121
    Height = 21
    BorderStyle = bsNone
    TabOrder = 1
    OnKeyPress = EditValorEntradaKeyPress
  end
  object EditValorParcelado: TEdit
    Left = 88
    Top = 52
    Width = 121
    Height = 21
    BorderStyle = bsNone
    TabOrder = 3
    OnKeyPress = EditValorEntradaKeyPress
  end
  object gParcelamento: TDBGrid
    Left = 88
    Top = 124
    Width = 461
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    DataSource = dParcelamento
    FixedColor = 12615680
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWhite
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ComboBoxTipoDocto: TComboBox
    Left = 88
    Top = 76
    Width = 121
    Height = 21
    BevelKind = bkFlat
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Crediario'
    Items.Strings = (
      'Crediario'
      'Cheque'
      'Cart'#227'o')
  end
  object EditQtdeParcela: TEdit
    Left = 88
    Top = 100
    Width = 121
    Height = 21
    BorderStyle = bsNone
    TabOrder = 6
    OnKeyPress = EditValorEntradaKeyPress
  end
  object ButtonLancar: TButton
    Left = 216
    Top = 100
    Width = 75
    Height = 21
    Caption = 'Lan'#231'ar'
    TabOrder = 7
    TabStop = False
    OnClick = ButtonLancarClick
  end
  object ButtonLimpar: TButton
    Left = 296
    Top = 100
    Width = 75
    Height = 21
    Caption = 'Limpar'
    TabOrder = 8
    TabStop = False
    OnClick = ButtonLimparClick
  end
  object ButtonFinalizar: TButton
    Left = 376
    Top = 100
    Width = 75
    Height = 21
    Caption = 'Finalizar'
    TabOrder = 9
    TabStop = False
    OnClick = ButtonFinalizarClick
  end
  object EditValorTroco: TEdit
    Left = 300
    Top = 28
    Width = 121
    Height = 21
    TabStop = False
    BorderStyle = bsNone
    Color = clSilver
    ReadOnly = True
    TabOrder = 2
  end
  object EditTotalParcelado: TEdit
    Left = 300
    Top = 52
    Width = 121
    Height = 21
    TabStop = False
    BorderStyle = bsNone
    Color = clSilver
    ReadOnly = True
    TabOrder = 4
  end
  object tParcelamento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 12
    Top = 172
  end
  object dParcelamento: TDataSource
    DataSet = tParcelamento
    Left = 44
    Top = 172
  end
end

object F_Venda: TF_Venda
  Left = 220
  Top = 114
  Width = 710
  Height = 486
  Caption = 'F_Venda'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 702
    Height = 53
    Align = alTop
    Shape = bsSpacer
  end
  object LabelCliente: TLabel
    Left = 4
    Top = 4
    Width = 32
    Height = 13
    Caption = 'Cliente'
  end
  object LabelProduto: TLabel
    Left = 4
    Top = 28
    Width = 37
    Height = 13
    Caption = 'Produto'
  end
  object EditCliente: TEdit
    Left = 80
    Top = 4
    Width = 121
    Height = 21
    BorderStyle = bsNone
    TabOrder = 0
    Text = '02681433908'
  end
  object EditProduto: TEdit
    Left = 80
    Top = 28
    Width = 121
    Height = 21
    BorderStyle = bsNone
    TabOrder = 1
    Text = '10'
    OnExit = EditProdutoExit
  end
  object gItem: TDBGrid
    Left = 0
    Top = 53
    Width = 702
    Height = 367
    TabStop = False
    Align = alClient
    BorderStyle = bsNone
    DataSource = dItem
    FixedColor = 12615680
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWhite
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object PanelTotal: TPanel
    Left = 0
    Top = 420
    Width = 702
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    object LabelValorTotal: TLabel
      Left = 4
      Top = 4
      Width = 47
      Height = 13
      Caption = 'Valor total'
    end
    object EditValorTotal: TEdit
      Left = 80
      Top = 4
      Width = 121
      Height = 21
      TabStop = False
      BorderStyle = bsNone
      Color = 8454143
      ReadOnly = True
      TabOrder = 0
      Text = '0'
      OnExit = EditProdutoExit
    end
  end
  object tItem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 132
    Top = 148
  end
  object dItem: TDataSource
    DataSet = tItem
    Left = 164
    Top = 148
  end
end

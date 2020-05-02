object view_ImportacaoMovimentacao: Tview_ImportacaoMovimentacao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Importa'#231#227'o da planilha de Movimenta'#231#245'es '
  ClientHeight = 519
  ClientWidth = 810
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    810
    519)
  PixelsPerInch = 96
  TextHeight = 13
  object lblArquivo: TLabel
    Left = 8
    Top = 55
    Width = 49
    Height = 16
    Caption = '&Arquivo'
    FocusControl = editArquivo
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblData: TLabel
    Left = 8
    Top = 119
    Width = 31
    Height = 16
    Caption = '&Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object speedButtonArquivo: TSpeedButton
    Left = 503
    Top = 77
    Width = 23
    Height = 26
    Cursor = crHandPoint
    Action = actAbrir
    Anchors = [akTop, akRight]
    Flat = True
    Transparent = False
  end
  object lblNotice: TLabel
    Left = 8
    Top = 453
    Width = 121
    Height = 58
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Processando. Aguarde...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsItalic]
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    Visible = False
    WordWrap = True
  end
  object panelTitle: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'panelTitle'
    Color = clHighlight
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 0
    object lblTitle: TLabel
      Left = 44
      Top = 13
      Width = 66
      Height = 23
      Caption = 'lblTitle'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object imageLogo: TImage
      Left = 6
      Top = 4
      Width = 32
      Height = 32
      Stretch = True
    end
  end
  object panelButtonImportar: TPanel
    Left = 540
    Top = 70
    Width = 128
    Height = 32
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'panelButtonImportar'
    Color = clHighlight
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object speedButtonImportar: TSpeedButton
      Left = 0
      Top = 0
      Width = 128
      Height = 32
      Cursor = crHandPoint
      Action = actImportar
      Align = alClient
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 72
      ExplicitTop = 16
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
  object panelButtonSair: TPanel
    Left = 674
    Top = 70
    Width = 128
    Height = 32
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'panelButtomImportar'
    Color = clGray
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object speedButtonSair: TSpeedButton
      Left = 0
      Top = 0
      Width = 128
      Height = 32
      Cursor = crHandPoint
      Action = actSair
      Align = alClient
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 64
      ExplicitTop = 16
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
  object editArquivo: TEdit
    Left = 8
    Top = 77
    Width = 489
    Height = 26
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object dateTimePickerData: TDateTimePicker
    Left = 8
    Top = 149
    Width = 137
    Height = 26
    CalColors.TextColor = clTeal
    Date = 43867.482720555560000000
    Time = 43867.482720555560000000
    Checked = False
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 4
  end
  object aclMovimento: TActionList
    Left = 728
    Top = 152
    object actImportar: TAction
      Category = 'Movimenta'#231#227'o'
      Caption = 'IMPORTAR'
      Hint = 'importar planilha de movimenta'#231#245'es de assinaturas'
      OnExecute = actImportarExecute
    end
    object actSair: TAction
      Category = 'Movimenta'#231#227'o'
      Caption = 'SAIR'
      Hint = 'Sair da tela'
      OnExecute = actSairExecute
    end
    object actAbrir: TAction
      Category = 'Movimenta'#231#227'o'
      Caption = '...'
      Hint = 'Abrir arquivo de planilha de movimenta'#231#245'es'
      OnExecute = actAbrirExecute
    end
  end
end

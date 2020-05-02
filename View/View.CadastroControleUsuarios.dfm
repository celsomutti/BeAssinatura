object view_CadastroControleUsuarios: Tview_CadastroControleUsuarios
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Cadastro e Controle de Usu'#225'rios do APP eAssinatura'
  ClientHeight = 403
  ClientWidth = 791
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
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    791
    403)
  PixelsPerInch = 96
  TextHeight = 13
  object panelTitle: TPanel
    Left = 0
    Top = 0
    Width = 791
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
  object DBGrid1: TDBGrid
    Left = 16
    Top = 88
    Width = 767
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    DataSource = dataSourceUsuarios
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = popupMenuUsuarios
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id_usuario'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nom_usuario'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_login'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_senha'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_agente'
        Title.Alignment = taCenter
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -15
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 600
        Visible = True
      end>
  end
  object panelButtonImportar: TPanel
    Left = 655
    Top = 47
    Width = 128
    Height = 32
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'panelButtonSair'
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
      ExplicitLeft = 48
      ExplicitTop = 8
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
  object panelGravar: TPanel
    Left = 521
    Top = 47
    Width = 128
    Height = 32
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'panelButtonSair'
    Color = clMenuHighlight
    ParentBackground = False
    ShowCaption = False
    TabOrder = 3
    object speedButtonGravar: TSpeedButton
      Left = 0
      Top = 0
      Width = 128
      Height = 32
      Cursor = crHandPoint
      Action = actGravar
      Align = alClient
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 48
      ExplicitTop = 8
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
  end
  object dataSourceUsuarios: TDataSource
    DataSet = Data_Module.memTableUsuarios
    Left = 408
    Top = 40
  end
  object aclUsuarios: TActionList
    Left = 472
    Top = 40
    object actSair: TAction
      Category = 'Usu'#225'rios'
      Caption = 'SAIR'
      Hint = 'Sair da tela'
      OnExecute = actSairExecute
    end
    object actGravar: TAction
      Category = 'Usu'#225'rios'
      Caption = 'GRAVAR'
      Hint = 'Gravar no banco de dados;'
      OnExecute = actGravarExecute
    end
    object actAtivar: TAction
      Category = 'Usu'#225'rios'
      Caption = 'Ativar usu'#225'rio'
      Hint = 'Ativar usu'#225'rio selecionado'
      OnExecute = actAtivarExecute
    end
    object actDesativar: TAction
      Category = 'Usu'#225'rios'
      Caption = 'Desativar'
      Hint = 'Desativar usu'#225'rio selecionado'
      OnExecute = actDesativarExecute
    end
  end
  object popupMenuUsuarios: TPopupMenu
    Left = 112
    Top = 40
    object Ativarusurio1: TMenuItem
      Action = actAtivar
    end
    object Desativar1: TMenuItem
      Action = actDesativar
    end
  end
end

object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  Caption = 'Principal - IBAlerter'
  ClientHeight = 511
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 583
    Height = 511
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 489
    object Label1: TLabel
      Left = 32
      Top = 36
      Width = 60
      Height = 16
      Caption = 'Digite aqui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btn_fechamento: TButton
      Left = 196
      Top = 36
      Width = 150
      Height = 45
      Caption = 'Iniciar Fechamento'
      TabOrder = 1
      OnClick = btn_fechamentoClick
    end
    object edt_nome: TEdit
      Left = 32
      Top = 60
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 96
      Width = 583
      Height = 321
      DataSource = dsClientes
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object pnlBottom: TPanel
      Left = 1
      Top = 440
      Width = 581
      Height = 70
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object btn_sair: TButton
        Left = 399
        Top = 9
        Width = 150
        Height = 45
        Caption = 'Sair'
        TabOrder = 0
        OnClick = btn_sairClick
      end
    end
    object btn_concluir: TButton
      Left = 376
      Top = 36
      Width = 150
      Height = 45
      Caption = 'Concluir Fechamento'
      TabOrder = 4
      OnClick = btn_sairClick
    end
  end
  object tbClientes: TIBTable
    Database = ibConexao
    Transaction = ibTransacao
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 55
      end
      item
        Name = 'ENDERECO'
        DataType = ftWideString
        Size = 55
      end
      item
        Name = 'BAIRRO'
        DataType = ftWideString
        Size = 25
      end
      item
        Name = 'CEP'
        DataType = ftWideString
        Size = 9
      end
      item
        Name = 'CIDADE'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'ESTADO'
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'FONE1'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'EMAIL'
        DataType = ftWideString
        Size = 60
      end>
    IndexDefs = <
      item
        Name = 'PK_TB_CLIENTES'
        Fields = 'ID'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'TB_CLIENTES'
    UniDirectional = False
    Left = 96
    Top = 120
    object tbClientesID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object tbClientesNOME: TIBStringField
      FieldName = 'NOME'
      Required = True
      Size = 55
    end
    object tbClientesENDERECO: TIBStringField
      FieldName = 'ENDERECO'
      Size = 55
    end
  end
  object dsClientes: TDataSource
    DataSet = tbClientes
    Left = 37
    Top = 117
  end
  object qBusca: TIBQuery
    Database = ibConexao
    Transaction = ibTransacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 504
    Top = 256
  end
  object qGrava: TIBQuery
    Database = ibConexao
    Transaction = ibTransacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 504
    Top = 320
  end
  object IBEvents1: TIBEvents
    AutoRegister = False
    Database = ibConexao
    Events.Strings = (
      'NEW_PUSH'
      'NOVO_EVENTO')
    Registered = False
    OnEventAlert = IBEvents1EventAlert
    Left = 520
    Top = 192
  end
  object ibConexao: TIBDatabase
    Connected = True
    DatabaseName = 'C:\database\ODC_TESTE.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 512
    Top = 136
  end
  object ibTransacao: TIBTransaction
    Active = True
    DefaultDatabase = ibConexao
    Left = 456
    Top = 192
  end
end

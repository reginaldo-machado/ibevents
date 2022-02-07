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
    object DBGrid1: TDBGrid
      Left = 0
      Top = 95
      Width = 583
      Height = 329
      DataSource = dsDATMOV
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
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
      TabOrder = 4
      object btn_sair: TButton
        Left = 399
        Top = 9
        Width = 150
        Height = 45
        Caption = 'Sair'
        TabOrder = 0
        OnClick = btn_sairClick
      end
      object btn_atualizar: TButton
        Left = 264
        Top = 9
        Width = 117
        Height = 25
        Caption = 'Atualizar Grid'
        TabOrder = 1
        OnClick = btn_atualizarClick
      end
    end
    object btn_iniciar_fechamento: TButton
      Left = 219
      Top = 3
      Width = 150
      Height = 40
      Caption = 'Iniciar Fechamento'
      TabOrder = 1
      OnClick = btn_iniciar_fechamentoClick
    end
    object btn_concluir: TButton
      Left = 400
      Top = 3
      Width = 150
      Height = 40
      Caption = 'Concluir Fechamento'
      TabOrder = 2
      OnClick = btn_concluirClick
    end
    object edt_usuario: TEdit
      Left = 15
      Top = 12
      Width = 74
      Height = 21
      TabOrder = 0
      Text = 'a'
      OnExit = edt_usuarioExit
    end
    object edt_terminal: TEdit
      Left = 15
      Top = 49
      Width = 74
      Height = 21
      TabOrder = 5
      Text = '10'
      OnExit = edt_usuarioExit
    end
  end
  object dsDATMOV: TDataSource
    DataSet = qDATMOV
    Left = 69
    Top = 125
  end
  object qBusca: TIBQuery
    Database = ibConexao
    Transaction = ibTransacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 448
    Top = 256
  end
  object IBEvents1: TIBEvents
    AutoRegister = False
    Database = ibConexao
    Events.Strings = (
      'FECHAMENTO_INICIADO'
      'NEW_PUSH'
      'NOVO_EVENTO')
    Registered = False
    OnEventAlert = IBEvents1EventAlert
    Left = 520
    Top = 192
  end
  object ibConexao: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Unisoft\Dados\ABAETE_CONTRATOS.FDB'
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
  object qAtualiza: TIBQuery
    Database = ibConexao
    Transaction = ibTransacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 504
    Top = 256
  end
  object qDATMOV: TIBQuery
    Database = ibConexao
    Transaction = ibTransacao
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select DATA, FECHOU, FECHAMENTO_INICIADO, FECHAMENTO_USUARIO, FE' +
        'CHAMENTO_TERMINAL, FECHAMENTO_HORA from DATMOV where FECHOU = '#39'N' +
        #39)
    Left = 136
    Top = 128
    object qDATMOVDATA: TDateField
      FieldName = 'DATA'
      Origin = 'DATMOV.DATA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qDATMOVFECHOU: TIBStringField
      FieldName = 'FECHOU'
      Origin = 'DATMOV.FECHOU'
      Size = 1
    end
    object qDATMOVFECHAMENTO_INICIADO: TIBStringField
      DisplayLabel = 'INICIADO'
      FieldName = 'FECHAMENTO_INICIADO'
      Origin = 'DATMOV.FECHAMENTO_INICIADO'
      FixedChar = True
      Size = 1
    end
    object qDATMOVFECHAMENTO_USUARIO: TIBStringField
      DisplayLabel = 'USUARIO'
      FieldName = 'FECHAMENTO_USUARIO'
      Origin = 'DATMOV.FECHAMENTO_USUARIO'
    end
    object qDATMOVFECHAMENTO_TERMINAL: TIBStringField
      DisplayLabel = 'TERMINAL'
      FieldName = 'FECHAMENTO_TERMINAL'
      Origin = 'DATMOV.FECHAMENTO_TERMINAL'
      Size = 3
    end
    object qDATMOVFECHAMENTO_HORA: TTimeField
      DisplayLabel = 'HORA'
      FieldName = 'FECHAMENTO_HORA'
      Origin = 'DATMOV.FECHAMENTO_HORA'
    end
  end
end

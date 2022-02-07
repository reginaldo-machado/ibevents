unit f_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  IBX.IBQuery, Vcl.Grids, Vcl.DBGrids, IBX.IBCustomDataSet, IBX.IBTable,
  IBX.IBDatabase, IBX.IBEvents, DateUtils;

type
  Tfrm_principal = class(TForm)
    pnlClient: TPanel;
    dsDATMOV: TDataSource;
    DBGrid1: TDBGrid;
    qBusca: TIBQuery;
    IBEvents1: TIBEvents;
    ibConexao: TIBDatabase;
    ibTransacao: TIBTransaction;
    pnlBottom: TPanel;
    btn_sair: TButton;
    qAtualiza: TIBQuery;
    btn_iniciar_fechamento: TButton;
    btn_atualizar: TButton;
    qDATMOV: TIBQuery;
    qDATMOVDATA: TDateField;
    qDATMOVFECHOU: TIBStringField;
    qDATMOVFECHAMENTO_INICIADO: TIBStringField;
    btn_concluir: TButton;
    edt_usuario: TEdit;
    edt_terminal: TEdit;
    qDATMOVFECHAMENTO_USUARIO: TIBStringField;
    qDATMOVFECHAMENTO_TERMINAL: TIBStringField;
    qDATMOVFECHAMENTO_HORA: TTimeField;
    procedure btn_sairClick(Sender: TObject);
    procedure IBEvents1EventAlert(Sender: TObject; EventName: string;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_iniciar_fechamentoClick(Sender: TObject);
    procedure btn_atualizarClick(Sender: TObject);
    procedure btn_concluirClick(Sender: TObject);
    procedure edt_usuarioExit(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

  wusuario_logado: string;
  wincluir: boolean;


implementation

{$R *.dfm}

procedure Tfrm_principal.btn_iniciar_fechamentoClick(Sender: TObject);
begin
    try
      if not ibTransacao.Active then
        ibTransacao.Active := True;

      qAtualiza.Close;
      qAtualiza.SQL.Clear;
      qAtualiza.SQL.Add('UPDATE DATMOV ');
      qAtualiza.SQL.Add('SET FECHAMENTO_INICIADO = :pFECHAMENTO_INICIADO, ');
      qAtualiza.SQL.Add(' FECHAMENTO_USUARIO  = :pFECHAMENTO_USUARIO, ');
      qAtualiza.SQL.Add(' FECHAMENTO_TERMINAL = :pFECHAMENTO_TERMINAL, ');
      qAtualiza.SQL.Add(' FECHAMENTO_HORA = :pFECHAMENTO_HORA ');
      qAtualiza.SQL.Add('WHERE DATA = :pDATA ');
      qAtualiza.SQL.Add('AND FECHOU = ''N'' ');
      qAtualiza.SQL.Add('AND FECHAMENTO_INICIADO IS NULL');
      qAtualiza.ParamByName('pFECHAMENTO_INICIADO').AsString := 'S';
      qAtualiza.ParamByName('pFECHAMENTO_USUARIO').AsString := edt_usuario.Text;
      qAtualiza.ParamByName('pFECHAMENTO_TERMINAL').AsString := edt_terminal.Text;
      qAtualiza.ParamByName('pFECHAMENTO_HORA').AsTime :=  HourOf(Now);
      qAtualiza.ParamByName('pDATA').Value := qDATMOV.FieldByName('DATA').Value;
      qAtualiza.ExecSQL;

      ibTransacao.Commit;

      wincluir := true;

      qDATMOV.Close;
      qDATMOV.Open;


     if wusuario_logado <> 'a' then
     begin
        Application.MessageBox('N�o � poss�vel continuar!' +#10+
                    'Finalize o fechamento.' ,'Aviso',Mb_IconInformation + Mb_Ok  );

         Application.Terminate;
     end;

    except
      Application.MessageBox('Erro ao iniciar fechamento!',
                  'Erro',
                  Mb_IconInformation + Mb_Ok );

    end;

end;

procedure Tfrm_principal.btn_sairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrm_principal.edt_usuarioExit(Sender: TObject);
begin


  if edt_usuario.Text <> '' then
    wusuario_logado := edt_usuario.Text
  else
  begin
    Application.MessageBox('Usu�rio n�o foi informado.',
                'Aviso',
                Mb_IconInformation + Mb_Ok  );
    edt_usuario.SetFocus;
  end;
end;

procedure Tfrm_principal.btn_concluirClick(Sender: TObject);
begin
    try
      if not ibTransacao.Active then
        ibTransacao.Active := True;

      qAtualiza.Close;
      qAtualiza.SQL.Clear;
      qAtualiza.SQL.Add('UPDATE DATMOV ');
      qAtualiza.SQL.Add('SET FECHAMENTO_INICIADO = :pFECHAMENTO_INICIADO, ');
      qAtualiza.SQL.Add(' FECHAMENTO_USUARIO  = :pFECHAMENTO_USUARIO, ');
      qAtualiza.SQL.Add(' FECHAMENTO_TERMINAL = :pFECHAMENTO_TERMINAL, ');
      qAtualiza.SQL.Add(' FECHAMENTO_HORA = :pFECHAMENTO_HORA ');
      qAtualiza.SQL.Add('WHERE DATA = :pDATA ');
      qAtualiza.SQL.Add('AND FECHOU = ''N'' ');
      qAtualiza.SQL.Add('AND FECHAMENTO_INICIADO IS NOT NULL');
      qAtualiza.ParamByName('pFECHAMENTO_INICIADO').Value := Null;
      qAtualiza.ParamByName('pFECHAMENTO_USUARIO').Value := Null;
      qAtualiza.ParamByName('pFECHAMENTO_TERMINAL').Value := Null;
      qAtualiza.ParamByName('pFECHAMENTO_HORA').Value := Null;
      qAtualiza.ParamByName('pDATA').Value := qDATMOV.FieldByName('DATA').Value;
      qAtualiza.ExecSQL;

      ibTransacao.Commit;

      wincluir := false;

      qDATMOV.Close;
      qDATMOV.Open;

    except
      Application.MessageBox('Erro ao tentar atualizar o campo Fechamento_Iniciado!',
                  'Erro',
                  Mb_IconInformation + Mb_Ok );

    end;

end;

procedure Tfrm_principal.btn_atualizarClick(Sender: TObject);
begin
  qDATMOV.Close;
  qDATMOV.Open;
end;

procedure Tfrm_principal.FormCreate(Sender: TObject);
begin
  qDATMOV.Active := True;

{
  #@
  Aqui pDATA � apenas para fins de teste.
  Em produ��o, Iniciar Fechamento sempre vai ser na data atual?
  Definir se vai ser permitido Iniciar Fechamento hoje(data atual) referente a 5 dias atr�s?

  A select abaixo faz uma valida��o para n�o permitir abrir o sistema caso um fechamento
  ainda n�o tenha sido finalizado.
  Nessa select tbm � necess�rio filtrar FECHOU= 'N' ?
}

  qBusca.SQL.Clear;
  qBusca.Close;
  qBusca.SQL.Add('select DATA, FECHOU, FECHAMENTO_INICIADO FROM DATMOV ');
  qBusca.SQL.Add('where DATA = :pDATA ');
  qBusca.ParamByName('pDATA').Value := qDATMOV.FieldByName('DATA').Value;
  qBusca.Open;

  qBusca.First;
  if qBusca.FieldByName('FECHAMENTO_INICIADO').AsString = 'S' then
  begin
    //verificar terminal e usu�rio
    Application.MessageBox('N�o � poss�vel conectar!' +#10+
                'Finalize o fechamento.' ,'Aviso',Mb_IconInformation + Mb_Ok  );

    Application.Terminate;

  end;

  IBEvents1.RegisterEvents;
end;

procedure Tfrm_principal.FormDestroy(Sender: TObject);
begin
  if ibConexao.Connected then
  begin
    if ibTransacao.InTransaction then
      ibTransacao.Commit;

    if IBEvents1.Registered then
      IBEvents1.UnRegisterEvents;

    qDATMOV.Active := False;

    ibConexao.Close;
  end;
end;

procedure Tfrm_principal.IBEvents1EventAlert(Sender: TObject; EventName: string;
  EventCount: Integer; var CancelAlerts: Boolean);
begin
  qDATMOV.Close;
  qDATMOV.Open;

  { #@
    no teste inicial feito sexta feira, a aplica��o secund�ria n�o teve os dados atualizados,
    analisar esse fato.

  }

  //showmessage('Recebi o evento: ' + EventName);


  { if wincluir foi necess�rio para tratar erro que era gerado ao comparar
    edt_usuario (que tem valor = a) com o campo fechamento_usuario (que tem valor null) }

  if wincluir then
  begin
    if edt_usuario.Text = qDATMOV.FieldByName('FECHAMENTO_USUARIO').AsString then
    begin

      showmessage('Evento Recebito. '+#10+
      'Usu�rio: ' + qDATMOV.FieldByName('FECHAMENTO_USUARIO').AsString);

      {
      Application.MessageBox('N�o � poss�vel continuar!' +#10+
                  'Fechamento em aberto.' ,'Aviso',Mb_IconInformation + Mb_Ok  );

      Application.Terminate;
      }

    end
    else
    begin
      Application.MessageBox('N�o � poss�vel continuar!' +#10+
                  'Fechamento em aberto.' ,'Aviso',Mb_IconInformation + Mb_Ok  );

      Application.Terminate;

    end;


  end;




  //Consultar a tabela datmov e verificar se o usuario e o terminal = editterminal e edtusuario.

  //se for igual  n�o mostra mensagem nenhuma.
  //sen�o mostra

  //Application.MessageBox('Fechamento iniciado!', 'Aviso', Mb_IconInformation + Mb_Ok  );
  //mostrar na mensagem = usu�rio,terminal,hora



end;

end.

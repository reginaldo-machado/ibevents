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
  IBX.IBDatabase, IBX.IBEvents;

type
  Tfrm_principal = class(TForm)
    pnlClient: TPanel;
    btn_fechamento: TButton;
    edt_nome: TEdit;
    tbClientes: TIBTable;
    tbClientesID: TIntegerField;
    tbClientesNOME: TIBStringField;
    tbClientesENDERECO: TIBStringField;
    dsClientes: TDataSource;
    DBGrid1: TDBGrid;
    qBusca: TIBQuery;
    qGrava: TIBQuery;
    IBEvents1: TIBEvents;
    ibConexao: TIBDatabase;
    ibTransacao: TIBTransaction;
    Label1: TLabel;
    pnlBottom: TPanel;
    btn_concluir: TButton;
    btn_sair: TButton;
    procedure btn_fechamentoClick(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure IBEvents1EventAlert(Sender: TObject; EventName: string;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

procedure Tfrm_principal.btn_fechamentoClick(Sender: TObject);
var
  Lcontador: Integer;
  Lnome: String;
begin
  if edt_nome.Text = '' then
  begin
    Application.MessageBox('Nada foi informado!',
                'Aviso',
                Mb_IconInformation + Mb_Ok);

    exit;
  end;



  qBusca.SQL.Clear;
  qBusca.Close;
  qBusca.SQL.Add('select MAX(ID) AS ID FROM TB_CLIENTES ');
  qBusca.Open;
  if qBusca.FieldByName('ID').AsInteger >= 1 then
    Lcontador := qBusca.FieldByName('ID').AsInteger + 1
  else
    Lcontador := 1;

  Lnome := edt_nome.Text;

  try
    ibTransacao.Active := false;
    ibTransacao.Active := true;

    qGrava.Close;
    qGrava.SQL.Clear;
    qGrava.SQL.Add('insert into tb_clientes(id, nome) ');
    qGrava.SQL.Add('values (:PId, :PNome) ');
    qGrava.ParamByName('PId').AsInteger := Lcontador;
    qGrava.ParamByName('PNome').AsString := edt_nome.Text;
    qGrava.ExecSQL;

    ibTransacao.Commit;
    ibTransacao.Active := false;


    Application.MessageBox('Um novo registro foi inserido!',
                'Aviso',
                Mb_IconInformation + Mb_Ok  );

  except
    Application.MessageBox('Erro ao gravar',
                'Erro',
                Mb_IconInformation + Mb_Ok );

  end;

end;

procedure Tfrm_principal.btn_sairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrm_principal.FormCreate(Sender: TObject);
begin
  tbClientes.Active := True;

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

    tbClientes.Active := False;

    ibConexao.Close;
  end;
end;

procedure Tfrm_principal.IBEvents1EventAlert(Sender: TObject; EventName: string;
  EventCount: Integer; var CancelAlerts: Boolean);
begin
  showmessage('Recebi o evento: ' + EventName);

  tbClientes.Close;
  tbClientes.Open;

  edt_nome.Clear;

end;

end.

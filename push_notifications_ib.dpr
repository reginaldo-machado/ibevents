program push_notifications_ib;

uses
  Vcl.Forms,
  f_principal in 'forms\f_principal.pas' {frm_principal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.Run;
end.

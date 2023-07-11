program Project;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Inserir in 'forms\Inserir.pas' {frmInserir},
  Classes in 'Classes.pas',
  Alterar in 'forms\Alterar.pas' {frmAlterar};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := (DebugHook) <> 0;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAlterar, frmAlterar);
  Application.CreateForm(TfrmInserir, frmInserir);
  Application.Run;
end.

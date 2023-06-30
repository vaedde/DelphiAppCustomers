program Project;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Inserir in 'forms\Inserir.pas' {frmInserir},
  Classes in 'Classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmInserir, frmInserir);
  Application.Run;
end.

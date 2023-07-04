program Project;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Inserir in 'forms\Inserir.pas' {frmInserir},
  Classes in 'Classes.pas',
  Alterar in 'forms\Alterar.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmInserir, frmInserir);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmMain = class(TForm)
    pnlMain: TPanel;
    pnlShadow: TPanel;
    pnlLeft: TPanel;
    pnlForm: TPanel;
    pnlAlterar: TPanel;
    pnlInserir: TPanel;
    pnlTop: TPanel;
    Image2: TImage;
    pnlBottom: TPanel;
    pnlLine: TPanel;
    pnlMenu: TPanel;
    pnlRelatorio: TPanel;
    Edit1: TEdit;
    imgSearch: TImage;
    imgMenu: TImage;
    imgInserir: TImage;
    imgAlterar: TImage;
    imgRelatorio: TImage;
    Image1: TImage;
    pnlQuantCad: TPanel;
    pnlQuantPF: TPanel;
    pnlQuantPJ: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    StringGrid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure imgInserirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    arq : TextFile;
    Lines : Integer;
    Linha : String;
    procedure CloseAll;
    procedure Carregar;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Inserir;

procedure TfrmMain.Carregar;
var
  Get, Post : TStrings;
  I, J : Integer;
begin
  Reset(arq);
  Lines := 1;
  while (not Eof(arq)) do begin
    Readln(arq, Linha);
    Lines := Lines + 1;
  end;

   ReadLn ( arq, linha );
   StringGrid.ColCount:=StrToInt(linha);
   ReadLn ( arq, linha );
   StringGrid.RowCount:=StrToInt(linha);
   ReadLn ( arq, linha );
  for i:=0 to StringGrid.RowCount do begin
    for j:=0 to StringGrid.ColCount do begin
      StringGrid.Cells[j,i]:=linha;
      ReadLn ( arq, linha );
    end;
  end;
  CloseFile ( arq );
end;

procedure TfrmMain.CloseAll;
begin
  frmInserir.Close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  pnlMain.SetFocus;

  if not FileExists(GetCurrentDir + '.\db\database.txt') then begin
    try
      FileCreate(GetCurrentDir + '\db\database.txt');
    except
      Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end else begin
    AssignFile(arq, GetCurrentDir + '\db\database.txt');
  end;

  Carregar;
  pnlQuantCad.Caption := IntToStr(Lines);
  CloseFile(arq);
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin
  CloseAll;

  Carregar;
  pnlQuantCad.Caption := IntToStr(Lines);
  CloseFile(arq);
end;

procedure TfrmMain.imgInserirClick(Sender: TObject);
begin
  CloseAll;
  frmInserir.Parent := pnlForm;
  frmInserir.Show;
end;

end.

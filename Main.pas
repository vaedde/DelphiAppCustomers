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
    edtSearch: TEdit;
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
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    arq : TextFile;
    Lines, LinesSto, LinesF, LinesJ : Integer;
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
  I, J, K : Integer;
  Linha, LinhaSto : String;
begin
  Reset(arq);
  Lines    := 1;
  LinesSto := 1;
  LinesF   := 0;
  LinesJ   := 0;
  while (not Eof(arq)) do begin
    Readln(arq, Linha);
    Lines := Lines + 1;
  end;

  with StringGrid do
  for I := 1 to RowCount -1 do begin
    Rows[I].Clear;
  end;

  StringGrid.RowCount:= Lines;

  Reset(arq);
  for I := 1 to StringGrid.RowCount do begin
    ReadLn (arq, Linha);
    for J := 0 to StringGrid.ColCount do begin
      K := pos('|', Linha);
      LinhaSto := copy(linha, 1, K-1);
      Delete(Linha, 1, K);
      StringGrid.Cells[j,i] := LinhaSto;
    end;
  end;

  Lines := Lines - 1;

  Reset(arq);
  while (not Eof(arq)) do begin
    ReadLn (arq, Linha);
    Linha := StringGrid.Cells[16, LinesSto];
    LinesSto := LinesSto + 1;
    if Linha = 'PF' then begin
      LinesF := LinesF + 1;
    end else if Linha = 'PJ' then begin
      LinesJ := LinesJ + 1;
    end;
  end;
end;

procedure TfrmMain.CloseAll;
begin
  frmInserir.Close;
end;

procedure TfrmMain.edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  I, J, K : Integer;
  Linha, LinhaSto : String;
begin
  if edtSearch.Text = '' then begin
    Carregar;
  end;

  try
    Linha := StringGrid.Cells[1, LinesSto];
  except
    Linha := StringGrid.Cells[2, LinesSto];
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  with StringGrid do begin
    ColCount := 17;
    Cells[0,0]  := 'ID';
    ColWidths[0]  := 40;
    Cells[1,0]  := 'Nome';
    ColWidths[1]  := 150;
    Cells[2,0]  := 'CPF - CNPJ';
    ColWidths[2]  := 100;
    Cells[3,0]  := 'RG - IM';
    ColWidths[3]  := 100;
    Cells[4,0]  := 'Email';
    ColWidths[4]  := 200;
    Cells[5,0]  := 'Telefone';
    ColWidths[5]  := 100;
    Cells[6,0]  := 'Data';
    ColWidths[6]  := 100;
    Cells[7,0]  := 'Nacionalidade';
    ColWidths[7]  := 120;
    Cells[8,0]  := 'Grau de Escolaridade';
    ColWidths[8]  := 120;
    Cells[9,0]  := 'Profissão';
    ColWidths[9]  := 150;
    Cells[10,0]  := 'CEP';
    ColWidths[10]  := 100;
    Cells[11,0] := 'Enereço';
    ColWidths[11] := 200;
    Cells[12,0] := 'Número';
    ColWidths[12] := 40;
    Cells[13,0] := 'Bairro';
    ColWidths[13] := 100;
    Cells[14,0] := 'Município';
    ColWidths[14] := 100;
    Cells[15,0] := 'UF';
    ColWidths[15] := 40;
    Cells[16,0] := 'Tipo';
    ColWidths[16] := 40;
  end;

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
  pnlQuantPF.Caption  := IntToStr(LinesF);
  pnlQuantPJ.Caption  := IntToStr(LinesJ);
  CloseFile(arq);
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin
  CloseAll;
  Carregar;
  pnlQuantCad.Caption := IntToStr(Lines);
  pnlQuantPF.Caption  := IntToStr(LinesF);
  pnlQuantPJ.Caption  := IntToStr(LinesJ);
  CloseFile(arq);
end;

procedure TfrmMain.imgInserirClick(Sender: TObject);
begin
  CloseAll;
  frmInserir.Parent := pnlForm;
  frmInserir.Show;
end;

end.

unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Classes;

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
    imgMenu: TImage;
    imgInserir: TImage;
    imgAlterar: TImage;
    imgRelatorio: TImage;
    pnlQuantCad: TPanel;
    pnlQuantPF: TPanel;
    pnlQuantPJ: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlStroke: TPanel;
    StringGrid: TStringGrid;
    CheckBox: TCheckBox;
    Panel1: TPanel;
    RadioButtonTodos: TRadioButton;
    RadioButtonPF: TRadioButton;
    RadioButtonPJ: TRadioButton;
    pnlOrdem: TPanel;
    imgOrdenar: TImage;
    imgOrdenarTipo: TImage;
    pnlRefresh: TPanel;
    imgRefresh: TImage;
    procedure FormShow(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CheckBoxClick(Sender: TObject);
    procedure imgRefreshClick(Sender: TObject);
    procedure RadioButtonPFClick(Sender: TObject);
    procedure RadioButtonPJClick(Sender: TObject);
    procedure RadioButtonTodosClick(Sender: TObject);
    procedure imgInserirClick(Sender: TObject);
    procedure imgAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dbpf, dbpj : TextFile;
    FilaPF : TFilaPF;
    PF     : TPFisica;
    FilaPJ : TFilaPJ;
    PJ     : TPJuridica;
    Lines, L, LinesF, LPF, LinesJ, LPJ : Integer;
    function Extrair(Linha : String) : String;
    procedure Carregar;
    procedure PopularClasse;
    procedure PopularGridF;
    procedure PopularGridJ;
    procedure GridClear;
    procedure SearchF(Filtro : String);
    procedure SearchJ(Filtro : String);
    procedure SearchFJ(Filtro: String);
    function  Search(Edt : String) : String;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Inserir;

procedure TfrmMain.Carregar;
var
  I, J : Integer;
begin
  Lines  := 0;
  L      := 1;
  LinesF := 0;
  LPF    := 0;
  LinesJ := 0;
  LPJ    := 0;

  LinesF := FilaPF.FilaPF.Count;
  LinesJ := FilaPJ.FilaPJ.Count;
  Lines := LinesF + LinesJ;

  if not CheckBox.Checked then begin
    if RadioButtonTodos.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        if PF.Status = '1' then begin
          PopularGridF;
          L := L + 1;
        end else begin
        end;
        LPF := LPF + 1;
      end;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        if PJ.Status = '1' then begin
          PopularGridJ;
          L := L + 1;
        end else begin
        end;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPF.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        if PF.Status = '1' then begin
          PopularGridF;
          L := L + 1;
        end else begin
        end;
        LPF := LPF + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPJ.Checked then begin
      GridClear;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        if PJ.Status = '1' then begin
          PopularGridJ;
          L := L + 1;
        end else begin
        end;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end;
  end else begin
    if RadioButtonTodos.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        PopularGridF;
        L := L + 1;
        LPF := LPF + 1;
      end;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        PopularGridJ;
        L := L + 1;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPF.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        PopularGridF;
        L := L + 1;
        LPF := LPF + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPJ.Checked then begin
      GridClear;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        PopularGridJ;
        L := L + 1;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end;
  end;

  pnlQuantCad.Caption := IntToStr(Lines);
  pnlQuantPF.Caption  := IntToStr(LinesF);
  pnlQuantPJ.Caption  := IntToStr(LinesJ);
end;

procedure TfrmMain.CheckBoxClick(Sender: TObject);
begin
  if edtSearch.Text = '' then begin
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

procedure TfrmMain.edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if edtSearch.Text = '' then begin
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

function TfrmMain.Extrair(Linha: String): String;
var
  I   : Integer;
  Sto : String;
begin
  I   := pos('|', Linha);
  Sto := copy(Linha, 1, I-1);
  Delete(Linha, 1, I);
  Result := Sto;
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
    Cells[11,0] := 'Endereço';
    ColWidths[11] := 200;
    Cells[12,0] := 'Número';
    ColWidths[12] := 60;
    Cells[13,0] := 'Bairro';
    ColWidths[13] := 100;
    Cells[14,0] := 'Município';
    ColWidths[14] := 100;
    Cells[15,0] := 'UF';
    ColWidths[15] := 40;
    Cells[16,0] := 'Tipo';
    ColWidths[16] := 40;
  end;

  if not FileExists(GetCurrentDir + '\db\pessoaf.txt') then begin
    try
      FileCreate(GetCurrentDir + '\db\pessoaf.txt');
    except
      Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end else begin
    AssignFile(dbpf, GetCurrentDir + '\db\pessoaf.txt');
  end;

  if not FileExists(GetCurrentDir + '\db\pessoaj.txt') then begin
    try
      FileCreate(GetCurrentDir + '\db\pessoaj.txt');
    except
      Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end else begin
    AssignFile(dbpj, GetCurrentDir + '\db\pessoaj.txt');
  end;

  FilaPF := TFilaPF.Create;
  FilaPJ := TFilaPJ.Create;

  PopularClasse;
  Carregar;

  StringGrid.SetFocus;

  CloseFile(dbpf);
  CloseFile(dbpj);
end;

procedure TfrmMain.GridClear;
var
  I : Integer;
begin
  with StringGrid do
  for I := 1 to RowCount -1 do begin
    Rows[I].Clear;
  end;
end;

procedure TfrmMain.imgAlterarClick(Sender: TObject);
begin
  L := StringGrid.Row;
end;

procedure TfrmMain.imgInserirClick(Sender: TObject);
begin
  frmInserir.Parent := pnlForm;
  frmInserir.Show;
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin
  frmInserir.Close;
  Carregar;
end;

procedure TfrmMain.imgRefreshClick(Sender: TObject);
begin
  Carregar;
end;

procedure TfrmMain.PopularClasse;
var
  I : Integer;
  Linha, Result : String;
begin
  if (FilaPF.FilaPF.Count <> 0) or (FilaPJ.FilaPJ.Count <> 0) then begin
    FilaPF.Clear;
    FilaPJ.Clear;
  end;

  Reset(dbpf);

  while (not Eof(dbpf)) do begin
    Readln(dbpf, Linha);
    PF := TPFisica.Create;
    Result := Extrair(Linha);
    PF.ID := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Nome := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.CPF := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.RG := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Email := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Telefone := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Data := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Nacionalidade := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Grau := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Profissao := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.CEP := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Endereco := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Numero := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Bairro := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Municipio := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.UF := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PF.Status := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    FilaPF.AddFila(PF);
  end;

  Reset(dbpj);

  while (not Eof(dbpj)) do begin
    Readln(dbpj, Linha);
    PJ := TPJuridica.Create;
    Result := Extrair(Linha);
    PJ.ID := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Nome := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.CNPJ := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.InscricaoMunicipal := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Email := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Telefone := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Data := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Nacionalidade := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Atuacao := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.CEP := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Endereco := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Numero := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Bairro := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Municipio := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.UF := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    Result := Extrair(Linha);
    PJ.Status := Result;
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    FilaPJ.AddFila(PJ);
  end;
end;

procedure TfrmMain.PopularGridF;
begin
  StringGrid.Cells[0, L] := PF.ID;
  StringGrid.Cells[1, L] := PF.Nome;
  StringGrid.Cells[2, L] := PF.CPF;
  StringGrid.Cells[3, L] := PF.RG;
  StringGrid.Cells[4, L] := PF.Email;
  StringGrid.Cells[5, L] := PF.Telefone;
  StringGrid.Cells[6, L] := PF.Data;
  StringGrid.Cells[7, L] := PF.Nacionalidade;
  StringGrid.Cells[8, L] := PF.Grau;
  StringGrid.Cells[9, L] := PF.Profissao;
  StringGrid.Cells[10,L] := PF.CEP;
  StringGrid.Cells[11,L] := PF.Endereco;
  StringGrid.Cells[12,L] := PF.Numero;
  StringGrid.Cells[13,L] := PF.Bairro;
  StringGrid.Cells[14,L] := PF.Municipio;
  StringGrid.Cells[15,L] := PF.UF;
  StringGrid.Cells[16,L] := PF.Status;
end;

procedure TfrmMain.PopularGridJ;
begin
  StringGrid.Cells[0, L] := PJ.ID;
  StringGrid.Cells[1, L] := PJ.Nome;
  StringGrid.Cells[2, L] := PJ.CNPJ;
  StringGrid.Cells[3, L] := PJ.InscricaoMunicipal;
  StringGrid.Cells[4, L] := PJ.Email;
  StringGrid.Cells[5, L] := PJ.Telefone;
  StringGrid.Cells[6, L] := PJ.Data;
  StringGrid.Cells[7, L] := PJ.Nacionalidade;
  if not RadioButtonPJ.Checked then begin
    StringGrid.Cells[8, L] := '';
    StringGrid.Cells[9, L] := '';
    StringGrid.Cells[10,L] := PJ.CEP;
    StringGrid.Cells[11,L] := PJ.Endereco;
    StringGrid.Cells[12,L] := PJ.Numero;
    StringGrid.Cells[13,L] := PJ.Bairro;
    StringGrid.Cells[14,L] := PJ.Municipio;
    StringGrid.Cells[15,L] := PJ.UF;
    StringGrid.Cells[16,L] := PJ.Status;
  end else begin
    StringGrid.Cells[8,L] := PJ.CEP;
    StringGrid.Cells[9,L] := PJ.Endereco;
    StringGrid.Cells[10,L] := PJ.Numero;
    StringGrid.Cells[11,L] := PJ.Bairro;
    StringGrid.Cells[12,L] := PJ.Municipio;
    StringGrid.Cells[13,L] := PJ.UF;
    StringGrid.Cells[14,L] := PJ.Status;
  end;
end;

procedure TfrmMain.RadioButtonPFClick(Sender: TObject);
begin
  with StringGrid do begin
    ColCount := 17;
    Cells[0,0]  := 'ID';
    ColWidths[0]  := 40;
    Cells[1,0]  := 'Nome';
    ColWidths[1]  := 150;
    Cells[2,0]  := 'CPF';
    ColWidths[2]  := 100;
    Cells[3,0]  := 'RG';
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
    Cells[11,0] := 'Endereço';
    ColWidths[11] := 200;
    Cells[12,0] := 'Número';
    ColWidths[12] := 60;
    Cells[13,0] := 'Bairro';
    ColWidths[13] := 100;
    Cells[14,0] := 'Município';
    ColWidths[14] := 100;
    Cells[15,0] := 'UF';
    ColWidths[15] := 40;
    Cells[16,0] := 'Status';
    ColWidths[16] := 40;
  end;
  if edtSearch.Text = '' then begin
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

procedure TfrmMain.RadioButtonPJClick(Sender: TObject);
begin
  with StringGrid do begin
    ColCount := 15;
    Cells[0,0]  := 'ID';
    ColWidths[0]  := 40;
    Cells[1,0]  := 'Nome';
    ColWidths[1]  := 150;
    Cells[2,0]  := 'CNPJ';
    ColWidths[2]  := 100;
    Cells[3,0]  := 'IM';
    ColWidths[3]  := 100;
    Cells[4,0]  := 'Email';
    ColWidths[4]  := 200;
    Cells[5,0]  := 'Telefone';
    ColWidths[5]  := 100;
    Cells[6,0]  := 'Data';
    ColWidths[6]  := 100;
    Cells[7,0]  := 'Nacionalidade';
    ColWidths[7]  := 120;
    Cells[8,0]  := 'CEP';
    ColWidths[8]  := 100;
    Cells[9,0] := 'Endereço';
    ColWidths[9] := 200;
    Cells[10,0] := 'Número';
    ColWidths[10] := 60;
    Cells[11,0] := 'Bairro';
    ColWidths[11] := 100;
    Cells[12,0] := 'Município';
    ColWidths[12] := 100;
    Cells[13,0] := 'UF';
    ColWidths[13] := 40;
    Cells[14,0] := 'Status';
    ColWidths[14] := 40;
  end;
  if edtSearch.Text = '' then begin
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

procedure TfrmMain.RadioButtonTodosClick(Sender: TObject);
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
    Cells[11,0] := 'Endereço';
    ColWidths[11] := 200;
    Cells[12,0] := 'Número';
    ColWidths[12] := 60;
    Cells[13,0] := 'Bairro';
    ColWidths[13] := 100;
    Cells[14,0] := 'Município';
    ColWidths[14] := 100;
    Cells[15,0] := 'UF';
    ColWidths[15] := 40;
    Cells[16,0] := 'Status';
    ColWidths[16] := 40;
  end;
  if edtSearch.Text = '' then begin
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

function TfrmMain.Search(Edt: String): String;
var
  I, J  : Integer;
  CopyP : String;
begin
  L      := 1;
  LinesF := 0;
  LPF    := 0;
  LinesJ := 0;
  LPJ    := 0;

  LinesF := FilaPF.FilaPF.Count;
  LinesJ := FilaPJ.FilaPJ.Count;

  try
    StrToInt(edtSearch.Text);
    if not CheckBox.Checked then begin
      if RadioButtonTodos.Checked then begin
        GridClear;
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          if (PF.Status = '1') and (PF.ID = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          if (PJ.Status = '1') and (PJ.ID = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPF.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          if (PF.Status = '1') and (PF.ID = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPJ.Checked then begin
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          if (PJ.Status = '1') and (PJ.ID = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end;
    end else begin
      if RadioButtonTodos.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          if (PF.ID = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          if (PJ.ID = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPF.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          if (PF.ID = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPJ.Checked then begin
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          if (PJ.ID = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end;
    end;
  except
    if not CheckBox.Checked then begin
      if RadioButtonTodos.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          J := Length(Edt);
          CopyP := Copy(PF.Nome, 1, J);
          if (PF.Status = '1') and (CopyP = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          J := Length(Edt);
          CopyP := Copy(PJ.Nome, 1, J);
          if (PJ.Status = '1') and (CopyP = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPF.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          J := Length(Edt);
          CopyP := Copy(PF.Nome, 1, J);
          if (PF.Status = '1') and (CopyP = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPJ.Checked then begin
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          J := Length(Edt);
          CopyP := Copy(PJ.Nome, 1, J);
          if (PJ.Status = '1') and (CopyP = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end;
    end else begin
      if RadioButtonTodos.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          J := Length(Edt);
          CopyP := Copy(PF.Nome, 1, J);
          if (CopyP = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          J := Length(Edt);
          CopyP := Copy(PJ.Nome, 1, J);
          if (CopyP = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPF.Checked then begin
        for I := 1 to LinesF do begin
          PF := FilaPF.FilaPF[LPF];
          J := Length(Edt);
          CopyP := Copy(PF.Nome, 1, J);
          if (CopyP = Edt) then begin
            PopularGridF;
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        StringGrid.RowCount := L;
      end else if RadioButtonPJ.Checked then begin
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          J := Length(Edt);
          CopyP := Copy(PJ.Nome, 1, J);
          if (CopyP = Edt) then begin
            PopularGridJ;
            L := L + 1;
          end else begin
          end;
          LPJ := LPJ + 1;
        end;
        StringGrid.RowCount := L;
      end;
    end;
  end;
end;

procedure TfrmMain.SearchF(Filtro: String);
var
  I, J  : Integer;
  CopyP, Edt : String;
begin
  L      := 1;
  LinesF := 0;
  LPF    := 0;
  LinesF := FilaPF.FilaPF.Count;
  for I := 1 to LinesF do begin
    PF := FilaPF.FilaPF[LPF];
    J := Length(Edt);
    CopyP := Copy(PF.Nome, 1, J);
    if Filtro.ToBoolean(Filtro) then begin
      PopularGridF;
      L := L + 1;
    end else begin
    end;
    LPF := LPF + 1;
  end;
  StringGrid.RowCount := L;
end;

procedure TfrmMain.SearchFJ(Filtro: String);
var
  I, J  : Integer;
  CopyP, Edt : String;
begin
  L      := 1;
  LinesF := 0;
  LPF    := 0;
  LinesJ := 0;
  LPJ    := 0;
  LinesF := FilaPF.FilaPF.Count;
  LinesJ := FilaPJ.FilaPJ.Count;
  for I := 1 to LinesF do begin
    PF := FilaPF.FilaPF[LPF];
    J := Length(Edt);
    CopyP := Copy(PF.Nome, 1, J);
    if Filtro.ToBoolean(Filtro) then begin
      PopularGridF;
      L := L + 1;
    end else begin
    end;
    LPF := LPF + 1;
  end;
  for I := 1 to LinesJ do begin
    PJ := FilaPJ.FilaPJ[LPJ];
    J := Length(Edt);
    CopyP := Copy(PJ.Nome, 1, J);
    if Filtro.ToBoolean(Filtro) then begin
      PopularGridJ;
      L := L + 1;
    end else begin
    end;
    LPJ := LPJ + 1;
  end;
  StringGrid.RowCount := L;
end;

procedure TfrmMain.SearchJ(Filtro: String);
var
  I, J  : Integer;
  CopyP, Edt : String;
begin
  L      := 1;
  LinesJ := 0;
  LPJ    := 0;
  LinesJ := FilaPF.FilaPF.Count;
  for I := 1 to LinesJ do begin
    PJ := FilaPJ.FilaPJ[LPJ];
    J := Length(Edt);
    CopyP := Copy(PJ.Nome, 1, J);
    if Filtro.ToBoolean(Filtro) then begin
      PopularGridJ;
      L := L + 1;
    end else begin
    end;
    LPJ := LPJ + 1;
  end;
  StringGrid.RowCount := L;
end;

end.

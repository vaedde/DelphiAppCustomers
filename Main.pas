unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Classes,
  Vcl.ExtDlgs;

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
    pnlEnable: TPanel;
    edtSearch: TEdit;
    imgMenu: TImage;
    imgInserir: TImage;
    imgAlterar: TImage;
    imgEnable: TImage;
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
    pnlRefresh: TPanel;
    imgRefresh: TImage;
    pnlRelatorio: TPanel;
    imgRelatorio: TImage;
    pnlExportar: TPanel;
    imgExportar: TImage;
    OpenDialog: TOpenDialog;
    Image1: TImage;
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
    procedure imgEnableClick(Sender: TObject);
    procedure imgRelatorioClick(Sender: TObject);
    procedure imgExportarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    Ordenar : Boolean;
  public
    { Public declarations }
    PF : TPFisica;
    PJ : TPJuridica;
    FilaPF, FilaPFSto : TFilaPF;
    FilaPJ, FilaPJSto : TFilaPJ;
    PFExist, PJExist : Boolean;
    arq, dbpf, dbpj : TextFile;
    function  Extrair(Linha : String) : String;
    procedure Carregar;
    procedure PopularClasse;
    procedure Sort;
    procedure PopularGridF(L : Integer);
    procedure PopularGridJ(L : Integer);
    procedure GridClear;
    procedure ChecarLinha;
    procedure Reescrever;
    procedure verificaStringList(StringList : TStringList);
    function  Search(Edt : String) : String;
//  procedure SearchF(Filtro : String);
//  procedure SearchJ(Filtro : String);
//  procedure SearchFJ(Filtro: String;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Inserir, Alterar;

procedure TfrmMain.Carregar;
var
  I, L, LPF, LPJ : Integer;
  Lines, LinesF, LinesJ : Integer;
begin
  L      := 1;
  LPF    := 0;
  LPJ    := 0;
  LinesF := FilaPF.FilaPF.Count;
  LinesJ := FilaPJ.FilaPJ.Count;
  Lines  := LinesF + LinesJ;
  Sort;
  if not CheckBox.Checked then begin
    if RadioButtonTodos.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        if PF.Status = '1' then begin
          PopularGridF(L);
          L := L + 1;
        end;
        LPF := LPF + 1;
      end;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        if PJ.Status = '1' then begin
          PopularGridJ(L);
          L := L + 1;
        end;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPF.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        if PF.Status = '1' then begin
          PopularGridF(L);
          L := L + 1;
        end;
        LPF := LPF + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPJ.Checked then begin
      GridClear;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        if PJ.Status = '1' then begin
          PopularGridJ(L);
          L := L + 1;
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
        PopularGridF(L);
        L := L + 1;
        LPF := LPF + 1;
      end;
      for I := 1 to LinesJ do begin
        PJ := FilaPJ.FilaPJ[LPJ];
        PopularGridJ(L);
        L := L + 1;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPF.Checked then begin
      GridClear;
      for I := 1 to LinesF do begin
        PF := FilaPF.FilaPF[LPF];
        PopularGridF(L);
        L := L + 1;
        LPF := LPF + 1;
      end;
      StringGrid.RowCount := L;
    end else if RadioButtonPJ.Checked then begin
      GridClear;
      for I := 1 to LinesJ do begin
        Sort;
        PJ := FilaPJ.FilaPJ[LPJ];
        PopularGridJ(L);
        L := L + 1;
        LPJ := LPJ + 1;
      end;
      StringGrid.RowCount := L;
    end;
  end;
  pnlQuantCad.Caption := IntToStr(Lines);
  pnlQuantPF.Caption  := IntToStr(LinesF);
  pnlQuantPJ.Caption  := IntToStr(LinesJ);
  FilaPF.Free;
  FilaPJ.Free;
  FilaPFSto := nil;
  FilaPJSto := nil;
end;

procedure TfrmMain.ChecarLinha;
var
  I, L, LPF, LPJ : Integer;
  Nome : String;
begin
  L    := StringGrid.Row;
  LPF  := 0;
  LPJ  := 0;
  Nome := StringGrid.Cells[1, L];
  for I := 1 to FilaPF.FilaPF.Count do begin
    if Nome = FilaPF.FilaPF[LPF].Nome then begin
      PF := FilaPF.FilaPF[LPF];
      PFExist := True;
      break;
    end;
    LPF := LPF + 1;
  end;
  for I := 1 to FilaPJ.FilaPJ.Count do begin
    if Nome = FilaPJ.FilaPJ[LPJ].Nome then begin
      PJ := FilaPJ.FilaPJ[LPJ];
      PJExist := True;
      break;
    end;
    LPJ := LPJ + 1;
  end;
end;

procedure TfrmMain.CheckBoxClick(Sender: TObject);
begin
  if edtSearch.Text = '' then begin
    PopularClasse;
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

procedure TfrmMain.edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if edtSearch.Text = '' then begin
    PopularClasse;
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
    ColWidths[0]  := 25;
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

procedure TfrmMain.Image1Click(Sender: TObject);
begin
  if Ordenar = True then begin
    Ordenar := False;
  end else if Ordenar = False then begin
    Ordenar := True;
  end;
  PopularClasse;
  Carregar;
end;

procedure TfrmMain.imgAlterarClick(Sender: TObject);
var
  I, L, LPF, LPJ : Integer;
  Nome : String;
begin
  L    := StringGrid.Row;
  LPF  := 0;
  LPJ  := 0;
  Nome := StringGrid.Cells[1, L];
  PopularClasse;
  for I := 1 to FilaPF.FilaPF.Count do begin
    if Nome = FilaPF.FilaPF[LPF].Nome then begin
      PF := FilaPF.FilaPF[LPF];
      PFExist := True;
      break;
    end;
    LPF := LPF + 1;
  end;
  for I := 1 to FilaPJ.FilaPJ.Count do begin
    if Nome = FilaPJ.FilaPJ[LPJ].Nome then begin
      PJ := FilaPJ.FilaPJ[LPJ];
      PJExist := True;
      break;
    end;
    LPJ := LPJ + 1;
  end;
  frmInserir.Close;
  frmAlterar.Parent := pnlForm;
  frmAlterar.Show;
end;

procedure TfrmMain.imgInserirClick(Sender: TObject);
begin
  frmAlterar.Close;
  frmInserir.Parent := pnlForm;
  frmInserir.Show;
  PopularClasse;
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin
  frmInserir.Close;
  frmAlterar.Close;
  PopularClasse;
  Carregar;
end;

procedure TfrmMain.imgRefreshClick(Sender: TObject);
begin
  PopularClasse;
  Carregar;
end;

procedure TfrmMain.imgRelatorioClick(Sender: TObject);
var
  I, L : Integer;
  Caminho : String;
  StringList : TStringList;
begin
  PopularClasse;
  try
    if OpenDialog.Execute then begin
      StringList := TStringList.Create;
      Caminho := OpenDialog.FileName;
      I := pos('.txt', Caminho);
      if I <> 0 then begin
        Caminho := OpenDialog.FileName;
      end else begin
        Caminho := OpenDialog.FileName+'.txt';
      end;
      if not FileExists(Caminho) then begin
        try
          try
            AssignFile(arq, Caminho);
            Rewrite(arq);
          finally
            CloseFile(arq);
          end;
        except
          Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
        end;
      end;
      StringList.Add('Pessoa Física'+ #13);
      L := 0;
      for I := 1 to FilaPF.FilaPF.Count do begin
      PF := FilaPF.FilaPF[L];
      StringList.Add(
             'ID:                   ' + PF.ID
       +#13+ 'Nome Completo:        ' + PF.Nome
       +#13+ 'CPF:                  ' + PF.CPF
       +#13+ 'RG:                   ' + PF.RG
       +#13+ 'Email:                ' + PF.Email
       +#13+ 'Telefone:             ' + PF.Telefone
       +#13+ 'Data de Nascimento:   ' + PF.Data
       +#13+ 'Nacionalidade:        ' + PF.Nacionalidade
       +#13+ 'Grau de Escolaridade: ' + PF.Grau
       +#13+ 'Profissão:            ' + PF.Profissao
       +#13+ 'CEP:                  ' + PF.CEP
       +#13+ 'Endereço:             ' + PF.Endereco
       +#13+ 'Número:               ' + PF.Numero
       +#13+ 'Bairro:               ' + PF.Bairro
       +#13+ 'Município:            ' + PF.Municipio
       +#13+ 'UF:                   ' + PF.UF
       +#13+ 'Status:               ' + PF.Status
       +#13+ '................................................................' + #13)
      ;
      L := L + 1;
      end;
      StringList.Add('');
      StringList.Add('Pessoa Juridica' + #13);
      L := 0;
      for I := 1 to FilaPJ.FilaPJ.Count do begin
      PJ := FilaPJ.FilaPJ[L];
      StringList.Add(
             'ID:                  ' + PJ.ID
       +#13+ 'Nome Fantasia:       ' + PJ.Nome
       +#13+ 'CNPJ:                ' + PJ.CNPJ
       +#13+ 'Inscrição Municipal: ' + PJ.InscricaoMunicipal
       +#13+ 'Email:               ' + PJ.Email
       +#13+ 'Telefone:            ' + PJ.Telefone
       +#13+ 'Data de Criação:     ' + PJ.Data
       +#13+ 'Nacionalidade:       ' + PJ.Nacionalidade
       +#13+ 'Atuação:             ' + PJ.Atuacao
       +#13+ 'CEP:                 ' + PJ.CEP
       +#13+ 'Endereço:            ' + PJ.Endereco
       +#13+ 'Número:              ' + PJ.Numero
       +#13+ 'Bairro:              ' + PJ.Bairro
       +#13+ 'Município:           ' + PJ.Municipio
       +#13+ 'UF:                  ' + PJ.UF
       +#13+ 'Status:              ' + PJ.Status
       +#13+ '................................................................' + #13)
      ;
      L := L + 1;
      end;
      StringList.SaveToFile(Caminho);
      StringList.Free;
      Application.MessageBox('Relatório criado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
    end;
  except
    Application.MessageBox('Não foi possível criar o Relatório!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
  Carregar;
end;

procedure TfrmMain.imgEnableClick(Sender: TObject);
var
  Status: String;
begin
  PopularClasse;
  ChecarLinha;
  try
    if PFExist = True then begin
      Status := PF.Status;
      if Status = '1' then begin
        PF.Status := '0';
        Application.MessageBox('Cliente desativado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
      end else begin
        PF.Status := '1';
        Application.MessageBox('Cliente ativado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
      end;
      PFExist := false;
    end else if PJExist = True then begin
      Status := PJ.Status;
      if Status = '1' then begin
        PJ.Status := '0';
        Application.MessageBox('Cliente desativado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
      end else begin
        PJ.Status := '1';
        Application.MessageBox('Cliente ativado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
      end;
      PJExist := false;
    end;
    Reescrever;
    Carregar;
  except
    Application.MessageBox('Não foi possível alterar o cliente!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
end;

procedure TfrmMain.imgExportarClick(Sender: TObject);
var
  I, L : Integer;
  Caminho : String;
  StringList : TStringList;
begin
  PopularClasse;
  try
    if OpenDialog.Execute then begin
      StringList := TStringList.Create;
      Caminho := OpenDialog.FileName;
      I := pos('.txt', Caminho);
      if I <> 0 then begin
        Caminho := OpenDialog.FileName;
      end else begin
        Caminho := OpenDialog.FileName+'.txt';
      end;
      if not FileExists(Caminho) then begin
        try
          try
            AssignFile(arq, Caminho);
            Rewrite(arq);
          finally
            CloseFile(arq);
          end;
        except
          Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
        end;
      end;
      StringList.Add('Pessoa Física'+ #13);
      L := 0;
      for I := 1 to FilaPF.FilaPF.Count do begin
      PF := FilaPF.FilaPF[L];
      StringList.Add(PF.ID + '|'
       + PF.Nome +           '|'
       + PF.CPF +            '|'
       + PF.RG +             '|'
       + PF.Email +          '|'
       + PF.Telefone +       '|'
       + PF.Data +           '|'
       + PF.Nacionalidade +  '|'
       + PF.Grau +           '|'
       + PF.Profissao +      '|'
       + PF.CEP +            '|'
       + PF.Endereco +       '|'
       + PF.Numero +         '|'
       + PF.Bairro +         '|'
       + PF.Municipio +      '|'
       + PF.UF +             '|'
       + PF.Status +         '|'
      );
      L := L + 1;
      end;
      StringList.Add('');
      StringList.Add('Pessoa Juridica' + #13);
      L := 0;
      for I := 1 to FilaPJ.FilaPJ.Count do begin
      PJ := FilaPJ.FilaPJ[L];
      StringList.Add(PJ.ID +     '|'
       + PJ.Nome +               '|'
       + PJ.CNPJ +               '|'
       + PJ.InscricaoMunicipal + '|'
       + PJ.Email +              '|'
       + PJ.Telefone +           '|'
       + PJ.Data +               '|'
       + PJ.Nacionalidade +      '|'
       + PJ.Atuacao +            '|'
       + PJ.CEP +                '|'
       + PJ.Endereco +           '|'
       + PJ.Numero +             '|'
       + PJ.Bairro +             '|'
       + PJ.Municipio +          '|'
       + PJ.UF +                 '|'
       + PJ.Status +             '|'
      );
      L := L + 1;
      end;
      StringList.SaveToFile(Caminho);
      StringList.Free;
      Application.MessageBox('Relatório criado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
    end;
  except
    Application.MessageBox('Não foi possível criar o Relatório!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
  Carregar;
end;

procedure TfrmMain.PopularClasse;
var
  I : Integer;
  Linha : String;
begin
  if (FilaPF.FilaPF = nil) or (FilaPJ.FilaPJ = nil) then begin
    FilaPF := TFilaPF.Create;
    FilaPJ := TFilaPJ.Create;
  end else if (FilaPF.FilaPF.Count <> 0) or (FilaPJ.FilaPJ.Count <> 0) then begin
    FilaPF.Clear;
    FilaPJ.Clear;
  end;
  Reset(dbpf);
  while (not Eof(dbpf)) do begin
    Readln(dbpf, Linha);
    PF := TPFisica.Create;
    PF.ID := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Nome := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.CPF := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.RG := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Email := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Telefone := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Data := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Nacionalidade := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Grau := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Profissao := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.CEP := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Endereco := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Numero := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Bairro := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Municipio := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.UF := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PF.Status := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    FilaPF.AddFila(PF);
  end;
  Reset(dbpj);
  while (not Eof(dbpj)) do begin
    Readln(dbpj, Linha);
    PJ := TPJuridica.Create;
    PJ.ID := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Nome := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.CNPJ := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.InscricaoMunicipal := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Email := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Telefone := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Data := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Nacionalidade := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Atuacao := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.CEP := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Endereco := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Numero := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Bairro := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Municipio := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.UF := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    PJ.Status := Extrair(Linha);
    I := pos('|', Linha);
    Delete(Linha, 1, I);
    FilaPJ.AddFila(PJ);
  end;
  CloseFile(dbpf);
  CloseFile(dbpj);
end;

procedure TfrmMain.PopularGridF(L : Integer);
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
    ColWidths[0]  := 25;
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
    PopularClasse;
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
    ColWidths[0]  := 25;
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
    PopularClasse;
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
    ColWidths[0]  := 25;
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
    PopularClasse;
    Carregar;
  end else begin
    Search(edtSearch.Text);
  end;
end;

procedure TfrmMain.Reescrever;
var
  I, L : Integer;
begin
  try
    Rewrite(dbpf);
  finally
    CloseFile(dbpf);
  end;
  L := 0;
  for I := 1 to FilaPF.FilaPF.Count do begin
    PF := FilaPF.FilaPF[L];
    Append(dbpf);
    Writeln(dbpf, PF.ID, '|', PF.Nome, '|', PF.CPF, '|', PF.RG, '|', PF.Email, '|', PF.Telefone, '|', PF.Data, '|', PF.Nacionalidade, '|', PF.Grau, '|', PF.Profissao, '|', PF.CEP, '|', PF.Endereco, '|', PF.Numero, '|', PF.Bairro, '|', PF.Municipio, '|', PF.UF, '|', PF.Status, '|');
    L := L + 1;
    CloseFile(dbpf);
  end;
  try
    Rewrite(dbpj);
  finally
    CloseFile(dbpj);
  end;
  L := 0;
  for I := 1 to FilaPJ.FilaPJ.Count do begin
    PJ := FilaPJ.FilaPJ[L];
    Append(dbpj);
    Writeln(dbpj, PJ.ID, '|', PJ.Nome, '|', PJ.CNPJ, '|', PJ.InscricaoMunicipal, '|', PJ.Email, '|', PJ.Telefone, '|', PJ.Data, '|', PJ.Nacionalidade, '|', PJ.Atuacao, '|', PJ.CEP, '|', PJ.Endereco, '|', PJ.Numero, '|', PJ.Bairro, '|', PJ.Municipio, '|', PJ.UF, '|', PJ.Status, '|');
    L := L + 1;
    CloseFile(dbpj);
  end;
end;

function TfrmMain.Search(Edt: String): String;
var
  I, J, L, LPF, LPJ : Integer;
  Lines, LinesF, LinesJ : Integer;
  CopyP : String;
begin
  L      := 1;
  LPF    := 0;
  LPJ    := 0;
  PopularClasse;
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
            PopularGridF(L);
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          if (PJ.Status = '1') and (PJ.ID = Edt) then begin
            PopularGridJ(L);
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
            PopularGridF(L);
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
            PopularGridJ(L);
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
            PopularGridF(L);
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          if (PJ.ID = Edt) then begin
            PopularGridJ(L);
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
            PopularGridF(L);
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
            PopularGridJ(L);
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
          CopyP := LowerCase(Copy(PF.Nome, 1, J));
          if (PF.Status = '1') and (CopyP = LowerCase(Edt)) then begin
            PopularGridF(L);
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          J := Length(Edt);
          CopyP := LowerCase(Copy(PJ.Nome, 1, J));
          if (PJ.Status = '1') and (CopyP = LowerCase(Edt)) then begin
            PopularGridJ(L);
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
          CopyP := LowerCase(Copy(PF.Nome, 1, J));
          if (PF.Status = '1') and (CopyP = LowerCase(Edt)) then begin
            PopularGridF(L);
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
          CopyP := LowerCase(Copy(PJ.Nome, 1, J));
          if (PJ.Status = '1') and (CopyP = LowerCase(Edt)) then begin
            PopularGridJ(L);
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
          CopyP := LowerCase(Copy(PF.Nome, 1, J));
          if (CopyP = LowerCase(Edt)) then begin
            PopularGridF(L);
            L := L + 1;
          end else begin
          end;
          LPF := LPF + 1;
        end;
        for I := 1 to LinesJ do begin
          PJ := FilaPJ.FilaPJ[LPJ];
          J := Length(Edt);
          CopyP := LowerCase(Copy(PJ.Nome, 1, J));
          if (CopyP = LowerCase(Edt)) then begin
            PopularGridJ(L);
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
          CopyP := LowerCase(Copy(PF.Nome, 1, J));
          if (CopyP = LowerCase(Edt)) then begin
            PopularGridF(L);
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
          CopyP := LowerCase(Copy(PJ.Nome, 1, J));
          if (CopyP = LowerCase(Edt)) then begin
            PopularGridJ(L);
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

procedure TfrmMain.Sort;
var
  I, LPF, LPJ : Integer;
  StringListPF, StringListPJ : TStringList;
begin
  if Ordenar = True then begin
    StringListPF := TStringList.Create;
    StringListPJ := TStringList.Create;
    FilaPFSto := TFilaPF.Create;
    FilaPJSto := TFilaPJ.Create;
    LPF := 0;
    LPJ := 0;
    for I := 0 to FilaPF.FilaPF.Count-1 do begin
      StringListPF.Add(FilaPF.FilaPF[0].Nome);
      PF := FilaPF.DelFila;
      FilaPFSto.AddFila(PF);
    end;
    for I := 0 to FilaPJ.FilaPJ.Count-1 do begin
      StringListPJ.Add(FilaPJ.FilaPJ[0].Nome);
      PJ := FilaPJ.DelFila;
      FilaPJSto.AddFila(PJ);
    end;
    StringListPF.Sort;
    StringListPJ.Sort;
    while StringListPF.Count <> 0 do begin
      for I := 0 to FilaPFSto.FilaPF.Count-1 do begin
        PF := FilaPFSto.FilaPF[LPF];
        if StringListPF.Count = 0 then begin
          break;
        end;
        if PF.Nome = StringListPF[0] then begin
          FilaPF.AddFila(PF);
          StringListPF.Delete(0);
          LPF := 0;
        end else begin
          LPF := LPF + 1;
        end;
      end;
    end;
    while StringListPJ.Count <> 0 do begin
      for I := 0 to FilaPJSto.FilaPJ.Count-1 do begin
        PJ := FilaPJSto.FilaPJ[LPJ];
        if StringListPJ.Count = 0 then begin
          break;
        end;
        if PJ.Nome = StringListPJ[0] then begin
          FilaPJ.AddFila(PJ);
          StringListPJ.Delete(0);
          LPJ := 0;
        end else begin
          LPJ := LPJ + 1;
        end;
      end;
    end;
  end else if Ordenar = False then begin

  end;
end;

procedure TfrmMain.verificaStringList(StringList : TStringList);
begin
  
end;

//procedure TfrmMain.SearchF(Filtro: String);
//var
//  I, J  : Integer;
//  CopyP, Edt : String;
//begin
//  L      := 1;
//  LinesF := 0;
//  LPF    := 0;
//  LinesF := FilaPF.FilaPF.Count;
//  for I := 1 to LinesF do begin
//    PF := FilaPF.FilaPF[LPF];
//    J := Length(Edt);
//    CopyP := Copy(PF.Nome, 1, J);
//    if Filtro.ToBoolean(Filtro) then begin
//      PopularGridF;
//      L := L + 1;
//    end else begin
//    end;
//    LPF := LPF + 1;
//  end;
//  StringGrid.RowCount := L;
//end;
//
//procedure TfrmMain.SearchFJ(Filtro: String);
//var
//  I, J  : Integer;
//  CopyP, Edt : String;
//begin
//  L      := 1;
//  LinesF := 0;
//  LPF    := 0;
//  LinesJ := 0;
//  LPJ    := 0;
//  LinesF := FilaPF.FilaPF.Count;
//  LinesJ := FilaPJ.FilaPJ.Count;
//  for I := 1 to LinesF do begin
//    PF := FilaPF.FilaPF[LPF];
//    J := Length(Edt);
//    CopyP := Copy(PF.Nome, 1, J);
//    if Filtro.ToBoolean(Filtro) then begin
//      PopularGridF;
//      L := L + 1;
//    end else begin
//    end;
//    LPF := LPF + 1;
//  end;
//  for I := 1 to LinesJ do begin
//    PJ := FilaPJ.FilaPJ[LPJ];
//    J := Length(Edt);
//    CopyP := Copy(PJ.Nome, 1, J);
//    if Filtro.ToBoolean(Filtro) then begin
//      PopularGridJ;
//      L := L + 1;
//    end else begin
//    end;
//    LPJ := LPJ + 1;
//  end;
//  StringGrid.RowCount := L;
//end;
//
//procedure TfrmMain.SearchJ(Filtro: String);
//var
//  I, J  : Integer;
//  CopyP, Edt : String;
//begin
//  L      := 1;
//  LinesJ := 0;
//  LPJ    := 0;
//  LinesJ := FilaPF.FilaPF.Count;
//  for I := 1 to LinesJ do begin
//    PJ := FilaPJ.FilaPJ[LPJ];
//    J := Length(Edt);
//    CopyP := Copy(PJ.Nome, 1, J);
//    if Filtro.ToBoolean(Filtro) then begin
//      PopularGridJ;
//      L := L + 1;
//    end else begin
//    end;
//    LPJ := LPJ + 1;
//  end;
//  StringGrid.RowCount := L;
//end;
end.

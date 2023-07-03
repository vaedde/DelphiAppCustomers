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
    procedure imgInserirClick(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CheckBoxClick(Sender: TObject);
    procedure RadioButtonPFClick(Sender: TObject);
    procedure RadioButtonPJClick(Sender: TObject);
    procedure RadioButtonTodosClick(Sender: TObject);
    procedure imgRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    arq : TextFile;
    Lines, LinesSto, LinesF, LinesJ : Integer;
    Lista : TStringList;
    procedure CloseAll;
    procedure Carregar;
    procedure Popular;
    function Search : Integer;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Inserir;

procedure TfrmMain.Carregar;
var
  I, J, K, LinhaSto : Integer;
  Linha, Sto : String;
begin
  Reset(arq);
  Lines    := 1;
  LinesSto := 0;
  LinhaSto := 1;
  LinesF   := 0;
  LinesJ   := 0;
  while (not Eof(arq)) do begin
    Readln(arq, Linha);
    Lines := Lines + 1;
  end;

  if not CheckBox.Checked then begin
    with StringGrid do
    for I := 1 to RowCount -1 do begin
      Rows[I].Clear;
    end;

    if RadioButtonTodos.Checked then begin
      StringGrid.RowCount := Lines;
      Reset(arq);
      for I := 1 to Lines do begin
        ReadLn (arq, Linha);
        Sto := copy(Linha,Length(Linha),1);
        if Sto <> '1' then begin
          LinesSto := LinesSto + 1;
        end else begin
          for J := 0 to StringGrid.ColCount do begin
            K := pos('|', Linha);
            Sto := copy(Linha, 1, K-1);
            Delete(Linha, 1, K);
            StringGrid.Cells[J, LinhaSto] := Sto;
          end;
          LinhaSto := LinhaSto + 1;
        end;
      end;
      for I := 2 to LinesSto do begin
        Lines := Lines -1;
      end;
      StringGrid.RowCount := Lines;
    end else if RadioButtonPF.Checked then begin
      StringGrid.RowCount := Lines;
      Reset(arq);
      for I := 1 to Lines do begin
        ReadLn (arq, Linha);
        Sto := copy(Linha,Length(Linha),1);
        if Sto <> '1' then begin
          LinesSto := LinesSto + 1;
        end else begin
          for J := 0 to StringGrid.ColCount do begin
            K := pos('|', Linha);
            Sto := copy(Linha, 1, K-1);
            Delete(Linha, 1, K);
            StringGrid.Cells[J, LinhaSto] := Sto;
          end;
          LinhaSto := LinhaSto + 1;
        end;
      end;
      for I := 2 to LinesSto do begin
        Lines := Lines -1;
      end;
    end else if RadioButtonPJ.Checked then begin
           
    end;

    
  end else begin
    with StringGrid do
    for I := 1 to RowCount -1 do begin
      Rows[I].Clear;
    end;

    if RadioButtonTodos.Checked then begin
      StringGrid.RowCount:= Lines;
      Reset(arq);
      for I := 1 to StringGrid.RowCount do begin
        ReadLn (arq, Linha);
        for J := 0 to StringGrid.ColCount do begin
          K := pos('|', Linha);
          Sto := copy(Linha, 1, K-1);
          Delete(Linha, 1, K);
          StringGrid.Cells[J,I] := Sto;
        end;
      end;
    end else if RadioButtonPF.Checked then begin

    end else if RadioButtonPJ.Checked then begin

    end;
  end;

  Lines := Lines - 1;

  for I := 1 to StringGrid.RowCount do begin
    Linha := StringGrid.Cells[16, I];
    if Linha = 'PF' then begin
      LinesF := LinesF + 1;
    end else if Linha = 'PJ' then begin
      LinesJ := LinesJ + 1;
    end;
  end;

  pnlQuantCad.Caption := IntToStr(Lines);
  pnlQuantPF.Caption  := IntToStr(LinesF);
  pnlQuantPJ.Caption  := IntToStr(LinesJ);
end;

procedure TfrmMain.CheckBoxClick(Sender: TObject);
begin
  Carregar;
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
  ShowMessage(Search.ToString);
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

  pnlMain.SetFocus;

  if not FileExists(GetCurrentDir + '\db\database.txt') then begin
    try
      FileCreate(GetCurrentDir + '\db\database.txt');
    except
      Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end else begin
    AssignFile(arq, GetCurrentDir + '\db\database.txt');
  end;

  Carregar;
  Popular;
  CloseFile(arq);
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin
  CloseAll;
  Carregar;
  CloseFile(arq);
end;

procedure TfrmMain.imgRefreshClick(Sender: TObject);
begin
  Carregar;
end;

procedure TfrmMain.Popular;
begin

end;

procedure TfrmMain.RadioButtonPFClick(Sender: TObject);
begin
  with StringGrid do begin
    ColCount := 16;
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
  end;
  Carregar;
end;

procedure TfrmMain.RadioButtonPJClick(Sender: TObject);
begin
  with StringGrid do begin
    ColCount := 14;
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
  end;
  Carregar; 
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
    Cells[16,0] := 'Tipo';
    ColWidths[16] := 40;
  end;
  Carregar;
end;

function TfrmMain.Search: Integer;
var
  Linha, Sto : String;
  I, J, K : Integer;
begin
  I := 0;
  try
    StrToInt(edtSearch.Text);
    for I := 1 to StringGrid.RowCount do begin
      K := pos('|', StringGrid.Cells[1, I]);
      Linha := StringGrid.Cells[1, I];
      Sto := copy(Linha, 1, K-1);
      if Sto = edtSearch.Text then begin
        Result := I;  
      end;
    end;
  except
    
  end;

end;

procedure TfrmMain.imgInserirClick(Sender: TObject);
begin
  CloseAll;
  frmInserir.Parent := pnlForm;
  frmInserir.Show;
end;

end.

unit Alterar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, Classes;

type
  TfrmAlterar = class(TForm)
    PageControl: TPageControl;
    Cliente: TTabSheet;
    pnlMianF: TPanel;
    lblCPF: TLabel;
    lblRG: TLabel;
    lblDataNasc: TLabel;
    lblTelefoneF: TLabel;
    lblGrau: TLabel;
    edtCEPF: TLabeledEdit;
    edtNomeComp: TLabeledEdit;
    edtEmailF: TLabeledEdit;
    edtNacionalidadeF: TLabeledEdit;
    edtProfissao: TLabeledEdit;
    edtEnderecoF: TLabeledEdit;
    edtNumeroF: TLabeledEdit;
    edtBairroF: TLabeledEdit;
    edtMunicipioF: TLabeledEdit;
    edtUFF: TLabeledEdit;
    edtCPF: TMaskEdit;
    edtRG: TMaskEdit;
    edtDataNasc: TMaskEdit;
    btnAddF: TButton;
    edtTelefoneF: TMaskEdit;
    cbxGrau: TComboBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Empresa: TTabSheet;
    pnlMainJ: TPanel;
    lblCNPJ: TLabel;
    lblM: TLabel;
    lblDataCriacao: TLabel;
    lblTelefoneJ: TLabel;
    edtCEPJ: TLabeledEdit;
    edtNomeFant: TLabeledEdit;
    edtEmailJ: TLabeledEdit;
    edtAtuacao: TLabeledEdit;
    edtEnderecoJ: TLabeledEdit;
    edtNumeroJ: TLabeledEdit;
    edtBairroJ: TLabeledEdit;
    edtMunicipioJ: TLabeledEdit;
    edtUFJ: TLabeledEdit;
    edtCNPJ: TMaskEdit;
    edtInscricao: TMaskEdit;
    edtDataCriacao: TMaskEdit;
    btnAddJ: TButton;
    edtTelefoneJ: TMaskEdit;
    pnlLine5: TPanel;
    pnlLine6: TPanel;
    pnlLine7: TPanel;
    pnlLine8: TPanel;
    pnlLine1: TPanel;
    pnlLine2: TPanel;
    pnlLine3: TPanel;
    pnlLine4: TPanel;
    edtNacionalidadeJ: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btnAddFClick(Sender: TObject);
    procedure btnAddJClick(Sender: TObject);
  private
    { Private declarations }
    PF : TPFisica;
    PJ : TPJuridica;
  public
    { Public declarations }
  end;

var
  frmAlterar: TfrmAlterar;

implementation

{$R *.dfm}

uses Main;

procedure TfrmAlterar.btnAddFClick(Sender: TObject);
var
  I, L, LPF, LPJ : Integer;
  Lines, LinesF, LinesJ : Integer;
  dbpf : TextFile;
begin
  if frmMain.StringGrid.RowCount <> 1 then begin
    if not FileExists(GetCurrentDir + '\db\pessoaf.txt') then begin
      try
        FileCreate(GetCurrentDir + '\db\pessoaf.txt');
      except
        Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
      end;
    end else begin
      AssignFile(dbpf, GetCurrentDir + '\db\pessoaf.txt');
    end;
    try
      PF.Nome := edtNomeComp.Text;
      PF.CPF := edtCPF.Text;
      PF.RG := edtRg.Text;
      PF.Email := edtEmailF.Text;
      PF.Telefone := edtTelefoneF.Text;
      PF.Data := edtDataNasc.Text;
      PF.Nacionalidade := edtNacionalidadeF.Text;
      PF.Grau := cbxGrau.Text;
      PF.Profissao := edtProfissao.Text;
      PF.CEP := edtCEPF.Text;
      PF.Endereco := edtEnderecoF.Text;
      PF.Numero := edtNumeroF.Text;
      PF.Bairro := edtBairroF.Text;
      PF.Municipio := edtMunicipioF.Text;
      PF.UF := edtUFF.Text;
      try
        Rewrite(dbpf);
      finally
        CloseFile(dbpf);
      end;
      L := 0;
      for I := 1 to frmMain.FilaPF.FilaPF.Count do begin
        PF := frmMain.FilaPF.FilaPF[L];
        Append(dbpf);
        Writeln(dbpf, PF.ID, '|', PF.Nome, '|', PF.CPF, '|', PF.RG, '|', PF.Email, '|', PF.Telefone, '|', PF.Data, '|', PF.Nacionalidade, '|', PF.Grau, '|', PF.Profissao, '|', PF.CEP, '|', PF.Endereco, '|', PF.Numero, '|', PF.Bairro, '|', PF.Municipio, '|', PF.UF, '|', PF.Status, '|');
        CloseFile(dbpf);
        L := L + 1;
      end;
      Application.MessageBox('Cliente alterado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
      frmMain.PopularClasse;
      frmMain.Carregar;
      Close;
    except
      Application.MessageBox('Não foi possível alterar o cliente!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end;
end;

procedure TfrmAlterar.btnAddJClick(Sender: TObject);
var
  I, L, LPF, LPJ : Integer;
  Lines, LinesF, LinesJ : Integer;
  dbpj : TextFile;
begin
  if frmMain.StringGrid.RowCount <> 1 then begin
    if not FileExists(GetCurrentDir + '\db\pessoaj.txt') then begin
      try
        FileCreate(GetCurrentDir + '\db\pessoaj.txt');
      except
        Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
      end;
    end else begin
      AssignFile(dbpj, GetCurrentDir + '\db\pessoaj.txt');
    end;
    try
      PJ.Nome := edtNomeComp.Text;
      PJ.CNPJ := edtCNPJ.Text;
      PJ.InscricaoMunicipal := edtInscricao.Text;
      PJ.Email := edtEmailJ.Text;
      PJ.Telefone := edtTelefoneJ.Text;
      PJ.Data := edtDataNasc.Text;
      PJ.Nacionalidade := edtNacionalidadeJ.Text;
      PJ.Atuacao := edtAtuacao.Text;
      PJ.CEP := edtCEPJ.Text;
      PJ.Endereco := edtEnderecoJ.Text;
      PJ.Numero := edtNumeroJ.Text;
      PJ.Bairro := edtBairroJ.Text;
      PJ.Municipio := edtMunicipioJ.Text;
      PJ.UF := edtUFJ.Text;
      try
        Rewrite(dbpj);
      finally
        CloseFile(dbpj);
      end;
      L := 0;
      for I := 1 to frmMain.FilaPJ.FilaPJ.Count do begin
        PJ := frmMain.FilaPJ.FilaPJ[L];
        Append(dbpj);
        Writeln(dbpj, PJ.ID, '|', PJ.Nome, '|', PJ.CNPJ, '|', PJ.InscricaoMunicipal, '|', PJ.Email, '|', PJ.Telefone, '|', PJ.Data, '|', PJ.Nacionalidade, '|', PJ.Atuacao, '|', PJ.CEP, '|', PJ.Endereco, '|', PJ.Numero, '|', PJ.Bairro, '|', PJ.Municipio, '|', PJ.UF, '|', PJ.Status, '|');
        CloseFile(dbpj);
        L := L + 1;
      end;
      Application.MessageBox('Cliente alterado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
      frmMain.PopularClasse;
      frmMain.Carregar;
      Close;
    except
      Application.MessageBox('Não foi possível alterar o cliente!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end;
end;

procedure TfrmAlterar.FormShow(Sender: TObject);
var
  I, L, LPF, LPJ : Integer;
  Lines, LinesF, LinesJ : Integer;
  dbpf, dbpj : TextFile;
begin
  if frmMain.PFExist = True then begin
    PageControl.ActivePageIndex := 0;
    PF := frmMain.PF;
    edtNomeComp.Text := PF.Nome;
    edtCPF.Text := PF.CPF;
    edtRG.Text := PF.RG;
    edtEmailF.Text := PF.Email;
    edtTelefoneF.Text := PF.Telefone;
    edtDataNasc.Text := PF.Data;
    edtNacionalidadeF.Text := PF.Nacionalidade;
    cbxGrau.Text := PF.Grau;
    edtProfissao.Text := PF.Profissao;
    edtCEPF.Text := PF.CEP;
    edtEnderecoF.Text := PF.Endereco;
    edtNumeroF.Text := PF.Numero;
    edtBairroF.Text := PF.Bairro;
    edtMunicipioF.Text := PF.Municipio;
    edtUFF.Text := PF.UF;
  end else if frmMain.PJExist = True then begin
    PageControl.ActivePageIndex := 1;
    PJ := frmMain.PJ;
    edtNomeFant.Text := PJ.Nome;
    edtCNPJ.Text := PJ.CNPJ;
    edtInscricao.Text := PJ.InscricaoMunicipal;
    edtEmailJ.Text := PJ.Email;
    edtTelefoneJ.Text := PJ.Telefone;
    edtDataCriacao.Text := PJ.Data;
    edtNacionalidadeJ.Text := PJ.Nacionalidade;
    edtAtuacao.Text := PJ.Atuacao;
    edtCEPJ.Text := PJ.CEP;
    edtEnderecoJ.Text := PJ.Endereco;
    edtNumeroJ.Text := PJ.Numero;
    edtBairroJ.Text := PJ.Bairro;
    edtMunicipioJ.Text := PJ.Municipio;
    edtUFJ.Text := PJ.UF;
  end;
end;

end.

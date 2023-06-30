unit Inserir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Imaging.pngimage, Classes;

type
  TfrmInserir = class(TForm)
    pnlForm: TPanel;
    Empresa: TTabSheet;
    Cliente: TTabSheet;
    PageControl: TPageControl;
    pnlMianF: TPanel;
    edtNomeComp: TLabeledEdit;
    edtEmailF: TLabeledEdit;
    edtNacionalidadeF: TLabeledEdit;
    edtProfissao: TLabeledEdit;
    edtCEPF: TLabeledEdit;
    edtEnderecoF: TLabeledEdit;
    edtNumeroF: TLabeledEdit;
    edtBairroF: TLabeledEdit;
    edtMunicipioF: TLabeledEdit;
    edtUFF: TLabeledEdit;
    edtCPF: TMaskEdit;
    lblCPF: TLabel;
    edtRG: TMaskEdit;
    lblRG: TLabel;
    lblDataNasc: TLabel;
    edtDataNasc: TMaskEdit;
    imgSearchF: TImage;
    btnAddF: TButton;
    edtTelefoneF: TMaskEdit;
    lblTelefoneF: TLabel;
    pnlMainJ: TPanel;
    lblCNPJ: TLabel;
    lblM: TLabel;
    lblDataCriacao: TLabel;
    imgSearchJ: TImage;
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
    cbxGrau: TComboBox;
    lblGrau: TLabel;
    pnlLine6: TPanel;
    pnlLine7: TPanel;
    pnlLine8: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    pnlLine1: TPanel;
    pnlLine2: TPanel;
    pnlLine3: TPanel;
    pnlLine4: TPanel;
    edtNacionalidadeJ: TLabeledEdit;
    procedure btnAddFClick(Sender: TObject);
    procedure btnAddJClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    arq: TextFile;
    PF : TPFisica;
    PJ : TPJuridica;
    procedure EditClear;
  end;

var
  frmInserir: TfrmInserir;

implementation

{$R *.dfm}
procedure TfrmInserir.btnAddFClick(Sender: TObject);
var
  I, Linha, Nome : String;
  Lines : Integer;
begin
  try
    Reset(arq);

    Lines := 1;

    PF := TPFisica.Create;
    PF.Nome          := edtNomeComp.Text;
    PF.CPF           := edtCPF.Text;
    PF.RG            := edtRG.Text;
    PF.Email         := edtEmailF.Text;
    PF.Telefone      := edtTelefoneF.Text;
    PF.Data          := edtDataNasc.Text;
    PF.Nacionalidade := edtNacionalidadeF.Text;
    PF.Grau          := cbxGrau.Text;
    PF.Profissao     := edtProfissao.Text;
    PF.CEP           := edtCEPF.Text;
    PF.Endereco      := edtEnderecoF.Text;
    PF.Numero        := edtNumeroF.Text;
    PF.Bairro        := edtBairroF.Text;
    PF.Municipio     := edtMunicipioF.Text;
    PF.UF            := edtUFF.Text;
    PF.Tipo          := 'PF';

    while (not Eof(arq)) do begin
      Readln(arq, Linha);
      Lines := Lines + 1;
    end;

    CloseFile(arq);
    Append(arq);

    Writeln(arq, Lines.ToString, '|', PF.Nome, '|', PF.CPF, '|', PF.RG, '|', PF.Email, '|', PF.Telefone, '|', PF.Data, '|', PF.Nacionalidade, '|', PF.Grau, '|', PF.Profissao, '|', PF.CEP, '|', PF.Endereco, '|', PF.Numero, '|', PF.Bairro, '|', PF.Municipio, '|', PF.UF, '|', PF.Tipo);
    EditClear;
    Application.MessageBox('Cliente cadastrado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);

    PJ.Free;
    CloseFile(arq);
  except
    Application.MessageBox('Não foi possível cadastrar um novo cliente!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
end;

procedure TfrmInserir.btnAddJClick(Sender: TObject);
var
  I, Linha, Nome : String;
  Lines : Integer;
begin
  try
    Reset(arq);

    Lines := 1;

    PJ := TPJuridica.Create;
    PJ.Nome               := edtNomeFant.Text;
    PJ.CNPJ               := edtCNPJ.Text;
    PJ.InscricaoMunicipal := edtInscricao.Text;
    PJ.Email              := edtEmailJ.Text;
    PJ.Telefone           := edtTelefoneJ.Text;
    PJ.Data               := edtDataCriacao.Text;
    PJ.Nacionalidade      := edtNacionalidadeJ.Text;
    PJ.CEP                := edtCEPJ.Text;
    PJ.Endereco           := edtEnderecoJ.Text;
    PJ.Numero             := edtNumeroJ.Text;
    PJ.Bairro             := edtBairroJ.Text;
    PJ.Municipio          := edtMunicipioJ.Text;
    PJ.UF                 := edtUFJ.Text;
    PJ.Tipo               := 'PJ';

    while (not Eof(arq)) do begin
      Readln(arq, Linha);
      Lines := Lines + 1;
    end;

    CloseFile(arq);
    Append(arq);

    Writeln(arq, Lines.ToString, '|', PJ.Nome, '|', PJ.CNPJ, '|', PJ.InscricaoMunicipal, '|', PJ.Email, '|', PJ.Telefone, '|', PJ.Data, '|', PJ.Nacionalidade, '|', PJ.CEP, '|', PJ.Endereco, '|', PJ.Numero, '|', PJ.Bairro, '|', PJ.Municipio, '|', PJ.UF, '|', PJ.Tipo);
    EditClear;
    Application.MessageBox('Cliente cadastrado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);

    PJ.Free;
    CloseFile(arq);
  except
    Application.MessageBox('Não foi possível cadastrar um novo cliente!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
end;

procedure TfrmInserir.EditClear;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i] is TEdit then begin
      TEdit(Self.Components[i]).Clear;
    end;
    if Self.Components[i] is TLabeledEdit then begin
      TLabeledEdit(Self.Components[i]).Clear;
    end;
    if Self.Components[i] is TMaskEdit then begin
      TMaskEdit(Self.Components[i]).Clear;
    end;
    if Self.Components[i] is TComboBox then begin
      TComboBox(Self.Components[i]).Clear;
    end;
  end;
end;

procedure TfrmInserir.FormShow(Sender: TObject);
begin
  if not FileExists(GetCurrentDir + '.\db\database.txt') then begin
    try
      FileCreate(GetCurrentDir + '\db\database.txt');
    except
      Application.MessageBox('Não foi possível criar o arquivo!!','Aviso',mb_Ok+mb_IconExclamation);
    end;
  end else begin
    AssignFile(arq, GetCurrentDir + '\db\database.txt');
  end;
end;	

end.

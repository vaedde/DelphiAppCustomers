unit Inserir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Imaging.pngimage, Classes, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

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
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    procedure btnAddFClick(Sender: TObject);
    procedure btnAddJClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSearchFClick(Sender: TObject);
    procedure imgSearchJClick(Sender: TObject);
  private
    { Private declarations }
    dbpf, dbpj : TextFile;
  public
    { Public declarations }
    procedure EditClear;
  end;

var
  frmInserir: TfrmInserir;

implementation

{$R *.dfm}

uses Main;
procedure TfrmInserir.btnAddFClick(Sender: TObject);
var
  Linha : String;
  Lines : Integer;
  PF : TPFisica;
begin
  try
    Reset(dbpf);
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
    PF.Status       := '1';

    while (not Eof(dbpf)) do begin
      Readln(dbpf, Linha);
      Lines := Lines + 1;
    end;

    PF.ID := Lines.ToString;

    CloseFile(dbpf);
    Append(dbpf);

    Writeln(dbpf, PF.Status, '|', PF.Nome, '|', PF.CPF, '|', PF.RG, '|', PF.Email, '|', PF.Telefone, '|', PF.Data, '|', PF.Nacionalidade, '|', PF.Grau, '|', PF.Profissao, '|', PF.CEP, '|', PF.Endereco, '|', PF.Numero, '|', PF.Bairro, '|', PF.Municipio, '|', PF.UF, '|', PF.Status, '|');
    EditClear;
    Application.MessageBox('Cliente cadastrado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
    PF.Free;
    CloseFile(dbpf);
  except
    Application.MessageBox('Não foi possível cadastrar um novo cliente!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
end;

procedure TfrmInserir.btnAddJClick(Sender: TObject);
var
  Linha : String;
  Lines : Integer;
  PJ : TPJuridica;
begin
  try
    Reset(dbpj);

    Lines := 1;

    PJ := TPJuridica.Create;
    PJ.Nome               := edtNomeFant.Text;
    PJ.CNPJ               := edtCNPJ.Text;
    PJ.InscricaoMunicipal := edtInscricao.Text;
    PJ.Email              := edtEmailJ.Text;
    PJ.Telefone           := edtTelefoneJ.Text;
    PJ.Data               := edtDataCriacao.Text;
    PJ.Nacionalidade      := edtNacionalidadeJ.Text;
    PJ.Atuacao            := edtAtuacao.Text;
    PJ.CEP                := edtCEPJ.Text;
    PJ.Endereco           := edtEnderecoJ.Text;
    PJ.Numero             := edtNumeroJ.Text;
    PJ.Bairro             := edtBairroJ.Text;
    PJ.Municipio          := edtMunicipioJ.Text;
    PJ.UF                 := edtUFJ.Text;
    PJ.Status             := '1';

    while (not Eof(dbpj)) do begin
      Readln(dbpj, Linha);
      Lines := Lines + 1;
    end;

    PJ.ID := Lines.ToString;

    CloseFile(dbpj);
    Append(dbpj);

    Writeln(dbpj, PJ.ID, '|', PJ.Nome, '|', PJ.CNPJ, '|', PJ.InscricaoMunicipal, '|', PJ.Email, '|', PJ.Telefone, '|', PJ.Data, '|', PJ.Nacionalidade, '|', PJ.Atuacao, '|', PJ.CEP, '|', PJ.Endereco, '|', PJ.Numero, '|', PJ.Bairro, '|', PJ.Municipio, '|', PJ.UF, '|', PJ.Status, '|');
    EditClear;
    Application.MessageBox('Cliente cadastrado com sucesso!!','Aviso',mb_Ok+mb_IconInformation);
    PJ.Free;
    CloseFile(dbpj);
  except
    Application.MessageBox('Não foi possível cadastrar um novo cliente!!','Aviso',mb_Ok+mb_IconExclamation);
  end;
end;

procedure TfrmInserir.EditClear;
var
  I : Integer;
begin
  for I := 0 to Self.ComponentCount -1 do
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
  end;
end;

procedure TfrmInserir.FormShow(Sender: TObject);
begin
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
end;	

procedure TfrmInserir.imgSearchFClick(Sender: TObject);
var
  TempCep : String;
begin
  TempCep := edtCEPF.Text;
  if Length(TempCep) <> 8 then begin
  ShowMessage('A formatação do seu CEP está errada!');
  end else begin
  RESTRequest1.Resource := TempCep + '/json';
  RESTRequest1.Execute;
    if RESTRequest1.Response.StatusCode = 200 then begin
      if RESTRequest1.Response.Content.IndexOf('erro') > 0 then begin
        ShowMessage('CEP Não encontrado');
      end else with FDMemTable1 do begin
        edtEnderecoF.Clear;
        edtBairroF.Clear;
        edtMunicipioF.Clear;
        edtUFF.Clear;
        edtEnderecoF.Text  := FieldByName('logradouro').AsString;
        edtBairroF.Text    := FieldByName('bairro').AsString;
        edtMunicipioF.Text := FieldByName('localidade').AsString;
        edtUFF.Text        := FieldByName('uf').AsString;
      end;
    end;
  end;
end;

procedure TfrmInserir.imgSearchJClick(Sender: TObject);
var
  TempCep : String;
begin
  TempCep := edtCEPJ.Text;
  if Length(TempCep) <> 8 then begin
  ShowMessage('A formatação do seu CEP está errada!');
  end else begin
  RESTRequest1.Resource := TempCep + '/json';
  RESTRequest1.Execute;
    if RESTRequest1.Response.StatusCode = 200 then begin
      if RESTRequest1.Response.Content.IndexOf('erro') > 0 then begin
        ShowMessage('CEP Não encontrado');
      end else with FDMemTable1 do begin
        edtEnderecoJ.Clear;
        edtBairroJ.Clear;
        edtMunicipioJ.Clear;
        edtUFJ.Clear;
        edtEnderecoJ.Text  := FieldByName('logradouro').AsString;
        edtBairroJ.Text    := FieldByName('bairro').AsString;
        edtMunicipioJ.Text := FieldByName('localidade').AsString;
        edtUFJ.Text        := FieldByName('uf').AsString;
      end;
    end;
  end;
end;

end.

unit Classes;

interface

uses
//  System.SysUtils, Vcl.StdCtrls, Vcl.Controls, Vcl.Imaging.pngimage,
//  Vcl.ExtCtrls, System.Classes;
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Imaging.pngimage, Generics.Collections;

type

  TPessoa = class
    private
      FEmail: String;
      FBairro: String;
      FUF: String;
      FCEP: String;
      FNumero: String;
      FMunicipio: String;
      FEndereco: String;
      FTelefone: String;
      FData: String;
      FNacionalidade: String;
      FID: String;
      procedure SetBairro(const Value: String);
      procedure SetTelefone(const Value: String);
      procedure SetCEP(const Value: String);
      procedure SetEmail(const Value: String);
      procedure SetEndereco(const Value: String);
      procedure SetMunicipio(const Value: String);
      procedure SetNumero(const Value: String);
      procedure SetUF(const Value: String);
      procedure SetData(const Value: String);
      procedure SetNacionalidade(const Value: String);
      procedure SetID(const Value: String);
    public
      Status : String;
      property ID            : String read FID write SetID;
      property CEP           : String read FCEP write SetCEP;
      property Endereco      : String read FEndereco write SetEndereco;
      property Numero        : String read FNumero write SetNumero;
      property Bairro        : String read FBairro write SetBairro;
      property Municipio     : String read FMunicipio write SetMunicipio;
      property UF            : String read FUF write SetUF;
      property Email         : String read FEmail write SetEmail;
      property Telefone      : String read FTelefone write SetTelefone;
      property Data          : String read FData write SetData;
      property Nacionalidade : String read FNacionalidade write SetNacionalidade;
  end;

  TPFisica = class(TPessoa)
    private
      FRG: String;
      FCPF: String;
      FGrau: String;
      FNome: String;
      FProfissao: String;
      procedure SetFCPF(const Value: String);
      procedure SetFRG(const Value: String);
      procedure SetGrau(const Value: String);
      procedure SetNome(const Value: String);
      procedure SetProfissao(const Value: String);
    public
      property CPF       : String read FCPF write SetFCPF;
      property RG        : String read FRG write SetFRG;
      property Nome      : String read FNome write SetNome;
      property Grau      : String read FGrau write SetGrau;
      property Profissao : String read FProfissao write SetProfissao;
  end;

  TPJuridica = class(TPessoa)
    private
      FCNPJ: String;
      FAtuacao: String;
      FInscricaoMunicipal: String;
      FNome: String;
      procedure SetAtuacao(const Value: String);
      procedure SetCNPJ(const Value: String);
      procedure SetInscricaoMunicipal(const Value: String);
      procedure SetNome(const Value: String);
    public
      property CNPJ               : String read FCNPJ write SetCNPJ;
      property InscricaoMunicipal : String read FInscricaoMunicipal write SetInscricaoMunicipal;
      property Nome               : String read FNome write SetNome;
      property Atuacao            : String read FAtuacao write SetAtuacao;
  end;

  TFilaPF = class
  private
      FFilaPF: TObjectList<TPFisica>;
      procedure SetFilaPF(const Value: TObjectList<TPFisica>);
    public
      property FilaPF : TObjectList<TPFisica> read FFilaPF write SetFilaPF;
      procedure AddFila(Pessoa : TPFisica);
      function  DelFila : TPFisica;
      constructor Create;
      procedure Clear;
  end;

  TFilaPJ = class
  private
      FFilaPJ: TObjectList<TPJuridica>;
      procedure SetFilaPJ(const Value: TObjectList<TPJuridica>);
    public
      property FilaPJ : TObjectList<TPJuridica> read FFilaPJ write SetFilaPJ;
      procedure AddFila(Pessoa : TPJuridica);
      function  DelFila : TPJuridica;
      constructor Create;
      procedure Clear;
  end;

implementation

{ TPFisica }

uses Inserir;

procedure TPFisica.SetFCPF(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 11) then begin
    FCPF := Value;
  end else begin
    frmInserir.edtCPF.Clear;
    frmInserir.edtCPF.SetFocus;
    Application.MessageBox('Preencha o campo CPF corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo CPF!!');
  end;
end;

procedure TPFisica.SetFRG(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 9) then begin
    FRG := Value;
  end else begin
    frmInserir.edtRG.Clear;
    frmInserir.edtRG.SetFocus;
    Application.MessageBox('Preencha o campo RG corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo RG!!');
  end;
end;

procedure TPFisica.SetGrau(const Value: String);
begin
  if Value <> '' then begin
    FGrau := Value;
  end else begin
    frmInserir.cbxGrau.Clear;
    frmInserir.cbxGrau.SetFocus;
    Application.MessageBox('Preencha o campo Grau de Escolaridade!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Grau de Escolaridade!!');
  end;
end;

procedure TPFisica.SetNome(const Value: String);
begin
  if Value <> '' then begin
    FNome := Value;
  end else begin
    frmInserir.edtNomeComp.Clear;
    frmInserir.edtNomeComp.Setfocus;
    Application.MessageBox('Preencha o campo Nome!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Nome!!');
  end;
end;

procedure TPFisica.SetProfissao(const Value: String);
begin
  if Value <> '' then begin
    FProfissao := Value;
  end else begin
    frmInserir.edtProfissao.Clear;
    frmInserir.edtProfissao.SetFocus;
    Application.MessageBox('Preencha o campo Profissão!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Profissão!!');
  end;
end;

{ TPJuridica }

procedure TPJuridica.SetAtuacao(const Value: String);
begin
  if Value <> '' then begin
    FAtuacao := Value;
  end else begin
    frmInserir.edtAtuacao.Clear;
    frmInserir.edtAtuacao.SetFocus;
    Application.MessageBox('Preencha o campo Atuação!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Atuação!!');
  end;
end;

procedure TPJuridica.SetCNPJ(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 14) then begin
    FCNPJ := Value;
  end else begin
    frmInserir.edtCNPJ.Clear;
    frmInserir.edtCNPJ.SetFocus;
    Application.MessageBox('Preencha o campo CNPJ corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo CNPJ!!');
  end;
end;

procedure TPJuridica.SetInscricaoMunicipal(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 12) then begin
    FInscricaoMunicipal := Value;
  end else begin
    frmInserir.edtInscricao.Clear;
    frmInserir.edtInscricao.SetFocus;
    Application.MessageBox('Preencha o campo IM corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo IM!!');
  end;
end;

procedure TPJuridica.SetNome(const Value: String);
begin
  if Value <> '' then begin
    FNome := Value;
  end else begin
    frmInserir.edtNomeFant.Clear;
    frmInserir.edtNomeFant.SetFocus;
    Application.MessageBox('Preencha o campo Nome!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Nome!!');
  end;
end;

{ TPessoa }

procedure TPessoa.SetBairro(const Value: String);
begin
  if Value <> '' then begin
    FBairro := Value;
  end else begin
    frmInserir.edtBairroF.Clear;
    frmInserir.edtBairroJ.Clear;
    Application.MessageBox('Preencha o campo Bairro!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Bairro!!');
  end;
end;

procedure TPessoa.SetTelefone(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 11) then begin
    FTelefone := Value;
  end else begin
    frmInserir.edtTelefoneF.Clear;
    frmInserir.edtTelefoneJ.Clear;
    Application.MessageBox('Preencha o campo Telefone corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Telefone!!');
  end;
end;

procedure TPessoa.SetCEP(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 8) then begin
    FCEP := Value;
  end else begin
    frmInserir.edtCEPF.Clear;
    frmInserir.edtCEPJ.Clear;
    Application.MessageBox('Preencha o campo CEP corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo CEP!!');
  end;
end;

procedure TPessoa.SetData(const Value: String);
begin
  if Value <> '' then begin
  FData := Value;
  end else begin
    frmInserir.edtDataNasc.Clear;
    frmInserir.edtDataCriacao.Clear;
    Application.MessageBox('Preencha o campo Data!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Data!!');
  end;
end;

procedure TPessoa.SetEmail(const Value: String);
begin
  if Value <> '' then begin
    FEmail := Value;
  end else begin
    frmInserir.edtEmailF.Clear;
    frmInserir.edtEmailJ.Clear;
    Application.MessageBox('Preencha o campo Email!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Email!!');
  end;
end;

procedure TPessoa.SetEndereco(const Value: String);
begin
  if Value <> '' then begin
    FEndereco := Value;
  end else begin
    frmInserir.edtEnderecoF.Clear;
    frmInserir.edtEnderecoJ.Clear;
    Application.MessageBox('Preencha o campo Endereço!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Endereco!!');
  end;
end;

procedure TPessoa.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TPessoa.SetMunicipio(const Value: String);
begin
  if Value <> '' then begin
    FMunicipio := Value;
  end else begin
    frmInserir.edtMunicipioF.Clear;
    frmInserir.edtMunicipioJ.Clear;
    Application.MessageBox('Preencha o campo Município!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Municipio!!');
  end;
end;

procedure TPessoa.SetNacionalidade(const Value: String);
begin
  if Value <> '' then begin
    FNacionalidade := Value;
  end else begin
    frmInserir.edtNacionalidadeF.Clear;
    frmInserir.edtNacionalidadeJ.Clear;
    Application.MessageBox('Preencha o campo Nacionalidade!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Nacionalidade!!');
  end;
end;

procedure TPessoa.SetNumero(const Value: String);
begin
  if Value <> '' then begin
    FNumero := Value;
  end else begin
    frmInserir.edtNumeroF.Clear;
    frmInserir.edtNumeroJ.Clear;
    Application.MessageBox('Preencha o campo Número!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Numero!!');
  end;
end;

procedure TPessoa.SetUF(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 2) then begin
    FUF := Value;
  end else begin
    frmInserir.edtUFF.Clear;
    frmInserir.edtUFJ.Clear;
    Application.MessageBox('Preencha o campo UF corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo UF!!');
  end;
end;

{ TFilaPF }

procedure TFilaPF.AddFila(Pessoa: TPFisica);
begin
  Self.FilaPF.Add(Pessoa);
end;

procedure TFilaPF.Clear;
begin
  Self.FilaPF.Clear;
end;

constructor TFilaPF.Create;
begin
  Self.FilaPF := TObjectList<TPFisica>.Create;
  inherited;
end;

function TFilaPF.DelFila: TPFisica;
begin
  Result := nil;
  if Self.FilaPF.Count > 0 then begin
    Result := Self.FilaPF.ExtractAt(0);
  end;
end;

procedure TFilaPF.SetFilaPF(const Value: TObjectList<TPFisica>);
begin
  FFilaPF := Value;
end;

{ TFilaPJ }

procedure TFilaPJ.AddFila(Pessoa: TPJuridica);
begin
  Self.FilaPJ.Add(Pessoa);
end;

procedure TFilaPJ.Clear;
begin
  Self.FilaPJ.Clear;
end;

constructor TFilaPJ.Create;
begin
  Self.FilaPJ := TObjectList<TPJuridica>.Create;
  inherited;
end;

function TFilaPJ.DelFila: TPJuridica;
begin
  Result := nil;
  if Self.FilaPJ.Count > 0 then begin
    Result := Self.FilaPJ.ExtractAt(0);
  end;
end;

procedure TFilaPJ.SetFilaPJ(const Value: TObjectList<TPJuridica>);
begin
  FFilaPJ := Value;
end;

end.

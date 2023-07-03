unit Classes;

interface

uses
//  System.SysUtils, Vcl.StdCtrls, Vcl.Controls, Vcl.Imaging.pngimage,
//  Vcl.ExtCtrls, System.Classes;
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Imaging.pngimage;

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
    FTipo: String;
    FNacionalidade: String;
      procedure SetBairro(const Value: String);
      procedure SetTelefone(const Value: String);
      procedure SetCEP(const Value: String);
      procedure SetEmail(const Value: String);
      procedure SetEndereco(const Value: String);
      procedure SetMunicipio(const Value: String);
      procedure SetNumero(const Value: String);
      procedure SetUF(const Value: String);
      procedure SetData(const Value: String);
      procedure SetTipo(const Value: String);
      procedure SetNacionalidade(const Value: String);
    public
      Status : Integer;
      property CEP       : String read FCEP write SetCEP;
      property Endereco  : String read FEndereco write SetEndereco;
      property Numero    : String read FNumero write SetNumero;
      property Bairro    : String read FBairro write SetBairro;
      property Municipio : String read FMunicipio write SetMunicipio;
      property UF        : String read FUF write SetUF;
      property Email     : String read FEmail write SetEmail;
      property Telefone  : String read FTelefone write SetTelefone;
      property Data      : String read FData write SetData;
      property Nacionalidade : String read FNacionalidade write SetNacionalidade;
      property Tipo : String read FTipo write SetTipo;
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
      property CPF           : String read FCPF write SetFCPF;
      property RG            : String read FRG write SetFRG;
      property Nome          : String read FNome write SetNome;
      property Grau          : String read FGrau write SetGrau;
      property Profissao     : String read FProfissao write SetProfissao;
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

  TCelula = class
    private

    public
      Pessoa : TPessoa;
      Prox : TCelula;
      constructor Create;
  end;

  TPilha = class
    private
      function    CreateCel : TCelula;

    public
      Head  : TCelula;
      constructor Create;
      destructor  Destroy; override;
      procedure   CreateHead;
      procedure   AddCel(Pessoa: TPessoa);
      function    DelCel : TPessoa;
      function    Count : Integer;
  end;

  var
    Cel : TCelula;

implementation

{ TPFisica }

uses Inserir;

procedure TPFisica.SetFCPF(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 11) then begin
    FCPF := Value;
  end else begin
    Application.MessageBox('Preencha o campo CPF corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo CPF!!');
  end;
end;

procedure TPFisica.SetFRG(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 9) then begin
    FRG := Value;
  end else begin
    Application.MessageBox('Preencha o campo RG corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo RG!!');
  end;
end;

procedure TPFisica.SetGrau(const Value: String);
begin
  if Value <> '' then begin
    FGrau := Value;
  end else begin
    Application.MessageBox('Preencha o campo Grau de Escolaridade!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Grau de Escolaridade!!');
  end;
end;

procedure TPFisica.SetNome(const Value: String);
begin
  if Value <> '' then begin
    FNome := Value;
  end else begin
    Application.MessageBox('Preencha o campo Nome!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Nome!!');
  end;
end;

procedure TPFisica.SetProfissao(const Value: String);
begin
  if Value <> '' then begin
    FProfissao := Value;
  end else begin
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
    Application.MessageBox('Preencha o campo Atuação!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Atuação!!');
  end;
end;

procedure TPJuridica.SetCNPJ(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 14) then begin
    FCNPJ := Value;
  end else begin
    Application.MessageBox('Preencha o campo CNPJ corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo CNPJ!!');
  end;
end;

procedure TPJuridica.SetInscricaoMunicipal(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 12) then begin
    FInscricaoMunicipal := Value;
  end else begin
    Application.MessageBox('Preencha o campo IM corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo IM!!');
  end;
end;

procedure TPJuridica.SetNome(const Value: String);
begin
  if Value <> '' then begin
    FNome := Value;
  end else begin
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
    Application.MessageBox('Preencha o campo Bairro!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Bairro!!');
  end;
end;

procedure TPessoa.SetTelefone(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 11) then begin
    FTelefone := Value;
  end else begin
    Application.MessageBox('Preencha o campo Telefone corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Telefone!!');
  end;
end;

procedure TPessoa.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TPessoa.SetCEP(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 8) then begin
    FCEP := Value;
  end else begin
    Application.MessageBox('Preencha o campo CEP corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo CEP!!');
  end;
end;

procedure TPessoa.SetData(const Value: String);
begin
  if Value <> '' then begin
  FData := Value;
  end else begin
    Application.MessageBox('Preencha o campo Data!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Data!!');
  end;
end;

procedure TPessoa.SetEmail(const Value: String);
begin
  if Value <> '' then begin
    FEmail := Value;
  end else begin
    Application.MessageBox('Preencha o campo Email!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Email!!');
  end;
end;

procedure TPessoa.SetEndereco(const Value: String);
begin
  if Value <> '' then begin
    FEndereco := Value;
  end else begin
    Application.MessageBox('Preencha o campo Endereço!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Endereco!!');
  end;
end;

procedure TPessoa.SetMunicipio(const Value: String);
begin
  if Value <> '' then begin
    FMunicipio := Value;
  end else begin
    Application.MessageBox('Preencha o campo Município!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Municipio!!');
  end;
end;

procedure TPessoa.SetNacionalidade(const Value: String);
begin
  if Value <> '' then begin
    FNacionalidade := Value;
  end else begin
    Application.MessageBox('Preencha o campo Nacionalidade!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Nacionalidade!!');
  end;
end;

procedure TPessoa.SetNumero(const Value: String);
begin
  if Value <> '' then begin
    FNumero := Value;
  end else begin
    Application.MessageBox('Preencha o campo Número!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo Numero!!');
  end;
end;

procedure TPessoa.SetUF(const Value: String);
begin
  if (Value <> '') and (Length(Value) = 2) then begin
    FUF := Value;
  end else begin
    Application.MessageBox('Preencha o campo UF corretamente!!','Aviso',mb_Ok+mb_IconExclamation);
    raise Exception.Create('Preencha o campo UF!!');
  end;
end;

{ TCelula }

constructor TCelula.Create;
begin
  inherited;
end;

{ TPilha }

procedure TPilha.AddCel(Pessoa: TPessoa);
begin
  Cel := CreateCel;
  Cel.Pessoa := Pessoa;
  Cel.Prox := Self.Head.Prox;
  Self.Head.Prox:=Cel;
end;

function TPilha.Count: Integer;
var
I : Integer;
begin
  Cel:=Self.Head.Prox;

  I:=0;

  while Cel<>nil do
  begin
    I:=i+1;
    Cel:=Cel.Prox;
  end;

  Result:=I;
end;

constructor TPilha.Create;
begin
  inherited;
end;

function TPilha.CreateCel: TCelula;
begin
  Cel := TCelula.Create;
  Cel.Pessoa := nil;
  Cel.Prox := nil;
  Result := Cel;
end;

procedure TPilha.CreateHead;
begin
  Self.Head := CreateCel;
end;

function TPilha.DelCel: TPessoa;
var
  Cel : TCelula;
begin
  Cel:=Self.Head.Prox;
  Self.Head.Prox := Cel.Prox;
  Result:=Cel.Pessoa;
  Cel.Destroy;
end;

destructor TPilha.Destroy;
begin
  inherited;
end;

end.

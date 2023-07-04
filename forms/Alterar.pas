unit Alterar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.

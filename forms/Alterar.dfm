object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 521
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 976
    Height = 521
    ActivePage = Empresa
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 64
    ExplicitTop = 208
    object Cliente: TTabSheet
      Caption = 'Pessoa F'#237'sica'
      object pnlMianF: TPanel
        Left = 0
        Top = 0
        Width = 968
        Height = 491
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          968
          491)
        object lblCPF: TLabel
          Left = 151
          Top = 14
          Width = 21
          Height = 15
          Caption = 'CPF'
        end
        object lblRG: TLabel
          Left = 286
          Top = 14
          Width = 15
          Height = 15
          Caption = 'RG'
        end
        object lblDataNasc: TLabel
          Left = 689
          Top = 14
          Width = 107
          Height = 15
          Caption = 'Data de Nascimento'
        end
        object lblTelefoneF: TLabel
          Left = 556
          Top = 14
          Width = 44
          Height = 15
          Caption = 'Telefone'
        end
        object lblGrau: TLabel
          Left = 16
          Top = 110
          Width = 110
          Height = 15
          Caption = 'Grau de escolaridade'
        end
        object edtCEPF: TLabeledEdit
          Left = 286
          Top = 128
          Width = 119
          Height = 23
          EditLabel.Width = 21
          EditLabel.Height = 15
          EditLabel.Caption = 'CEP'
          MaxLength = 8
          NumbersOnly = True
          TabOrder = 9
          Text = ''
        end
        object edtNomeComp: TLabeledEdit
          Left = 16
          Top = 32
          Width = 121
          Height = 23
          EditLabel.Width = 89
          EditLabel.Height = 15
          EditLabel.Caption = 'Nome Completo'
          TabOrder = 0
          Text = ''
        end
        object edtEmailF: TLabeledEdit
          Left = 421
          Top = 32
          Width = 121
          Height = 23
          EditLabel.Width = 29
          EditLabel.Height = 15
          EditLabel.Caption = 'Email'
          TabOrder = 3
          Text = ''
        end
        object edtNacionalidadeF: TLabeledEdit
          Left = 824
          Top = 32
          Width = 121
          Height = 23
          EditLabel.Width = 76
          EditLabel.Height = 15
          EditLabel.Caption = 'Nacionalidade'
          TabOrder = 6
          Text = ''
        end
        object edtProfissao: TLabeledEdit
          Left = 151
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 48
          EditLabel.Height = 15
          EditLabel.Caption = 'Profiss'#227'o'
          TabOrder = 8
          Text = ''
        end
        object edtEnderecoF: TLabeledEdit
          Left = 421
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 49
          EditLabel.Height = 15
          EditLabel.Caption = 'Endere'#231'o'
          TabOrder = 10
          Text = ''
        end
        object edtNumeroF: TLabeledEdit
          Left = 556
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 44
          EditLabel.Height = 15
          EditLabel.Caption = 'N'#250'mero'
          MaxLength = 5
          NumbersOnly = True
          TabOrder = 11
          Text = ''
        end
        object edtBairroF: TLabeledEdit
          Left = 689
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 31
          EditLabel.Height = 15
          EditLabel.Caption = 'Bairro'
          TabOrder = 12
          Text = ''
        end
        object edtMunicipioF: TLabeledEdit
          Left = 824
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 54
          EditLabel.Height = 15
          EditLabel.Caption = 'Munic'#237'pio'
          TabOrder = 13
          Text = ''
        end
        object edtUFF: TLabeledEdit
          Left = 16
          Top = 221
          Width = 121
          Height = 23
          EditLabel.Width = 14
          EditLabel.Height = 15
          EditLabel.Caption = 'UF'
          MaxLength = 2
          TabOrder = 14
          Text = ''
        end
        object edtCPF: TMaskEdit
          Left = 151
          Top = 32
          Width = 119
          Height = 23
          EditMask = '!999.999.999-99;0;_'
          MaxLength = 14
          TabOrder = 1
          Text = ''
        end
        object edtRG: TMaskEdit
          Left = 286
          Top = 32
          Width = 119
          Height = 23
          EditMask = '99.999.999-9;0;_'
          MaxLength = 12
          TabOrder = 2
          Text = ''
        end
        object edtDataNasc: TMaskEdit
          Left = 689
          Top = 32
          Width = 117
          Height = 23
          EditMask = '!99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 5
          Text = '  /  /    '
        end
        object btnAddF: TButton
          Left = 151
          Top = 221
          Width = 121
          Height = 23
          Caption = 'Alterar'
          TabOrder = 15
        end
        object edtTelefoneF: TMaskEdit
          Left = 556
          Top = 32
          Width = 113
          Height = 23
          EditMask = '!\(99\) 99999-9999;0;_'
          MaxLength = 15
          TabOrder = 4
          Text = ''
        end
        object cbxGrau: TComboBox
          Left = 16
          Top = 128
          Width = 121
          Height = 23
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            'Analfabeto'
            'At'#233' 5'#186' Ano '
            '5'#186' Ano Completo'
            '6'#186' ao 9'#186' Ano'
            'Fundamental Completo'
            'M'#233'dio Incompleto'
            'M'#233'dio Completo'
            'Superior Incompleto'
            'Superior Completo'
            'Mestrado'
            'Doutorado')
        end
        object Panel3: TPanel
          Left = 16
          Top = 253
          Width = 934
          Height = 233
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 16
          object Panel4: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 924
            Height = 223
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            TabOrder = 0
            object Panel9: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 914
              Height = 213
              Align = alClient
              BevelKind = bkFlat
              BevelOuter = bvNone
              TabOrder = 0
              object Panel10: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 904
                Height = 203
                Align = alClient
                BevelKind = bkFlat
                BevelOuter = bvNone
                TabOrder = 0
              end
            end
          end
        end
        object Panel11: TPanel
          Left = 286
          Top = 162
          Width = 664
          Height = 82
          Anchors = [akLeft, akTop, akRight]
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 17
          object Panel12: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 654
            Height = 72
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            TabOrder = 0
            object Panel13: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 644
              Height = 62
              Align = alClient
              BevelKind = bkFlat
              BevelOuter = bvNone
              TabOrder = 0
              object Panel14: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 634
                Height = 52
                Align = alClient
                BevelKind = bkFlat
                BevelOuter = bvNone
                TabOrder = 0
              end
            end
          end
        end
      end
    end
    object Empresa: TTabSheet
      Caption = 'Pessoa Juridica'
      ImageIndex = 1
      object pnlMainJ: TPanel
        Left = 0
        Top = 0
        Width = 968
        Height = 491
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          968
          491)
        object lblCNPJ: TLabel
          Left = 151
          Top = 14
          Width = 27
          Height = 15
          Caption = 'CNPJ'
        end
        object lblM: TLabel
          Left = 286
          Top = 14
          Width = 103
          Height = 15
          Caption = 'Inscri'#231#227'o Municipal'
        end
        object lblDataCriacao: TLabel
          Left = 689
          Top = 14
          Width = 83
          Height = 15
          Caption = 'Data de Cria'#231#227'o'
        end
        object lblTelefoneJ: TLabel
          Left = 556
          Top = 14
          Width = 44
          Height = 15
          Caption = 'Telefone'
        end
        object edtCEPJ: TLabeledEdit
          Left = 151
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 21
          EditLabel.Height = 15
          EditLabel.Caption = 'CEP'
          MaxLength = 8
          NumbersOnly = True
          TabOrder = 7
          Text = ''
        end
        object edtNomeFant: TLabeledEdit
          Left = 16
          Top = 32
          Width = 121
          Height = 23
          EditLabel.Width = 79
          EditLabel.Height = 15
          EditLabel.Caption = 'Nome Fantasia'
          TabOrder = 0
          Text = ''
        end
        object edtEmailJ: TLabeledEdit
          Left = 421
          Top = 32
          Width = 121
          Height = 23
          EditLabel.Width = 29
          EditLabel.Height = 15
          EditLabel.Caption = 'Email'
          TabOrder = 3
          Text = ''
        end
        object edtAtuacao: TLabeledEdit
          Left = 16
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 44
          EditLabel.Height = 15
          EditLabel.Caption = 'Atua'#231#227'o'
          TabOrder = 6
          Text = ''
        end
        object edtEnderecoJ: TLabeledEdit
          Left = 286
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 49
          EditLabel.Height = 15
          EditLabel.Caption = 'Endere'#231'o'
          TabOrder = 8
          Text = ''
        end
        object edtNumeroJ: TLabeledEdit
          Left = 421
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 44
          EditLabel.Height = 15
          EditLabel.Caption = 'N'#250'mero'
          TabOrder = 9
          Text = ''
        end
        object edtBairroJ: TLabeledEdit
          Left = 556
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 31
          EditLabel.Height = 15
          EditLabel.Caption = 'Bairro'
          TabOrder = 10
          Text = ''
        end
        object edtMunicipioJ: TLabeledEdit
          Left = 691
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 54
          EditLabel.Height = 15
          EditLabel.Caption = 'Munic'#237'pio'
          TabOrder = 11
          Text = ''
        end
        object edtUFJ: TLabeledEdit
          Left = 824
          Top = 128
          Width = 121
          Height = 23
          EditLabel.Width = 14
          EditLabel.Height = 15
          EditLabel.Caption = 'UF'
          MaxLength = 2
          TabOrder = 12
          Text = ''
        end
        object edtCNPJ: TMaskEdit
          Left = 151
          Top = 32
          Width = 121
          Height = 23
          EditMask = '!99.999.999/9999-99;0;_'
          MaxLength = 18
          TabOrder = 1
          Text = ''
        end
        object edtInscricao: TMaskEdit
          Left = 286
          Top = 32
          Width = 115
          Height = 23
          EditMask = '999.999.999.999;0;_'
          MaxLength = 15
          TabOrder = 2
          Text = ''
        end
        object edtDataCriacao: TMaskEdit
          Left = 689
          Top = 32
          Width = 123
          Height = 23
          EditMask = '!99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 5
          Text = '  /  /    '
        end
        object btnAddJ: TButton
          Left = 16
          Top = 221
          Width = 121
          Height = 23
          Caption = 'Alterar'
          TabOrder = 13
        end
        object edtTelefoneJ: TMaskEdit
          Left = 556
          Top = 32
          Width = 121
          Height = 23
          EditMask = '!\(99\) 99999-9999;0;_'
          MaxLength = 15
          TabOrder = 4
          Text = ''
        end
        object pnlLine5: TPanel
          Left = 16
          Top = 253
          Width = 934
          Height = 233
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 14
          object pnlLine6: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 924
            Height = 223
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            TabOrder = 0
            object pnlLine7: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 914
              Height = 213
              Align = alClient
              BevelKind = bkFlat
              BevelOuter = bvNone
              TabOrder = 0
              object pnlLine8: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 904
                Height = 203
                Align = alClient
                BevelKind = bkFlat
                BevelOuter = bvNone
                TabOrder = 0
              end
            end
          end
        end
        object pnlLine1: TPanel
          Left = 151
          Top = 162
          Width = 799
          Height = 82
          Anchors = [akLeft, akTop, akRight]
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 15
          object pnlLine2: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 789
            Height = 72
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            TabOrder = 0
            object pnlLine3: TPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 779
              Height = 62
              Align = alClient
              BevelKind = bkFlat
              BevelOuter = bvNone
              TabOrder = 0
              object pnlLine4: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 769
                Height = 52
                Align = alClient
                BevelKind = bkFlat
                BevelOuter = bvNone
                TabOrder = 0
              end
            end
          end
        end
        object edtNacionalidadeJ: TLabeledEdit
          Left = 824
          Top = 32
          Width = 121
          Height = 23
          EditLabel.Width = 76
          EditLabel.Height = 15
          EditLabel.Caption = 'Nacionalidade'
          TabOrder = 16
          Text = ''
        end
      end
    end
  end
end

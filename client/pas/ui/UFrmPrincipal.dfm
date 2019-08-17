object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Pizzaria'
  ClientHeight = 327
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 597
    Height = 58
    Align = alTop
    TabOrder = 0
    object edtDocumentoCliente: TLabeledEdit
      Left = 12
      Top = 25
      Width = 214
      Height = 21
      EditLabel.Width = 213
      EditLabel.Height = 13
      EditLabel.Caption = 'Informe o N'#250'mero do Documento do CLiente'
      TabOrder = 0
    end
    object btn_Acao: TButton
      Left = 232
      Top = 23
      Width = 97
      Height = 23
      Caption = 'Fazer Pedido'
      TabOrder = 1
      OnClick = btn_AcaoClick
    end
    object edtPortaBackend: TLabeledEdit
      Left = 487
      Top = 25
      Width = 107
      Height = 21
      EditLabel.Width = 112
      EditLabel.Height = 13
      EditLabel.Caption = 'Porta Pizzaria Backend:'
      TabOrder = 2
      Text = '8080'
      Visible = False
    end
    object edtEnderecoBackend: TLabeledEdit
      Left = 338
      Top = 25
      Width = 143
      Height = 21
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
      TabOrder = 3
      Text = 'http://localhost'
      Visible = False
    end
  end
  object pgPedido: TPageControl
    Left = 0
    Top = 58
    Width = 597
    Height = 269
    ActivePage = tsPedido
    Align = alClient
    TabOrder = 1
    OnChange = pgPedidoChange
    object tsPedido: TTabSheet
      Caption = 'Efetuar Pedido'
      object Label1: TLabel
        Left = 8
        Top = 11
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object Label2: TLabel
        Left = 8
        Top = 61
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object Label3: TLabel
        Left = 230
        Top = 11
        Width = 118
        Height = 13
        Caption = 'Retorno do WebService:'
      end
      object cmbTamanhoPizza: TComboBox
        Left = 8
        Top = 29
        Width = 193
        Height = 21
        ItemIndex = 0
        TabOrder = 0
        Text = 'enPequena'
        Items.Strings = (
          'enPequena'
          'enMedia'
          'enGrande')
      end
      object cmbSaborPizza: TComboBox
        Left = 8
        Top = 80
        Width = 193
        Height = 21
        ItemIndex = 0
        TabOrder = 1
        Text = 'enCalabresa'
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object mmRetornoWebService: TMemo
        Left = 230
        Top = 29
        Width = 335
        Height = 187
        Color = clCream
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'mmRetornoWebService')
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object tsCosnulta: TTabSheet
      Caption = 'Consultar Pedido'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbResumo: TGroupBox
        Left = 0
        Top = 0
        Width = 589
        Height = 241
        Align = alClient
        Caption = '  Resumo do Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object mmResumoPedido: TMemo
          Left = 2
          Top = 15
          Width = 585
          Height = 224
          Align = alClient
          Color = clCream
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
  end
end

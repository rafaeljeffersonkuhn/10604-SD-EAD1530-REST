object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Pedido de Pizza'
  ClientHeight = 341
  ClientWidth = 596
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
  object pgPedido: TPageControl
    Left = 0
    Top = 73
    Width = 596
    Height = 268
    ActivePage = tsPedido
    Align = alClient
    TabOrder = 0
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
        TabOrder = 0
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
        TabOrder = 1
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object mmRetornoWebService: TMemo
        Left = 230
        Top = 30
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
      object gbResumo: TGroupBox
        Left = 0
        Top = 0
        Width = 588
        Height = 240
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
          Width = 584
          Height = 223
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 596
    Height = 73
    Align = alTop
    TabOrder = 1
    object edtEnderecoBackend: TLabeledEdit
      Left = 376
      Top = 34
      Width = 161
      Height = 21
      EditLabel.Width = 131
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
      Enabled = False
      TabOrder = 0
      Text = 'http://localhost:8080/soap/IPizzariaBackendController'
      Visible = False
    end
    object edtDocumentoCliente: TLabeledEdit
      Left = 12
      Top = 34
      Width = 214
      Height = 21
      EditLabel.Width = 213
      EditLabel.Height = 13
      EditLabel.Caption = 'Informe o N'#250'mero do Documento do CLiente'
      TabOrder = 1
    end
    object btn_Acao: TButton
      Left = 232
      Top = 33
      Width = 97
      Height = 23
      Caption = 'Fazer Pedido'
      TabOrder = 2
      OnClick = btn_AcaoClick
    end
  end
end

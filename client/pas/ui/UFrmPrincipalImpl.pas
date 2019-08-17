unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    pgPedido: TPageControl;
    tsPedido: TTabSheet;
    tsCosnulta: TTabSheet;
    cmbTamanhoPizza: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbSaborPizza: TComboBox;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    gbResumo: TGroupBox;
    mmResumoPedido: TMemo;
    GroupBox1: TGroupBox;
    edtEnderecoBackend: TLabeledEdit;
    edtDocumentoCliente: TLabeledEdit;
    btn_Acao: TButton;
    procedure btn_AcaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pgPedidoChange(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultarPedido;
    procedure EfetuarPedido;
    function CopiarDescricao(ATexto: String): String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum, UPedidoRetornoDTOImpl;

{$R *.dfm}

procedure TForm1.btn_AcaoClick(Sender: TObject);
begin
  if (pgPedido.ActivePageIndex = 0)then
    EfetuarPedido
  else
    ConsultarPedido;
end;

procedure TForm1.ConsultarPedido;
var
  oPizzariaBackendController: IPizzariaBackendController;
  oPedidoRetorno : TPedidoRetornoDTO;
begin
  mmResumoPedido.Lines.Clear;
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  oPedidoRetorno := oPizzariaBackendController.consultarPedido(edtDocumentoCLiente.Text);
  mmResumoPedido.Lines.Add('Data/Hora do Pedido..: ' + DateTimeToStr(oPedidoRetorno.DataPedido));
  mmResumoPedido.Lines.Add('Tamanho da Pizza.....: ' + CopiarDescricao(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oPedidoRetorno.PizzaTamanho)));
  mmResumoPedido.Lines.Add('Sabor da Pizza.......: ' + CopiarDescricao(TRttiEnumerationType.GetName<TPizzaSaborEnum>(oPedidoRetorno.PizzaSabor)));
  mmResumoPedido.Lines.Add('Tempo de preparo.....: ' + IntToStr(oPedidoRetorno.TempoPreparo) + ' minutos');
  mmResumoPedido.Lines.Add('Data/Hora Entrega....: ' + DateTimeToStr(oPedidoRetorno.DataEntrega));
  mmResumoPedido.Lines.Add('Valor do Pedido......: R$ ' + FormatFloat('#,##0.00', oPedidoRetorno.ValorTotalPedido));

end;

function TForm1.CopiarDescricao(ATexto: String): String;
begin
  Result := copy(Atexto, 3, Length(Atexto));
end;

procedure TForm1.EfetuarPedido;
var
  oPizzariaBackendController: IPizzariaBackendController;
  oPedidoRetorno : TPedidoRetornoDTO;
begin
  mmRetornoWebService.Lines.Clear;
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pgPedido.ActivePageIndex := 0;
  btn_Acao.Caption := 'Fazer Pedido';
end;

procedure TForm1.pgPedidoChange(Sender: TObject);
begin
  if (pgPedido.ActivePageIndex = 0)then
    btn_Acao.Caption := 'Fazer Pedido'
  else
    btn_Acao.Caption := 'Consultar Pedido';
end;

end.

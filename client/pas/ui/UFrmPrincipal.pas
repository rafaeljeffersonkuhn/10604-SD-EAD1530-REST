unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    edtDocumentoCliente: TLabeledEdit;
    btn_Acao: TButton;
    edtPortaBackend: TLabeledEdit;
    edtEnderecoBackend: TLabeledEdit;
    pgPedido: TPageControl;
    tsPedido: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cmbTamanhoPizza: TComboBox;
    cmbSaborPizza: TComboBox;
    mmRetornoWebService: TMemo;
    tsCosnulta: TTabSheet;
    gbResumo: TGroupBox;
    mmResumoPedido: TMemo;
    procedure btn_AcaoClick(Sender: TObject);
    procedure pgPedidoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure ConsultarPedido;
    procedure EfetuarPedido;
    function CopiarDescricao(ATexto: String): String;
    procedure validar;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  Rest.JSON, MVCFramework.RESTClient, UEfetuarPedidoDTOImpl, System.Rtti,
  UPizzaSaborEnum, UPizzaTamanhoEnum, UPedidoRetornoDTOImpl, JsonDataObjects,
  system.Json;

{$R *.dfm}

procedure TForm1.btn_AcaoClick(Sender: TObject);
begin
  validar;
  if (pgPedido.ActivePageIndex = 0)then
    EfetuarPedido
  else
    ConsultarPedido;
end;

procedure TForm1.ConsultarPedido;
var
  Clt: TRestClient;
  Response: IRESTResponse;
  oPedidoRetornoDTO: TPedidoRetornoDTO;
begin
  Clt := MVCFramework.RESTClient.TRestClient.Create(edtEnderecoBackend.Text,
    StrToIntDef(edtPortaBackend.Text, 80), nil);
  try
    Clt.ReadTimeOut(60000);
    mmResumoPedido.Lines.Clear;
    Response := Clt.doGET('/consultarPedido', [edtDocumentoCliente.Text]);

    if Response.HasError then
      begin
      mmResumoPedido.Text := Response.BodyAsString(); //Response.Error.ToString - Acess violation.;
      Exit;
    end;

    oPedidoRetornoDTO := TJson.JsonToObject<TPedidoRetornoDTO>(Response.BodyAsString());
    mmResumoPedido.Lines.Add('Data/Hora do Pedido..: ' + DateTimeToStr(oPedidoRetornoDTO.DataPedido));
    mmResumoPedido.Lines.Add('Tamanho da Pizza.....: ' + CopiarDescricao(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oPedidoRetornoDTO.PizzaTamanho)));
    mmResumoPedido.Lines.Add('Sabor da Pizza.......: ' + CopiarDescricao(TRttiEnumerationType.GetName<TPizzaSaborEnum>(oPedidoRetornoDTO.PizzaSabor)));
    mmResumoPedido.Lines.Add('Tempo de preparo.....: ' + IntToStr(oPedidoRetornoDTO.TempoPreparo) + ' minutos');
    mmResumoPedido.Lines.Add('Data/Hora Entrega....: ' + DateTimeToStr(oPedidoRetornoDTO.DataEntrega));
    mmResumoPedido.Lines.Add('Valor do Pedido......: R$ ' + FormatFloat('#,##0.00', oPedidoRetornoDTO.ValorTotalPedido));
  finally
    Clt.Free;
  end;
end;

function TForm1.CopiarDescricao(ATexto: String): String;
begin
  Result := copy(Atexto, 3, Length(Atexto));
end;

procedure TForm1.EfetuarPedido;
var
  Clt: TRestClient;
  oEfetuarPedido: TEfetuarPedidoDTO;
begin
  Clt := MVCFramework.RESTClient.TRestClient.Create(edtEnderecoBackend.Text,
    StrToIntDef(edtPortaBackend.Text, 80), nil);
  try
    oEfetuarPedido := TEfetuarPedidoDTO.Create;
    try
      oEfetuarPedido.PizzaTamanho :=
        TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text);
      oEfetuarPedido.PizzaSabor :=
        TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text);
      oEfetuarPedido.DocumentoCliente := edtDocumentoCliente.Text;
      mmRetornoWebService.Text := Clt.doPOST('/efetuarPedido', [],
        TJson.ObjecttoJsonString(oEfetuarPedido)).BodyAsString;
    finally
      oEfetuarPedido.Free;
    end;
  finally
    Clt.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pgPedido.ActivePageIndex := 0;
  btn_Acao.Caption := 'Efetuar Pedido';
end;

procedure TForm1.pgPedidoChange(Sender: TObject);
begin
  if (pgPedido.ActivePageIndex = 0)then
    btn_Acao.Caption := 'Efetuar Pedido'
  else
    btn_Acao.Caption := 'Consultar Pedido';
end;

procedure TForm1.validar;
begin
  if edtDocumentoCliente.Text = '' then
    raise Exception.Create('Informe o número de documento');
end;

end.

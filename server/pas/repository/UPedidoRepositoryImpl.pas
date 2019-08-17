unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client,
  UPedidoRetornoDTOImpl;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer; const ADataPedido: TDateTime; const ADataEntrega: TDateTime);
    procedure consultarPedido(const ADocumentoCliente: String; out AFQuery: TFDQuery );

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param, Rtti;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tx_saborpizza, tx_tamanhopizza)  '+
    ' VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pSaborPizza, :pTamanhoPizza)';

  CMD_CONSULTAR_PEDIDO
    : String =
    'SELECT tx_tamanhopizza, tx_saborpizza, vl_pedido, nr_tempopedido, dt_pedido, dt_entrega FROM tb_pedido p1 '+
    'INNER JOIN tb_cliente c1 ON c1.id = p1.cd_cliente ' +
    ' WHERE c1.nr_documento = :pDocumentoCliente ORDER BY p1.id desc limit 1 ';


  { TPedidoRepository }


procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: string;
  out AFQuery: TFDQuery);
begin
  AFQuery.connection :=  FDBConnection.getDefaultConnection;
  AFQuery.SQL.Text := CMD_CONSULTAR_PEDIDO;
  AFQuery.ParamByName('pDocumentoCliente').AsString := ADocumentoCliente;
  AFQuery.Prepare;
  AFQuery.Open;

end;

constructor TPedidoRepository.Create;
begin
  inherited;

  FDBConnection := TDBConnection.Create;
  FFDQuery := TFDQuery.Create(nil);
  FFDQuery.Connection := FDBConnection.getDefaultConnection;
end;

destructor TPedidoRepository.Destroy;
begin
  FFDQuery.Free;
  inherited;
end;

procedure TPedidoRepository.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
  const ATempoPreparo: Integer; const ACodigoCliente: Integer; const ADataPedido: TDateTime; const ADataEntrega: TDateTime);
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;

  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime := ADataPedido;
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := ADataEntrega;
  FFDQuery.ParamByName('pValorPedido').AsCurrency := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger := ATempoPreparo;
  FFDQuery.ParamByName('pTamanhoPizza').AsString := TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(ApizzaTamanho);
  FFDQuery.ParamByName('pSaborPizza').AsString := TRttiEnumerationType.GetName<TPizzaSaborEnum>(ApizzaSabor);

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.

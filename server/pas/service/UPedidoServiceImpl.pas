unit UPedidoServiceImpl;

interface

uses
  UPedidoServiceIntf, UPizzaTamanhoEnum, UPizzaSaborEnum,
  UPedidoRepositoryIntf, UPedidoRetornoDTOImpl, UClienteServiceIntf;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)
  private
    FPedidoRepository: IPedidoRepository;
    FClienteService: IClienteService;

    function calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
    function calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
  public
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO;
    function consultarPedido(const ADocumentoCliente: String): TPedidoRetornoDTO;

    constructor Create; reintroduce;
  end;

implementation

uses
  UPedidoRepositoryImpl, System.SysUtils, UClienteServiceImpl,
  FireDAC.Comp.Client, Rtti, DateUtils;

{ TPedidoService }

function TPedidoService.calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
begin
  Result := 15;
  case APizzaTamanho of
    enPequena:
      Result := 15;
    enMedia:
      Result := 20;
    enGrande:
      Result := 25;
  end;

  if (APizzaSabor = enPortuguesa) then
    Result := Result + 5;
end;

function TPedidoService.calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
begin
  Result := 20;
  case APizzaTamanho of
    enPequena:
      Result := 20;
    enMedia:
      Result := 30;
    enGrande:
      Result := 40;
  end;
end;

function TPedidoService.consultarPedido(
  const ADocumentoCliente: String): TPedidoRetornoDTO;
var
  oFDQuery : TFDQuery;
begin
  oFdQuery := TFDQuery.Create(nil);
  try
    FPedidoRepository.consultarPedido( ADocumentoCliente, oFDQuery);
    if oFdQuery.IsEmpty then
      raise Exception.Create('Nenhum pedido cadastro para o cliente com n�mero de documento: '+ ADocumentoCLiente);

    Result := TPedidoRetornoDTO.Create(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(oFDQuery.FieldByName('tx_tamanhopizza').AsString),
                      TRttiEnumerationType.GetValue<TPizzaSaborEnum>(oFDQuery.FieldByName('tx_saborpizza').AsString),
                      oFDQuery.FieldByName('vl_pedido').AsInteger,
                      oFDQuery.FieldByName('nr_tempopedido').AsInteger,
                      oFDQuery.FieldByName('dt_pedido').AsDateTime,
                      oFDQuery.FieldByName('dt_entrega').AsDateTime
    );
  finally
    oFDQUery.Free;
  end;
end;

constructor TPedidoService.Create;
begin
  inherited;

  FPedidoRepository := TPedidoRepository.Create;
  FClienteService := TClienteService.Create;
end;

function TPedidoService.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String)
  : TPedidoRetornoDTO;
var
  oValorPedido: Currency;
  oTempoPreparo: Integer;
  oCodigoCliente: Integer;
  oDataHora: TDateTime;
begin
  oValorPedido := calcularValorPedido(APizzaTamanho);
  oTempoPreparo := calcularTempoPreparo(APizzaTamanho, APizzaSabor);
  oCodigoCliente := FClienteService.adquirirCodigoCliente(ADocumentoCliente);
  oDataHora  := now;

  FPedidoRepository.efetuarPedido(APizzaTamanho, APizzaSabor, oValorPedido, oTempoPreparo, oCodigoCliente, oDataHora, IncMinute(oDataHora, oTempoPreparo));
  Result := TPedidoRetornoDTO.Create(APizzaTamanho, APizzaSabor, oValorPedido, oTempoPreparo, oDataHora, IncMinute(oDataHora + oTempoPreparo));
end;

end.

unit UPedidoRepositoryIntf;

interface

uses
  UPizzaSaborEnum, UPizzaTamanhoEnum, UPedidoRetornoDTOImpl,
  FireDAC.Comp.Client;

type
  IPedidoRepository = interface(IInterface)
    ['{76A94FF6-4634-4C52-91E4-3F969389D917}']

    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer; const ADataPedido: TdateTime; const ADataEntrega: TdateTime);
    procedure consultarPedido(const ADocumentoCliente: String; out AQuery :TFDQuery);
  end;

implementation

end.

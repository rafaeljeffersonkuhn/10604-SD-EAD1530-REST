unit UPedidoRetornoDTOImpl;

interface

uses
  Soap.InvokeRegistry, UPizzaTamanhoEnum, UPizzaSaborEnum;

type
  TPedidoRetornoDTO = class(TRemotable)
  private
    FPizzaTamanho: TPizzaTamanhoEnum;
    FPizzaSabor: TPizzaSaborEnum;
    FValorTotalPedido: Currency;
    FTempoPreparo: Integer;
    FDataPedido: TDateTime;
    FDataEntrega: TDateTime;
  published
    property PizzaTamanho: TPizzaTamanhoEnum read FPizzaTamanho write FPizzaTamanho;
    property PizzaSabor: TPizzaSaborEnum read FPizzaSabor write FPizzaSabor;
    property ValorTotalPedido: Currency read FValorTotalPedido write FValorTotalPedido;
    property TempoPreparo: Integer read FTempoPreparo write FTempoPreparo;
    property DataPedido: TDateTime read FDataPedido write FDataPedido;
    property DataEntrega: TDateTime read FDataEntrega write FDataEntrega;
  public
    constructor Create(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum;
                       const AValorTotalPedido: Currency; const ATempoPreparo: Integer;
                       const ADataPedido: TdateTime; const ADataEntrega: TDateTime); reintroduce;

  end;

implementation

uses
  System.SysUtils;
{ TPedidoRetornoDTO }

constructor TPedidoRetornoDTO.Create(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum;
      const AValorTotalPedido: Currency; const ATempoPreparo: Integer; const ADataPedido: TDateTime; const ADataEntrega: TDateTime);
begin
  FPizzaTamanho := APizzaTamanho;
  FPizzaSabor := APizzaSabor;
  FValorTotalPedido := AValorTotalPedido;
  FTempoPreparo := ATempoPreparo;
  FDataPedido := ADataPedido;
  FDataEntrega := ADataEntrega;
end;


end.

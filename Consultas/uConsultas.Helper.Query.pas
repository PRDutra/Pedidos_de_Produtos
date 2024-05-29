unit uConsultas.Helper.Query;

interface

uses
  FireDAC.Comp.Client, uInterface.Consultas;

type
  TConsultasHelperQuery = class helper for TFDMemTable
  private
    class var FPedido: IInterfaceConsulta;
    class var FItensPedido: IInterfaceConsulta;
    function GetItensPedido: IInterfaceConsulta;
    function GetPedido: IInterfaceConsulta;
  public
    property Pedido: IInterfaceConsulta read GetPedido;
    property ItensPedido: IInterfaceConsulta read GetItensPedido;
  end;

implementation

uses
  SysUtils, uConsultas.ItensPedido, uConsultas.Pedido;

{ TConsultasHelperQuery }

function TConsultasHelperQuery.GetItensPedido: IInterfaceConsulta;
begin
  if not Assigned(FItensPedido) then
    FItensPedido := TConsultasItensPedido.Create;
  FItensPedido.AplicarQuery(Self);
  Result := FItensPedido;
end;

function TConsultasHelperQuery.GetPedido: IInterfaceConsulta;
begin
  if not Assigned(FPedido) then
    FPedido := TConsultasPedido.Create;
  FPedido.AplicarQuery(Self);
  Result := FPedido;
end;

end.

unit uConsultas.Pedido;

interface

uses
  Classes, uInterface.Consultas, FireDAC.Comp.Client, FireDAC.Stan.StorageXML, DB;

type
  TConsultasPedido = class(TInterfacedObject, IInterfaceConsulta)
  private
    FQuery: TFDMemTable;
    FPkField: TField;
  public
    procedure AplicarQuery(AQuery: TFDMemTable);
    procedure Consultar;
    procedure ConsultarPorID(const AId: Integer);
    procedure SalvarDados;
    procedure ExcluirRegistro(const AId: Integer);
  end;

implementation

uses
  uManipulacao.XML.Carregar, uConst.Informacao.Sistema, SysUtils, uMemTable.Utils, uManipulacao.XML.Salvar,
  uManipulacao.XML.Deletar;

{ TConsultasPedido }

procedure TConsultasPedido.Consultar;
begin
  FQuery.Close;
  FQuery.Open;
  TManipulacaoXMLCarregar.Executar(FQuery, TConstInformacaoSistema.CaminhoCompletoPedidoDB);
end;

procedure TConsultasPedido.ConsultarPorID(const AId: Integer);
var
  qryTemp: TFDMemTable;
begin
  FQuery.Close;
  FQuery.Open;
  qryTemp := TFDMemTable.Create(nil);
  try
    TMemTableUtils.ClonarCampos(FQuery, qryTemp);
    TManipulacaoXMLCarregar.Executar(qryTemp, TConstInformacaoSistema.CaminhoCompletoPedidoDB);
    qryTemp.Filter := FPkField.FieldName + ' = ' + AId.ToString;
    qryTemp.Filtered := True;
    if not FQuery.Active then
      FQuery.Open;
    FQuery.Append;
    FQuery.CopyRecord(qryTemp);
    FQuery.Post;
  finally
    qryTemp.Free;
  end;
end;

procedure TConsultasPedido.ExcluirRegistro(const AId: Integer);
begin
  FQuery.Filter := FPkField.FieldName + ' = ' + FPkField.AsString;
  FQuery.Filtered := True;
  try
    TManipulacaoXMLDeletar.Executar(FQuery, FPkField.FieldName, TConstInformacaoSistema.CaminhoCompletoPedidoDB);
  finally
    FQuery.Filtered := False;
  end;
end;

procedure TConsultasPedido.SalvarDados;
begin
  TManipulacaoXMLSalvar.Executar(FQuery, FPkField.FieldName, TConstInformacaoSistema.CaminhoCompletoPedidoDB);
end;

procedure TConsultasPedido.AplicarQuery(AQuery: TFDMemTable);
begin
  Self.FQuery := AQuery;
  Self.FPkField := AQuery.FindField('NroPedido');
end;

end.

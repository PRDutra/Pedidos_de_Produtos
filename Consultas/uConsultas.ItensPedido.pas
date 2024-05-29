unit uConsultas.ItensPedido;

interface

uses
  Classes, uInterface.Consultas, FireDAC.Comp.Client, FireDAC.Stan.StorageXML, DB;

type
  TConsultasItensPedido = class(TInterfacedObject, IInterfaceConsulta)
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


{ TConsultasItensPedido }

procedure TConsultasItensPedido.Consultar;
begin
  FQuery.Close;
  FQuery.Open;
  TManipulacaoXMLCarregar.Executar(FQuery, TConstInformacaoSistema.CaminhoCompletoItensPedidoDB);
end;

procedure TConsultasItensPedido.ConsultarPorID(const AId: Integer);
var
  qryTemp: TFDMemTable;
begin
  FQuery.Close;
  FQuery.Open;
  qryTemp := TFDMemTable.Create(nil);
  try
    TMemTableUtils.ClonarCampos(FQuery, qryTemp);
    TManipulacaoXMLCarregar.Executar(qryTemp, TConstInformacaoSistema.CaminhoCompletoItensPedidoDB);
    qryTemp.Filter := FPkField.FieldName + ' = ' + AId.ToString;
    qryTemp.Filtered := True;
    qryTemp.first;
    while not qryTemp.Eof do
    begin
      FQuery.Append;
      FQuery.CopyRecord(qryTemp);
      FQuery.Post;
      qryTemp.Next;
    end;
  finally
    qryTemp.Free;
  end;
end;

procedure TConsultasItensPedido.AplicarQuery(AQuery: TFDMemTable);
begin
  Self.FQuery := AQuery;
  Self.FPkField := AQuery.FindField('NroPedido');
end;

procedure TConsultasItensPedido.SalvarDados;
begin
  TManipulacaoXMLSalvar.Executar(FQuery, FPkField.FieldName, TConstInformacaoSistema.CaminhoCompletoItensPedidoDB);
end;

procedure TConsultasItensPedido.ExcluirRegistro(const AId: Integer);
begin
  FQuery.Filter := FPkField.FieldName + ' = ' + AId.ToString;
  FQuery.Filtered := True;
  try
    TManipulacaoXMLDeletar.Executar(FQuery, FPkField.FieldName, TConstInformacaoSistema.CaminhoCompletoItensPedidoDB);
  finally
    FQuery.Filtered := False;
  end;
end;

end.

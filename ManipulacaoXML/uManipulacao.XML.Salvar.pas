unit uManipulacao.XML.Salvar;

interface

uses
  FireDAC.Comp.Client;

type
  TManipulacaoXMLSalvar = class
  public
    class procedure Executar(ADadosConsulta: TFDMemTable; const AChavePrimaria, ACaminhoCompleto: string);
  end;

implementation

uses
  SysUtils, Forms, FireDAC.Stan.Intf, DB, uMemTable.Utils;

{ TManipulacaoXMLSalvar }

class procedure TManipulacaoXMLSalvar.Executar(ADadosConsulta: TFDMemTable; const AChavePrimaria, ACaminhoCompleto: string);
var
  qryTemp: TFDMemTable;
begin
  qryTemp := TFDMemTable.Create(nil);
  try
    TMemTableUtils.ClonarCampos(ADadosConsulta, qryTemp);

    if FileExists(ACaminhoCompleto) then
      qryTemp.LoadFromFile(ACaminhoCompleto);

    ADadosConsulta.First;
    while not ADadosConsulta.Eof do
    begin
      while qryTemp.Locate(AChavePrimaria, ADadosConsulta.FieldByName(AChavePrimaria).Value, []) do
        qryTemp.Delete;
      ADadosConsulta.Next;
    end;

    ADadosConsulta.First;
    while not ADadosConsulta.Eof do
    begin
      qryTemp.Append;
      qryTemp.CopyRecord(ADadosConsulta);
      qryTemp.Post;
      ADadosConsulta.Next;
    end;

    qryTemp.SaveToFile(ACaminhoCompleto, sfXML);
  finally
    qryTemp.Free;
  end;
end;

end.

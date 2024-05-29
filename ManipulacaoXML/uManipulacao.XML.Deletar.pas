unit uManipulacao.XML.Deletar;

interface

uses
  FireDAC.Comp.Client;

type
  TManipulacaoXMLDeletar = class
  public
    class procedure Executar(ADadosConsulta: TFDMemTable; const AChavePrimaria, ACaminhoCompleto: string);
  end;


implementation

uses
  SysUtils, Forms, FireDAC.Stan.Intf, DB, uMemTable.Utils;

{ TManipulacaoXMLDeletar }

class procedure TManipulacaoXMLDeletar.Executar(ADadosConsulta: TFDMemTable; const AChavePrimaria, ACaminhoCompleto: string);
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

      ADadosConsulta.Delete;
    end;

    qryTemp.SaveToFile(ACaminhoCompleto, sfXML);
  finally
    qryTemp.Free;
  end;
end;

end.

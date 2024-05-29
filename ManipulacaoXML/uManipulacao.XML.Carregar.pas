unit uManipulacao.XML.Carregar;

interface

uses
  FireDAC.Comp.Client;

type
  TManipulacaoXMLCarregar = class
  public
    class procedure Executar(ADadosConsulta: TFDMemTable; const ACaminhoCompleto: string);
  end;

implementation

uses
  SysUtils, Forms, FireDAC.Stan.Intf, DB;

{ TManipulacaoXMLCarregar }

class procedure TManipulacaoXMLCarregar.Executar(ADadosConsulta: TFDMemTable; const ACaminhoCompleto: string);
begin
  ADadosConsulta.Close;
  ADadosConsulta.Open;

  if FileExists(ACaminhoCompleto) then
  begin
    ADadosConsulta.LoadFromFile(ACaminhoCompleto);
    Exit;
  end;

  ADadosConsulta.SaveToFile(ACaminhoCompleto, sfXML);
end;

end.

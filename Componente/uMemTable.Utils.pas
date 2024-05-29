unit uMemTable.Utils;

interface

uses
  FireDAC.Comp.Client;

type
  TMemTableUtils = class
  public
    class procedure ClonarCampos(ADeQuery, AParaQuery: TFdMemTable);
  end;

implementation

uses
  DB;

{ TMemTableUtils }

class procedure TMemTableUtils.ClonarCampos(ADeQuery, AParaQuery: TFdMemTable);
begin
  for var icampo := 0 to ADeQuery.FieldCount -1 do
    AParaQuery.FieldDefs.Add(ADeQuery.Fields[icampo].FieldName, ADeQuery.Fields[icampo].DataType, ADeQuery.Fields[icampo].Size);
  AParaQuery.CreateDataSet;
end;

end.

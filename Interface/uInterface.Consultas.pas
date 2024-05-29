unit uInterface.Consultas;

interface

uses
  FireDAC.Comp.Client;

type
  IInterfaceConsulta = Interface
  ['{0AFD80A7-08FF-4150-A464-B0D3EE93B636}']
    procedure AplicarQuery(AQuery: TFDMemTable);
    procedure Consultar;
    procedure ConsultarPorID(const AId: Integer);
    procedure SalvarDados;
    procedure ExcluirRegistro(const AId: Integer);
  end;

implementation

end.

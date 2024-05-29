unit fSimulaVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Comp.Client;

type
  TfmSimulaVenda = class(TForm)
    mnDadosVenda: TMemo;
    pnRodape: TPanel;
    btnVoltar: TButton;
    procedure btnVoltarClick(Sender: TObject);
  private
    procedure CarregarDadosSimulacaoVenda(AqryPedido, AqryItens: TFdMemTable; const AtextoCondicao: string; const ApercentCondPgo: Integer);
    function SomarPercentual(const AValor: Currency; const APercentual: Integer): Currency;
  public
    class procedure AbrirVenda(AqryPedido, AqryItens: TFdMemTable; const AtextoCondicao: string; const ApercentCondPgo: Integer);
  end;

implementation

uses
  uGeradorTexto.SimuladorVenda;

{$R *.dfm}

class procedure TfmSimulaVenda.AbrirVenda(AqryPedido, AqryItens: TFdMemTable; const AtextoCondicao: string; const ApercentCondPgo: Integer);
var
  fmSimulaVenda: TfmSimulaVenda;
begin
  fmSimulaVenda := TfmSimulaVenda.Create(nil);
  try
    fmSimulaVenda.CarregarDadosSimulacaoVenda(AqryPedido, AqryItens, AtextoCondicao, ApercentCondPgo);
    fmSimulaVenda.ShowModal;
  finally
    fmSimulaVenda.Free;
  end;
end;

procedure TfmSimulaVenda.btnVoltarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TfmSimulaVenda.SomarPercentual(const AValor: Currency; const APercentual: Integer): Currency;
begin
  if (APercentual = 0) or (AValor = 0) then
    Exit(AValor);

  Result := AValor + (AValor * APercentual) / 100;
end;

procedure TfmSimulaVenda.CarregarDadosSimulacaoVenda(AqryPedido, AqryItens: TFdMemTable; const AtextoCondicao: string; const ApercentCondPgo: Integer);
var
  geradorTextoSimuladorVenda: TGeradorTextoSimuladorVenda;
  listaProdutos: TListaProdutoInfo;
  infoProduto: TProdutoInfo;
begin
  geradorTextoSimuladorVenda := TGeradorTextoSimuladorVenda.Create;
  try
    geradorTextoSimuladorVenda.NroPedido := AqryPedido.FieldByName('NroPedido').AsInteger;
    geradorTextoSimuladorVenda.NomeCliente := AqryPedido.FieldByName('Cliente').AsString;
    geradorTextoSimuladorVenda.Endereco := AqryPedido.FieldByName('Endereco').AsString;
    geradorTextoSimuladorVenda.NomeCidade := AqryPedido.FieldByName('Cidade').AsString;
    geradorTextoSimuladorVenda.UF := AqryPedido.FieldByName('UF').AsString;
    geradorTextoSimuladorVenda.textoCondicao := AtextoCondicao;
    geradorTextoSimuladorVenda.Valor := 0;

    SetLength(listaProdutos, AqryItens.RecordCount);
    AqryItens.First;
    while not AqryItens.Eof do
    begin
      infoProduto.Nome := AqryItens.FieldByName('Produto').AsString;
      infoProduto.Quantidade := AqryItens.FieldByName('Quantidade').AsInteger;
      infoProduto.ValorUnitario := SomarPercentual(AqryItens.FieldByName('ValorUnitario').AsCurrency, ApercentCondPgo);
      infoProduto.ValorTotal := infoProduto.Quantidade * infoProduto.ValorUnitario;
      geradorTextoSimuladorVenda.Valor := geradorTextoSimuladorVenda.Valor + infoProduto.ValorTotal;
      listaProdutos[AqryItens.RecNo-1] := infoProduto;
      AqryItens.Next;
    end;

    geradorTextoSimuladorVenda.ListaProdutos := listaProdutos;
    geradorTextoSimuladorVenda.EscreverDados(mnDadosVenda.Lines);
  finally
    geradorTextoSimuladorVenda.Free;
  end;
end;

end.

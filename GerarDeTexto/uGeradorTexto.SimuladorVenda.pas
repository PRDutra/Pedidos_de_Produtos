unit uGeradorTexto.SimuladorVenda;

interface

uses
  Classes;

type
  TProdutoInfo = record
    Nome: string;
    Quantidade: Integer;
    ValorUnitario: Currency;
    ValorTotal: Currency;
  end;
  TListaProdutoInfo = TArray<TProdutoInfo>;
  TGeradorTextoSimuladorVenda = class
  private
    FNomeCliente: string;
    FUF: string;
    FNroPedido: Integer;
    FNomeCidade: string;
    FEndereco: string;
    FListaProdutos: TListaProdutoInfo;
    FValor: Currency;
    FTextoCondicao: string;
    procedure SetEndereco(const Value: string);
    procedure SetListaProdutos(const Value: TListaProdutoInfo);
    procedure SetNomeCidade(const Value: string);
    procedure SetNomeCliente(const Value: string);
    procedure SetNroPedido(const Value: Integer);
    procedure SetUF(const Value: string);
    procedure SetValor(const Value: Currency);
    procedure SetTextoCondicao(const Value: string);
  public
    property NroPedido: Integer read FNroPedido write SetNroPedido;
    property NomeCliente: string read FNomeCliente write SetNomeCliente;
    property Endereco: string read FEndereco write SetEndereco;
    property NomeCidade: string read FNomeCidade write SetNomeCidade;
    property UF: string read FUF write SetUF;
    property Valor: Currency read FValor write SetValor;
    property TextoCondicao: string read FTextoCondicao write SetTextoCondicao;
    property ListaProdutos: TListaProdutoInfo read FListaProdutos write SetListaProdutos;
    procedure EscreverDados(ALinhas: TStrings);
  end;

implementation

uses
  SysUtils;

{ TGeradorTextoSimuladorVenda }

procedure TGeradorTextoSimuladorVenda.EscreverDados(ALinhas: TStrings);
var
  item: TProdutoInfo;
  linhaSeparador: string;
begin
  ALinhas.Clear;

  linhaSeparador := ''.PadLeft(100, '-');

  ALinhas.Add(linhaSeparador);
  ALinhas.Add(Format('Venda : %d', [NroPedido]));
  ALinhas.Add(Format('Cliente : %s', [NomeCliente]));
  ALinhas.Add(Format('Endereço : %s', [Endereco]));
  ALinhas.Add(Format('Cidade/UF : %s - %s', [NomeCidade, UF]));

  ALinhas.Add(linhaSeparador);
  ALinhas.Add('Produto'.PadRight(50) +
              'Quantidade'.PadLeft(15) +
              'Unitário'.PadLeft(15) +
              'Total'.PadLeft(20));
  ALinhas.Add(linhaSeparador);

  for item in ListaProdutos do
  begin
    ALinhas.Add( item.Nome.PadRight(50) +
                 item.Quantidade.ToString.PadLeft(15) +
                 item.ValorUnitario.ToString.PadLeft(15) +
                 item.ValorTotal.ToString.PadLeft(20)
    );
  end;

  ALinhas.Add(linhaSeparador);
  ALinhas.Add(Format('Total : %f', [Valor]));
  ALinhas.Add(linhaSeparador);
  ALinhas.Add(TextoCondicao);
  ALinhas.Add(linhaSeparador);
end;

procedure TGeradorTextoSimuladorVenda.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetListaProdutos(const Value: TListaProdutoInfo);
begin
  FListaProdutos := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetNomeCidade(const Value: string);
begin
  FNomeCidade := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetNomeCliente(const Value: string);
begin
  FNomeCliente := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetNroPedido(const Value: Integer);
begin
  FNroPedido := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetTextoCondicao(const Value: string);
begin
  FTextoCondicao := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TGeradorTextoSimuladorVenda.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.

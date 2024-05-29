unit fmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Samples.Spin, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TformMain = class(TForm)
    DBGrid1: TDBGrid;
    lbTitulo: TLabel;
    rbImpressaoVenda: TGroupBox;
    rbCondVenda: TRadioGroup;
    pnDireita: TPanel;
    gbCondPersonalizada: TGroupBox;
    lbPercent: TLabel;
    edtPercentVenda: TSpinEdit;
    btnSimularVenda: TButton;
    dsVenda: TDataSource;
    qryVenda: TFDMemTable;
    pnBotoes: TPanel;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    qryVendaNroPedido: TIntegerField;
    qryVendaCliente: TStringField;
    qryVendaEndereco: TStringField;
    qryVendaCidade: TStringField;
    qryVendaUF: TStringField;
    qryVendaValor: TCurrencyField;
    qryVendaUltimoID: TAggregateField;
    qryItens: TFDMemTable;
    qryItensNroPedido: TIntegerField;
    qryItensProduto: TStringField;
    qryItensQuantidade: TIntegerField;
    qryItensValorUnitario: TCurrencyField;
    qryItensValorTotal: TCurrencyField;
    qryItensTotalItens: TAggregateField;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure rbCondVendaClick(Sender: TObject);
    procedure btnSimularVendaClick(Sender: TObject);
  private
    function RetornarTextoCondPgto: string;
    function RetornarPercentCondPgto: Integer;
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

uses
  fCadastroPedido, uConsultas.Helper.Query, fSimulaVenda, StrUtils;

{$R *.dfm}

procedure TformMain.btnEditarClick(Sender: TObject);
begin
  if TfmCadastroPedido.EditarPedido(qryVendaNroPedido.AsInteger) then
    qryVenda.Pedido.Consultar;
end;

procedure TformMain.btnExcluirClick(Sender: TObject);
var
  nroPedido: Integer;
begin
  if Application.MessageBox('Deseja excluir o registro?', 'Atenção', MB_ICONQUESTION+MB_YESNO) = mrYes then
  begin
    nroPedido := qryVendaNroPedido.AsInteger;
    qryItens.ItensPedido.ConsultarPorID(nroPedido);
    qryItens.ItensPedido.ExcluirRegistro(nroPedido);
    qryVenda.Pedido.ExcluirRegistro(nroPedido);
  end;
end;

procedure TformMain.btnNovoClick(Sender: TObject);
begin
  if TfmCadastroPedido.AbrirNovoPedido(qryVendaUltimoID.Value) then
    qryVenda.Pedido.Consultar;
end;

function TformMain.RetornarTextoCondPgto: string;
begin
  case rbCondVenda.ItemIndex of
   -1,0,1,2,4,5: Result := rbCondVenda.Items[rbCondVenda.ItemIndex];
    3,6: Result := StringReplace(rbCondVenda.Items[rbCondVenda.ItemIndex], 'Informar ', edtPercentVenda.Value.ToString, []);
  end;
end;

function TformMain.RetornarPercentCondPgto: Integer;
begin
  case rbCondVenda.ItemIndex of
   -1,
    0: Result := 0;
    1: Result := -05;
    2: Result := -10;
    3: Result := (edtPercentVenda.Value*-1);
    4: Result := 10;
    5: Result := 12;
    6: Result := edtPercentVenda.Value;
  end;
end;

procedure TformMain.btnSimularVendaClick(Sender: TObject);
begin
  if edtPercentVenda.Enabled and (edtPercentVenda.Value = 0) then
    rbCondVenda.ItemIndex := 0;

  qryItens.ItensPedido.ConsultarPorID(qryVendaNroPedido.AsInteger);
  TfmSimulaVenda.AbrirVenda(qryVenda, qryItens, RetornarTextoCondPgto, RetornarPercentCondPgto);
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  qryVenda.Pedido.Consultar;
end;

procedure TformMain.rbCondVendaClick(Sender: TObject);
begin
  edtPercentVenda.Enabled := rbCondVenda.ItemIndex in [3,6];
  if not edtPercentVenda.Enabled then
    edtPercentVenda.Text := '0';
end;

end.

unit fCadastroPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TfmCadastroPedido = class(TForm)
    lbTitulo: TLabel;
    pndadosBasicos: TPanel;
    edtNroPedido: TDBEdit;
    edtNomeCliente: TDBEdit;
    edtRua: TDBEdit;
    edtNomeCidade: TDBEdit;
    edtUF: TDBEdit;
    lbNroPedido: TLabel;
    lbNomeCliente: TLabel;
    lbEndereco: TLabel;
    lbCidade: TLabel;
    lbUF: TLabel;
    qryPedido: TFDMemTable;
    qryPedidoNroPedido: TIntegerField;
    qryPedidoCliente: TStringField;
    qryPedidoEndereco: TStringField;
    qryPedidoCidade: TStringField;
    qryPedidoUF: TStringField;
    qryPedidoValor: TCurrencyField;
    dsPedido: TDataSource;
    qryItens: TFDMemTable;
    dsItens: TDataSource;
    gridItens: TDBGrid;
    lbTituloGrid: TLabel;
    qryItensProduto: TStringField;
    qryItensQuantidade: TIntegerField;
    qryItensValorUnitario: TCurrencyField;
    qryItensValorTotal: TCurrencyField;
    pnTotal: TPanel;
    lbTotal: TLabel;
    edtTotalProdutos: TDBEdit;
    lbItem: TPanel;
    lbTituloItem: TLabel;
    edtProduto: TDbEdit;
    edtQtd: TDbEdit;
    edtValorUnit: TDbEdit;
    lbProduto: TLabel;
    qryItensTotalItens: TAggregateField;
    lbQuantidade: TLabel;
    lbVlUnitItem: TLabel;
    dbNavegador: TDBNavigator;
    btnGravarPedido: TButton;
    btnCancelarPedido: TButton;
    qryItensNroPedido: TIntegerField;
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure qryItensCalcFields(DataSet: TDataSet);
    procedure edtUFKeyPress(Sender: TObject; var Key: Char);
    procedure qryPedidoAfterPost(DataSet: TDataSet);
    procedure qryItensAfterPost(DataSet: TDataSet);
    procedure qryItensBeforePost(DataSet: TDataSet);
    procedure edtValorUnitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtValorUnitKeyPress(Sender: TObject; var Key: Char);
    procedure qryItensValorUnitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    FEdicaoPedido: Boolean;
    FEdicaoItens: Boolean;
    FCarregandoDados: Boolean;
    procedure CarregarPorNroPedido(const ANroPedido: Integer);
  public
    class function AbrirNovoPedido(const AUtiloID: Variant): Boolean;
    class function EditarPedido(const ANroPedido: Integer): Boolean;
  end;


implementation

uses
  uConsultas.Helper.Query, Math, uMensagem, uValidarMunicipio;

{$R *.dfm}

class function TfmCadastroPedido.AbrirNovoPedido(const AUtiloID: Variant): Boolean;
var
  fmCadastroPedido: TfmCadastroPedido;
begin
  fmCadastroPedido := TfmCadastroPedido.Create(Application.MainForm);
  try
    fmCadastroPedido.FCarregandoDados := True;
    fmCadastroPedido.qryPedido.Open;
    fmCadastroPedido.qryPedido.Append;
    fmCadastroPedido.qryItens.Open;
    fmCadastroPedido.qryPedidoNroPedido.AsInteger := StrToIntDef(VarToStrDef(AUtiloID, '0'), 0) + 1;
    fmCadastroPedido.FCarregandoDados := False;
    Result := fmCadastroPedido.ShowModal = mrOk;
  finally
    fmCadastroPedido.Free;
  end;
end;

procedure TfmCadastroPedido.btnCancelarPedidoClick(Sender: TObject);
begin
  if qryPedido.State in dsEditModes then
    qryPedido.Cancel;
  ModalResult := mrCancel;
end;

procedure TfmCadastroPedido.btnGravarPedidoClick(Sender: TObject);
var
  totalProdutos: Currency;
begin
  if qryItens.State in dsEditModes then
    qryItens.Post;

  if qryPedido.State in dsEditModes then
    qryPedido.Post;

  if FEdicaoPedido or FEdicaoItens then
  begin
    totalProdutos := StrToCurrDef(VarToStrDef(qryItensTotalItens.Value, '0'), 0);

    if Trunc(totalProdutos*100) <> Trunc(qryPedidoValor.AsCurrency*100) then
    begin
      qryPedido.Edit;
      qryPedidoValor.AsCurrency := totalProdutos;
      qryPedido.Post;
    end;
  end;

  if not FEdicaoPedido and not FEdicaoItens then
  begin
    Application.MessageBox('Não existem alterações no pedido para salvar', 'Informação', MB_ICONINFORMATION);
    Exit;
  end;

  if Trim(edtNomeCliente.Text) = '' then
  begin
    Application.MessageBox('Digite o nome do cliente', 'Atenção', MB_ICONQUESTION);
    edtNomeCliente.SetFocus;
    Exit;
  end;

  TfmMensagem.Apresentar(Self);
  try
    if not ValidarMunicipio.ValidarMunicipio(edtNomeCidade.Text, edtUF.Text) then
    begin
      TfmMensagem.FecharMsg;
      if Application.MessageBox('Cidade/UF Inválida, deseja continuar?', 'Atenção', MB_ICONQUESTION+MB_YESNO) = mrNo then
        Exit;
    end;
  finally
    TfmMensagem.FecharMsg;
  end;

  if FEdicaoPedido then
    qryPedido.Pedido.SalvarDados;

  if FEdicaoItens then
    qryItens.ItensPedido.SalvarDados;

  ModalResult := mrOk;
end;

procedure TfmCadastroPedido.CarregarPorNroPedido(const ANroPedido: Integer);
begin
  qryPedido.Pedido.ConsultarPorID(ANroPedido);
  qryItens.ItensPedido.ConsultarPorID(ANroPedido);
end;

class function TfmCadastroPedido.EditarPedido(const ANroPedido: Integer): Boolean;
var
  fmCadastroPedido: TfmCadastroPedido;
begin
  fmCadastroPedido := TfmCadastroPedido.Create(Application.MainForm);
  try
    fmCadastroPedido.FCarregandoDados := True;
    fmCadastroPedido.CarregarPorNroPedido(ANroPedido);
    fmCadastroPedido.FCarregandoDados := False;
    Result := fmCadastroPedido.ShowModal = mrOk;
  finally
    fmCadastroPedido.Free;
  end;
end;

procedure TfmCadastroPedido.edtUFKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Char(ifthen(CharInSet(UpCase(Key), ['A'..'Z', #8]), Ord(UpCase(Key)), 0));
end;

procedure TfmCadastroPedido.edtValorUnitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN)and(qryItens.State in dsEditModes) then
  begin
    qryItens.Post;
    edtProduto.SetFocus;
    qryItens.Append;
    Key := 0;
  end;
end;

procedure TfmCadastroPedido.edtValorUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(VK_RETURN)) then
    Key := #0;
end;

procedure TfmCadastroPedido.qryItensAfterPost(DataSet: TDataSet);
begin
  if not FCarregandoDados then
    FEdicaoItens := True;
end;

procedure TfmCadastroPedido.qryItensBeforePost(DataSet: TDataSet);
begin
  if FCarregandoDados then
    Exit;

  if DataSet.FieldByName('Produto').AsString.Trim.IsEmpty then
  begin
    Application.MessageBox('Nome do produto não informado!', 'Atenção', MB_ICONWARNING);
    edtProduto.SetFocus;
    Abort;
  end;

  if (DataSet.FieldByName('Quantidade').IsNull) or
     (DataSet.FieldByName('Quantidade').AsInteger = 0) then
  begin
    DataSet.FieldByName('Quantidade').AsInteger := 0;
    DataSet.FieldByName('ValorTotal').AsCurrency := 0;
  end;

  DataSet.FieldByName('NroPedido').AsInteger := qryPedidoNroPedido.AsInteger;
end;

procedure TfmCadastroPedido.qryItensCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('ValorTotal').AsCurrency :=
    DataSet.FieldByName('Quantidade').AsInteger *
    DataSet.FieldByName('ValorUnitario').AsCurrency;
end;

procedure TfmCadastroPedido.qryItensValorUnitarioGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsCurrency = 0 then
    Text := 'R$ 0,00'
  else
    Text := FormatCurr('R$ 0.00#,##', Sender.AsCurrency);
end;

procedure TfmCadastroPedido.qryPedidoAfterPost(DataSet: TDataSet);
begin
  if not FCarregandoDados then
    FEdicaoPedido := True;
end;

end.

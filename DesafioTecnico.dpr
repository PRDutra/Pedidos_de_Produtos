program DesafioTecnico;

uses
  Vcl.Forms,
  fmMain in 'src\fmMain.pas' {formMain},
  fCadastroPedido in 'src\fCadastroPedido.pas' {fmCadastroPedido},
  uManipulacao.XML.Carregar in 'ManipulacaoXML\uManipulacao.XML.Carregar.pas',
  uConst.Informacao.Sistema in 'Constantes\uConst.Informacao.Sistema.pas',
  uConsultas.Helper.Query in 'Consultas\uConsultas.Helper.Query.pas',
  uInterface.Consultas in 'Interface\uInterface.Consultas.pas',
  uConsultas.Pedido in 'Consultas\uConsultas.Pedido.pas',
  uConsultas.ItensPedido in 'Consultas\uConsultas.ItensPedido.pas',
  uManipulacao.XML.Salvar in 'ManipulacaoXML\uManipulacao.XML.Salvar.pas',
  uManipulacao.XML.Deletar in 'ManipulacaoXML\uManipulacao.XML.Deletar.pas',
  fSimulaVenda in 'src\fSimulaVenda.pas' {fmSimulaVenda},
  uGeradorTexto.SimuladorVenda in 'GerarDeTexto\uGeradorTexto.SimuladorVenda.pas',
  uMensagem in 'src\uMensagem.pas' {fmMensagem};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.

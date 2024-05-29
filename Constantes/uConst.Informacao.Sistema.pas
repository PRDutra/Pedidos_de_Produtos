unit uConst.Informacao.Sistema;

interface

uses
  SysUtils;

const
  CONST_INFORMACAO_SISTEMA_NOME_DB = 'basepedidos.xml';
  CONST_INFORMACAO_SISTEMA_PEDIDO_NOME_DB = 'baseitenspedidos.xml';

type
  TConstInformacaoSistema = class
  private
    class function RetornaDiretorio: string;
  public
    class function CaminhoCompletoItensPedidoDB: string;
    class function CaminhoCompletoPedidoDB: string;
  end;

implementation

uses
  IOUtils;

{ TConstInformacaoSistema }

class function TConstInformacaoSistema.CaminhoCompletoPedidoDB: string;
begin
  Result := TPath.Combine(RetornaDiretorio, CONST_INFORMACAO_SISTEMA_NOME_DB);
end;

class function TConstInformacaoSistema.RetornaDiretorio: string;
begin
  Result := TPath.GetDirectoryName(ParamStr(0));
end;

class function TConstInformacaoSistema.CaminhoCompletoItensPedidoDB: string;
begin
  Result := TPath.Combine(RetornaDiretorio, CONST_INFORMACAO_SISTEMA_PEDIDO_NOME_DB);
end;

end.

unit uValidarMunicipio;

interface

uses
  REST.Json, System.Json;

type
  TCidadeInfo = record
    NomeCidade: string;
    UF: string;
  end;
  TValidarMunicipio = class
  private
    FListaCidadeInfo: TArray<TCidadeInfo>;
    procedure ConsultarMunicipios;
    constructor Create;
  public
    function ValidarMunicipio(const ANome, AUF: string): Boolean;
  end;

var
  ValidarMunicipio: TValidarMunicipio;

implementation

uses
  IdHTTP, Classes, SysUtils, IdSSLOpenSSL, IdSSL, Vcl.Forms;

const
  LINK_BUSCA_MUNICIPIOS = 'https://servicodados.ibge.gov.br/api/v1/localidades/municipios';

{ TValidarMunicipio }

procedure TValidarMunicipio.ConsultarMunicipios;
var
  idHttp: TIdHTTP;
  dataString: TStringStream;
  jsonObject: TJSONValue;
  listaMunicipios: TJSONArray;
  recItem: Integer;
  jsonValue: TJSONValue;
  nomeMunicipio: string;
  ufMunicipio: string;
begin
  if Length(FListaCidadeInfo) > 0 then
    Exit;
  try
    idHttp := TIdHTTP.Create(Nil);
    try
      dataString := TStringStream.Create('', TEncoding.UTF8);
      try
        idHttp.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(idHttp);
        TIdSSLIOHandlerSocketOpenSSL(idHttp.IOHandler).SSLOptions.Method := sslvTLSv1_2;
        TIdSSLIOHandlerSocketOpenSSL(idHttp.IOHandler).SSLOptions.SSLVersions := [sslvTLSv1_2];

        idHttp.Get(LINK_BUSCA_MUNICIPIOS, dataString);
        jsonObject := TJSONObject.ParseJSONValue(dataString.DataString);

        if not Assigned(jsonObject) or (not(jsonObject is TJSONArray)) then
          Exit;

        listaMunicipios := TJSONArray(jsonObject);
        SetLength(FListaCidadeInfo, listaMunicipios.Count);

        for recItem := 0 to listaMunicipios.Count-1 do
        begin
          jsonValue := listaMunicipios.Items[recItem];
          if jsonValue.TryGetValue<string>('nome', nomeMunicipio) and not nomeMunicipio.Trim.IsEmpty then
          begin
            if jsonValue.TryGetValue<TJSONValue>('microrregiao', jsonValue) and
               jsonValue.TryGetValue<TJSONValue>('mesorregiao', jsonValue) and
               jsonValue.TryGetValue<TJSONValue>('UF', jsonValue) and
               jsonValue.TryGetValue<string>('sigla', ufMunicipio) and
               not ufMunicipio.Trim.IsEmpty then
            begin
              FListaCidadeInfo[recItem].NomeCidade := nomeMunicipio;
              FListaCidadeInfo[recItem].UF := ufMunicipio;
            end;
          end;
        end;
      finally
        dataString.Free;
      end;
    finally
      idHttp.Free;
    end
  except
    Application.MessageBox('Não foi possível validar o nome da cidade!', 'Atenção', 0);
  end;
end;

constructor TValidarMunicipio.Create;
begin
  SetLength(FListaCidadeInfo, 0)
end;

function TValidarMunicipio.ValidarMunicipio(const ANome, AUF: string): Boolean;
var
  recItem: Integer;
begin
  ConsultarMunicipios;
  Result := False;

  if Length(FListaCidadeInfo) = 0 then
    Exit(True);

  for recItem := 0 to Length(FListaCidadeInfo)-1 do
  begin
    if SameText(FListaCidadeInfo[recItem].NomeCidade, ANome) and
       SameText(FListaCidadeInfo[recItem].UF, AUF) then
      Exit(True);
  end;
end;

initialization
  ValidarMunicipio := TValidarMunicipio.Create;
finalization
  FreeAndNil(ValidarMunicipio);
end.

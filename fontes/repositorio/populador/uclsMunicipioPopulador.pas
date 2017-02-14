unit uclsMunicipioPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uMunicipio;

type
  TMunicipioPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TMunicipioPopulador }

class procedure TMunicipioPopulador.Initialize;
var
  vList_Municipio : TMunicipioList;

  procedure Adicionar(
    ACd_Municipio : Integer;
    ADs_Municipio : String;
    ADs_Sigla : String;
    ACd_Estado : Integer);
  begin
    with vList_Municipio.Add do begin
      Cd_Municipio := ACd_Municipio;
      U_Version := '';
      Cd_Operador := 0;
      Dt_Cadastro := Now;
      Ds_Municipio := ADs_Municipio;
      Ds_Sigla := ADs_Sigla;
      Cd_Estado := ACd_Estado;
    end;
  end;

begin
  vList_Municipio := TMunicipioList.Create(nil);

  Adicionar(4105508, 'CIANORTE', 'CTE', 41);

  AContexto.AddOrUpdate(vList_Municipio);
end;

end.

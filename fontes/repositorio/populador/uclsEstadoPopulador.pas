unit uclsEstadoPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uEstado;

type
  TEstadoPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TEstadoPopulador }

class procedure TEstadoPopulador.Initialize;
var
  vList_Estado : TEstadoList;

  procedure Adicionar(
    ACd_Estado : Integer;
    ADs_Estado : String;
    ADs_Sigla : String;
    ACd_Pais : Integer);
  begin
    with vList_Estado.Add do begin
      Cd_Estado := ACd_Estado;
      U_Version := '';
      Cd_Operador := 0;
      Dt_Cadastro := Now;
      Ds_Estado := ADs_Estado;
      Ds_Sigla := ADs_Sigla;
      Cd_Pais := ACd_Pais;
    end;
  end;

begin
  vList_Estado := TEstadoList.Create(nil);

  Adicionar(41, 'PARANA', 'PR', 1058);

  AContexto.AddOrUpdate(vList_Estado);
end;

end.

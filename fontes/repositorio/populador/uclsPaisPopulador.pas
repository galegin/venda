unit uclsPaisPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uPais;

type
  TPaisPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TPaisPopulador }

class procedure TPaisPopulador.Initialize;
var
  vList_Pais : TPaisList;

  procedure Adicionar(
    ACd_Pais : Integer;
    ADs_Pais : String;
    ADs_Sigla : String);
  begin
    with vList_Pais.Add do begin
      Cd_Pais := ACd_Pais;
      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;
      Ds_Pais := ADs_Pais;
      Ds_Sigla := ADs_Sigla;
    end;
  end;

begin
  vList_Pais := TPaisList.Create(nil);

  Adicionar(1058, 'BRASIL', 'BRA');

  AContexto.AddOrUpdate(vList_Pais);
end;

end.

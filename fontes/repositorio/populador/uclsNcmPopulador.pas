unit uclsNcmPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uNcm;

type
  TNcmPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TNcmPopulador }

class procedure TNcmPopulador.Initialize;
var
  vList_Ncm : TNcmList;

  procedure Adicionar(
    ACd_Ncm : String;
    ADs_Ncm : String);
  begin
    with vList_Ncm.Add do begin
      Cd_Ncm := ACd_Ncm;
      U_Version := '';
      Cd_Operador := 0;
      Dt_Cadastro := Now;
      Ds_Ncm := ADs_Ncm;
    end;
  end;

begin
  vList_Ncm := TNcmList.Create(nil);

  Adicionar('61130000', 'VESTUARIO CONFECC. DE TECIDOS MALHA C/PLASTICO/BORACHA');

  AContexto.AddOrUpdate(vList_Ncm);
end;

end.

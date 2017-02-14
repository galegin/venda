unit uclsAliqicmsPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uAliqicms;

type
  TAliqicmsPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TAliqicmsPopulador }

class procedure TAliqicmsPopulador.Initialize;
var
  vList_Aliqicms : TAliqicmsList;

  procedure Adicionar(
    AUf_Origem : String;
    AUf_Destino : String;
    APr_Aliquota : Real);
  begin
    with vList_Aliqicms.Add do begin
      Uf_Origem := AUf_Origem;
      Uf_Destino := AUf_Destino;
      U_Version := '';
      Cd_Operador := 0;
      Dt_Cadastro := Now;
      Pr_Aliquota := APr_Aliquota;
    end;
  end;

begin
  vList_Aliqicms := TAliqicmsList.Create(nil);

  Adicionar('PR', 'PR', 17);

  AContexto.AddOrUpdate(vList_Aliqicms);
end;

end.

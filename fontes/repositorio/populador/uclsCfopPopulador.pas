unit uclsCfopPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uCfop;

type
  TCfopPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TCfopPopulador }

class procedure TCfopPopulador.Initialize;
var
  vList_Cfop : TCfopList;

  procedure Adicionar(
    ACd_Cfop : Integer;
    ADs_Cfop : String);
  begin
    with vList_Cfop.Add do begin
      Cd_Cfop := ACd_Cfop;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Ds_Cfop := ADs_Cfop;
    end;
  end;

begin
  vList_Cfop := TCfopList.Create(nil);

  Adicionar(1101, 'COMPRA PARA INDUSTRIALIZACAO');
  Adicionar(1102, 'COMPRA PARA COMERCIALIZACAO');
  Adicionar(1201, 'DEVOLUCAO DE VENDA DE PRODUCAO');
  Adicionar(1202, 'DEVOLUCAO DE VENDA DE MERCADORIA');
  Adicionar(5101, 'VENDA DE PRODUCAO');
  Adicionar(5102, 'VENDA DE MERCADORIA');
  Adicionar(6101, 'VENDA DE PRODUCAO');
  Adicionar(6102, 'VENDA DE MERCADORIA');

  AContexto.AddOrUpdate(vList_Cfop);
end;

end.

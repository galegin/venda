unit uclsRegrafiscalPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uRegrafiscal, uRegrafiscalImposto;

type
  TRegrafiscalPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

uses
  mCollectionItem;

{ TRegrafiscalPopulador }

class procedure TRegrafiscalPopulador.Initialize;
var
  vList_Regrafiscal : TRegrafiscalList;
  vList_Imposto : TRegrafiscalImpostoList;

  procedure Adicionar(
    ACd_Regrafiscal : Integer;
    ADs_Regrafiscal : String;
    AIn_CalcImposto : Boolean);
  begin
    with vList_Regrafiscal.Add do begin
      Cd_Regrafiscal := ACd_Regrafiscal;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Ds_Regrafiscal := ADs_Regrafiscal;
      In_Calcimposto := AIn_CalcImposto;
    end;
  end;

  procedure AdicionarImposto(
    ACd_Regrafiscal : Integer;
    ACd_Imposto : Integer;
    APr_Aliquota: Real;
    APr_Basecalculo: Real;
    ACd_Cst: String;
    ACd_Csosn: String;
    AIn_Isento: Boolean;
    AIn_Outro: Boolean);
  begin
    with vList_Imposto.Add do begin
      Cd_Regrafiscal := ACd_Regrafiscal;
      Cd_Imposto := ACd_Imposto;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Pr_Aliquota := APr_Aliquota;
      Pr_Basecalculo := APr_Basecalculo;
      Cd_Cst := ACd_Cst;
      Cd_Csosn := ACd_Csosn;
      In_Isento := AIn_Isento;
      In_Outro := AIn_Outro;
    end;
  end;

begin
  vList_Regrafiscal := TRegrafiscalList.Create(nil);
  vList_Imposto := TRegrafiscalimpostoList.Create(nil);

  Adicionar(1, 'DEVOLUCAO', True);
  AdicionarImposto(1, 1, 18, 100, '0', '', False, False);

  Adicionar(2, 'VENDA', True);
  AdicionarImposto(2, 1, 18, 100, '0', '', False, False);

  AContexto.AddOrUpdate(vList_Regrafiscal);
  AContexto.AddOrUpdate(vList_Imposto);
end;

end.

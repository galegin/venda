unit uclsOperacaoPopulador;

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, uOperacao, uTipoModalidade;

type
  TOperacaoPopulador = class(TComponent)
  public
    class procedure Initialize(AContexto : TmContexto);
  end;

implementation

{ TOperacaoPopulador }

class procedure TOperacaoPopulador.Initialize;
var
  vList_Operacao : TOperacaoList;

  procedure Adicionar(
    ACd_Operacao : String;
    ADs_Operacao : String;
    ATp_Docfiscal : Integer;
    ATp_Modalidade : Integer;
    ATp_Operacao : Integer;
    ACd_Serie : String;
    ACd_Regrafiscal : Integer;
    ACd_Cfop : Integer);
  begin
    with vList_Operacao.Add do begin
      Cd_Operacao := ACd_Operacao;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Ds_Operacao := ADs_Operacao;
      Tp_Docfiscal := ATp_Docfiscal;
      Tp_Modalidade := ATp_Modalidade;
      Tp_Operacao := ATp_Operacao;
      Cd_Serie := ACd_Serie;
      Cd_Regrafiscal := ACd_Regrafiscal;
      Cd_Cfop := ACd_Cfop;
    end;
  end;

begin
  vList_Operacao := TOperacaoList.Create(nil);

  Adicionar('DEVOLUCAO_NFE', 'DEVOLUCAO NFE', 55, 1, 0, '1'  , 1, 1201);
  Adicionar('VENDA_ECF'    , 'VENDA ECF'    , 71, 2, 1, 'ECF', 2, 6101);
  Adicionar('VENDA_MANUAL' , 'VENDA MANUAL' , 01, 3, 1, '1'  , 2, 6101);
  Adicionar('VENDA_NFCE'   , 'VENDA NFC-E'  , 65, 4, 1, '1'  , 2, 6101);
  Adicionar('VENDA_NFE'    , 'VENDA NF-E'   , 55, 5, 1, '1'  , 2, 6101);
  Adicionar('VENDA_SAT'    , 'VENDA ECF'    , 59, 6, 1, '1'  , 2, 6101);

  AContexto.AddOrUpdate(vList_Operacao);
end;

end.

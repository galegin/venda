unit uclsContingenciaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  pcnConversao, pcnConversaoNFe,
  mException, mInternet, mFilter,
  uTipoProcessamento, uTipoRetornoSefaz, uTransfiscal, uTransacao;

type
  TTipoContingencia = (tpcSemContingencia, tpcContingencia);

  TcContingenciaServico = class(TComponent)
  private
    fObj_Fiscal : TTransfiscal;
    fTipoEmissao : TpcnTipoEmissao;
    fModeloDF : TpcnModeloDF;
    fTipoRetorno : RTipoRetornoSefaz;
    function GetTipo: TTipoContingencia;
  public
    constructor Create(AOwner : TComponent); override;
    procedure EnviarPendente;
  published
    property TipoEmissao : TpcnTipoEmissao read fTipoEmissao write fTipoEmissao;
    property ModeloDF : TpcnModeloDF read fModeloDF write fModeloDF;
    property TipoRetorno : RTipoRetornoSefaz read fTipoRetorno write fTipoRetorno;
    property Tipo : TTipoContingencia read GetTipo;
  end;

  function Instance : TcContingenciaServico;

implementation

uses
  uclsDFeServico;

var
  _instance : TcContingenciaServico;

  function Instance : TcContingenciaServico;
  begin
    if not Assigned(_instance) then
      _instance := TcContingenciaServico.Create(nil);
    Result := _instance;
  end;

{ TcContingenciaServico }

constructor TcContingenciaServico.Create(AOwner: TComponent);
begin
  inherited;
  fObj_Fiscal := TTransfiscal.Create(nil);
end;

function TcContingenciaServico.GetTipo: TTipoContingencia;
begin
  Result := tpcSemContingencia;
  if not TmInternet.IsConectado() or (TipoRetorno.tStatus in [tsContingencia]) then
    if (fTipoEmissao in [teNormal]) and (fModeloDF in [moNFCe]) then
      Result := tpcContingencia;
end;

procedure TcContingenciaServico.EnviarPendente;
const
  cDS_METHOD = 'TcContingenciaServico.EnviarPendente';
var
  vObj_DFeServico : TcDFeServico;
  vLst_Filter : TmFilterList;
  vLst_Fiscal : TList;
  vDt_Emissao : TDateTime;
  I : Integer;
begin
  if not TmInternet.IsConectado() then
    Exit;

  vDt_Emissao := Date - 1;

  vLst_Filter := TmFilterList.Create;
  with vLst_Filter do begin
    Add(TmFilter.CreateS('Tp_Processamento', TipoProcessamentoToStr(tppGerada)));
    Add(TmFilter.CreateD('Dh_Emissao', tpfMaiorIgual, vDt_Emissao));
  end;

  fObj_Fiscal.Limpar();
  vLst_Fiscal := fObj_Fiscal.Listar(vLst_Filter);
  if not Assigned(vLst_Fiscal) or (vLst_Fiscal.Count = 0) then
    Exit;

  try
    vObj_DFeServico := TcDFeServico.Create(nil);

    try
      for I := 0 to vLst_Fiscal.Count - 1 do begin
        vObj_DFeServico.EmitirDFeContingencia(TTransfiscal(vLst_Fiscal));
        if vObj_DFeServico.cStat in [108, 109] then
          Break;
      end;
    except
      on E : Exception do
        raise TmException.Create(E.Message, cDS_METHOD);
    end;

    TipoRetorno := vObj_DFeServico.TipoRetorno;
    
  finally
    FreeAndNil(vObj_DFeServico);
    
  end;
end;

end.

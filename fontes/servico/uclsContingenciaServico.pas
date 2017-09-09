unit uclsContingenciaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  pcnConversao, pcnConversaoNFe,
  mException, mInternet,
  uTipoProcessamento, uTipoRetornoSefaz, uTransacao, uTransfiscal, uTranscont;

type
  TTipoContingencia = (tpcSemContingencia, tpcContingencia);

  TcContingenciaServico = class(TComponent)
  private
    fTipoEmissao : TpcnTipoEmissao;
    fModeloDF : TpcnModeloDF;
    fTipoRetorno : RTipoRetornoSefaz;
    function GetTipo: TTipoContingencia;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure EnviarPendente;
  published
    property TipoEmissao : TpcnTipoEmissao read fTipoEmissao write fTipoEmissao;
    property ModeloDF : TpcnModeloDF read fModeloDF write fModeloDF;
    property TipoRetorno : RTipoRetornoSefaz read fTipoRetorno write fTipoRetorno;
    property Tipo : TTipoContingencia read GetTipo;
  end;

  function Instance : TcContingenciaServico;
  procedure Destroy;

implementation

uses
  uclsDFeServico,
  mContexto;

var
  _instance : TcContingenciaServico;

  function Instance : TcContingenciaServico;
  begin
    if not Assigned(_instance) then
      _instance := TcContingenciaServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

{ TcContingenciaServico }

constructor TcContingenciaServico.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TcContingenciaServico.Destroy;
begin

  inherited;
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
  vDFeServico : TcDFeServico;
  vTranscont : TTranscont;
  vTransconts : TTransconts;
  vTransfiscal : TTransfiscal;
  vDtEmissao : TDateTime;
  vWhere : String;
  I : Integer;
begin
  if not TmInternet.IsConectado() then
    Exit;

  vDtEmissao := Date - 1;

  vWhere := 'Tp_Situacao = 1';

  vTransconts := mContexto.Instance.GetLista(TTranscont, vWhere, TTransconts) as TTransconts;
  if not Assigned(vTransconts) or (vTransconts.Count = 0) then
    Exit;

  try
    vDFeServico := TcDFeServico.Create(nil);

    try
      for I := 0 to vTransconts.Count - 1 do begin
        vTranscont := TTranscont(vTransconts.Items[I]);
        vWhere := 'Id_Transacao = ''' + vTranscont.Id_Transacao;
        vTransfiscal := mContexto.Instance.GetObjeto(TTransfiscal, vWhere) as TTransfiscal;
        vDFeServico.EmitirDFeContingencia(vTransfiscal);
        if vDFeServico.cStat in [108, 109] then
          Break;
      end;
    except
      on E : Exception do
        raise TmException.Create(cDS_METHOD, E.Message);
    end;

    TipoRetorno := vDFeServico.TipoRetorno;
    
  finally
    FreeAndNil(vDFeServico);
    
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

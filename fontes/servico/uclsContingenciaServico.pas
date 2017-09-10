unit uclsContingenciaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  pcnConversao, pcnConversaoNFe,
  mException, mInternet,
  uTipoProcessamento, uTipoRetornoSefaz, uTransacao, uTranscont;

type
  TcContingenciaServico = class(TComponent)
  private
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure EnviarPendente;
  published
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

procedure TcContingenciaServico.EnviarPendente;
const
  cDS_METHOD = 'TcContingenciaServico.EnviarPendente';
var
  vDFeServico : TcDFeServico;
  vTranscont : TTranscont;
  vTransconts : TTransconts;
  vTransacao : TTransacao;
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
        vTransacao := mContexto.Instance.GetObjeto(TTransacao, vWhere) as TTransacao;
        vDFeServico.EmitirDFeContingencia(vTransacao);
        if vDFeServico.cStat in [108, 109] then
          Break;
      end;
    except
      on E : Exception do
        raise TmException.Create(cDS_METHOD, E.Message);
    end;

  finally
    FreeAndNil(vDFeServico);
    
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

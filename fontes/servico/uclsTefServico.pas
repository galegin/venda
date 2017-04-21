unit uclsTefServico;

(* cTefServico *)

interface

uses
  Classes, SysUtils, StrUtils,
  ACBrTEFD, ACBrTEFDClass,
  uclsTransacaoTef;

type
  TcTefServico = class(TComponent)
  private
    fACBrTEFD : TACBrTEFD;
    fTipoTEF : TACBrTEFDTipo;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure GerenciadorAtivo; // ATV

    function RequisitarTransacaoTef(ARequisicao : TcTransacaoTefCrt) : TcTransacaoTefCtr_Ret; // CRT

    procedure ConfirmarPendente(ATransacao : TcTransacaoTefCnf); // CNF
    procedure CancelarPendente(ATransacao : TcTransacaoTefNcn); // NCN

    procedure CancelarAutorizada(ATransacao : TcTransacaoTefCnc); // CNC

    procedure ChamarAdministrativo; // ADM

    procedure ConsultarCheque(ATransacao : TcTransacaoTefChq); // CHQ
  published
  end;

  function Instance : TcTefServico;
  procedure Destroy;

implementation

var
  _instance : TcTefServico;

  function Instance : TcTefServico;
  begin
    if not Assigned(_instance) then
      _instance := TcTefServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cTefServico *)

constructor TcTefServico.Create(AOwner : TComponent);
begin
  inherited;

  fACBrTEFD := TACBrTEFD.Create(nil);

  fTipoTEF := gpTefDial;
end;

destructor TcTefServico.Destroy;
begin
  FreeAndNil(fACBrTEFD);

  inherited;
end;

//-- ATV

procedure TcTefServico.GerenciadorAtivo;
begin
  fACBrTEFD.ATV(fTipoTEF);
end;

//-- CRT

function TcTefServico.RequisitarTransacaoTef;
begin
  fACBrTEFD.CRT(
    ARequisicao.Valor,
    ARequisicao.IndiceFPG_ECF,
    ARequisicao.DocumentoVinculado,
    ARequisicao.Moeda);

  with Result do begin
    Rede := '';
    NSU := '';
    Finalizacao := '';
    DocumentoVinculado := '';
    DataHoraTransacao := 0;
    Valor := 0;
  end;
end;

//-- CNF

procedure TcTefServico.ConfirmarPendente;
begin
  fACBrTEFD.CNF(
    ATransacao.Rede,
    ATransacao.NSU,
    ATransacao.Finalizacao,
    ATransacao.DocumentoVinculado);

end;

//-- NCN

procedure TcTefServico.CancelarPendente;
begin
  fACBrTEFD.NCN(
    ATransacao.Rede,
    ATransacao.NSU,
    ATransacao.Finalizacao,
    ATransacao.Valor,
    ATransacao.DocumentoVinculado);

end;

//-- CNC

procedure TcTefServico.CancelarAutorizada;
begin
  fACBrTEFD.CNC(
    ATransacao.Rede,
    ATransacao.NSU,
    ATransacao.DataHoraTransacao,
    ATransacao.Valor);

end;

//-- ADM

procedure TcTefServico.ChamarAdministrativo;
begin
  fACBrTEFD.ADM(fTipoTEF);

end;

//-- CHQ

procedure TcTefServico.ConsultarCheque;
begin
  fACBrTEFD.CHQ(
    ATransacao.Valor,
    ATransacao.IndiceFPG_ECF,
    ATransacao.DocumentoVinculado,
    ATransacao.CMC7,
    ATransacao.TipoPessoa,
    ATransacao.DocumentoPessoa,
    ATransacao.DataCheque,
    ATransacao.Banco,
    ATransacao.Agencia,
    ATransacao.AgenciaDC,
    ATransacao.Conta,
    ATransacao.ContaDC,
    ATransacao.Cheque,
    ATransacao.ChequeDC,
    ATransacao.Compensacao);

end;

initialization
  //Instance();

finalization
  Destroy();

end.

unit uclsPagamentoServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uPagto, mSequence;

type
  TcPagamentoServico = class(TComponent)
  private
    fPagto : TPagto;
  protected
  public
    constructor Create(AOwner : TComponent); override;

    function Listar() : TPagtoList;

    procedure Limpar();

    procedure Buscar(
      ACd_Dnapagto: String);

    function NumerarCapa(
      ADt_Pagto: TDateTime) : Integer;

    procedure Salvar(
      ACd_Equip: String;
      ADt_Pagto: TDateTime;
      ANr_Pagto: Integer;
      AVl_Pagto: Real;
      AVl_Entrada: Real;
      AVl_Troco: Real;
      AVl_Variacao: Real);

    procedure Excluir(ACd_Dnapagto: String);

    procedure TotalizarCapa();

    function NumerarParcela() : Integer;
    
    procedure AdicionarParcela(
      ANr_Parcela: Integer;
      AVl_Parcela: Real;
      ATp_Docto: Integer;
      ANr_Docto: Integer;
      ADt_Vencto: TDateTime;
      ADs_Adicional: String = '';
      ACd_Dnabaixa: String = '');

  published
    property Pagto : TPagto read fPagto write fPagto;
  end;

  function Instance : TcPagamentoServico;

implementation

uses
  uPagtoparc, mMensagemLog;

var
  _instance : TcPagamentoServico;

  function Instance : TcPagamentoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcPagamentoServico.Create(nil);
    Result := _instance;
  end;

constructor TcPagamentoServico.Create(AOwner : TComponent);
begin
  inherited;
  fPagto := TPagto.Create(nil);
end;

function TcPagamentoServico.Listar;
begin
  Result := TPagtoList(fPagto.Listar(nil));
end;

procedure TcPagamentoServico.Limpar;
begin
  fPagto.Limpar();
end;

procedure TcPagamentoServico.Buscar;
begin
  fPagto.Limpar();
  if ACd_Dnapagto <> '' then begin
    fPagto.Cd_Dnapagto := ACd_Dnapagto;
    fPagto.Consultar(nil);
  end;
end;

function TcPagamentoServico.NumerarCapa;
begin
  Result := mSequence.Instance.GetSequencia('PAGTO', 'NR_PAGTO', ADt_Pagto);
end;

procedure TcPagamentoServico.Salvar;
const
  cDS_METHOD = 'TcPagamentoServico.Salvar';
begin
  if ACd_Equip = '' then
    mMensagemLog.Instance.ErroException('Equipamento do pagamento deve ser informado', cDS_METHOD);
  if ADt_Pagto = 0 then
    mMensagemLog.Instance.ErroException('Data do pagamento deve ser informada', cDS_METHOD);
  if AVl_Pagto = 0 then
    mMensagemLog.Instance.ErroException('Valor do pagamento deve ser informado', cDS_METHOD);

  if ANr_Pagto = 0 then
    ANr_Pagto := NumerarCapa(ADt_Pagto);

  with fPagto do begin
    Cd_Dnapagto :=
      ACd_Equip + '#' +
      FormatDateTime('yyyymmdd', ADt_Pagto) + '#' +
      IntToStr(ANr_Pagto);

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Cd_Equip := ACd_Equip;
    Dt_Pagto := ADt_Pagto;
    Nr_Pagto := ANr_Pagto;
    Vl_Pagto := AVl_Pagto;
    Vl_Entrada := AVl_Entrada;
    Vl_Troco := AVl_Troco;
    Vl_Variacao := AVl_Variacao;

    Salvar();
  end;
end;

procedure TcPagamentoServico.Excluir;
begin
  with fPagto do begin
    Cd_Dnapagto := '';

    Excluir();
  end;
end;

procedure TcPagamentoServico.TotalizarCapa();
begin
  with fPagto do
    Vl_Pagto :=
      Vl_Entrada +
      Vl_Parcelado +
      Vl_Variacao -
      Vl_Troco;
end;

function TcPagamentoServico.NumerarParcela;
begin
  with fPagto.List_Parcela do
    if Count > 0 then
      Result := Trunc(Max('Nr_Parcela')) + 1
    else
      Result := 1;
end;

procedure TcPagamentoServico.AdicionarParcela;
const
  cDS_METHOD = 'TcPagamentoServico.AdicionarParcela';
begin
  if AVl_Parcela = 0 then
    mMensagemLog.Instance.ErroException('Valor da parcela deve ser informado', cDS_METHOD);
  if ATp_Docto = 0 then
    mMensagemLog.Instance.ErroException('Tipo docto da parcela deve ser informado', cDS_METHOD);
  if ANr_Docto = 0 then
    mMensagemLog.Instance.ErroException('Numero docto da parcela deve ser informado', cDS_METHOD);
  if ADt_Vencto = 0 then
    mMensagemLog.Instance.ErroException('Data da parcela deve ser informado', cDS_METHOD);

  if ANr_Parcela = 0 then
    ANr_Parcela := NumerarParcela();

  with fPagto do begin
    with List_Parcela.Add do begin
      Cd_Dnapagto := fPagto.Cd_Dnapagto;
      Nr_Parcela := ANr_Parcela;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Vl_Parcela := AVl_Parcela;
      Tp_Docto := ATp_Docto;
      Nr_Docto := ANr_Docto;
      Dt_Vencto := ADt_Vencto;
      Ds_Adicional := ADs_Adicional;
      Cd_Dnabaixa := ACd_Dnabaixa;

      TotalizarCapa();

      Salvar();
    end;
  end;
end;

end.

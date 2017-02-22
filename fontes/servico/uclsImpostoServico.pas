unit uclsImpostoServico;

(* classe servico *)

interface

uses
  Classes, SysUtils, StrUtils, Math,
  uEmpresa, uTransacao, uTransitem,
  uRegrafiscal, uRegrafiscalimposto,
  uTipoImposto;

type
  TcImpostoServico = class(TComponent)
  private
    fTransacao : TTransacao;
    fTransitem : TTransitem;
    fRegrafiscal : TRegrafiscal;
    fRegrafiscalImposto : TRegrafiscalImposto;
  protected
    procedure GerarIcms;
    procedure GerarIcmsSt;
    procedure GerarIcmsUf;
    procedure GerarIpi;
    procedure GerarPis;
    procedure GerarPisSt;
    procedure GerarCofins;
    procedure GerarCofinsSt;
    procedure GerarIssqn;
    procedure GerarIi;
  public
    constructor Create(AOwner : TComponent); override;

    procedure Gerar(
      ATransacao : TTransacao;
      ATransitem : TTransitem);

  published
  end;

  function Instance : TcImpostoServico;

implementation

uses
  uclsRegrafiscalServico, uTransimposto, mFloat;

var
  _instance : TcImpostoServico;

  function Instance : TcImpostoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcImpostoServico.Create(nil);
    Result := _instance;
  end;

{ TcImpostoServico }

constructor TcImpostoServico.Create(AOwner : TComponent);
begin
  inherited;
  fRegrafiscal := TRegrafiscal.Create(nil);
end;

//--

procedure TcImpostoServico.GerarIcms;
begin
  with fTransitem.List_Imposto.Add do begin
    Cd_Dnatrans := fTransitem.Cd_Dnatrans;
    Nr_Item := fTransitem.Nr_Item;
    Cd_Imposto := fRegrafiscalImposto.Cd_Imposto;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Vl_Basecalculo := fTransitem.Vl_Totitem;
    Pr_Basecalculo := fRegrafiscalImposto.Pr_Basecalculo;
    Pr_Aliquota := fRegrafiscalImposto.Pr_Aliquota;
    Cd_Cst := fRegrafiscalImposto.Cd_Cst;
    Cd_Csosn := fRegrafiscalImposto.Cd_Csosn;
    Vl_Imposto := TmFloat.Rounded(Vl_Basecalculo * (Pr_Aliquota / 100) * (Pr_Basecalculo / 100), 2);

    if fRegrafiscalImposto.In_Isento then begin
      Vl_Isento := Vl_Imposto;
      Vl_Imposto := 0;
    end else if fRegrafiscalImposto.In_Outro then begin
      Vl_Outro := Vl_Imposto;
      Vl_Imposto := 0;
    end;
  end;
end;

procedure TcImpostoServico.GerarIcmsSt;
begin
end;

procedure TcImpostoServico.GerarIcmsUf;
begin
end;

procedure TcImpostoServico.GerarIpi;
begin
end;

procedure TcImpostoServico.GerarPis;
begin
end;

procedure TcImpostoServico.GerarPisSt;
begin
end;

procedure TcImpostoServico.GerarCofins;
begin
end;

procedure TcImpostoServico.GerarCofinsSt;
begin
end;

procedure TcImpostoServico.GerarIssqn;
begin
end;

procedure TcImpostoServico.GerarIi;
begin
end;

//--

procedure TcImpostoServico.Gerar;
const
  cDS_METHOD = 'TcImpostoServico.Gerar';
var
  I : Integer;
begin
  fTransacao := ATransacao;
  fTransitem := ATransitem;

  if not Assigned(fTransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);
  if not Assigned(fTransitem) then
    raise Exception.Create('Item da transacao deve ser informada / ' + cDS_METHOD);

  fRegrafiscal := uclsRegrafiscalServico.Instance.Consular(
    fTransacao.Obj_Operacao.Cd_Regrafiscal);

  if not Assigned(fRegrafiscal) then
    raise Exception.Create('Regra fiscal deve ser informada / ' + cDS_METHOD);

  if fRegrafiscal.Cd_Regrafiscal = 0 then
    raise Exception.Create('Regra fiscal deve ser informada / ' + cDS_METHOD);
  if fRegrafiscal.In_Calcimposto then
    if fRegrafiscal.List_Imposto.Count = 0 then
      raise Exception.Create('Imposto da regra fiscal ' + FloatToStr(fRegrafiscal.Cd_Regrafiscal) + ' deve ser configurado / ' + cDS_METHOD);

  with fRegrafiscal do
    for I := 0 to List_Imposto.Count - 1 do
      with List_Imposto[I] do begin
        fRegrafiscalImposto := List_Imposto[I];

        case TTipoImposto(Ord(Cd_Imposto)) of
          tpiIcms : GerarIcms();
          tpiIcmsSt : GerarIcmsSt();
          tpiIcmsUf : GerarIcmsUf();
          tpiIpi : GerarIpi();
          tpiPis : GerarPis();
          tpiPisSt : GerarPisSt();
          tpiCofins : GerarCofins();
          tpiCofinsSt : GerarCofinsSt();
          tpiIssqn : GerarIssqn();
          tpiIi : GerarIi();
        end;
      end;

end;

end.

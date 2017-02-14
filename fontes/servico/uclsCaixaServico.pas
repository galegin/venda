unit uclsCaixaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uCaixa;

type
  TcCaixaServico = class(TComponent)
  private
    fCaixa : TCaixa;
  protected
  public
    constructor Create(AOwner : TComponent); override;

    function Listar() : TCaixaList;

    procedure Salvar(
      ACd_Equip : String;
      ADt_Caixa : TDateTime;
      ANr_Seq : Integer;
      AVl_Abertura : Real;
      ADt_Fechado : TDateTime);

    procedure Excluir(ACd_Dnacaixa : String);
    
  published
    property Caixa : TCaixa read fCaixa write fCaixa;
  end;

  function Instance : TcCaixaServico;

implementation

uses mCollectionItem;

var
  _instance : TcCaixaServico;

  function Instance : TcCaixaServico;
  begin
    if not Assigned(_instance) then
      _instance := TcCaixaServico.Create(nil);
    Result := _instance;
  end;

constructor TcCaixaServico.Create(AOwner : TComponent);
begin
  inherited;
  fCaixa := TCaixa.Create(nil);
end;

function TcCaixaServico.Listar;
begin
  Result := TCaixaList(fCaixa.Listar(nil));
end;

procedure TcCaixaServico.Salvar;
begin
  with fCaixa do begin
    Cd_Dnacaixa :=
      ACd_Equip + '#' +
      FormatDateTime('yyyymmdd', Dt_Caixa) + '#' +
      IntToStr(ANr_Seq);

    U_Version := '';
    Cd_Operador := 0;
    Dt_Cadastro := Now;

    Cd_Equip := ACd_Equip;
    Dt_Caixa := ADt_Caixa;
    Nr_Seq := ANr_Seq;
    Vl_Abertura := AVl_Abertura;
    Dt_Fechado := ADt_Fechado;

    Salvar();
  end;
end;

procedure TcCaixaServico.Excluir;
begin
  with fCaixa do begin
    Limpar();
    if ACd_Dnacaixa <> '' then begin
      Cd_Dnacaixa := ACd_Dnacaixa;
      Excluir();
    end;  
  end;
end;

end.

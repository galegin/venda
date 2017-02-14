unit uclsRegrafiscalServico;

(* classe servico *)

interface

uses
  Classes, SysUtils, StrUtils,
  uRegrafiscal;

type
  TcRegrafiscalServico = class(TComponent)
  private
    fRegrafiscal : TRegrafiscal;
  protected
  public
    constructor Create(AOwner : TComponent); override;

    function Consular(
      ACd_Regrafiscal : Integer): TRegrafiscal;

  published
  end;

  function Instance : TcRegrafiscalServico;

implementation

var
  _instance : TcRegrafiscalServico;

  function Instance : TcRegrafiscalServico;
  begin
    if not Assigned(_instance) then
      _instance := TcRegrafiscalServico.Create(nil);
    Result := _instance;
  end;

{ TcRegrafiscalServico }

constructor TcRegrafiscalServico.Create(AOwner : TComponent);
begin
  inherited;
  fRegrafiscal := TRegrafiscal.Create(nil);
end;

function TcRegrafiscalServico.Consular;
const
  cDS_METHOD = 'TcRegrafiscalServico.Consular';
begin
  if ACd_Regrafiscal = 0 then
    raise Exception.Create('C�digo regra fiscal deve ser informada / ' + cDS_METHOD);

  fRegrafiscal.Limpar();
  fRegrafiscal.Cd_Regrafiscal:= ACd_Regrafiscal;
  fRegrafiscal.Consultar(nil);
  if fRegrafiscal.Cd_Regrafiscal = 0 then
    raise Exception.Create('Regra fiscal ' + FloatToStr(ACd_Regrafiscal) + ' nao encontrada / ' + cDS_METHOD);

  Result := fRegrafiscal;
end;

end.
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
    destructor Destroy; override;
    function Consular(AId_Regrafiscal : Integer): TRegrafiscal;
  published
  end;

  function Instance : TcRegrafiscalServico;
  procedure Destroy;

implementation

uses
  mContexto;

var
  _instance : TcRegrafiscalServico;

  function Instance : TcRegrafiscalServico;
  begin
    if not Assigned(_instance) then
      _instance := TcRegrafiscalServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

{ TcRegrafiscalServico }

constructor TcRegrafiscalServico.Create(AOwner : TComponent);
begin
  inherited;

  fRegrafiscal := TRegrafiscal.Create(nil);
end;

destructor TcRegrafiscalServico.Destroy;
begin
  FreeAndNil(fRegrafiscal);

  inherited;
end;

function TcRegrafiscalServico.Consular;
const
  cDS_METHOD = 'TcRegrafiscalServico.Consular';
begin
  if AId_Regrafiscal = 0 then
    raise Exception.Create('Código regra fiscal deve ser informada / ' + cDS_METHOD);

  fRegrafiscal := mContexto.Instance.GetObjeto(TRegrafiscal, 'Id_Regrafiscal = ' + IntToStr(AId_Regrafiscal)) as TRegrafiscal;
  if fRegrafiscal.Id_Regrafiscal = 0 then
    raise Exception.Create('Regra fiscal ' + FloatToStr(AId_Regrafiscal) + ' nao encontrada / ' + cDS_METHOD);

  Result := fRegrafiscal;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

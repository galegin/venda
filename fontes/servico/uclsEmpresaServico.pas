unit uclsEmpresaServico;

(* classe servico *)

interface

uses
  Classes, SysUtils, StrUtils,
  uEmpresa;

type
  TcEmpresaServico = class(TComponent)
  private
    fEmpresa : TEmpresa;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Consultar(AId_Empresa : Integer) : TEmpresa;
  published
  end;

  function Instance : TcEmpresaServico;
  procedure Destroy;

implementation

uses
  mContexto;

var
  _instance : TcEmpresaServico;

  function Instance : TcEmpresaServico;
  begin
    if not Assigned(_instance) then
      _instance := TcEmpresaServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

{ TcEmpresaServico }

constructor TcEmpresaServico.Create(AOwner : TComponent);
begin
  inherited;

  fEmpresa := TEmpresa.Create(nil);
end;

destructor TcEmpresaServico.Destroy;
begin
  FreeAndNil(fEmpresa);

  inherited;
end;

function TcEmpresaServico.Consultar;
const
  cDS_METHOD = 'TcEmpresaServico.Consular';
begin
  if AId_Empresa = 0 then
    raise Exception.Create('Código empresa deve ser informada / ' + cDS_METHOD);

  fEmpresa := mContexto.Instance.GetObjeto(TEmpresa, 'Id_Empresa = ' + IntToStr(AId_Empresa)) as TEmpresa;
  if fEmpresa.Id_Empresa = 0 then
    raise Exception.Create('Empresa ' + FloatToStr(AId_Empresa) + ' nao encontrada / ' + cDS_METHOD);

  Result := fEmpresa;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

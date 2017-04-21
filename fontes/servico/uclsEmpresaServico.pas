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

    function Consultar(ANr_Cpfcnpj : String = '') : TEmpresa;
  published
  end;

  function Instance : TcEmpresaServico;
  procedure Destroy;

implementation

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
begin
  fEmpresa.Limpar();
  if ANr_Cpfcnpj <> '' then
    fEmpresa.Nr_CpfCnpj := ANr_Cpfcnpj;
  fEmpresa.ConsultarAll(nil);
  if fEmpresa.Nr_Cpfcnpj <> '' then begin
    with fEmpresa do begin
      Obj_Pessoa.Limpar();
      Obj_Pessoa.Nr_Cpfcnpj := fEmpresa.Nr_Cpfcnpj;
      Obj_Pessoa.Consultar(nil);
    end;
  end;
  Result := fEmpresa;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

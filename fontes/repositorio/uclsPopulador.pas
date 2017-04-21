unit uclsPopulador;

(* popular banco de dados *)

interface

uses
  Classes, SysUtils, StrUtils,
  mPopulador, mContexto;

type
  TcPopulador = class(TmPopulador)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Initialize(AContexto : TmContexto); override;
  published
  end;

  function Instance : TcPopulador;
  procedure Destroy;

implementation

uses
  uclsAliqicmsPopulador,
  uclsCfopPopulador,
  uclsEstadoPopulador,
  uclsMunicipioPopulador,
  uclsNcmPopulador,
  uclsOperacaoPopulador,
  uclsPaisPopulador,
  uclsRegrafiscalPopulador;

var
  _instance : TcPopulador;

  function Instance : TcPopulador;
  begin
    if not Assigned(_instance) then
      _instance := TcPopulador.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcPopulador.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcPopulador.Destroy;
begin

  inherited;
end;

procedure TcPopulador.Initialize(AContexto: TmContexto);
begin
  inherited;

  TPaisPopulador.Initialize(AContexto);
  TEstadoPopulador.Initialize(AContexto);
  TMunicipioPopulador.Initialize(AContexto);

  TAliqicmsPopulador.Initialize(AContexto);
  TCfopPopulador.Initialize(AContexto);
  TNcmPopulador.Initialize(AContexto);
  TRegrafiscalPopulador.Initialize(AContexto);
  TOperacaoPopulador.Initialize(AContexto);

  (*
  TCaixaPopulador.Initialize(AContexto);
  THistrelPopulador.Initialize(AContexto);
  TEquipPopulador.Initialize(AContexto);
  TPessoaPopulador.Initialize(AContexto);
  TProdutoPopulador.Initialize(AContexto);
  TUsuarioPopulador.Initialize(AContexto);
  *)
  
end;

initialization
  //Instance();

finalization
  Destroy();

end.

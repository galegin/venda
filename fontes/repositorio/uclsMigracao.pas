unit uclsMigracao;

(* sincroniza estrutura do banco de dados *)

interface

uses
  Classes, SysUtils, StrUtils,
  mMigracao, mContexto;

type
  TcMigracao = class(TmMigracao)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Initialize(AContexto : TmContexto); override;
  published
  end;

  function Instance : TcMigracao;
  procedure Destroy;

implementation

uses
  mCollectionMap;

var
  _instance : TcMigracao;

  function Instance : TcMigracao;
  begin
    if not Assigned(_instance) then
      _instance := TcMigracao.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcMigracao.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcMigracao.Destroy;
begin

  inherited;
end;

procedure TcMigracao.Initialize(AContexto: TmContexto);
begin
  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

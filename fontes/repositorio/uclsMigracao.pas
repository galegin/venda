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
    procedure Initialize(AContexto : TmContexto); override;
  published
  end;

  function Instance : TcMigracao;

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

constructor TcMigracao.Create(AOwner : TComponent);
begin
  inherited;
end;

procedure TcMigracao.Initialize(AContexto: TmContexto);
begin
  inherited;
end;

end.

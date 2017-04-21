unit uclsMapeamento;

(* mapeamento entidade *)

interface

uses
  Classes, SysUtils, StrUtils;

type
  TcMapeamento = class(TComponent)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcMapeamento;
  procedure Destroy;

implementation

var
  _instance : TcMapeamento;

  function Instance : TcMapeamento;
  begin
    if not Assigned(_instance) then
      _instance := TcMapeamento.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcMapeamento.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcMapeamento.Destroy;
begin

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

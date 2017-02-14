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
  published
  end;

  function Instance : TcMapeamento;

implementation

var
  _instance : TcMapeamento;

  function Instance : TcMapeamento;
  begin
    if not Assigned(_instance) then
      _instance := TcMapeamento.Create(nil);
    Result := _instance;
  end;

constructor TcMapeamento.Create(AOwner : TComponent);
begin
  inherited;
end;

end.

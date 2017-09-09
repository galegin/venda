unit DFeEventoServico; // uclsDFeServico

(* DFeEventoServico *)

interface

uses
  Classes, SysUtils, StrUtils;

type
  TcDFeEventoServico = class(TComponent)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcDFeEventoServico;
  procedure Destroy;

implementation

var
  _instance : TcDFeEventoServico;

  function Instance : TcDFeEventoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeEventoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cDFeEventoServico *)

constructor TcDFeEventoServico.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcDFeEventoServico.Destroy;
begin

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

end.
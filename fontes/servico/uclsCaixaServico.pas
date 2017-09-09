unit uclsCaixaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uCaixa;

type
  TcCaixaServico = class(TComponent)
  private
    fCaixa : TCaixa;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcCaixaServico;
  procedure Destroy;

implementation

var
  _instance : TcCaixaServico;

  function Instance : TcCaixaServico;
  begin
    if not Assigned(_instance) then
      _instance := TcCaixaServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcCaixaServico.Create(AOwner : TComponent);
begin
  inherited;

  fCaixa := TCaixa.Create(nil);
end;

destructor TcCaixaServico.Destroy;
begin
  FreeAndNil(fCaixa);

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

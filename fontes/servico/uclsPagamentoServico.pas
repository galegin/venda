unit uclsPagamentoServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uTranspagto, mException;

type
  TcPagamentoServico = class(TComponent)
  private
    fTranspagto : TTranspagto;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcPagamentoServico;
  procedure Destroy;

implementation

uses
  mLogger;

var
  _instance : TcPagamentoServico;

  function Instance : TcPagamentoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcPagamentoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcPagamentoServico.Create(AOwner : TComponent);
begin
  inherited;

  fTranspagto := TTranspagto.Create(nil);
end;

destructor TcPagamentoServico.Destroy;
begin
  FreeAndNil(fTranspagto);

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

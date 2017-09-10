unit uclsCaixaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uCaixa, uCaixacont;

type
  TcCaixaServico = class(TComponent)
  private
    fCaixa : TCaixa;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function CaixaAberto(AIdEmpresa, AIdTerminal : Integer) : TCaixa;
    function ContagemCaixa(AIdEmpresa, AIdTerminal : Integer) : TCaixacont;
    procedure SuprirCaixa(ACaixa : TCaixa; AVlSuprimento : Real);
    procedure RetirarCaixa(ACaixa : TCaixa; AVlSuprimento : Real);
    procedure EncerrarCaixa(ACaixa : TCaixa);
    procedure FecharCaixa(ACaixa : TCaixa);
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

//--

function TcCaixaServico.CaixaAberto(AIdEmpresa, AIdTerminal : Integer) : TCaixa;
begin
end;

function TcCaixaServico.ContagemCaixa(AIdEmpresa, AIdTerminal : Integer) : TCaixacont;
begin
end;

procedure TcCaixaServico.SuprirCaixa(ACaixa : TCaixa; AVlSuprimento : Real);
begin
end;

procedure TcCaixaServico.RetirarCaixa(ACaixa : TCaixa; AVlSuprimento : Real);
begin
end;

procedure TcCaixaServico.EncerrarCaixa(ACaixa : TCaixa);
begin
end;

procedure TcCaixaServico.FecharCaixa(ACaixa : TCaixa);
begin
end;

//--

initialization
  //Instance();

finalization
  Destroy();

end.

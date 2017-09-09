unit DFeComumServico; // uclsDFeServico

(* DFeComumServico *)

interface

uses
  Classes, SysUtils, StrUtils,
  DFeConfiguracaoServico;

type
  TcDFeComumServico = class(TComponent)
  private
    function GetConfiguracao: TcDFeConfiguracaoServico;
    function GetIsConectadoInternet: Boolean;
    function GetIsGerarContingencia: Boolean;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property IsConectadoInternet : Boolean read GetIsConectadoInternet;
    property IsGerarContingencia : Boolean read GetIsGerarContingencia;
    property Configuracao : TcDFeConfiguracaoServico read GetConfiguracao;
  end;

  function Instance : TcDFeComumServico;
  procedure Destroy;

implementation

var
  _instance : TcDFeComumServico;

  function Instance : TcDFeComumServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeComumServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cDFeComumServico *)

constructor TcDFeComumServico.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcDFeComumServico.Destroy;
begin

  inherited;
end;

function TcDFeComumServico.GetConfiguracao: TcDFeConfiguracaoServico;
begin

end;

function TcDFeComumServico.GetIsConectadoInternet: Boolean;
begin

end;

function TcDFeComumServico.GetIsGerarContingencia: Boolean;
begin

end;

initialization
  //Instance();

finalization
  Destroy();

end.
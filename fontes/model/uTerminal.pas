unit uTerminal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTerminal = class(TmMapping)
  private
    fId_Terminal: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Terminal: Integer;
    fDs_Terminal: String;
    procedure SetId_Terminal(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Terminal(const Value : Integer);
    procedure SetDs_Terminal(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Terminal : Integer read fId_Terminal write SetId_Terminal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
    property Ds_Terminal : String read fDs_Terminal write SetDs_Terminal;
  end;

  TTerminals = class(TList)
  public
    function Add: TTerminal; overload;
  end;

implementation

{ TTerminal }

constructor TTerminal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTerminal.Destroy;
begin

  inherited;
end;

//--

function TTerminal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TERMINAL';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Terminal', 'ID_TERMINAL');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Terminal', 'ID_TERMINAL');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Terminal', 'CD_TERMINAL');
    Add('Ds_Terminal', 'DS_TERMINAL');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTerminal.SetId_Terminal(const Value : Integer);
begin
  fId_Terminal := Value;
end;

procedure TTerminal.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTerminal.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTerminal.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTerminal.SetCd_Terminal(const Value : Integer);
begin
  fCd_Terminal := Value;
end;

procedure TTerminal.SetDs_Terminal(const Value : String);
begin
  fDs_Terminal := Value;
end;

{ TTerminals }

function TTerminals.Add: TTerminal;
begin
  Result := TTerminal.Create(nil);
  Self.Add(Result);
end;

end.
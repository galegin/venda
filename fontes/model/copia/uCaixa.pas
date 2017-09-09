unit uCaixa;

interface

uses
  Classes, SysUtils,
  mMapping,
  uCaixacont, uCaixamov;

type
  TCaixa = class(TmMapping)
  private
    fId_Caixa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Terminal: Integer;
    fDt_Abertura: TDateTime;
    fVl_Abertura: Real;
    fIn_Fechado: String;
    fDt_Fechado: TDateTime;
    fContagens: TCaixaconts;
    fMovtos: TCaixamovs;
    procedure SetId_Caixa(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Terminal(const Value : Integer);
    procedure SetDt_Abertura(const Value : TDateTime);
    procedure SetVl_Abertura(const Value : Real);
    procedure SetIn_Fechado(const Value : String);
    procedure SetDt_Fechado(const Value : TDateTime);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write SetDt_Abertura;
    property Vl_Abertura : Real read fVl_Abertura write SetVl_Abertura;
    property In_Fechado : String read fIn_Fechado write SetIn_Fechado;
    property Dt_Fechado : TDateTime read fDt_Fechado write SetDt_Fechado;
    property Contagens : TCaixaconts read fContagens write fContagens;
    property Movtos : TCaixamovs read fMovtos write fMovtos;
  end;

  TCaixas = class(TList)
  public
    function Add: TCaixa; overload;
  end;

implementation

{ TCaixa }

constructor TCaixa.Create(AOwner: TComponent);
begin
  inherited;

  fContagens := TCaixaconts.Create;
  fMovtos := TCaixamovs.Create;
end;

destructor TCaixa.Destroy;
begin
  FreeAndNil(fContagens);
  FreeAndNil(fMovtos);

  inherited;
end;

//--

function TCaixa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'CAIXA';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Caixa', 'ID_CAIXA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Caixa', 'ID_CAIXA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Terminal', 'CD_TERMINAL');
    Add('Dt_Abertura', 'DT_ABERTURA');
    Add('Vl_Abertura', 'VL_ABERTURA');
    Add('In_Fechado', 'IN_FECHADO');
    Add('Dt_Fechado', 'DT_FECHADO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Contagens', TCaixacont, TCaixaconts)^.Campos do begin
      Add('Id_Caixa');
    end;

    with Add('Movtos', TCaixamov, TCaixamovs)^.Campos do begin
      Add('Id_Caixa');
    end;

  end;
end;

//--

procedure TCaixa.SetId_Caixa(const Value : Integer);
begin
  fId_Caixa := Value;
end;

procedure TCaixa.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TCaixa.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TCaixa.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TCaixa.SetCd_Terminal(const Value : Integer);
begin
  fCd_Terminal := Value;
end;

procedure TCaixa.SetDt_Abertura(const Value : TDateTime);
begin
  fDt_Abertura := Value;
end;

procedure TCaixa.SetVl_Abertura(const Value : Real);
begin
  fVl_Abertura := Value;
end;

procedure TCaixa.SetIn_Fechado(const Value : String);
begin
  fIn_Fechado := Value;
end;

procedure TCaixa.SetDt_Fechado(const Value : TDateTime);
begin
  fDt_Fechado := Value;
end;

{ TCaixas }

function TCaixas.Add: TCaixa;
begin
  Result := TCaixa.Create(nil);
  Self.Add(Result);
end;

end.
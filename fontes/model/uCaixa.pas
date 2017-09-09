unit uCaixa;

interface

uses
  Classes, SysUtils,
  mMapping,
  uEmpresa, uTerminal,
  uCaixacont, uCaixamov,
  uTranspagto;

type
  TCaixa = class(TmMapping)
  private
    fId_Caixa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Empresa: Integer;
    fId_Terminal: Integer;
    fDt_Abertura: TDateTime;
    fVl_Abertura: Real;
    fIn_Fechado: String;
    fDt_Fechado: TDateTime;
    fEmpresa: TEmpresa;
    fTerminal: TTerminal;
    fContagens: TCaixaconts;
    fMovtos: TCaixamovs;
    fPagtos: TTranspagtos;
    procedure SetId_Caixa(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetId_Empresa(const Value : Integer);
    procedure SetId_Terminal(const Value : Integer);
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
    property Id_Empresa : Integer read fId_Empresa write SetId_Empresa;
    property Id_Terminal : Integer read fId_Terminal write SetId_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write SetDt_Abertura;
    property Vl_Abertura : Real read fVl_Abertura write SetVl_Abertura;
    property In_Fechado : String read fIn_Fechado write SetIn_Fechado;
    property Dt_Fechado : TDateTime read fDt_Fechado write SetDt_Fechado;
    property Empresa : TEmpresa read fEmpresa write fEmpresa;
    property Terminal : TTerminal read fTerminal write fTerminal;
    property Contagens : TCaixaconts read fContagens write fContagens;
    property Movtos : TCaixamovs read fMovtos write fMovtos;
    property Pagtos : TTranspagtos read fPagtos write fPagtos;
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

  fEmpresa:= TEmpresa.Create(nil);
  fTerminal:= TTerminal.Create(nil);
  fContagens:= TCaixaconts.Create;
  fMovtos:= TCaixamovs.Create;
  fPagtos:= TTranspagtos.Create;
end;

destructor TCaixa.Destroy;
begin
  FreeAndNil(fTerminal);
  FreeAndNil(fContagens);
  FreeAndNil(fMovtos);
  FreeAndNil(fPagtos);

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

    with Add('Empresa', TEmpresa)^.Campos do begin
      Add('Id_Empresa');
    end;

    with Add('Terminal', TTerminal)^.Campos do begin
      Add('Id_Terminal');
    end;

    with Add('Contagens', TCaixacont, TCaixaconts)^.Campos do begin
      Add('Id_Caixa');
    end;

    with Add('Movtos', TCaixamov, TCaixamovs)^.Campos do begin
      Add('Id_Caixa');
    end;

    with Add('Pagtos', TTranspagto, TTranspagtos)^.Campos do begin
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

procedure TCaixa.SetId_Empresa(const Value : Integer);
begin
  fId_Empresa := Value;
end;

procedure TCaixa.SetId_Terminal(const Value : Integer);
begin
  fId_Terminal := Value;
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
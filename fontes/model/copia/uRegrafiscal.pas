unit uRegrafiscal;

interface

uses
  Classes, SysUtils,
  mMapping,
  uRegraimposto;

type
  TRegrafiscal = class(TmMapping)
  private
    fId_Regrafiscal: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Regrafiscal: String;
    fIn_Calcimposto: String;
    fImpostos: TRegraimpostos;
    procedure SetId_Regrafiscal(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDs_Regrafiscal(const Value : String);
    procedure SetIn_Calcimposto(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Regrafiscal : Integer read fId_Regrafiscal write SetId_Regrafiscal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Regrafiscal : String read fDs_Regrafiscal write SetDs_Regrafiscal;
    property In_Calcimposto : String read fIn_Calcimposto write SetIn_Calcimposto;
    property Impostos : TRegraimpostos read fImpostos write fImpostos;
  end;

  TRegrafiscals = class(TList)
  public
    function Add: TRegrafiscal; overload;
  end;

implementation

{ TRegrafiscal }

constructor TRegrafiscal.Create(AOwner: TComponent);
begin
  inherited;

  fImpostos:= TRegraimpostos.Create;
end;

destructor TRegrafiscal.Destroy;
begin
  FreeAndNil(fImpostos);

  inherited;
end;

//--

function TRegrafiscal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'REGRAFISCAL';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Regrafiscal', 'ID_REGRAFISCAL');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Regrafiscal', 'ID_REGRAFISCAL');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Ds_Regrafiscal', 'DS_REGRAFISCAL');
    Add('In_Calcimposto', 'IN_CALCIMPOSTO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Impostos', TRegraimpostos)^.Campos do begin
      Add('Id_Regrafiscal');
    end;

  end;
end;

//--

procedure TRegrafiscal.SetId_Regrafiscal(const Value : Integer);
begin
  fId_Regrafiscal := Value;
end;

procedure TRegrafiscal.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TRegrafiscal.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TRegrafiscal.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TRegrafiscal.SetDs_Regrafiscal(const Value : String);
begin
  fDs_Regrafiscal := Value;
end;

procedure TRegrafiscal.SetIn_Calcimposto(const Value : String);
begin
  fIn_Calcimposto := Value;
end;

{ TRegrafiscals }

function TRegrafiscals.Add: TRegrafiscal;
begin
  Result := TRegrafiscal.Create(nil);
  Self.Add(Result);
end;

end.
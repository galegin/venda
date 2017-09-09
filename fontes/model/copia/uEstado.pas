unit uEstado;

interface

uses
  Classes, SysUtils,
  mMapping,
  uPais;

type
  TEstado = class(TmMapping)
  private
    fId_Estado: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Estado: Integer;
    fDs_Estado: String;
    fDs_Sigla: String;
    fId_Pais: Integer;
    fPais: TPais;
    procedure SetId_Estado(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Estado(const Value : Integer);
    procedure SetDs_Estado(const Value : String);
    procedure SetDs_Sigla(const Value : String);
    procedure SetId_Pais(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Estado : Integer read fId_Estado write SetId_Estado;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Estado : Integer read fCd_Estado write SetCd_Estado;
    property Ds_Estado : String read fDs_Estado write SetDs_Estado;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Id_Pais : Integer read fId_Pais write SetId_Pais;
    property Pais : TPais read fPais write fPais;
  end;

  TEstados = class(TList)
  public
    function Add: TEstado; overload;
  end;

implementation

{ TEstado }

constructor TEstado.Create(AOwner: TComponent);
begin
  inherited;

  fPais:= TPais.Create(nil);
end;

destructor TEstado.Destroy;
begin
  FreeAndNil(fPais);

  inherited;
end;

//--

function TEstado.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'ESTADO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Estado', 'ID_ESTADO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Estado', 'ID_ESTADO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Estado', 'CD_ESTADO');
    Add('Ds_Estado', 'DS_ESTADO');
    Add('Ds_Sigla', 'DS_SIGLA');
    Add('Id_Pais', 'ID_PAIS');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Pais', TPais)^.Campos do begin
      Add('Id_Pais');
    end;

  end;
end;

//--

procedure TEstado.SetId_Estado(const Value : Integer);
begin
  fId_Estado := Value;
end;

procedure TEstado.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TEstado.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TEstado.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TEstado.SetCd_Estado(const Value : Integer);
begin
  fCd_Estado := Value;
end;

procedure TEstado.SetDs_Estado(const Value : String);
begin
  fDs_Estado := Value;
end;

procedure TEstado.SetDs_Sigla(const Value : String);
begin
  fDs_Sigla := Value;
end;

procedure TEstado.SetId_Pais(const Value : Integer);
begin
  fId_Pais := Value;
end;

{ TEstados }

function TEstados.Add: TEstado;
begin
  Result := TEstado.Create(nil);
  Self.Add(Result);
end;

end.
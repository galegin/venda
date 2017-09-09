unit uMunicipio;

interface

uses
  Classes, SysUtils,
  mMapping,
  uEstado;

type
  TMunicipio = class(TmMapping)
  private
    fId_Municipio: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Municipio: Integer;
    fDs_Municipio: String;
    fDs_Sigla: String;
    fId_Estado: Integer;
    fEstado: TEstado;
    procedure SetId_Municipio(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Municipio(const Value : Integer);
    procedure SetDs_Municipio(const Value : String);
    procedure SetDs_Sigla(const Value : String);
    procedure SetId_Estado(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Municipio : Integer read fId_Municipio write SetId_Municipio;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Municipio : Integer read fCd_Municipio write SetCd_Municipio;
    property Ds_Municipio : String read fDs_Municipio write SetDs_Municipio;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Id_Estado : Integer read fId_Estado write SetId_Estado;
    property Estado : TEstado read fEstado write fEstado;
  end;

  TMunicipios = class(TList)
  public
    function Add: TMunicipio; overload;
  end;

implementation

{ TMunicipio }

constructor TMunicipio.Create(AOwner: TComponent);
begin
  inherited;

  fEstado:= TEstado.Create(nil);
end;

destructor TMunicipio.Destroy;
begin
  FreeAndNil(fEstado);

  inherited;
end;

//--

function TMunicipio.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'MUNICIPIO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Municipio', 'ID_MUNICIPIO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Municipio', 'ID_MUNICIPIO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Municipio', 'CD_MUNICIPIO');
    Add('Ds_Municipio', 'DS_MUNICIPIO');
    Add('Ds_Sigla', 'DS_SIGLA');
    Add('Id_Estado', 'ID_ESTADO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Estado', TEstado)^.Campos do begin
      Add('Id_Estado');
    end;

  end;
end;

//--

procedure TMunicipio.SetId_Municipio(const Value : Integer);
begin
  fId_Municipio := Value;
end;

procedure TMunicipio.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TMunicipio.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TMunicipio.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TMunicipio.SetCd_Municipio(const Value : Integer);
begin
  fCd_Municipio := Value;
end;

procedure TMunicipio.SetDs_Municipio(const Value : String);
begin
  fDs_Municipio := Value;
end;

procedure TMunicipio.SetDs_Sigla(const Value : String);
begin
  fDs_Sigla := Value;
end;

procedure TMunicipio.SetId_Estado(const Value : Integer);
begin
  fId_Estado := Value;
end;

{ TMunicipios }

function TMunicipios.Add: TMunicipio;
begin
  Result := TMunicipio.Create(nil);
  Self.Add(Result);
end;

end.
unit uEmpresa;

interface

uses
  Classes, SysUtils,
  mMapping,
  uPessoa;

type
  TEmpresa = class(TmMapping)
  private
    fId_Empresa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Pessoa: String;
    fPessoa: TPessoa;
    procedure SetId_Empresa(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetId_Pessoa(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Empresa : Integer read fId_Empresa write SetId_Empresa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Id_Pessoa : String read fId_Pessoa write SetId_Pessoa;
    property Pessoa: TPessoa read fPessoa write fPessoa;
  end;

  TEmpresas = class(TList)
  public
    function Add: TEmpresa; overload;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create(AOwner: TComponent);
begin
  inherited;

  fPessoa:= TPessoa.Create(nil);
end;

destructor TEmpresa.Destroy;
begin
  FreeAndNil(fPessoa); 

  inherited;
end;

//--

function TEmpresa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'EMPRESA';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Empresa', 'ID_EMPRESA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Empresa', 'ID_EMPRESA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Id_Pessoa', 'ID_PESSOA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Pessoa', TPessoa)^.Campos do begin
      Add('Id_Pessoa');
    end;

  end;
end;

//--

procedure TEmpresa.SetId_Empresa(const Value : Integer);
begin
  fId_Empresa := Value;
end;

procedure TEmpresa.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TEmpresa.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TEmpresa.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TEmpresa.SetId_Pessoa(const Value : String);
begin
  fId_Pessoa := Value;
end;

{ TEmpresas }

function TEmpresas.Add: TEmpresa;
begin
  Result := TEmpresa.Create(nil);
  Self.Add(Result);
end;

end.
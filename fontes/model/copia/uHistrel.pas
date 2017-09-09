unit uHistrel;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  THistrel = class(TmMapping)
  private
    fId_Histrel: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Documento: Integer;
    fCd_Histrel: Integer;
    fDs_Histrel: String;
    fNr_Parcelas: Integer;
    procedure SetId_Histrel(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetTp_Documento(const Value : Integer);
    procedure SetCd_Histrel(const Value : Integer);
    procedure SetDs_Histrel(const Value : String);
    procedure SetNr_Parcelas(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Histrel : Integer read fId_Histrel write SetId_Histrel;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Documento : Integer read fTp_Documento write SetTp_Documento;
    property Cd_Histrel : Integer read fCd_Histrel write SetCd_Histrel;
    property Ds_Histrel : String read fDs_Histrel write SetDs_Histrel;
    property Nr_Parcelas : Integer read fNr_Parcelas write SetNr_Parcelas;
  end;

  THistrels = class(TList)
  public
    function Add: THistrel; overload;
  end;

implementation

{ THistrel }

constructor THistrel.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor THistrel.Destroy;
begin

  inherited;
end;

//--

function THistrel.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'HISTREL';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Histrel', 'ID_HISTREL');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Histrel', 'ID_HISTREL');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Tp_Documento', 'TP_DOCUMENTO');
    Add('Cd_Histrel', 'CD_HISTREL');
    Add('Ds_Histrel', 'DS_HISTREL');
    Add('Nr_Parcelas', 'NR_PARCELAS');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure THistrel.SetId_Histrel(const Value : Integer);
begin
  fId_Histrel := Value;
end;

procedure THistrel.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure THistrel.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure THistrel.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure THistrel.SetTp_Documento(const Value : Integer);
begin
  fTp_Documento := Value;
end;

procedure THistrel.SetCd_Histrel(const Value : Integer);
begin
  fCd_Histrel := Value;
end;

procedure THistrel.SetDs_Histrel(const Value : String);
begin
  fDs_Histrel := Value;
end;

procedure THistrel.SetNr_Parcelas(const Value : Integer);
begin
  fNr_Parcelas := Value;
end;

{ THistrels }

function THistrels.Add: THistrel;
begin
  Result := THistrel.Create(nil);
  Self.Add(Result);
end;

end.
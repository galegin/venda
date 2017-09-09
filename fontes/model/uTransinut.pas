unit uTransinut;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransinut = class(TmMapping)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDt_Emissao: TDateTime;
    fTp_Modelonf: Integer;
    fCd_Serie: String;
    fNr_Nf: Integer;
    fDt_Recebimento: TDateTime;
    fNr_Recibo: String;
    procedure SetId_Transacao(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetDt_Emissao(const Value : TDateTime);
    procedure SetTp_Modelonf(const Value : Integer);
    procedure SetCd_Serie(const Value : String);
    procedure SetNr_Nf(const Value : Integer);
    procedure SetDt_Recebimento(const Value : TDateTime);
    procedure SetNr_Recibo(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Emissao : TDateTime read fDt_Emissao write SetDt_Emissao;
    property Tp_Modelonf : Integer read fTp_Modelonf write SetTp_Modelonf;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Nr_Nf : Integer read fNr_Nf write SetNr_Nf;
    property Dt_Recebimento : TDateTime read fDt_Recebimento write SetDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
  end;

  TTransinuts = class(TList)
  public
    function Add: TTransinut; overload;
  end;

implementation

{ TTransinut }

constructor TTransinut.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransinut.Destroy;
begin

  inherited;
end;

//--

function TTransinut.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSINUT';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Dt_Emissao', 'DT_EMISSAO');
    Add('Tp_Modelonf', 'TP_MODELONF');
    Add('Cd_Serie', 'CD_SERIE');
    Add('Nr_Nf', 'NR_NF');
    Add('Dt_Recebimento', 'DT_RECEBIMENTO');
    Add('Nr_Recibo', 'NR_RECIBO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTransinut.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTransinut.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransinut.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransinut.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransinut.SetDt_Emissao(const Value : TDateTime);
begin
  fDt_Emissao := Value;
end;

procedure TTransinut.SetTp_Modelonf(const Value : Integer);
begin
  fTp_Modelonf := Value;
end;

procedure TTransinut.SetCd_Serie(const Value : String);
begin
  fCd_Serie := Value;
end;

procedure TTransinut.SetNr_Nf(const Value : Integer);
begin
  fNr_Nf := Value;
end;

procedure TTransinut.SetDt_Recebimento(const Value : TDateTime);
begin
  fDt_Recebimento := Value;
end;

procedure TTransinut.SetNr_Recibo(const Value : String);
begin
  fNr_Recibo := Value;
end;

{ TTransinuts }

function TTransinuts.Add: TTransinut;
begin
  Result := TTransinut.Create(nil);
  Self.Add(Result);
end;

end.
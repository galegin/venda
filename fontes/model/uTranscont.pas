unit uTranscont;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTranscont = class(TmMapping)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: Integer;
    fCd_Terminal: Integer;
    procedure SetId_Transacao(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetTp_Situacao(const Value : Integer);
    procedure SetCd_Terminal(const Value : Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Situacao : Integer read fTp_Situacao write SetTp_Situacao;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
  end;

  TTransconts = class(TList)
  public
    function Add: TTranscont; overload;
  end;

implementation

{ TTranscont }

constructor TTranscont.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTranscont.Destroy;
begin

  inherited;
end;

//--

function TTranscont.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSCONT';
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
    Add('Tp_Situacao', 'TP_SITUACAO');
    Add('Cd_Terminal', 'CD_TERMINAL');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTranscont.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTranscont.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTranscont.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTranscont.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTranscont.SetTp_Situacao(const Value : Integer);
begin
  fTp_Situacao := Value;
end;

procedure TTranscont.SetCd_Terminal(const Value : Integer);
begin
  fCd_Terminal := Value;
end;

{ TTransconts }

function TTransconts.Add: TTranscont;
begin
  Result := TTranscont.Create(nil);
  Self.Add(Result);
end;

end.
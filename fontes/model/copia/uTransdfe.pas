unit uTransdfe;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransdfe = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Sequencia: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Evento: Integer;
    fTp_Ambiente: Integer;
    fTp_Emissao: Integer;
    fDs_Envioxml: String;
    fDs_Retornoxml: String;
    procedure SetId_Transacao(const Value : String);
    procedure SetNr_Sequencia(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetTp_Evento(const Value : Integer);
    procedure SetTp_Ambiente(const Value : Integer);
    procedure SetTp_Emissao(const Value : Integer);
    procedure SetDs_Envioxml(const Value : String);
    procedure SetDs_Retornoxml(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Sequencia : Integer read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Evento : Integer read fTp_Evento write SetTp_Evento;
    property Tp_Ambiente : Integer read fTp_Ambiente write SetTp_Ambiente;
    property Tp_Emissao : Integer read fTp_Emissao write SetTp_Emissao;
    property Ds_Envioxml : String read fDs_Envioxml write SetDs_Envioxml;
    property Ds_Retornoxml : String read fDs_Retornoxml write SetDs_Retornoxml;
  end;

  TTransdfes = class(TList)
  public
    function Add: TTransdfe; overload;
  end;

implementation

{ TTransdfe }

constructor TTransdfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransdfe.Destroy;
begin

  inherited;
end;

//--

function TTransdfe.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSDFE';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('Nr_Sequencia', 'NR_SEQUENCIA');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('Nr_Sequencia', 'NR_SEQUENCIA');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Tp_Evento', 'TP_EVENTO');
    Add('Tp_Ambiente', 'TP_AMBIENTE');
    Add('Tp_Emissao', 'TP_EMISSAO');
    Add('Ds_Envioxml', 'DS_ENVIOXML');
    Add('Ds_Retornoxml', 'DS_RETORNOXML');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTransdfe.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTransdfe.SetNr_Sequencia(const Value : Integer);
begin
  fNr_Sequencia := Value;
end;

procedure TTransdfe.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransdfe.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransdfe.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransdfe.SetTp_Evento(const Value : Integer);
begin
  fTp_Evento := Value;
end;

procedure TTransdfe.SetTp_Ambiente(const Value : Integer);
begin
  fTp_Ambiente := Value;
end;

procedure TTransdfe.SetTp_Emissao(const Value : Integer);
begin
  fTp_Emissao := Value;
end;

procedure TTransdfe.SetDs_Envioxml(const Value : String);
begin
  fDs_Envioxml := Value;
end;

procedure TTransdfe.SetDs_Retornoxml(const Value : String);
begin
  fDs_Retornoxml := Value;
end;

{ TTransdfes }

function TTransdfes.Add: TTransdfe;
begin
  Result := TTransdfe.Create(nil);
  Self.Add(Result);
end;

end.
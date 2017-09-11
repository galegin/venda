unit uTransfiscal;

interface

uses
  Classes, SysUtils,
  mMapping,
  uTransdfe, uTranscont, uTransinut;

type
  TTransfiscal = class(TmMapping)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Operacao: Integer;
    fTp_Modalidade: Integer;
    fTp_Modelonf: Integer;
    fCd_Serie: String;
    fNr_Nf: Integer;
    fTp_Processamento: String;
    fDs_Chaveacesso: String;
    fDt_Recebimento: TDateTime;
    fNr_Recibo: String;
    fEventos: TTransdfes;
    fContingencia: TTranscont;
    fInutilizacao: TTransinut;
    procedure SetId_Transacao(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetTp_Operacao(const Value : Integer);
    procedure SetTp_Modalidade(const Value : Integer);
    procedure SetTp_Modelonf(const Value : Integer);
    procedure SetCd_Serie(const Value : String);
    procedure SetNr_Nf(const Value : Integer);
    procedure SetTp_Processamento(const Value : String);
    procedure SetDs_Chaveacesso(const Value: String);
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
    property Tp_Operacao : Integer read fTp_Operacao write SetTp_Operacao;
    property Tp_Modalidade : Integer read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Modelonf : Integer read fTp_Modelonf write SetTp_Modelonf;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Nr_Nf : Integer read fNr_Nf write SetNr_Nf;
    property Tp_Processamento : String read fTp_Processamento write SetTp_Processamento;
    property Ds_Chaveacesso : String read FDs_Chaveacesso write SetDs_Chaveacesso;
    property Dt_Recebimento : TDateTime read fDt_Recebimento write SetDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
    property Eventos: TTransdfes read fEventos write fEventos;
    property Contingencia: TTranscont read fContingencia write fContingencia;
    property Inutilizacao: TTransinut read fInutilizacao write fInutilizacao;
  end;

  TTransfiscals = class(TList)
  public
    function Add: TTransfiscal; overload;
  end;

implementation

{ TTransfiscal }

constructor TTransfiscal.Create(AOwner: TComponent);
begin
  inherited;

  fEventos:= TTransdfes.Create;
  fContingencia:= TTranscont.Create(nil);
  fInutilizacao:= TTransinut.Create(nil);
end;

destructor TTransfiscal.Destroy;
begin
  FreeAndNil(fEventos);
  FreeAndNil(fContingencia);
  FreeAndNil(fInutilizacao);

  inherited;
end;

//--

function TTransfiscal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSFISCAL';
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
    Add('Tp_Operacao', 'TP_OPERACAO');
    Add('Tp_Modalidade', 'TP_MODALIDADE');
    Add('Tp_Modelonf', 'TP_MODELONF');
    Add('Cd_Serie', 'CD_SERIE');
    Add('Nr_Nf', 'NR_NF');
    Add('Tp_Processamento', 'TP_PROCESSAMENTO');
    Add('Ds_Chaveacesso', 'DS_CHAVEACESSO');
    Add('Dt_Recebimento', 'DT_RECEBIMENTO');
    Add('Nr_Recibo', 'NR_RECIBO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Eventos', TTransdfe, TTransdfes)^.Campos do begin
      Add('Id_Transacao');
    end;

    with Add('Contingencia', TTranscont)^.Campos do begin
      Add('Id_Transacao');
    end;

    with Add('Inutilizacao', TTransinut)^.Campos do begin
      Add('Id_Transacao');
    end;

  end;
end;

//--

procedure TTransfiscal.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTransfiscal.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransfiscal.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransfiscal.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransfiscal.SetTp_Operacao(const Value : Integer);
begin
  fTp_Operacao := Value;
end;

procedure TTransfiscal.SetTp_Modalidade(const Value : Integer);
begin
  fTp_Modalidade := Value;
end;

procedure TTransfiscal.SetTp_Modelonf(const Value : Integer);
begin
  fTp_Modelonf := Value;
end;

procedure TTransfiscal.SetCd_Serie(const Value : String);
begin
  fCd_Serie := Value;
end;

procedure TTransfiscal.SetNr_Nf(const Value : Integer);
begin
  fNr_Nf := Value;
end;

procedure TTransfiscal.SetDs_Chaveacesso(const Value: String);
begin
  FDs_Chaveacesso := Value;
end;

procedure TTransfiscal.SetTp_Processamento(const Value : String);
begin
  fTp_Processamento := Value;
end;

procedure TTransfiscal.SetDt_Recebimento(const Value : TDateTime);
begin
  fDt_Recebimento := Value;
end;

procedure TTransfiscal.SetNr_Recibo(const Value : String);
begin
  fNr_Recibo := Value;
end;

{ TTransfiscals }

function TTransfiscals.Add: TTransfiscal;
begin
  Result := TTransfiscal.Create(nil);
  Self.Add(Result);
end;

end.
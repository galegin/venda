unit uTranspagto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTranspagto = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Seq: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Caixa: Integer;
    fTp_Documento: Integer;
    fId_Histrel: Integer;
    fNr_Parcela: Integer;
    fNr_Parcelas: Integer;
    fNr_Documento: Integer;
    fVl_Documento: Real;
    fDt_Vencimento: TDateTime;
    fCd_Autorizacao: String;
    fNr_Nsu: Integer;
    fDs_Redetef: String;
    fNm_Operadora: String;
    fNr_Banco: Integer;
    fNr_Agencia: Integer;
    fDs_Conta: String;
    fNr_Cheque: Integer;
    fDs_Cmc7: String;
    fTp_Baixa: Integer;
    fCd_Operbaixa: Integer;
    fDt_Baixa: TDateTime;
    procedure SetId_Transacao(const Value : String);
    procedure SetNr_Seq(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetId_Caixa(const Value : Integer);
    procedure SetTp_Documento(const Value : Integer);
    procedure SetId_Histrel(const Value : Integer);
    procedure SetNr_Parcela(const Value : Integer);
    procedure SetNr_Parcelas(const Value : Integer);
    procedure SetNr_Documento(const Value : Integer);
    procedure SetVl_Documento(const Value : Real);
    procedure SetDt_Vencimento(const Value : TDateTime);
    procedure SetCd_Autorizacao(const Value : String);
    procedure SetNr_Nsu(const Value : Integer);
    procedure SetDs_Redetef(const Value : String);
    procedure SetNm_Operadora(const Value : String);
    procedure SetNr_Banco(const Value : Integer);
    procedure SetNr_Agencia(const Value : Integer);
    procedure SetDs_Conta(const Value : String);
    procedure SetNr_Cheque(const Value : Integer);
    procedure SetDs_Cmc7(const Value : String);
    procedure SetTp_Baixa(const Value : Integer);
    procedure SetCd_Operbaixa(const Value : Integer);
    procedure SetDt_Baixa(const Value : TDateTime);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Seq : Integer read fNr_Seq write SetNr_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property Tp_Documento : Integer read fTp_Documento write SetTp_Documento;
    property Id_Histrel : Integer read fId_Histrel write SetId_Histrel;
    property Nr_Parcela : Integer read fNr_Parcela write SetNr_Parcela;
    property Nr_Parcelas : Integer read fNr_Parcelas write SetNr_Parcelas;
    property Nr_Documento : Integer read fNr_Documento write SetNr_Documento;
    property Vl_Documento : Real read fVl_Documento write SetVl_Documento;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write SetDt_Vencimento;
    property Cd_Autorizacao : String read fCd_Autorizacao write SetCd_Autorizacao;
    property Nr_Nsu : Integer read fNr_Nsu write SetNr_Nsu;
    property Ds_Redetef : String read fDs_Redetef write SetDs_Redetef;
    property Nm_Operadora : String read fNm_Operadora write SetNm_Operadora;
    property Nr_Banco : Integer read fNr_Banco write SetNr_Banco;
    property Nr_Agencia : Integer read fNr_Agencia write SetNr_Agencia;
    property Ds_Conta : String read fDs_Conta write SetDs_Conta;
    property Nr_Cheque : Integer read fNr_Cheque write SetNr_Cheque;
    property Ds_Cmc7 : String read fDs_Cmc7 write SetDs_Cmc7;
    property Tp_Baixa : Integer read fTp_Baixa write SetTp_Baixa;
    property Cd_Operbaixa : Integer read fCd_Operbaixa write SetCd_Operbaixa;
    property Dt_Baixa : TDateTime read fDt_Baixa write SetDt_Baixa;
  end;

  TTranspagtos = class(TList)
  public
    function Add: TTranspagto; overload;
  end;

implementation

{ TTranspagto }

constructor TTranspagto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTranspagto.Destroy;
begin

  inherited;
end;

//--

function TTranspagto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSPAGTO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('Nr_Seq', 'NR_SEQ');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('Nr_Seq', 'NR_SEQ');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Id_Caixa', 'ID_CAIXA');
    Add('Tp_Documento', 'TP_DOCUMENTO');
    Add('Id_Histrel', 'ID_HISTREL');
    Add('Nr_Parcela', 'NR_PARCELA');
    Add('Nr_Parcelas', 'NR_PARCELAS');
    Add('Nr_Documento', 'NR_DOCUMENTO');
    Add('Vl_Documento', 'VL_DOCUMENTO');
    Add('Dt_Vencimento', 'DT_VENCIMENTO');
    Add('Cd_Autorizacao', 'CD_AUTORIZACAO');
    Add('Nr_Nsu', 'NR_NSU');
    Add('Ds_Redetef', 'DS_REDETEF');
    Add('Nm_Operadora', 'NM_OPERADORA');
    Add('Nr_Banco', 'NR_BANCO');
    Add('Nr_Agencia', 'NR_AGENCIA');
    Add('Ds_Conta', 'DS_CONTA');
    Add('Nr_Cheque', 'NR_CHEQUE');
    Add('Ds_Cmc7', 'DS_CMC7');
    Add('Tp_Baixa', 'TP_BAIXA');
    Add('Cd_Operbaixa', 'CD_OPERBAIXA');
    Add('Dt_Baixa', 'DT_BAIXA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TTranspagto.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTranspagto.SetNr_Seq(const Value : Integer);
begin
  fNr_Seq := Value;
end;

procedure TTranspagto.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTranspagto.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTranspagto.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTranspagto.SetId_Caixa(const Value : Integer);
begin
  fId_Caixa := Value;
end;

procedure TTranspagto.SetTp_Documento(const Value : Integer);
begin
  fTp_Documento := Value;
end;

procedure TTranspagto.SetId_Histrel(const Value : Integer);
begin
  fId_Histrel := Value;
end;

procedure TTranspagto.SetNr_Parcela(const Value : Integer);
begin
  fNr_Parcela := Value;
end;

procedure TTranspagto.SetNr_Parcelas(const Value : Integer);
begin
  fNr_Parcelas := Value;
end;

procedure TTranspagto.SetNr_Documento(const Value : Integer);
begin
  fNr_Documento := Value;
end;

procedure TTranspagto.SetVl_Documento(const Value : Real);
begin
  fVl_Documento := Value;
end;

procedure TTranspagto.SetDt_Vencimento(const Value : TDateTime);
begin
  fDt_Vencimento := Value;
end;

procedure TTranspagto.SetCd_Autorizacao(const Value : String);
begin
  fCd_Autorizacao := Value;
end;

procedure TTranspagto.SetNr_Nsu(const Value : Integer);
begin
  fNr_Nsu := Value;
end;

procedure TTranspagto.SetDs_Redetef(const Value : String);
begin
  fDs_Redetef := Value;
end;

procedure TTranspagto.SetNm_Operadora(const Value : String);
begin
  fNm_Operadora := Value;
end;

procedure TTranspagto.SetNr_Banco(const Value : Integer);
begin
  fNr_Banco := Value;
end;

procedure TTranspagto.SetNr_Agencia(const Value : Integer);
begin
  fNr_Agencia := Value;
end;

procedure TTranspagto.SetDs_Conta(const Value : String);
begin
  fDs_Conta := Value;
end;

procedure TTranspagto.SetNr_Cheque(const Value : Integer);
begin
  fNr_Cheque := Value;
end;

procedure TTranspagto.SetDs_Cmc7(const Value : String);
begin
  fDs_Cmc7 := Value;
end;

procedure TTranspagto.SetTp_Baixa(const Value : Integer);
begin
  fTp_Baixa := Value;
end;

procedure TTranspagto.SetCd_Operbaixa(const Value : Integer);
begin
  fCd_Operbaixa := Value;
end;

procedure TTranspagto.SetDt_Baixa(const Value : TDateTime);
begin
  fDt_Baixa := Value;
end;

{ TTranspagtos }

function TTranspagtos.Add: TTranspagto;
begin
  Result := TTranspagto.Create(nil);
  Self.Add(Result);
end;

end.
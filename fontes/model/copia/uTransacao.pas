unit uTransacao;

interface

uses
  Classes, SysUtils,
  mMapping,
  uEmpresa, uPessoa, uOperacao,
  uTransfiscal, uTransitem, uTranspagto;

type
  TTransacao = class(TmMapping)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Empresa: Integer;
    fId_Pessoa: String;
    fId_Operacao: String;
    fDt_Transacao: TDateTime;
    fNr_Transacao: Integer;
    fTp_Situacao: Integer;
    fDt_Cancelamento: TDateTime;
    fEmpresa: TEmpresa;
    fPessoa: TPessoa;
    fOperacao: TOperacao;
    fFiscal: TTransfiscal;
    fItens: TTransitems;
    fPagtos: TTranspagtos;
    procedure SetId_Transacao(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetId_Empresa(const Value : Integer);
    procedure SetId_Pessoa(const Value : String);
    procedure SetId_Operacao(const Value : String);
    procedure SetDt_Transacao(const Value : TDateTime);
    procedure SetNr_Transacao(const Value : Integer);
    procedure SetTp_Situacao(const Value : Integer);
    procedure SetDt_Cancelamento(const Value : TDateTime);
    function GetVl_Baseicms: Real;
    function GetVl_Baseicmsst: Real;
    function GetVl_Icms: Real;
    function GetVl_Icmsst: Real;
    function GetVl_Cofins: Real;
    function GetVl_Desconto: Real;
    function GetVl_Frete: Real;
    function GetVl_Ii: Real;
    function GetVl_Ipi: Real;
    function GetVl_Item: Real;
    function GetVl_Outro: Real;
    function GetVl_Pis: Real;
    function GetVl_Seguro: Real;
    function GetVl_Total: Real;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Id_Empresa : Integer read fId_Empresa write SetId_Empresa;
    property Id_Pessoa : String read fId_Pessoa write SetId_Pessoa;
    property Id_Operacao : String read fId_Operacao write SetId_Operacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write SetDt_Transacao;
    property Nr_Transacao : Integer read fNr_Transacao write SetNr_Transacao;
    property Tp_Situacao : Integer read fTp_Situacao write SetTp_Situacao;
    property Dt_Cancelamento : TDateTime read fDt_Cancelamento write SetDt_Cancelamento;
    property Empresa: TEmpresa read fEmpresa write fEmpresa;
    property Pessoa: TPessoa read fPessoa write fPessoa;
    property Operacao: TOperacao read fOperacao write fOperacao;
    property Fiscal : TTransfiscal read fFiscal write fFiscal;
    property Itens : TTransitems read fItens write fItens;
    property Pagtos : TTranspagtos read fPagtos write fPagtos;
    property Vl_Baseicms : Real read GetVl_Baseicms;
    property Vl_Icms : Real read GetVl_Icms;
    property Vl_Baseicmsst : Real read GetVl_Baseicmsst;
    property Vl_Icmsst : Real read GetVl_Icmsst;
    property Vl_Item : Real read GetVl_Item;
    property Vl_Frete : Real read GetVl_Frete;
    property Vl_Seguro : Real read GetVl_Seguro;
    property Vl_Desconto : Real read GetVl_Desconto;
    property Vl_Ii : Real read GetVl_Ii;
    property Vl_Ipi : Real read GetVl_Ipi;
    property Vl_Pis : Real read GetVl_Pis;
    property Vl_Cofins : Real read GetVl_Cofins;
    property Vl_Outro : Real read GetVl_Outro;
    property Vl_Total : Real read GetVl_Total;
  end;

  TTransacaos = class(TList)
  public
    function Add: TTransacao; overload;
  end;

implementation

uses
  mList;

{ TTransacao }

constructor TTransacao.Create(AOwner: TComponent);
begin
  inherited;

  fEmpresa:= TEmpresa.Create(nil);
  fPessoa:= TPessoa.Create(nil);
  fOperacao:= TOperacao.Create(nil);
  fFiscal:= TTransfiscal.Create(nil);
  fItens:= TTransitems.Create();
  fPagtos:= TTranspagtos.Create();
end;

destructor TTransacao.Destroy;
begin
  FreeAndNil(fEmpresa);
  FreeAndNil(fPessoa);
  FreeAndNil(fOperacao);
  FreeAndNil(fFiscal);
  FreeAndNil(fItens);
  FreeAndNil(fPagtos);

  inherited;
end;

//--

function TTransacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSACAO';
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
    Add('Id_Empresa', 'ID_EMPRESA');
    Add('Id_Pessoa', 'ID_PESSOA');
    Add('Id_Operacao', 'ID_OPERACAO');
    Add('Dt_Transacao', 'DT_TRANSACAO');
    Add('Nr_Transacao', 'NR_TRANSACAO');
    Add('Tp_Situacao', 'TP_SITUACAO');
    Add('Dt_Cancelamento', 'DT_CANCELAMENTO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Empresa', TEmpresa)^.Campos do begin
      Add('Id_Empresa');
    end;

    with Add('Pessoa', TPessoa)^.Campos do begin
      Add('Id_Pessoa');
    end;

    with Add('Operacao', TOperacao)^.Campos do begin
      Add('Id_Operacao');
    end;

    with Add('Fiscal', TTransfiscal)^.Campos do begin
      Add('Id_Transacao');
    end;

    with Add('Itens', TTransitem, TTransitems)^.Campos do begin
      Add('Id_Transacao');
    end;

    with Add('Pagtos', TTranspagto, TTranspagtos)^.Campos do begin
      Add('Id_Transacao');
    end;

  end;
end;

//--

procedure TTransacao.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTransacao.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransacao.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransacao.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransacao.SetId_Empresa(const Value : Integer);
begin
  fId_Empresa := Value;
end;

procedure TTransacao.SetId_Pessoa(const Value : String);
begin
  fId_Pessoa := Value;
end;

procedure TTransacao.SetId_Operacao(const Value : String);
begin
  fId_Operacao := Value;
end;

procedure TTransacao.SetDt_Transacao(const Value : TDateTime);
begin
  fDt_Transacao := Value;
end;

procedure TTransacao.SetNr_Transacao(const Value : Integer);
begin
  fNr_Transacao := Value;
end;

procedure TTransacao.SetTp_Situacao(const Value : Integer);
begin
  fTp_Situacao := Value;
end;

procedure TTransacao.SetDt_Cancelamento(const Value : TDateTime);
begin
  fDt_Cancelamento := Value;
end;

function TTransacao.GetVl_Baseicms: Real;
begin
  Result := TmList(fItens).Sum('Vl_Baseicms');
end;

function TTransacao.GetVl_Icms: Real;
begin
  Result := TmList(fItens).Sum('Vl_Icms');
end;

function TTransacao.GetVl_Baseicmsst: Real;
begin
  Result := TmList(fItens).Sum('Vl_Baseicmsst');
end;

function TTransacao.GetVl_Icmsst: Real;
begin
  Result := TmList(fItens).Sum('Vl_Icmsst');
end;

function TTransacao.GetVl_Cofins: Real;
begin
  Result := TmList(fItens).Sum('Vl_Cofins');
end;

function TTransacao.GetVl_Desconto: Real;
begin
  Result := TmList(fItens).Sum('Vl_Desconto');
end;

function TTransacao.GetVl_Frete: Real;
begin
  Result := TmList(fItens).Sum('Vl_Frete');
end;

function TTransacao.GetVl_Ii: Real;
begin
  Result := TmList(fItens).Sum('Vl_Ii');
end;

function TTransacao.GetVl_Ipi: Real;
begin
  Result := TmList(fItens).Sum('Vl_Ipi');
end;

function TTransacao.GetVl_Item: Real;
begin
  Result := TmList(fItens).Sum('Vl_Item');
end;

function TTransacao.GetVl_Outro: Real;
begin
  Result := TmList(fItens).Sum('Vl_Outro');
end;

function TTransacao.GetVl_Pis: Real;
begin
  Result := TmList(fItens).Sum('Vl_Pis');
end;

function TTransacao.GetVl_Seguro: Real;
begin
  Result := TmList(fItens).Sum('Vl_Seguro');
end;

function TTransacao.GetVl_Total: Real;
begin
  Result := TmList(fItens).Sum('Vl_Total');
end;

{ TTransacaos }

function TTransacaos.Add: TTransacao;
begin
  Result := TTransacao.Create(nil);
  Self.Add(Result);
end;

end.
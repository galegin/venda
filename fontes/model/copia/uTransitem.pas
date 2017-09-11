unit uTransitem;

interface

uses
  Classes, SysUtils, Math,
  mMapping, mList,
  uProduto, uTransimposto;

type
  TTransitem = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Item: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Produto: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Cfop: Integer;
    fCd_Especie: String;
    fCd_Ncm: String;
    fQt_Item: Real;
    fVl_Custo: Real;
    fVl_Unitario: Real;
    fVl_Item: Real;
    fVl_Variacao: Real;
    fVl_Variacaocapa: Real;
    fVl_Frete: Real;
    fVl_Seguro: Real;
    fVl_Outro: Real;
    fVl_Despesa: Real;
    fProduto: TProduto;
    fImpostos: TTransimpostos;
    procedure SetId_Transacao(const Value : String);
    procedure SetNr_Item(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetId_Produto(const Value : String);
    procedure SetCd_Produto(const Value : Integer);
    procedure SetDs_Produto(const Value : String);
    procedure SetCd_Cfop(const Value : Integer);
    procedure SetCd_Especie(const Value : String);
    procedure SetCd_Ncm(const Value : String);
    procedure SetQt_Item(const Value : Real);
    procedure SetVl_Custo(const Value : Real);
    procedure SetVl_Unitario(const Value : Real);
    procedure SetVl_Item(const Value : Real);
    procedure SetVl_Variacao(const Value : Real);
    procedure SetVl_Variacaocapa(const Value : Real);
    procedure SetVl_Frete(const Value : Real);
    procedure SetVl_Seguro(const Value : Real);
    procedure SetVl_Outro(const Value : Real);
    procedure SetVl_Despesa(const Value : Real);
    function GetVl_Desconto: Real;
    function GetVl_Acrescimo: Real;
    function GetVl_Baseicms: Real;
    function GetVl_Baseicmsst: Real;
    function GetVl_Icms: Real;
    function GetVl_Icmsst: Real;
    function GetVl_Cofins: Real;
    function GetVl_Ii: Real;
    function GetVl_Ipi: Real;
    function GetVl_Pis: Real;
    function GetVl_Totitem: Real;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Item : Integer read fNr_Item write SetNr_Item;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Id_Produto : String read fId_Produto write SetId_Produto;
    property Cd_Produto : Integer read fCd_Produto write SetCd_Produto;
    property Ds_Produto : String read fDs_Produto write SetDs_Produto;
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
    property Cd_Especie : String read fCd_Especie write SetCd_Especie;
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property Qt_Item : Real read fQt_Item write SetQt_Item;
    property Vl_Custo : Real read fVl_Custo write SetVl_Custo;
    property Vl_Unitario : Real read fVl_Unitario write SetVl_Unitario;
    property Vl_Item : Real read fVl_Item write SetVl_Item;
    property Vl_Variacao : Real read fVl_Variacao write SetVl_Variacao;
    property Vl_Variacaocapa : Real read fVl_Variacaocapa write SetVl_Variacaocapa;
    property Vl_Frete : Real read fVl_Frete write SetVl_Frete;
    property Vl_Seguro : Real read fVl_Seguro write SetVl_Seguro;
    property Vl_Outro : Real read fVl_Outro write SetVl_Outro;
    property Vl_Despesa : Real read fVl_Despesa write SetVl_Despesa;
    property Produto : TProduto read fProduto write fProduto;
    property Impostos : TTransimpostos read fImpostos write fImpostos;
    property Vl_Desconto : Real read GetVl_Desconto;
    property Vl_Acrescimo : Real read GetVl_Acrescimo;
    property Vl_Baseicms : Real read GetVl_Baseicms;
    property Vl_Icms : Real read GetVl_Icms;
    property Vl_Baseicmsst : Real read GetVl_Baseicmsst;
    property Vl_Icmsst : Real read GetVl_Icmsst;
    property Vl_Ii : Real read GetVl_Ii;
    property Vl_Ipi : Real read GetVl_Ipi;
    property Vl_Pis : Real read GetVl_Pis;
    property Vl_Cofins : Real read GetVl_Cofins;
    property Vl_Totitem : Real read GetVl_Totitem;
  end;

  TTransitems = class(TList)
  public
    function Add: TTransitem; overload;
  end;

implementation

{ TTransitem }

constructor TTransitem.Create(AOwner: TComponent);
begin
  inherited;

  fProduto:= TProduto.Create(nil);
  fImpostos:= TTransimpostos.Create;
end;

destructor TTransitem.Destroy;
begin
  FreeAndNil(fProduto);
  FreeAndNil(fImpostos);

  inherited;
end;

//--

function TTransitem.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSITEM';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('Nr_Item', 'NR_ITEM');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO');
    Add('Nr_Item', 'NR_ITEM');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Id_Produto', 'ID_PRODUTO');
    Add('Cd_Produto', 'CD_PRODUTO');
    Add('Ds_Produto', 'DS_PRODUTO');
    Add('Cd_Cfop', 'CD_CFOP');
    Add('Cd_Especie', 'CD_ESPECIE');
    Add('Cd_Ncm', 'CD_NCM');
    Add('Qt_Item', 'QT_ITEM');
    Add('Vl_Custo', 'VL_CUSTO');
    Add('Vl_Unitario', 'VL_UNITARIO');
    Add('Vl_Item', 'VL_ITEM');
    Add('Vl_Variacao', 'VL_VARIACAO');
    Add('Vl_Variacaocapa', 'VL_VARIACAOCAPA');
    Add('Vl_Frete', 'VL_FRETE');
    Add('Vl_Seguro', 'VL_SEGURO');
    Add('Vl_Outro', 'VL_OUTRO');
    Add('Vl_Despesa', 'VL_DESPESA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin

    with Add('Produto', TProduto)^.Campos do begin
      Add('Id_Produto');
    end;

    with Add('Impostos', TTransimpostos)^.Campos do begin
      Add('Id_Transacao');
    end;

  end;
end;

//--

procedure TTransitem.SetId_Transacao(const Value : String);
begin
  fId_Transacao := Value;
end;

procedure TTransitem.SetNr_Item(const Value : Integer);
begin
  fNr_Item := Value;
end;

procedure TTransitem.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransitem.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransitem.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TTransitem.SetId_Produto(const Value : String);
begin
  fId_Produto := Value;
end;

procedure TTransitem.SetCd_Produto(const Value : Integer);
begin
  fCd_Produto := Value;
end;

procedure TTransitem.SetDs_Produto(const Value : String);
begin
  fDs_Produto := Value;
end;

procedure TTransitem.SetCd_Cfop(const Value : Integer);
begin
  fCd_Cfop := Value;
end;

procedure TTransitem.SetCd_Especie(const Value : String);
begin
  fCd_Especie := Value;
end;

procedure TTransitem.SetCd_Ncm(const Value : String);
begin
  fCd_Ncm := Value;
end;

procedure TTransitem.SetQt_Item(const Value : Real);
begin
  fQt_Item := Value;
end;

procedure TTransitem.SetVl_Custo(const Value : Real);
begin
  fVl_Custo := Value;
end;

procedure TTransitem.SetVl_Unitario(const Value : Real);
begin
  fVl_Unitario := Value;
end;

procedure TTransitem.SetVl_Item(const Value : Real);
begin
  fVl_Item := Value;
end;

procedure TTransitem.SetVl_Variacao(const Value : Real);
begin
  fVl_Variacao := Value;
end;

procedure TTransitem.SetVl_Variacaocapa(const Value : Real);
begin
  fVl_Variacaocapa := Value;
end;

procedure TTransitem.SetVl_Frete(const Value : Real);
begin
  fVl_Frete := Value;
end;

procedure TTransitem.SetVl_Seguro(const Value : Real);
begin
  fVl_Seguro := Value;
end;

procedure TTransitem.SetVl_Outro(const Value : Real);
begin
  fVl_Outro := Value;
end;

procedure TTransitem.SetVl_Despesa(const Value : Real);
begin
  fVl_Despesa := Value;
end;

function TTransitem.GetVl_Desconto: Real;
begin
  Result :=
    IfThen(Vl_Variacao < 0, Vl_Variacao, 0) +
    IfThen(Vl_Variacaocapa < 0, Vl_Variacaocapa, 0);
end;

function TTransitem.GetVl_Acrescimo: Real;
begin
  Result :=
    IfThen(Vl_Variacao > 0, Vl_Variacao, 0) +
    IfThen(Vl_Variacaocapa > 0, Vl_Variacaocapa, 0);
end;

function TTransitem.GetVl_Baseicms: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Baseicms');
end;

function TTransitem.GetVl_Icms: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Icms');
end;

function TTransitem.GetVl_Baseicmsst: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Baseicmsst');
end;

function TTransitem.GetVl_Icmsst: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Icmsst');
end;

function TTransitem.GetVl_Cofins: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Cofins');
end;

function TTransitem.GetVl_Ii: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Ii');
end;

function TTransitem.GetVl_Ipi: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Ipi');
end;

function TTransitem.GetVl_Pis: Real;
begin
  Result := TmList(fImpostos).Sum('Vl_Pis');
end;

function TTransitem.GetVl_Totitem: Real;
begin
  Result := Vl_Unitario * Qt_Item;
end;

{ TTransitems }

function TTransitems.Add: TTransitem;
begin
  Result := TTransitem.Create(nil);
  Self.Add(Result);
end;

end.
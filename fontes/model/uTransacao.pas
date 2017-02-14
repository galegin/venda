unit uTransacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uEmpresa, uOperacao, uPessoa, uTransitem, uTransvencto, uTranspagto,
  uTransfiscal;

type
  TTransacao = class;
  TTransacaoClass = class of TTransacao;

  TTransacaoList = class;
  TTransacaoListClass = class of TTransacaoList;

  TTransacao = class(TmCollectionItem)
  private
    fCd_Dnatrans: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDt_Transacao: TDateTime;
    fNr_Transacao: Integer;
    fNr_Cpfcnpj: String;
    fCd_Operacao: String;
    fCd_Dnapagto: String;
    fDt_Canc: TDateTime;

    fObj_Empresa: TEmpresa;
    fObj_Pessoa: TPessoa;
    fObj_Operacao: TOperacao;
    fObj_Fiscal: TTransfiscal;

    fList_Item: TTransitemList;
    fList_Vencto: TTransvenctoList;
    fList_Pagto: TTranspagtoList;

    function GetVl_Item: Real;
    function GetVl_Variacao: Real;
    function GetVl_Total: Real;
    function GetVl_Acrescimo: Real;
    function GetVl_Desconto: Real;
    function GetVl_Frete: Real;
    function GetVl_Despesa: Real;
    function GetVl_Seguro: Real;
    function GetVl_Outro: Real;

    function GetVl_Baseicms: Real;
    function GetVl_Icms: Real;
    function GetVl_Baseicmsst: Real;
    function GetVl_Icmsst: Real;
    function GetVl_Ipi: Real;
    function GetVl_Pis: Real;
    function GetVl_Cofins: Real;
    function GetVl_Ii: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write fCd_Dnatrans;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Equip : String read fCd_Equip write fCd_Equip;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Transacao : Integer read fNr_Transacao write fNr_Transacao;
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property Cd_Dnapagto : String read fCd_Dnapagto write fCd_Dnapagto;
    property Dt_Canc : TDateTime read fDt_Canc write fDt_Canc;

    property Obj_Empresa: TEmpresa read fObj_Empresa write fObj_Empresa;
    property Obj_Pessoa: TPessoa read fObj_Pessoa write fObj_Pessoa;
    property Obj_Operacao: TOperacao read fObj_Operacao write fObj_Operacao;
    property Obj_Fiscal: TTransfiscal read fObj_Fiscal write fObj_Fiscal;

    property List_Item: TTransitemList read fList_Item write fList_Item;
    property List_Vencto: TTransvenctoList read fList_Vencto write fList_Vencto;
    property List_Pagto: TTranspagtoList read fList_Pagto write fList_Pagto;

    property Vl_Item : Real read GetVl_Item;
    property Vl_Variacao : Real read GetVl_Variacao;
    property Vl_Total : Real read GetVl_Total;
    property Vl_Desconto : Real read GetVl_Desconto;
    property Vl_Acrescimo : Real read GetVl_Acrescimo;
    property Vl_Frete : Real read GetVl_Frete;
    property Vl_Seguro : Real read GetVl_Seguro;
    property Vl_Despesa : Real read GetVl_Despesa;
    property Vl_Outro : Real read GetVl_Outro;

    property Vl_Baseicms : Real read GetVl_Baseicms;
    property Vl_Icms : Real read GetVl_Icms;
    property Vl_Baseicmsst : Real read GetVl_Baseicmsst;
    property Vl_Icmsst : Real read GetVl_Icmsst;
    property Vl_Ipi : Real read GetVl_Ipi;
    property Vl_Pis : Real read GetVl_Pis;
    property Vl_Cofins : Real read GetVl_Cofins;
    property Vl_Ii : Real read GetVl_Ii;
  end;

  TTransacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransacao;
    procedure SetItem(Index: Integer; Value: TTransacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTransacao;
    property Items[Index: Integer]: TTransacao read GetItem write SetItem; default;
  end;

implementation

{ TTransacao }

constructor TTransacao.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Empresa:= TEmpresa.Create(nil);
  fObj_Pessoa:= TPessoa.Create(nil);
  fObj_Operacao:= TOperacao.Create(nil);
  fObj_Fiscal:= TTransfiscal.Create(nil);

  fList_Item:= TTransitemList.Create(nil);
  fList_Item.IsUpdate := True;
  fList_Vencto:= TTransvenctoList.Create(nil);
  fList_Vencto.IsUpdate := True;
  fList_Pagto:= TTranspagtoList.Create(nil);
  fList_Pagto.IsUpdate := True;
end;

destructor TTransacao.Destroy;
begin

  inherited;
end;

//--

function TTransacao.GetVl_Item: Real;
begin
  Result := List_Item.Sum('Vl_Item');
end;

function TTransacao.GetVl_Variacao: Real;
begin
  Result := List_Item.Sum('Vl_Variacao') + List_Item.Sum('Vl_VariacaoCapa');
end;

function TTransacao.GetVl_Total: Real;
begin
  Result := List_Item.Sum('Vl_Totitem');
end;

function TTransacao.GetVl_Acrescimo: Real;
begin
  Result := List_Item.Sum('Vl_Acrescimo');
end;

function TTransacao.GetVl_Desconto: Real;
begin
  Result := List_Item.Sum('Vl_Desconto');
end;

function TTransacao.GetVl_Frete: Real;
begin
  Result := List_Item.Sum('Vl_Frete');
end;

function TTransacao.GetVl_Outro: Real;
begin
  Result := List_Item.Sum('Vl_Outro');
end;

function TTransacao.GetVl_Despesa: Real;
begin
  Result := List_Item.Sum('Vl_Despesa');
end;

function TTransacao.GetVl_Seguro: Real;
begin
  Result := List_Item.Sum('Vl_Seguro');
end;

function TTransacao.GetVl_Baseicms: Real;
begin
  Result := List_Item.Sum('Vl_Baseicms');
end;

function TTransacao.GetVl_Icms: Real;
begin
  Result := List_Item.Sum('Vl_Icms');
end;

function TTransacao.GetVl_Baseicmsst: Real;
begin
  Result := List_Item.Sum('Vl_Baseicmsst');
end;

function TTransacao.GetVl_Icmsst: Real;
begin
  Result := List_Item.Sum('Vl_Icmsst');
end;

function TTransacao.GetVl_Ipi: Real;
begin
  Result := List_Item.Sum('Vl_Ipi');
end;

function TTransacao.GetVl_Pis: Real;
begin
  Result := List_Item.Sum('Vl_Pis');
end;

function TTransacao.GetVl_Cofins: Real;
begin
  Result := List_Item.Sum('Vl_Cofins');
end;

function TTransacao.GetVl_Ii: Real;
begin
  Result := List_Item.Sum('Vl_Ii');
end;

{ TTransacaoList }

constructor TTransacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTransacao);
end;

function TTransacaoList.Add: TTransacao;
begin
  Result := TTransacao(inherited Add);
  Result.create(Self);
end;

function TTransacaoList.GetItem(Index: Integer): TTransacao;
begin
  Result := TTransacao(inherited GetItem(Index));
end;

procedure TTransacaoList.SetItem(Index: Integer; Value: TTransacao);
begin
  inherited SetItem(Index, Value);
end;

end.
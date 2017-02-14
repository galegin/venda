unit uTransitem;

interface

uses
  Classes, SysUtils, Math,
  mCollection, mCollectionItem,
  uProduto, uTransimposto;

type
  TTransitem = class;
  TTransitemClass = class of TTransitem;

  TTransitemList = class;
  TTransitemListClass = class of TTransitemList;

  TTransitem = class(TmCollectionItem)
  private
    fCd_Dnatrans: String;
    fNr_Item: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Barraprd: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Especie: String;
    fCd_Ncm: String;
    fCd_Cfop: Integer;
    fQt_Item: Real;
    fVl_Custo: Real;
    fVl_Unitario: Real;
    fVl_Item: Real;
    fVl_Variacao: Real;
    fVl_VariacaoCapa: Real;
    fVl_Frete: Real;
    fVl_Seguro: Real;
    fVl_Outro: Real;
    fVl_Despesa: Real;

    fObj_Produto: TProduto;

    fList_Imposto: TTransimpostoList;
    
    function GetVl_Totitem: Real;
    function GetVl_Desconto: Real;
    function GetVl_Acrescimo: Real;
    function GetVl_AcrescimoCapa: Real;
    function GetVl_AcrescimoItem: Real;
    function GetVl_DescontoCapa: Real;
    function GetVl_DescontoItem: Real;
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
    property Cd_Dnatrans: String read fCd_Dnatrans write fCd_Dnatrans;
    property Nr_Item: Integer read fNr_Item write fNr_Item;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Barraprd: String read fCd_Barraprd write fCd_Barraprd;
    property Cd_Produto: Integer read fCd_Produto write fCd_Produto;
    property Ds_Produto: String read fDs_Produto write fDs_Produto;
    property Cd_Especie: String read fCd_Especie write fCd_Especie;
    property Cd_Ncm: String read fCd_Ncm write fCd_Ncm;
    property Cd_Cfop: Integer read fCd_Cfop write fCd_Cfop;
    property Qt_Item: Real read fQt_Item write fQt_Item;
    property Vl_Custo: Real read fVl_Custo write fVl_Custo;
    property Vl_Unitario: Real read fVl_Unitario write fVl_Unitario;
    property Vl_Item: Real read fVl_Item write fVl_Item;
    property Vl_Variacao: Real read fVl_Variacao write fVl_Variacao;
    property Vl_VariacaoCapa: Real read fVl_VariacaoCapa write fVl_VariacaoCapa;
    property Vl_Frete: Real read fVl_Frete write fVl_Frete;
    property Vl_Seguro: Real read fVl_Seguro write fVl_Seguro;
    property Vl_Outro: Real read fVl_Outro write fVl_Outro;
    property Vl_Despesa: Real read fVl_Despesa write fVl_Despesa;

    property Obj_Produto: TProduto read fObj_Produto write fObj_Produto;

    property List_Imposto: TTransimpostoList read fList_Imposto write fList_Imposto;

    property Vl_Totitem: Real read GetVl_Totitem;

    property Vl_Desconto: Real read GetVl_Desconto;
    property Vl_DescontoCapa: Real read GetVl_DescontoCapa;
    property Vl_DescontoItem: Real read GetVl_DescontoItem;

    property Vl_Acrescimo: Real read GetVl_Acrescimo;
    property Vl_AcrescimoCapa: Real read GetVl_AcrescimoCapa;
    property Vl_AcrescimoItem: Real read GetVl_AcrescimoItem;

    property Vl_Baseicms : Real read GetVl_Baseicms;
    property Vl_Icms : Real read GetVl_Icms;
    property Vl_Baseicmsst : Real read GetVl_Baseicmsst;
    property Vl_Icmsst : Real read GetVl_Icmsst;
    property Vl_Ipi : Real read GetVl_Ipi;
    property Vl_Pis : Real read GetVl_Pis;
    property Vl_Cofins : Real read GetVl_Cofins;
    property Vl_Ii : Real read GetVl_Ii;
  end;

  TTransitemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransitem;
    procedure SetItem(Index: Integer; Value: TTransitem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTransitem;
    property Items[Index: Integer]: TTransitem read GetItem write SetItem; default;
  end;

implementation

{ TTransitem }

constructor TTransitem.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Produto:= TProduto.Create(nil);

  fList_Imposto:= TTransimpostoList.Create(nil);
  fList_Imposto.IsUpdate := True;
end;

destructor TTransitem.Destroy;
begin

  inherited;
end;

//--

function TTransitem.GetVl_Acrescimo: Real;
begin
  Result := Vl_AcrescimoCapa + Vl_AcrescimoItem;
end;

function TTransitem.GetVl_AcrescimoCapa: Real;
begin
  Result :=IfThen(Vl_VariacaoCapa > 0, Vl_VariacaoCapa, 0);
end;

function TTransitem.GetVl_AcrescimoItem: Real;
begin
  Result :=IfThen(Vl_Variacao > 0, Vl_Variacao, 0);
end;

//--

function TTransitem.GetVl_Desconto: Real;
begin
  Result := Vl_DescontoCapa + Vl_DescontoItem;
end;

function TTransitem.GetVl_DescontoCapa: Real;
begin
  Result :=IfThen(Vl_VariacaoCapa < 0, Vl_VariacaoCapa * -1, 0);
end;

function TTransitem.GetVl_DescontoItem: Real;
begin
  Result :=IfThen(Vl_Variacao < 0, Vl_Variacao * -1, 0);
end;

//--

function TTransitem.GetVl_Totitem: Real;
begin
  Result := Vl_Item - Vl_Desconto + Vl_Acrescimo;
end;

//--

function TTransitem.GetVl_Baseicms: Real;
begin
  Result := List_Imposto.Sum('Vl_Baseicms');
end;

function TTransitem.GetVl_Icms: Real;
begin
  Result := List_Imposto.Sum('Vl_Icms');
end;

function TTransitem.GetVl_Baseicmsst: Real;
begin
  Result := List_Imposto.Sum('Vl_Baseicmsst');
end;

function TTransitem.GetVl_Icmsst: Real;
begin
  Result := List_Imposto.Sum('Vl_Icmsst');
end;

function TTransitem.GetVl_Ipi: Real;
begin
  Result := List_Imposto.Sum('Vl_Ipi');
end;

function TTransitem.GetVl_Pis: Real;
begin
  Result := List_Imposto.Sum('Vl_Pis');
end;

function TTransitem.GetVl_Cofins: Real;
begin
  Result := List_Imposto.Sum('Vl_Cofins');
end;

function TTransitem.GetVl_Ii: Real;
begin
  Result := List_Imposto.Sum('Vl_Ii');
end;

{ TTransitemList }

constructor TTransitemList.Create(AOwner: TPersistent);
begin
  inherited Create(TTransitem);
end;

function TTransitemList.Add: TTransitem;
begin
  Result := TTransitem(inherited Add);
  Result.create(Self);
end;

function TTransitemList.GetItem(Index: Integer): TTransitem;
begin
  Result := TTransitem(inherited GetItem(Index));
end;

procedure TTransitemList.SetItem(Index: Integer; Value: TTransitem);
begin
  inherited SetItem(Index, Value);
end;

end.
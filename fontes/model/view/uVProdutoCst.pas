unit uVProdutoCst;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Cst = class;
  TV_Produto_CstClass = class of TV_Produto_Cst;

  TV_Produto_CstList = class;
  TV_Produto_CstListClass = class of TV_Produto_CstList;

  TV_Produto_Cst = class(TmCollectionItem)
  private
    fCd_Barraprd: String;
    fCd_Produto: Real;
    fDs_Produto: String;
    fVl_Venda: Real;
    fVl_Custo: Real;
    fVl_Ganho: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Vl_Venda : Real read fVl_Venda write fVl_Venda;
    property Vl_Custo : Real read fVl_Custo write fVl_Custo;
    property Vl_Ganho : Real read fVl_Ganho write fVl_Ganho;
  end;

  TV_Produto_CstList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Cst;
    procedure SetItem(Index: Integer; Value: TV_Produto_Cst);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Cst;
    property Items[Index: Integer]: TV_Produto_Cst read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Cst }

constructor TV_Produto_Cst.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Cst.Destroy;
begin

  inherited;
end;

{ TV_Produto_CstList }

constructor TV_Produto_CstList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Cst);
end;

function TV_Produto_CstList.Add: TV_Produto_Cst;
begin
  Result := TV_Produto_Cst(inherited Add);
  Result.create;
end;

function TV_Produto_CstList.GetItem(Index: Integer): TV_Produto_Cst;
begin
  Result := TV_Produto_Cst(inherited GetItem(Index));
end;

procedure TV_Produto_CstList.SetItem(Index: Integer; Value: TV_Produto_Cst);
begin
  inherited SetItem(Index, Value);
end;

end.
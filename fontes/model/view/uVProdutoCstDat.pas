unit uVProdutoCstDat;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Cst_Dat = class;
  TV_Produto_Cst_DatClass = class of TV_Produto_Cst_Dat;

  TV_Produto_Cst_DatList = class;
  TV_Produto_Cst_DatListClass = class of TV_Produto_Cst_DatList;

  TV_Produto_Cst_Dat = class(TmCollectionItem)
  private
    fDt_Transacao: TDateTime;
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
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Vl_Venda : Real read fVl_Venda write fVl_Venda;
    property Vl_Custo : Real read fVl_Custo write fVl_Custo;
    property Vl_Ganho : Real read fVl_Ganho write fVl_Ganho;
  end;

  TV_Produto_Cst_DatList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Cst_Dat;
    procedure SetItem(Index: Integer; Value: TV_Produto_Cst_Dat);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Cst_Dat;
    property Items[Index: Integer]: TV_Produto_Cst_Dat read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Cst_Dat }

constructor TV_Produto_Cst_Dat.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Cst_Dat.Destroy;
begin

  inherited;
end;

{ TV_Produto_Cst_DatList }

constructor TV_Produto_Cst_DatList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Cst_Dat);
end;

function TV_Produto_Cst_DatList.Add: TV_Produto_Cst_Dat;
begin
  Result := TV_Produto_Cst_Dat(inherited Add);
  Result.create;
end;

function TV_Produto_Cst_DatList.GetItem(Index: Integer): TV_Produto_Cst_Dat;
begin
  Result := TV_Produto_Cst_Dat(inherited GetItem(Index));
end;

procedure TV_Produto_Cst_DatList.SetItem(Index: Integer; Value: TV_Produto_Cst_Dat);
begin
  inherited SetItem(Index, Value);
end;

end.
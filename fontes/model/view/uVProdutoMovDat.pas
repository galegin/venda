unit uVProdutoMovDat;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Mov_Dat = class;
  TV_Produto_Mov_DatClass = class of TV_Produto_Mov_Dat;

  TV_Produto_Mov_DatList = class;
  TV_Produto_Mov_DatListClass = class of TV_Produto_Mov_DatList;

  TV_Produto_Mov_Dat = class(TmCollectionItem)
  private
    fDt_Transacao: TDateTime;
    fCd_Barraprd: String;
    fCd_Produto: Real;
    fDs_Produto: String;
    fQt_Ent: Real;
    fQt_Sai: Real;
    fQt_Atu: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Qt_Ent : Real read fQt_Ent write fQt_Ent;
    property Qt_Sai : Real read fQt_Sai write fQt_Sai;
    property Qt_Atu : Real read fQt_Atu write fQt_Atu;
  end;

  TV_Produto_Mov_DatList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Mov_Dat;
    procedure SetItem(Index: Integer; Value: TV_Produto_Mov_Dat);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Mov_Dat;
    property Items[Index: Integer]: TV_Produto_Mov_Dat read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Mov_Dat }

constructor TV_Produto_Mov_Dat.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Mov_Dat.Destroy;
begin

  inherited;
end;

{ TV_Produto_Mov_DatList }

constructor TV_Produto_Mov_DatList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Mov_Dat);
end;

function TV_Produto_Mov_DatList.Add: TV_Produto_Mov_Dat;
begin
  Result := TV_Produto_Mov_Dat(inherited Add);
  Result.create;
end;

function TV_Produto_Mov_DatList.GetItem(Index: Integer): TV_Produto_Mov_Dat;
begin
  Result := TV_Produto_Mov_Dat(inherited GetItem(Index));
end;

procedure TV_Produto_Mov_DatList.SetItem(Index: Integer; Value: TV_Produto_Mov_Dat);
begin
  inherited SetItem(Index, Value);
end;

end.
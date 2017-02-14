unit uVProdutoInv;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Inv = class;
  TV_Produto_InvClass = class of TV_Produto_Inv;

  TV_Produto_InvList = class;
  TV_Produto_InvListClass = class of TV_Produto_InvList;

  TV_Produto_Inv = class(TmCollectionItem)
  private
    fDt_Transacao: TDateTime;
    fCd_Barraprd: String;
    fCd_Produto: Real;
    fDs_Produto: String;
    fQt_Ant: Real;
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
    property Qt_Ant : Real read fQt_Ant write fQt_Ant;
    property Qt_Ent : Real read fQt_Ent write fQt_Ent;
    property Qt_Sai : Real read fQt_Sai write fQt_Sai;
    property Qt_Atu : Real read fQt_Atu write fQt_Atu;
  end;

  TV_Produto_InvList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Inv;
    procedure SetItem(Index: Integer; Value: TV_Produto_Inv);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Inv;
    property Items[Index: Integer]: TV_Produto_Inv read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Inv }

constructor TV_Produto_Inv.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Inv.Destroy;
begin

  inherited;
end;

{ TV_Produto_InvList }

constructor TV_Produto_InvList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Inv);
end;

function TV_Produto_InvList.Add: TV_Produto_Inv;
begin
  Result := TV_Produto_Inv(inherited Add);
  Result.create;
end;

function TV_Produto_InvList.GetItem(Index: Integer): TV_Produto_Inv;
begin
  Result := TV_Produto_Inv(inherited GetItem(Index));
end;

procedure TV_Produto_InvList.SetItem(Index: Integer; Value: TV_Produto_Inv);
begin
  inherited SetItem(Index, Value);
end;

end.
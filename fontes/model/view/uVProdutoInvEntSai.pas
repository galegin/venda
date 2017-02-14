unit uVProdutoInvEntSai;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Inv_Ent_Sai = class;
  TV_Produto_Inv_Ent_SaiClass = class of TV_Produto_Inv_Ent_Sai;

  TV_Produto_Inv_Ent_SaiList = class;
  TV_Produto_Inv_Ent_SaiListClass = class of TV_Produto_Inv_Ent_SaiList;

  TV_Produto_Inv_Ent_Sai = class(TmCollectionItem)
  private
    fDt_Transacao: TDateTime;
    fCd_Barraprd: String;
    fCd_Produto: Real;
    fDs_Produto: String;
    fQt_Ent: Real;
    fQt_Sai: Real;
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
  end;

  TV_Produto_Inv_Ent_SaiList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Inv_Ent_Sai;
    procedure SetItem(Index: Integer; Value: TV_Produto_Inv_Ent_Sai);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Inv_Ent_Sai;
    property Items[Index: Integer]: TV_Produto_Inv_Ent_Sai read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Inv_Ent_Sai }

constructor TV_Produto_Inv_Ent_Sai.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Inv_Ent_Sai.Destroy;
begin

  inherited;
end;

{ TV_Produto_Inv_Ent_SaiList }

constructor TV_Produto_Inv_Ent_SaiList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Inv_Ent_Sai);
end;

function TV_Produto_Inv_Ent_SaiList.Add: TV_Produto_Inv_Ent_Sai;
begin
  Result := TV_Produto_Inv_Ent_Sai(inherited Add);
  Result.create;
end;

function TV_Produto_Inv_Ent_SaiList.GetItem(Index: Integer): TV_Produto_Inv_Ent_Sai;
begin
  Result := TV_Produto_Inv_Ent_Sai(inherited GetItem(Index));
end;

procedure TV_Produto_Inv_Ent_SaiList.SetItem(Index: Integer; Value: TV_Produto_Inv_Ent_Sai);
begin
  inherited SetItem(Index, Value);
end;

end.
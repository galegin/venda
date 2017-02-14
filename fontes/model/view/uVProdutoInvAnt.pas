unit uVProdutoInvAnt;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Inv_Ant = class;
  TV_Produto_Inv_AntClass = class of TV_Produto_Inv_Ant;

  TV_Produto_Inv_AntList = class;
  TV_Produto_Inv_AntListClass = class of TV_Produto_Inv_AntList;

  TV_Produto_Inv_Ant = class(TmCollectionItem)
  private
    fDt_Transacao: TDateTime;
    fCd_Barraprd: String;
    fCd_Produto: Real;
    fDs_Produto: String;
    fQt_Ant: Real;
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
    property Qt_Ant : Real read fQt_Ant write fQt_Ant;
    property Qt_Ent : Real read fQt_Ent write fQt_Ent;
    property Qt_Sai : Real read fQt_Sai write fQt_Sai;
  end;

  TV_Produto_Inv_AntList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Inv_Ant;
    procedure SetItem(Index: Integer; Value: TV_Produto_Inv_Ant);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Inv_Ant;
    property Items[Index: Integer]: TV_Produto_Inv_Ant read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Inv_Ant }

constructor TV_Produto_Inv_Ant.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Inv_Ant.Destroy;
begin

  inherited;
end;

{ TV_Produto_Inv_AntList }

constructor TV_Produto_Inv_AntList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Inv_Ant);
end;

function TV_Produto_Inv_AntList.Add: TV_Produto_Inv_Ant;
begin
  Result := TV_Produto_Inv_Ant(inherited Add);
  Result.create;
end;

function TV_Produto_Inv_AntList.GetItem(Index: Integer): TV_Produto_Inv_Ant;
begin
  Result := TV_Produto_Inv_Ant(inherited GetItem(Index));
end;

procedure TV_Produto_Inv_AntList.SetItem(Index: Integer; Value: TV_Produto_Inv_Ant);
begin
  inherited SetItem(Index, Value);
end;

end.
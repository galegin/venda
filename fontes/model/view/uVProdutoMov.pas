unit uVProdutoMov;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Produto_Mov = class;
  TV_Produto_MovClass = class of TV_Produto_Mov;

  TV_Produto_MovList = class;
  TV_Produto_MovListClass = class of TV_Produto_MovList;

  TV_Produto_Mov = class(TmCollectionItem)
  private
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
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Ds_Produto : String read fDs_Produto write fDs_Produto;
    property Qt_Ent : Real read fQt_Ent write fQt_Ent;
    property Qt_Sai : Real read fQt_Sai write fQt_Sai;
    property Qt_Atu : Real read fQt_Atu write fQt_Atu;
  end;

  TV_Produto_MovList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Produto_Mov;
    procedure SetItem(Index: Integer; Value: TV_Produto_Mov);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Produto_Mov;
    property Items[Index: Integer]: TV_Produto_Mov read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Produto_Mov }

constructor TV_Produto_Mov.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Produto_Mov.Destroy;
begin

  inherited;
end;

{ TV_Produto_MovList }

constructor TV_Produto_MovList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Produto_Mov);
end;

function TV_Produto_MovList.Add: TV_Produto_Mov;
begin
  Result := TV_Produto_Mov(inherited Add);
  Result.create;
end;

function TV_Produto_MovList.GetItem(Index: Integer): TV_Produto_Mov;
begin
  Result := TV_Produto_Mov(inherited GetItem(Index));
end;

procedure TV_Produto_MovList.SetItem(Index: Integer; Value: TV_Produto_Mov);
begin
  inherited SetItem(Index, Value);
end;

end.
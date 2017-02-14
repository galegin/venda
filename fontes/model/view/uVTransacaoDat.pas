unit uVTransacaoDat;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Transacao_Dat = class;
  TV_Transacao_DatClass = class of TV_Transacao_Dat;

  TV_Transacao_DatList = class;
  TV_Transacao_DatListClass = class of TV_Transacao_DatList;

  TV_Transacao_Dat = class(TmCollectionItem)
  private
    fDt_Transacao: TDateTime;
    fQt_Transacao: Integer;
    fVl_Item: Real;
    fVl_Desc: Real;
    fVl_Acres: Real;
    fVl_Total: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Qt_Transacao : Integer read fQt_Transacao write fQt_Transacao;
    property Vl_Item : Real read fVl_Item write fVl_Item;
    property Vl_Desc : Real read fVl_Desc write fVl_Desc;
    property Vl_Acres : Real read fVl_Acres write fVl_Acres;
    property Vl_Total : Real read fVl_Total write fVl_Total;
  end;

  TV_Transacao_DatList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Transacao_Dat;
    procedure SetItem(Index: Integer; Value: TV_Transacao_Dat);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Transacao_Dat;
    property Items[Index: Integer]: TV_Transacao_Dat read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Transacao_Dat }

constructor TV_Transacao_Dat.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Transacao_Dat.Destroy;
begin

  inherited;
end;

{ TV_Transacao_DatList }

constructor TV_Transacao_DatList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Transacao_Dat);
end;

function TV_Transacao_DatList.Add: TV_Transacao_Dat;
begin
  Result := TV_Transacao_Dat(inherited Add);
  Result.create;
end;

function TV_Transacao_DatList.GetItem(Index: Integer): TV_Transacao_Dat;
begin
  Result := TV_Transacao_Dat(inherited GetItem(Index));
end;

procedure TV_Transacao_DatList.SetItem(Index: Integer; Value: TV_Transacao_Dat);
begin
  inherited SetItem(Index, Value);
end;

end.
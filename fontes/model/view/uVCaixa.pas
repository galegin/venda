unit uVCaixa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Caixa = class;
  TV_CaixaClass = class of TV_Caixa;

  TV_CaixaList = class;
  TV_CaixaListClass = class of TV_CaixaList;

  TV_Caixa = class(TmCollectionItem)
  private
    fCd_Dnacaixa: String;
    fDt_Caixa: TDateTime;
    fNr_Seq: Real;
    fVl_Abert: Real;
    fDt_Fechado: TDateTime;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnacaixa : String read fCd_Dnacaixa write fCd_Dnacaixa;
    property Dt_Caixa : TDateTime read fDt_Caixa write fDt_Caixa;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Vl_Abert : Real read fVl_Abert write fVl_Abert;
    property Dt_Fechado : TDateTime read fDt_Fechado write fDt_Fechado;
  end;

  TV_CaixaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Caixa;
    procedure SetItem(Index: Integer; Value: TV_Caixa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Caixa;
    property Items[Index: Integer]: TV_Caixa read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Caixa }

constructor TV_Caixa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Caixa.Destroy;
begin

  inherited;
end;

{ TV_CaixaList }

constructor TV_CaixaList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Caixa);
end;

function TV_CaixaList.Add: TV_Caixa;
begin
  Result := TV_Caixa(inherited Add);
  Result.create;
end;

function TV_CaixaList.GetItem(Index: Integer): TV_Caixa;
begin
  Result := TV_Caixa(inherited GetItem(Index));
end;

procedure TV_CaixaList.SetItem(Index: Integer; Value: TV_Caixa);
begin
  inherited SetItem(Index, Value);
end;

end.
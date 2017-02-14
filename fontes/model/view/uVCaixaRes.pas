unit uVCaixaRes;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Caixa_Res = class;
  TV_Caixa_ResClass = class of TV_Caixa_Res;

  TV_Caixa_ResList = class;
  TV_Caixa_ResListClass = class of TV_Caixa_ResList;

  TV_Caixa_Res = class(TmCollectionItem)
  private
    fCd_Dnacaixa: String;
    fDt_Caixa: TDateTime;
    fNr_Seq: Real;
    fVl_Abert: Real;
    fDt_Fechado: TDateTime;
    fVl_Dinheiro: Real;
    fVl_Troco: Real;
    fVl_Cartao: Real;
    fVl_Cheque: Real;
    fVl_Carne: Real;
    fVl_Entrada: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnacaixa : String read fCd_Dnacaixa write fCd_Dnacaixa;
    property Dt_Caixa : TDateTime read fDt_Caixa write fDt_Caixa;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Vl_Abert : Real read fVl_Abert write fVl_Abert;
    property Dt_Fechado : TDateTime read fDt_Fechado write fDt_Fechado;
    property Vl_Dinheiro : Real read fVl_Dinheiro write fVl_Dinheiro;
    property Vl_Troco : Real read fVl_Troco write fVl_Troco;
    property Vl_Cartao : Real read fVl_Cartao write fVl_Cartao;
    property Vl_Cheque : Real read fVl_Cheque write fVl_Cheque;
    property Vl_Carne : Real read fVl_Carne write fVl_Carne;
    property Vl_Entrada : Real read fVl_Entrada write fVl_Entrada;
  end;

  TV_Caixa_ResList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Caixa_Res;
    procedure SetItem(Index: Integer; Value: TV_Caixa_Res);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Caixa_Res;
    property Items[Index: Integer]: TV_Caixa_Res read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Caixa_Res }

constructor TV_Caixa_Res.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Caixa_Res.Destroy;
begin

  inherited;
end;

{ TV_Caixa_ResList }

constructor TV_Caixa_ResList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Caixa_Res);
end;

function TV_Caixa_ResList.Add: TV_Caixa_Res;
begin
  Result := TV_Caixa_Res(inherited Add);
  Result.create;
end;

function TV_Caixa_ResList.GetItem(Index: Integer): TV_Caixa_Res;
begin
  Result := TV_Caixa_Res(inherited GetItem(Index));
end;

procedure TV_Caixa_ResList.SetItem(Index: Integer; Value: TV_Caixa_Res);
begin
  inherited SetItem(Index, Value);
end;

end.
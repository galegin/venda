unit uVCaixaResDoc;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Caixa_Res_Doc = class;
  TV_Caixa_Res_DocClass = class of TV_Caixa_Res_Doc;

  TV_Caixa_Res_DocList = class;
  TV_Caixa_Res_DocListClass = class of TV_Caixa_Res_DocList;

  TV_Caixa_Res_Doc = class(TmCollectionItem)
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
  end;

  TV_Caixa_Res_DocList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Caixa_Res_Doc;
    procedure SetItem(Index: Integer; Value: TV_Caixa_Res_Doc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Caixa_Res_Doc;
    property Items[Index: Integer]: TV_Caixa_Res_Doc read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Caixa_Res_Doc }

constructor TV_Caixa_Res_Doc.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Caixa_Res_Doc.Destroy;
begin

  inherited;
end;

{ TV_Caixa_Res_DocList }

constructor TV_Caixa_Res_DocList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Caixa_Res_Doc);
end;

function TV_Caixa_Res_DocList.Add: TV_Caixa_Res_Doc;
begin
  Result := TV_Caixa_Res_Doc(inherited Add);
  Result.create;
end;

function TV_Caixa_Res_DocList.GetItem(Index: Integer): TV_Caixa_Res_Doc;
begin
  Result := TV_Caixa_Res_Doc(inherited GetItem(Index));
end;

procedure TV_Caixa_Res_DocList.SetItem(Index: Integer; Value: TV_Caixa_Res_Doc);
begin
  inherited SetItem(Index, Value);
end;

end.
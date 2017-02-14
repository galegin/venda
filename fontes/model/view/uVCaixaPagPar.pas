unit uVCaixaPagPar;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Caixa_Pag_Par = class;
  TV_Caixa_Pag_ParClass = class of TV_Caixa_Pag_Par;

  TV_Caixa_Pag_ParList = class;
  TV_Caixa_Pag_ParListClass = class of TV_Caixa_Pag_ParList;

  TV_Caixa_Pag_Par = class(TmCollectionItem)
  private
    fCd_Dnacaixa: String;
    fDt_Caixa: TDateTime;
    fNr_Seq: Real;
    fVl_Abert: Real;
    fDt_Fechado: TDateTime;
    fCd_Dnapagto: String;
    fDt_Pagto: TDateTime;
    fNr_Pagto: Real;
    fVl_Pagto: Real;
    fVl_Entr: Real;
    fVl_Troco: Real;
    fVl_Desc: Real;
    fVl_Acres: Real;
    fNr_Parc: Real;
    fVl_Parc: Real;
    fTp_Doc: Real;
    fNr_Doc: Real;
    fDt_Venc: TDateTime;
    fDs_Adic: String;
    fCd_Dnabaixa: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnacaixa : String read fCd_Dnacaixa write fCd_Dnacaixa;
    property Dt_Caixa : TDateTime read fDt_Caixa write fDt_Caixa;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Vl_Abert : Real read fVl_Abert write fVl_Abert;
    property Dt_Fechado : TDateTime read fDt_Fechado write fDt_Fechado;
    property Cd_Dnapagto : String read fCd_Dnapagto write fCd_Dnapagto;
    property Dt_Pagto : TDateTime read fDt_Pagto write fDt_Pagto;
    property Nr_Pagto : Real read fNr_Pagto write fNr_Pagto;
    property Vl_Pagto : Real read fVl_Pagto write fVl_Pagto;
    property Vl_Entr : Real read fVl_Entr write fVl_Entr;
    property Vl_Troco : Real read fVl_Troco write fVl_Troco;
    property Vl_Desc : Real read fVl_Desc write fVl_Desc;
    property Vl_Acres : Real read fVl_Acres write fVl_Acres;
    property Nr_Parc : Real read fNr_Parc write fNr_Parc;
    property Vl_Parc : Real read fVl_Parc write fVl_Parc;
    property Tp_Doc : Real read fTp_Doc write fTp_Doc;
    property Nr_Doc : Real read fNr_Doc write fNr_Doc;
    property Dt_Venc : TDateTime read fDt_Venc write fDt_Venc;
    property Ds_Adic : String read fDs_Adic write fDs_Adic;
    property Cd_Dnabaixa : String read fCd_Dnabaixa write fCd_Dnabaixa;
  end;

  TV_Caixa_Pag_ParList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Caixa_Pag_Par;
    procedure SetItem(Index: Integer; Value: TV_Caixa_Pag_Par);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Caixa_Pag_Par;
    property Items[Index: Integer]: TV_Caixa_Pag_Par read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Caixa_Pag_Par }

constructor TV_Caixa_Pag_Par.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Caixa_Pag_Par.Destroy;
begin

  inherited;
end;

{ TV_Caixa_Pag_ParList }

constructor TV_Caixa_Pag_ParList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Caixa_Pag_Par);
end;

function TV_Caixa_Pag_ParList.Add: TV_Caixa_Pag_Par;
begin
  Result := TV_Caixa_Pag_Par(inherited Add);
  Result.create;
end;

function TV_Caixa_Pag_ParList.GetItem(Index: Integer): TV_Caixa_Pag_Par;
begin
  Result := TV_Caixa_Pag_Par(inherited GetItem(Index));
end;

procedure TV_Caixa_Pag_ParList.SetItem(Index: Integer; Value: TV_Caixa_Pag_Par);
begin
  inherited SetItem(Index, Value);
end;

end.
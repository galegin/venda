unit uVPagtoPar;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TV_Pagto_Par = class;
  TV_Pagto_ParClass = class of TV_Pagto_Par;

  TV_Pagto_ParList = class;
  TV_Pagto_ParListClass = class of TV_Pagto_ParList;

  TV_Pagto_Par = class(TmCollectionItem)
  private
    fCd_Dnapagto: String;
    fDt_Pagto: TDateTime;
    fNr_Pagto: Real;
    fVl_Pagto: Real;
    fVl_Entr: Real;
    fVl_Troco: Real;
    fVl_Desc: Real;
    fVl_Acres: Real;
    fCd_Dnacaixa: String;
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
    property Cd_Dnapagto : String read fCd_Dnapagto write fCd_Dnapagto;
    property Dt_Pagto : TDateTime read fDt_Pagto write fDt_Pagto;
    property Nr_Pagto : Real read fNr_Pagto write fNr_Pagto;
    property Vl_Pagto : Real read fVl_Pagto write fVl_Pagto;
    property Vl_Entr : Real read fVl_Entr write fVl_Entr;
    property Vl_Troco : Real read fVl_Troco write fVl_Troco;
    property Vl_Desc : Real read fVl_Desc write fVl_Desc;
    property Vl_Acres : Real read fVl_Acres write fVl_Acres;
    property Cd_Dnacaixa : String read fCd_Dnacaixa write fCd_Dnacaixa;
    property Nr_Parc : Real read fNr_Parc write fNr_Parc;
    property Vl_Parc : Real read fVl_Parc write fVl_Parc;
    property Tp_Doc : Real read fTp_Doc write fTp_Doc;
    property Nr_Doc : Real read fNr_Doc write fNr_Doc;
    property Dt_Venc : TDateTime read fDt_Venc write fDt_Venc;
    property Ds_Adic : String read fDs_Adic write fDs_Adic;
    property Cd_Dnabaixa : String read fCd_Dnabaixa write fCd_Dnabaixa;
  end;

  TV_Pagto_ParList = class(TmCollection)
  private
    function GetItem(Index: Integer): TV_Pagto_Par;
    procedure SetItem(Index: Integer; Value: TV_Pagto_Par);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Pagto_Par;
    property Items[Index: Integer]: TV_Pagto_Par read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Pagto_Par }

constructor TV_Pagto_Par.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TV_Pagto_Par.Destroy;
begin

  inherited;
end;

{ TV_Pagto_ParList }

constructor TV_Pagto_ParList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Pagto_Par);
end;

function TV_Pagto_ParList.Add: TV_Pagto_Par;
begin
  Result := TV_Pagto_Par(inherited Add);
  Result.create;
end;

function TV_Pagto_ParList.GetItem(Index: Integer): TV_Pagto_Par;
begin
  Result := TV_Pagto_Par(inherited GetItem(Index));
end;

procedure TV_Pagto_ParList.SetItem(Index: Integer; Value: TV_Pagto_Par);
begin
  inherited SetItem(Index, Value);
end;

end.
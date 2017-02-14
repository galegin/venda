unit uTranspagto;

(* classe modelagem *)

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTranspagto = class;
  TTranspagtoClass = class of TTranspagto;

  TTranspagtoList = class;
  TTranspagtoListClass = class of TTranspagtoList;

  TTranspagto = class(TmCollectionItem)
  private
    fCd_Dnatrans: String;
    fNr_Pagto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Pagto: Integer;
    fVl_Pagto: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnatrans: String read fCd_Dnatrans write fCd_Dnatrans;
    property Nr_Pagto: Integer read fNr_Pagto write fNr_Pagto;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Pagto: Integer read fTp_Pagto write fTp_Pagto;
    property Vl_Pagto: Real read fVl_Pagto write fVl_Pagto;
  end;

  TTranspagtoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTranspagto;
    procedure SetItem(Index: Integer; Value: TTranspagto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTranspagto;
    property Items[Index: Integer]: TTranspagto read GetItem write SetItem; default;
  end;

implementation

{ TTranspagto }

constructor TTranspagto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTranspagto.Destroy;
begin

  inherited;
end;

{ TTranspagtoList }

constructor TTranspagtoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTranspagto);
end;

function TTranspagtoList.Add: TTranspagto;
begin
  Result := TTranspagto(inherited Add);
  Result.create(Self);
end;

function TTranspagtoList.GetItem(Index: Integer): TTranspagto;
begin
  Result := TTranspagto(inherited GetItem(Index));
end;

procedure TTranspagtoList.SetItem(Index: Integer; Value: TTranspagto);
begin
  inherited SetItem(Index, Value);
end;

end.

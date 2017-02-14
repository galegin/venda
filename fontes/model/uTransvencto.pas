unit uTransvencto;

(* classe modelagem *)

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransvencto = class;
  TTransvenctoClass = class of TTransvencto;

  TTransvenctoList = class;
  TTransvenctoListClass = class of TTransvenctoList;

  TTransvencto = class(TmCollectionItem)
  private
    fCd_Dnatrans: String;
    fNr_Parcela: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDt_Parcela: TDateTime;
    fVl_Parcela: Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnatrans: String read fCd_Dnatrans write fCd_Dnatrans;
    property Nr_Parcela: Integer read fNr_Parcela write fNr_Parcela;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Parcela: TDateTime read fDt_Parcela write fDt_Parcela;
    property Vl_Parcela: Real read fVl_Parcela write fVl_Parcela;
  end;

  TTransvenctoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransvencto;
    procedure SetItem(Index: Integer; Value: TTransvencto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTransvencto;
    property Items[Index: Integer]: TTransvencto read GetItem write SetItem; default;
  end;

implementation

{ TTransvencto }

constructor TTransvencto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransvencto.Destroy;
begin

  inherited;
end;

{ TTransvenctoList }

constructor TTransvenctoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTransvencto);
end;

function TTransvenctoList.Add: TTransvencto;
begin
  Result := TTransvencto(inherited Add);
  Result.create(Self);
end;

function TTransvenctoList.GetItem(Index: Integer): TTransvencto;
begin
  Result := TTransvencto(inherited GetItem(Index));
end;

procedure TTransvenctoList.SetItem(Index: Integer; Value: TTransvencto);
begin
  inherited SetItem(Index, Value);
end;

end.
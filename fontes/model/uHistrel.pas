unit uHistrel;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  THistrel = class;
  THistrelClass = class of THistrel;

  THistrelList = class;
  THistrelListClass = class of THistrelList;

  THistrel = class(TmCollectionItem)
  private
    fCd_Dnahistrel: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fNr_Histrel: Integer;
    fDs_Histrel: String;
    fQt_Parcela: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnahistrel: String read fCd_Dnahistrel write fCd_Dnahistrel;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Equip: String read fCd_Equip write fCd_Equip;
    property Nr_Histrel: Integer read fNr_Histrel write fNr_Histrel;
    property Ds_Histrel: String read fDs_Histrel write fDs_Histrel;
    property Qt_Parcela: Integer read fQt_Parcela write fQt_Parcela;
  end;

  THistrelList = class(TmCollection)
  private
    function GetItem(Index: Integer): THistrel;
    procedure SetItem(Index: Integer; Value: THistrel);
  public
    constructor Create(AOwner: TPersistent);
    function Add: THistrel;
    property Items[Index: Integer]: THistrel read GetItem write SetItem; default;
  end;
  
implementation

{ THistrel }

constructor THistrel.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor THistrel.Destroy;
begin

  inherited;
end;

{ THistrelList }

constructor THistrelList.Create(AOwner: TPersistent);
begin
  inherited Create(THistrel);
end;

function THistrelList.Add: THistrel;
begin
  Result := THistrel(inherited Add);
  Result.create(Self);
end;

function THistrelList.GetItem(Index: Integer): THistrel;
begin
  Result := THistrel(inherited GetItem(Index));
end;

procedure THistrelList.SetItem(Index: Integer; Value: THistrel);
begin
  inherited SetItem(Index, Value);
end;

end.
unit uEquip;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TEquip = class;
  TEquipClass = class of TEquip;

  TEquipList = class;
  TEquipListClass = class of TEquipList;

  TEquip = class(TmCollectionItem)
  private
    fCd_Dnaequip: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDs_Equip: String;
    fCd_Ambiente: String;
    fCd_Empresa: Integer;
    fCd_Terminal: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnaequip: String read fCd_Dnaequip write fCd_Dnaequip;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Equip: String read fCd_Equip write fCd_Equip;
    property Ds_Equip: String read fDs_Equip write fDs_Equip;
    property Cd_Ambiente: String read fCd_Ambiente write fCd_Ambiente;
    property Cd_Empresa: Integer read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal: Integer read fCd_Terminal write fCd_Terminal;
  end;

  TEquipList = class(TmCollection)
  private
    function GetItem(Index: Integer): TEquip;
    procedure SetItem(Index: Integer; Value: TEquip);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TEquip;
    property Items[Index: Integer]: TEquip read GetItem write SetItem; default;
  end;
  
implementation

{ TEquip }

constructor TEquip.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TEquip.Destroy;
begin

  inherited;
end;

{ TEquipList }

constructor TEquipList.Create(AOwner: TPersistent);
begin
  inherited Create(TEquip);
end;

function TEquipList.Add: TEquip;
begin
  Result := TEquip(inherited Add);
  Result.create(Self);
end;

function TEquipList.GetItem(Index: Integer): TEquip;
begin
  Result := TEquip(inherited GetItem(Index));
end;

procedure TEquipList.SetItem(Index: Integer; Value: TEquip);
begin
  inherited SetItem(Index, Value);
end;

end.
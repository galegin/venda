unit uEquipMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uEquip;

type
  TEquipMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TEquipMap }

constructor TEquipMap.Create;
begin
  inherited Create(TEquip);

  ToTable('EQUIP');

  HasKey(['Cd_Equip']);

  Propert('Cd_Dnaequip').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Equip').IsRequired().MaxLength(20);
  Propert('Ds_Equip').IsRequired().MaxLength(60);
  Propert('Cd_Ambiente').IsRequired().MaxLength(20);
  Propert('Cd_Empresa').IsRequired();
  Propert('Cd_Terminal').IsRequired();
end;

end.

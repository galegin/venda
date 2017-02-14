unit uPagtoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uPagto;

type
  TPagtoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TPagtoMap }

constructor TPagtoMap.Create;
begin
  inherited Create(TPagto);

  ToTable('PAGTO');

  HasKey(['Cd_Dnapagto']);

  Propert('Cd_Dnapagto').IsRequired().MaxLength(40);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Equip').IsRequired().MaxLength(40);
  Propert('Dt_Pagto').IsRequired();
  Propert('Nr_Pagto').IsRequired();
  Propert('Vl_Pagto').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Entrada').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Troco').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Variacao').IsRequired().HasPrecision(15, 2);
  Propert('Cd_Dnacaixa').IsRequired().MaxLength(40);

  HasRequired('Obj_Equip').WithMany().HasForengKey(['Cd_Equip']);
  HasRequired('Obj_Caixa').WithMany().HasForengKey(['Cd_Dnacaixa']);
end;

end.

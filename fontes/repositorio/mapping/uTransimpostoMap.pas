unit uTransimpostoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uTransimposto;

type
  TTransimpostoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTransimpostoMap }

constructor TTransimpostoMap.Create;
begin
  inherited Create(TTransimposto);

  ToTable('TRANSIMPOSTO');

  HasKey(['Cd_Dnatrans', 'Nr_Item', 'Cd_Imposto']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('Nr_Item').IsRequired();
  Propert('Cd_Imposto').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Pr_Aliquota').IsRequired().HasPrecision(6, 2);
  Propert('Vl_Basecalculo').IsRequired().HasPrecision(15, 2);
  Propert('Pr_Basecalculo').IsRequired().HasPrecision(6, 2);
  Propert('Pr_Redbasecalculo').IsRequired().HasPrecision(6, 2);
  Propert('Vl_Imposto').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Outro').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Isento').IsRequired().HasPrecision(15, 2);
  Propert('Cd_Cst').IsRequired().MaxLength(3);
  Propert('Cd_Csosn').IsOptional().MaxLength(5);

  HasRequired('Obj_Item').WithMany().HasForengKey(['Cd_Dnatrans', 'Nr_Item']);
end;

end.

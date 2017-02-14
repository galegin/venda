unit uRegrafiscalImpostoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap,
  uRegrafiscalImposto;

type
  TRegrafiscalImpostoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TRegrafiscalImpostoMap }

constructor TRegrafiscalImpostoMap.Create;
begin
  inherited Create(TRegrafiscalimposto);

  ToTable('REGRAFISCALIMPOSTO');

  HasKey(['Cd_Regrafiscal', 'Cd_Imposto']);

  Propert('Cd_Regrafiscal').IsRequired();
  Propert('Cd_Imposto').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Pr_Aliquota').IsRequired().HasPrecision(6 ,2);
  Propert('Pr_Basecalculo').IsRequired().HasPrecision(6 ,2);
  Propert('Cd_Cst').IsRequired().MaxLength(4);
  Propert('Cd_Csosn').IsRequired().MaxLength(4);
  Propert('In_Isento').IsRequired();
  Propert('In_Outro').IsRequired();
end;

end.

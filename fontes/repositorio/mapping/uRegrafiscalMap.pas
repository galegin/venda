unit uRegrafiscalMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uRegrafiscal;

type
  TRegrafiscalMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TRegrafiscalMap }

constructor TRegrafiscalMap.Create;
begin
  inherited Create(TRegrafiscal);

  ToTable('REGRAFISCAL');

  HasKey(['Cd_Regrafiscal']);

  Propert('Cd_Regrafiscal').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Regrafiscal').IsRequired().MaxLength(60);
  Propert('In_CalcImposto').IsRequired();
end;

end.

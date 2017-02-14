unit uTransvenctoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uTransvencto;

type
  TTransvenctoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTransvenctoMap }

constructor TTransvenctoMap.Create;
begin
  inherited Create(TTransvencto);

  ToTable('TRANSVENCTO');

  HasKey(['Cd_Dnatrans', 'Nr_Parcela']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('Nr_Parcela').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Dt_Parcela').IsRequired();
  Propert('Vl_Parcela').IsRequired().HasPrecision(15, 2);

  HasRequired('Obj_Transacao').WithMany().HasForengKey(['Cd_Dnatrans']);
end;

end.

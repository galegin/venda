unit uTranspagtoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uTranspagto;

type
  TTranspagtoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTranspagtoMap }

constructor TTranspagtoMap.Create;
begin
  inherited Create(TTranspagto);

  ToTable('TRANSPAGTO');

  HasKey(['Cd_Dnatrans', 'Nr_Pagto']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('Nr_Pagto').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Tp_Pagto').IsRequired();
  Propert('Vl_Pagto').IsRequired().HasPrecision(15, 2);

  HasRequired('Obj_Transacao').WithMany().HasForengKey(['Cd_Dnatrans']);
end;

end.

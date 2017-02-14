unit uPagtoparcMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uPagtoparc;

type
  TPagtoparcMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TPagtoparcMap }

constructor TPagtoparcMap.Create;
begin
  inherited Create(TPagtoparc);

  ToTable('PAGTOPARC');

  HasKey(['Cd_Dnapagto', 'Nr_Parcela']);

  Propert('Cd_Dnapagto').IsRequired().MaxLength(40);
  Propert('Nr_Parcela').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Vl_Parcela').IsRequired().HasPrecision(15, 2);
  Propert('Tp_Docto').IsRequired();
  Propert('Nr_Docto').IsRequired();
  Propert('Dt_Vencto').IsRequired();
  Propert('Ds_Adicional').IsRequired().MaxLength(1000);
  Propert('Cd_Dnabaixa').IsRequired().MaxLength(40);

  HasRequired('Obj_Pagto').WithMany().HasForengKey(['Cd_Dnapagto']);
end;

end.

unit uCaixaMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uCaixa;

type
  TCaixaMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TCaixaMap }

constructor TCaixaMap.Create;
begin
  inherited Create(TCaixa);

  ToTable('CAIXA');

  HasKey(['Cd_Dnacaixa']);

  Propert('Cd_Dnacaixa').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Equip').IsRequired();
  Propert('Dt_Caixa').IsRequired();
  Propert('Nr_Seq').IsRequired();
  Propert('Vl_Abertura').IsRequired();
  Propert('Dt_Fechado').IsRequired();

  HasRequired('Obj_Equip').WithMany().HasForeignKey(['Cd_Equip']);
end;

end.

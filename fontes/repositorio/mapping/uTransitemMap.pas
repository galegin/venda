unit uTransitemMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uTransitem;

type
  TTransitemMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTransitemMap }

constructor TTransitemMap.Create;
begin
  inherited Create(TTransitem);

  ToTable('TRANSITEM');

  HasKey(['Cd_Dnatrans', 'Nr_Item']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('Nr_Item').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Barraprd').IsRequired().MaxLength(40);
  Propert('Cd_Produto').IsRequired();
  Propert('Ds_Produto').IsRequired().MaxLength(60);
  Propert('Cd_Especie').IsRequired().MaxLength(10);
  Propert('Cd_Ncm').IsRequired().MaxLength(5);
  Propert('Cd_Cfop').IsRequired();
  Propert('Qt_Item').IsRequired().HasPrecision(8, 3);
  Propert('Vl_Custo').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Unitario').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Item').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Variacao').IsRequired().HasPrecision(15, 2);
  Propert('Vl_VariacaoCapa').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Frete').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Seguro').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Outro').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Despesa').IsRequired().HasPrecision(15, 2);

  HasRequired('Obj_Transacao').WithMany().HasForeignKey(['Cd_Dnatrans']);
  HasRequired('Obj_Produto').WithMany().HasForeignKey(['Cd_Barraprd']);

end;

end.

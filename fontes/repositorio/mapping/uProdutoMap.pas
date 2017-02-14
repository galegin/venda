unit uProdutoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uProduto;

type
  TProdutoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TProdutoMap }

constructor TProdutoMap.Create;
begin
  inherited Create(TProduto);

  ToTable('Produto');

  HasKey(['Cd_Barraprd']);

  Propert('Cd_Barraprd').IsRequired().MaxLength(40);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Produto').IsRequired();
  Propert('Ds_Produto').IsRequired().MaxLength(60);
  Propert('Cd_Especie').IsRequired().MaxLength(10);
  Propert('Cd_Cst').IsRequired().MaxLength(4);
  Propert('Cd_Csosn').IsRequired().MaxLength(5);
  Propert('Cd_Ncm').IsRequired().MaxLength(10);
  Propert('Pr_Aliquota').IsRequired().HasPrecision(6, 2);
  Propert('Vl_Custo').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Venda').IsRequired().HasPrecision(15, 2);
  Propert('Vl_Promocao').IsRequired().HasPrecision(15, 2);
  Propert('Tp_Producao').IsRequired();
end;

end.

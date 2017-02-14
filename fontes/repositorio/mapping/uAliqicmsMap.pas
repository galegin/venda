unit uAliqicmsMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uAliqicms;

type
  TAliqicmsMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TAliqicmsMap }

constructor TAliqicmsMap.Create;
begin
  inherited Create(TAliqicms);

  ToTable('ALIQICMS');

  HasKey(['Uf_Origem', 'Uf_Destino']);

  Propert('Uf_Origem').IsRequired().MaxLength(2);
  Propert('Uf_Destino').IsRequired().MaxLength(2);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Pr_Aliquota').IsRequired().HasPrecision(6, 2);
end;

end.

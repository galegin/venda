unit uNcmsubstMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap,
  uNcmsubst;

type
  TNcmsubstMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TNcmsubstMap }

constructor TNcmsubstMap.Create;
begin
  inherited Create(TNcmsubst);

  ToTable('NCMSUBST');

  HasKey(['Uf_Origem', 'Uf_Destino', 'Cd_Ncm']);

  Propert('Uf_Origem').IsRequired().MaxLength(3);
  Propert('Uf_Destino').IsRequired().MaxLength(3);
  Propert('Cd_Ncm').IsRequired().MaxLength(10);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Cest').IsRequired().MaxLength(10);
end;

end.

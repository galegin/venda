unit uPaisMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uPais;

type
  TPaisMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TPaisMap }

constructor TPaisMap.Create;
begin
  inherited Create(TPais);

  ToTable('PAIS');

  HasKey(['Cd_Pais']);

  Propert('Cd_Pais').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Pais').IsRequired().MaxLength(60);
  Propert('Ds_Sigla').IsRequired().MaxLength(3);
end;

end.

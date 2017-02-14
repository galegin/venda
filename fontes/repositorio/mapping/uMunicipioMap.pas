unit uMunicipioMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uMunicipio;

type
  TMunicipioMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TMunicipioMap }

constructor TMunicipioMap.Create;
begin
  inherited Create(TMunicipio);

  ToTable('MUNICIPIO');

  HasKey(['Cd_Municipio']);

  Propert('Cd_Municipio').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Municipio').IsRequired().MaxLength(60);
  Propert('Ds_Sigla').IsRequired().MaxLength(3);
  Propert('Cd_Estado').IsRequired();

  HasRequired('Obj_Estado').WithMany().HasForengKey(['Cd_Estado']);
end;

end.

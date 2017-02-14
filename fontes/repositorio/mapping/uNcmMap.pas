unit uNcmMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uNcm;

type
  TNcmMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TNcmMap }

constructor TNcmMap.Create;
begin
  inherited Create(TNcm);

  ToTable('NCM');

  HasKey(['Cd_Ncm']);

  Propert('Cd_Ncm').IsRequired().MaxLength(10);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Ncm').IsRequired().MaxLength(60);
end;    

end.

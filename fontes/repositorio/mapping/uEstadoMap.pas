unit uEstadoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uEstado;

type
  TEstadoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TEstadoMap }

constructor TEstadoMap.Create;
begin
  inherited Create(TEstado);

  ToTable('ESTADO');

  HasKey(['Cd_Estado']);

  Propert('Cd_Estado').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Estado').IsRequired().MaxLength(60);
  Propert('Ds_Sigla').IsRequired().MaxLength(3);
  Propert('Cd_Pais').IsRequired();

  HasRequired('Obj_Pais').WithMany().HasForengKey(['Cd_Pais']);
end;

end.

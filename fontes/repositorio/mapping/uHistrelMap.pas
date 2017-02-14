unit uHistrelMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uHistrel;

type
  THistrelMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ THistrelMap }

constructor THistrelMap.Create;
begin
  inherited Create(THistrel);

  ToTable('HISTREL');

  HasKey(['Cd_Dnahistrel']);

  Propert('Cd_Dnahistrel').IsRequired().MaxLength(20);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Nr_Histrel').IsRequired();
  Propert('Ds_Histrel').IsRequired().MaxLength(60);
  Propert('Qt_Parcela').IsRequired();
end;

end.

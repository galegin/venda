unit uCfopMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uCfop;

type
  TCfopMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TCfopMap }

constructor TCfopMap.Create;
begin
  inherited Create(TCfop);

  ToTable('CFOP');

  HasKey(['Cd_Cfop']);

  Propert('Cd_Cfop').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Cfop').IsRequired().MaxLength(60);
end;

end.

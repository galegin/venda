unit uEmpresaMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap,
  uEmpresa;

type
  TEmpresaMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TEmpresaMap }

constructor TEmpresaMap.Create;
begin
  inherited Create(TEmpresa);

  ToTable('EMPRESA');

  HasKey(['Nr_Cpfcnpj']);

  Propert('Nr_Cpfcnpj').IsRequired().MaxLength(20);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
end;

end.

unit uUsuarioMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uUsuario;

type
  TUsuarioMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TUsuarioMap }

constructor TUsuarioMap.Create;
begin
  inherited Create(TUsuario);

  ToTable('USUARIO');

  HasKey(['Cd_Usuario']);

  Propert('Cd_Usuario').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Nm_Usuario').IsRequired().MaxLength(60);
  Propert('Nm_Login').IsRequired().MaxLength(20);
  Propert('Cd_Senha').IsRequired().MaxLength(40);
  Propert('Cd_Papel').IsRequired().MaxLength(20);
  Propert('Tp_Bloqueio').IsRequired();
  Propert('Dt_Bloqueio').IsOptional();
end;

end.

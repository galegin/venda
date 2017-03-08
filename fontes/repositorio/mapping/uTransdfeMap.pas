unit uTransdfeMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap,
  uTransdfe;

type
  TTransdfeMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTransdfeMap }

constructor TTransdfeMap.Create;
begin
  inherited Create(TTransdfe);

  ToTable('TRANSDFE');

  HasKey(['Cd_Dnatrans', 'Nr_Sequencia']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('Nr_Sequencia').IsRequired();
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Xml').IsRequired().MaxLength(4000).HasSubType('CLOB');
  Propert('Ds_RetornoXml').IsRequired().MaxLength(4000).HasSubType('CLOB');

  HasRequired('Obj_Transacao').WithMany().HasForeignKey(['Cd_Dnatrans']);
end;

end.

unit uTransfiscalMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uTransfiscal;

type
  TTransfiscalMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTransfiscalMap }

constructor TTransfiscalMap.Create;
begin
  inherited Create(TTransfiscal);

  ToTable('TRANSFISCAL');

  HasKey(['Cd_Dnatrans']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Tp_Ambiente').IsRequired();
  Propert('Tp_Emissao').IsRequired();
  Propert('Tp_Modalidade').IsRequired();
  Propert('Tp_Operacao').IsRequired();
  Propert('Tp_Docfiscal').IsRequired();
  Propert('Nr_Docfiscal').IsRequired();
  Propert('Cd_Serie').IsOptional().MaxLength(5);
  Propert('Dh_Emissao').IsOptional();
  Propert('Dh_EntradaSaida').IsOptional();
  Propert('Ds_Chave').IsOptional().MaxLength(40);
  Propert('Dh_Recibo').IsOptional();
  Propert('Nr_Recibo').IsOptional().MaxLength(40);
  Propert('Tp_Processamento').IsOptional().MaxLength(1);

  HasRequired('Obj_Transacao').WithMany().HasForeignKey(['Cd_Dnatrans']);
end;

end.

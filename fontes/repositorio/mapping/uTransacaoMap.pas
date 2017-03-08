unit uTransacaoMap;

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uTransacao;

type
  TTransacaoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TTransacaoMap }

constructor TTransacaoMap.Create;
begin
  inherited Create(TTransacao);

  ToTable('TRANSACAO');

  HasKey(['Cd_Dnatrans']);

  Propert('Cd_Dnatrans').IsRequired().MaxLength(40);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Cd_Equip').IsRequired().MaxLength(20);
  Propert('Dt_Transacao').IsRequired();
  Propert('Nr_Transacao').IsRequired();
  Propert('Nr_Cpfcnpj').IsRequired().MaxLength(20);
  Propert('Cd_Operacao').IsRequired().MaxLength(10);
  Propert('Cd_Dnapagto').IsOptional().MaxLength(40);
  Propert('Dt_Canc').IsOptional();

  HasRequired('Obj_Equip').WithMany().HasForeignKey(['Cd_Equip']);
  HasRequired('Obj_Operacao').WithMany().HasForeignKey(['Cd_Operacao']);
  HasRequired('Obj_Pessoa').WithMany().HasForeignKey(['Nr_Cpfcnpj']);
  HasRequired('Obj_Pagto').WithMany().HasForeignKey(['Cd_Dnapagto']);
end;

end.

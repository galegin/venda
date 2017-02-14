unit uPessoaMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uPessoa;

type
  TPessoaMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TPessoaMap }

constructor TPessoaMap.Create;
begin
  inherited Create(TPessoa);

  ToTable('PESSOA');

  HasKey(['Nr_Cpfcnpj']);

  Propert('Nr_Cpfcnpj').IsRequired().MaxLength(20);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Nr_Rgie').IsRequired().MaxLength(20);
  Propert('Cd_Pessoa').IsRequired();
  Propert('Nm_Pessoa').IsRequired().MaxLength(60);
  Propert('Nm_Fantasia').IsRequired().MaxLength(60);

  Propert('Cd_Cep').IsRequired();
  Propert('Nm_Logradouro').IsRequired().MaxLength(60);
  Propert('Nr_Logradouro').IsRequired().MaxLength(10);
  Propert('Ds_Bairro').IsRequired().MaxLength(60);
  Propert('Ds_Complemento').IsRequired().MaxLength(60);
  Propert('Cd_Municipio').IsRequired();
  Propert('Ds_Municipio').IsRequired().MaxLength(60);
  Propert('Cd_Estado').IsRequired();
  Propert('Ds_Estado').IsRequired().MaxLength(60);
  Propert('Ds_SiglaEstado').IsRequired().MaxLength(2);
  Propert('Cd_Pais').IsRequired();
  Propert('Ds_Pais').IsRequired().MaxLength(60);
  Propert('Ds_Fone').IsRequired().MaxLength(20);
  Propert('Ds_Celular').IsRequired().MaxLength(20);
  Propert('Ds_Email').IsRequired().MaxLength(60);
end;

end.

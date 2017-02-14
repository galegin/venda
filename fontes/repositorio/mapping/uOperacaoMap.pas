unit uOperacaoMap;

(* classe de mapeamento *)

interface

uses
  Classes, SysUtils,
  mCollectionMap, 
  uOperacao;

type
  TOperacaoMap = class(TmCollectionMap)
  public
    constructor Create(AClasse: TCollectionItemClass); override;
  end;

implementation

{ TOperacaoMap }

constructor TOperacaoMap.Create;
begin
  inherited Create(TOperacao);

  ToTable('Operacao');

  HasKey(['Cd_Operacao']);

  Propert('Cd_Operacao').IsRequired().MaxLength(20);
  Propert('U_Version').IsOptional().MaxLength(1);
  Propert('Cd_Operador').IsRequired();
  Propert('Dt_Cadastro').IsRequired();
  Propert('Ds_Operacao').IsRequired().MaxLength(60);
  Propert('Tp_Docfiscal').IsRequired();
  Propert('Tp_Modalidade').IsRequired();
  Propert('Tp_Operacao').IsRequired();
  Propert('Cd_Serie').IsRequired().MaxLength(5);
  Propert('Cd_Regrafiscal').IsRequired();
  Propert('Cd_Cfop').IsRequired();
end;

end.

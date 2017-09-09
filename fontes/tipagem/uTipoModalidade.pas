unit uTipoModalidade;

interface

type
  TTipoModalidade = (
    tpmDevolucaoNFe,
    tpmVendaEcf,
    tpmVendaManual,
    tpmVendaNFCe,
    tpmVendaNFe,
    tpmVendaSat,
    tpmVendaMaoFiscal,
    tpmDevolucaoNaoFiscal);

  function TipoModalidadeToStr(const pTipo : TTipoModalidade): string;
  function StrToTipoModalidade(const pCodigo : string): TTipoModalidade;

implementation

const
  TTipoModalidade_Codigo : Array [TTipoModalidade] of String = (
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8');

function TipoModalidadeToStr(const pTipo : TTipoModalidade): string;
begin
  Result := TTipoModalidade_Codigo[pTipo];
end;

function StrToTipoModalidade(const pCodigo : string): TTipoModalidade;
var
  I : Integer;
begin
  Result := TTipoModalidade(-1);
  for I := Ord(Low(TTipoModalidade)) to Ord(High(TTipoModalidade)) do
    if TTipoModalidade_Codigo[TTipoModalidade(I)] = pCodigo then
      Result := TTipoModalidade(I);
end;

end.

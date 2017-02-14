unit uTipoDocumentoFiscal;

interface

type
  TTipoDocumentoFiscal = (
    tpdDinheiro,
    tpdCheque,
    tpdCrediarioLoja,
    tpdCartaoCredito,
    tpdCartaoDebito,
    tpdValeAlimentacao,
    tpdValeRefeicao,
    tpdValePresente,
    tpdValeTransporte,
    tpdOutro);

  function TipoDocumentoFiscalToStr(const t: TTipoDocumentoFiscal): string;
  function StrToTipoDocumentoFiscal(const s: string): TTipoDocumentoFiscal;

implementation

const
  TTipoDocumentoFiscal_Codigo : Array [TTipoDocumentoFiscal] of String = (
    '1',
    '2',
    '3',
    '4',
    '5',
    '11',
    '12',
    '13',
    '14',
    '99');

function TipoDocumentoFiscalToStr(const t: TTipoDocumentoFiscal): string;
begin
  Result := TTipoDocumentoFiscal_Codigo[t];
end;

function StrToTipoDocumentoFiscal(const s: string): TTipoDocumentoFiscal;
var
  I : Integer;
begin
  Result := TTipoDocumentoFiscal(-1);
  for I := Ord(Low(TTipoDocumentoFiscal)) to Ord(High(TTipoDocumentoFiscal)) do
    if TTipoDocumentoFiscal_Codigo[TTipoDocumentoFiscal(I)] = s then
      Result := TTipoDocumentoFiscal(I);
end;

end.

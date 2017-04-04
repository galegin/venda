unit uTipoImpressaoDanfe;

interface

uses
  Classes, SysUtils, StrUtils;

type
  TTipoImpressaoDanfe = (
    tpiImprimir,
    tpiImprimirPDF,
    tpiImprimirResumido,
    tpiImprimirResumidoPDF);

  function StrToTipoImpressaoDanfe(const pCodigo : string) : TTipoImpressaoDanfe;
  function TipoImpressaoDanfeToStr(const pTipo : TTipoImpressaoDanfe) : string;

implementation

const
  TTipoImpressaoDanfe_Cod : array [TTipoImpressaoDanfe] of string = (
    '1',
    '2',
    '3',
    '4');

function StrToTipoImpressaoDanfe(const pCodigo : string) : TTipoImpressaoDanfe;
var
  I : Integer;
begin
  Result := TTipoImpressaoDanfe(Ord(-1));
  for I := Ord(Low(TTipoImpressaoDanfe)) to Ord(High(TTipoImpressaoDanfe)) do
    if TTipoImpressaoDanfe_Cod[TTipoImpressaoDanfe(Ord(I))] = pCodigo then
      Result := TTipoImpressaoDanfe(Ord(I));
end;

function TipoImpressaoDanfeToStr(const pTipo : TTipoImpressaoDanfe) : string;
begin
  Result := TTipoImpressaoDanfe_Cod[pTipo];
end;

end.

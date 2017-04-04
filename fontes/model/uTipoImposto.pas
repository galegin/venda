unit uTipoImposto;

interface

type
  TTipoImposto = (
    tpiNaoConfigurado,
    tpiICMS,
    tpiICMSST,
    tpiICMSUF,
    tpiIPI,
    tpiPIS,
    tpiPISST,
    tpiCOFINS,
    tpiCOFINSST,
    tpiISSQN,
    tpiII);

  function TipoImpostoToStr(const pTipo : TTipoImposto): string;
  function StrToTipoImposto(const pCodigo : string): TTipoImposto;

implementation

const
  TTipoImposto_Codigo : Array [TTipoImposto] of String = (
    '',
    'ICMS',
    'ICMSST',
    'ICMSUF',
    'IPI',
    'PIS',
    'PISST',
    'COFINS',
    'COFINSST',
    'ISSQN',
    'II');

function TipoImpostoToStr(const pTipo : TTipoImposto): string;
begin
  Result := TTipoImposto_Codigo[pTipo];
end;

function StrToTipoImposto(const pCodigo : string): TTipoImposto;
var
  I : Integer;
begin
  Result := TTipoImposto(-1);
  for I := Ord(Low(TTipoImposto)) to Ord(High(TTipoImposto)) do
    if TTipoImposto_Codigo[TTipoImposto(I)] = pCodigo then
      Result := TTipoImposto(I);
end;

end.

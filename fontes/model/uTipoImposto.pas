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

  function TipoImpostoToStr(const t: TTipoImposto): string;
  function StrToTipoImposto(const s: string): TTipoImposto;

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

function TipoImpostoToStr(const t: TTipoImposto): string;
begin
  Result := TTipoImposto_Codigo[t];
end;

function StrToTipoImposto(const s: string): TTipoImposto;
var
  I : Integer;
begin
  Result := TTipoImposto(-1);
  for I := Ord(Low(TTipoImposto)) to Ord(High(TTipoImposto)) do
    if TTipoImposto_Codigo[TTipoImposto(I)] = s then
      Result := TTipoImposto(I);
end;

end.

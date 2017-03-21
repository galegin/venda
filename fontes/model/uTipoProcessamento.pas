unit uTipoProcessamento;

interface

type
  TTipoProcessamento = (
    tppGerada,
    tppAutorizada,
    tppCancelada,
    tppRejeitada);

  function TipoProcessamentoToStr(const t: TTipoProcessamento): string;
  function StrToTipoProcessamento(const s: string): TTipoProcessamento;

implementation

const
  TTipoProcessamento_Codigo : array [TTipoProcessamento] of string = (
    'G',
    'A',
    'C',
    'R');

function TipoProcessamentoToStr(const t: TTipoProcessamento): string;
begin
  Result := TTipoProcessamento_Codigo[t];
end;

function StrToTipoProcessamento(const s: string): TTipoProcessamento;
var
  I : Integer;
begin
  Result := TTipoProcessamento(-1);
  for I := Ord(Low(TTipoProcessamento)) to Ord(High(TTipoProcessamento)) do
    if TTipoProcessamento_Codigo[TTipoProcessamento(I)] = s then
      Result := TTipoProcessamento(I);
end;

end.

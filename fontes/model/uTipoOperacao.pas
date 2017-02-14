unit uTipoOperacao;

interface

type
  TTipoOperacao = (
    tpoEntrada,
    tpoSaida);

  function TipoOperacaoToStr(const t: TTipoOperacao): string;
  function StrToTipoOperacao(const s: string): TTipoOperacao;

implementation

const
  TTipoOperacao_Codigo : Array [TTipoOperacao] of String = (
    '1',
    '0');

function TipoOperacaoToStr(const t: TTipoOperacao): string;
begin
  Result := TTipoOperacao_Codigo[t];
end;

function StrToTipoOperacao(const s: string): TTipoOperacao;
var
  I : Integer;
begin
  Result := TTipoOperacao(-1);
  for I := Ord(Low(TTipoOperacao)) to Ord(High(TTipoOperacao)) do
    if TTipoOperacao_Codigo[TTipoOperacao(I)] = s then
      Result := TTipoOperacao(I);
end;

end.

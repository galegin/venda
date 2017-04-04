unit uTipoOperacao;

interface

type
  TTipoOperacao = (
    tpoEntrada,
    tpoSaida);

  function TipoOperacaoToStr(const pTipo : TTipoOperacao): string;
  function StrToTipoOperacao(const pCodigo : string): TTipoOperacao;

implementation

const
  TTipoOperacao_Codigo : Array [TTipoOperacao] of String = (
    '1',
    '0');

function TipoOperacaoToStr(const pTipo : TTipoOperacao): string;
begin
  Result := TTipoOperacao_Codigo[pTipo];
end;

function StrToTipoOperacao(const pCodigo : string): TTipoOperacao;
var
  I : Integer;
begin
  Result := TTipoOperacao(-1);
  for I := Ord(Low(TTipoOperacao)) to Ord(High(TTipoOperacao)) do
    if TTipoOperacao_Codigo[TTipoOperacao(I)] = pCodigo then
      Result := TTipoOperacao(I);
end;

end.

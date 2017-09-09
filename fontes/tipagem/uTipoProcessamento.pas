unit uTipoProcessamento;

interface

type
  TTipoProcessamento = (
    tppGerada,
    tppAutorizada,
    tppCancelada,
    tppRejeitada);

  function TipoProcessamentoToStr(const pTipo : TTipoProcessamento): string;
  function StrToTipoProcessamento(const pCodigo : string): TTipoProcessamento;

implementation

const
  TTipoProcessamento_Codigo : array [TTipoProcessamento] of string = (
    'G',
    'A',
    'C',
    'R');

function TipoProcessamentoToStr(const pTipo : TTipoProcessamento): string;
begin
  Result := TTipoProcessamento_Codigo[pTipo];
end;

function StrToTipoProcessamento(const pCodigo : string): TTipoProcessamento;
var
  I : Integer;
begin
  Result := TTipoProcessamento(-1);
  for I := Ord(Low(TTipoProcessamento)) to Ord(High(TTipoProcessamento)) do
    if TTipoProcessamento_Codigo[TTipoProcessamento(I)] = pCodigo then
      Result := TTipoProcessamento(I);
end;

end.

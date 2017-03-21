unit uTipoPessoa;

interface

type
  TTipoPessoa = (tpFisica, tpJuridica);

  function StrToTipoPessoa(const s : string) : TTipoPessoa;

implementation

  function StrToTipoPessoa(const s : string) : TTipoPessoa;
  begin
    Result := TTipoPessoa(Ord(-1));

    case Length(s) of
      11 :
        Result := tpFisica;
      14 :
        Result := tpJuridica;
     end;
  end;

end.

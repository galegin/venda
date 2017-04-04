unit uTipoPessoa;

interface

type
  TTipoPessoa = (tpFisica, tpJuridica);

  function StrToTipoPessoa(const pDocumento : string) : TTipoPessoa;

implementation

  function StrToTipoPessoa(const pDocumento : string) : TTipoPessoa;
  begin
    Result := TTipoPessoa(Ord(-1));

    case Length(pDocumento) of
      11 :
        Result := tpFisica;
      14 :
        Result := tpJuridica;
     end;
  end;

end.

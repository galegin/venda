unit uclsTransacaoTef;

interface

type
  TcTransacaoTefCrt = class
  private
  public
    Valor : Double;
    IndiceFPG_ECF : String;
    DocumentoVinculado : String;
    Moeda : Integer;
  end;

  TcTransacaoTefCtr_Ret = class
  private
  public
    Rede : String;
    NSU : String;
    Finalizacao : String;
    DocumentoVinculado : String;
    DataHoraTransacao : TDateTime;
    Valor : Double;
  end;

  TcTransacaoTefCnf = class
  private
  public
    Rede : String;
    NSU : String;
    Finalizacao : String;
    DocumentoVinculado : String;
  end;

  TcTransacaoTefNcn = class
  private
  public
    Rede : String;
    NSU : String;
    Finalizacao : String;
    Valor : Double;
    DocumentoVinculado : String;
  end;

  TcTransacaoTefCnc = class
  private
  public
    Rede : String;
    NSU : String;
    DataHoraTransacao : TDateTime;
    Valor : Double;
  end;

  TcTransacaoTefChq = class
  private
  public
    Valor : Double;
    IndiceFPG_ECF : String;
    DocumentoVinculado : String;
    CMC7 : String;
    TipoPessoa : AnsiChar;
    DocumentoPessoa : String;
    DataCheque : TDateTime;
    Banco : String;
    Agencia : String;
    AgenciaDC : String;
    Conta : String;
    ContaDC : String;
    Cheque : String;
    ChequeDC : String;
    Compensacao: String
  end;

implementation

end.

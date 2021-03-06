unit uAliqicms;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TAliqicms = class(TmMapping)
  private
    fUf_Origem: String;
    fUf_Destino: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Uf_Origem : String read fUf_Origem write fUf_Origem;
    property Uf_Destino : String read fUf_Destino write fUf_Destino;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
  end;

  TAliqicmss = class(TList)
  public
    function Add: TAliqicms; overload;
  end;

implementation

{ TAliqicms }

constructor TAliqicms.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TAliqicms.Destroy;
begin

  inherited;
end;

//--

function TAliqicms.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'ALIQICMS';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Uf_Origem', 'UF_ORIGEM', tfKey);
    Add('Uf_Destino', 'UF_DESTINO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Pr_Aliquota', 'PR_ALIQUOTA', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TAliqicmss }

function TAliqicmss.Add: TAliqicms;
begin
  Result := TAliqicms.Create(nil);
  Self.Add(Result);
end;

end.
unit uRegraimposto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TRegraimposto = class(TmMapping)
  private
    fId_Regrafiscal: Integer;
    fCd_Imposto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fPr_Basecalculo: Real;
    fCd_Cst: String;
    fCd_Csosn: String;
    fIn_Isento: String;
    fIn_Outro: String;
    procedure SetId_Regrafiscal(const Value : Integer);
    procedure SetCd_Imposto(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetPr_Aliquota(const Value : Real);
    procedure SetPr_Basecalculo(const Value : Real);
    procedure SetCd_Cst(const Value : String);
    procedure SetCd_Csosn(const Value : String);
    procedure SetIn_Isento(const Value : String);
    procedure SetIn_Outro(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Regrafiscal : Integer read fId_Regrafiscal write SetId_Regrafiscal;
    property Cd_Imposto : Integer read fCd_Imposto write SetCd_Imposto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write SetPr_Aliquota;
    property Pr_Basecalculo : Real read fPr_Basecalculo write SetPr_Basecalculo;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Csosn : String read fCd_Csosn write SetCd_Csosn;
    property In_Isento : String read fIn_Isento write SetIn_Isento;
    property In_Outro : String read fIn_Outro write SetIn_Outro;
  end;

  TRegraimpostos = class(TList)
  public
    function Add: TRegraimposto; overload;
  end;

implementation

{ TRegraimposto }

constructor TRegraimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TRegraimposto.Destroy;
begin

  inherited;
end;

//--

function TRegraimposto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'REGRAIMPOSTO';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Regrafiscal', 'ID_REGRAFISCAL');
    Add('Cd_Imposto', 'CD_IMPOSTO');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Regrafiscal', 'ID_REGRAFISCAL');
    Add('Cd_Imposto', 'CD_IMPOSTO');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Pr_Aliquota', 'PR_ALIQUOTA');
    Add('Pr_Basecalculo', 'PR_BASECALCULO');
    Add('Cd_Cst', 'CD_CST');
    Add('Cd_Csosn', 'CD_CSOSN');
    Add('In_Isento', 'IN_ISENTO');
    Add('In_Outro', 'IN_OUTRO');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TRegraimposto.SetId_Regrafiscal(const Value : Integer);
begin
  fId_Regrafiscal := Value;
end;

procedure TRegraimposto.SetCd_Imposto(const Value : Integer);
begin
  fCd_Imposto := Value;
end;

procedure TRegraimposto.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TRegraimposto.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TRegraimposto.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TRegraimposto.SetPr_Aliquota(const Value : Real);
begin
  fPr_Aliquota := Value;
end;

procedure TRegraimposto.SetPr_Basecalculo(const Value : Real);
begin
  fPr_Basecalculo := Value;
end;

procedure TRegraimposto.SetCd_Cst(const Value : String);
begin
  fCd_Cst := Value;
end;

procedure TRegraimposto.SetCd_Csosn(const Value : String);
begin
  fCd_Csosn := Value;
end;

procedure TRegraimposto.SetIn_Isento(const Value : String);
begin
  fIn_Isento := Value;
end;

procedure TRegraimposto.SetIn_Outro(const Value : String);
begin
  fIn_Outro := Value;
end;

{ TRegraimpostos }

function TRegraimpostos.Add: TRegraimposto;
begin
  Result := TRegraimposto.Create(nil);
  Self.Add(Result);
end;

end.
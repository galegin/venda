unit uCaixamov;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TCaixamov = class(TmMapping)
  private
    fId_Caixa: Integer;
    fNr_Seq: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Lancto: Integer;
    fVl_Lancto: Real;
    fNr_Doc: Integer;
    fDs_Aux: String;
    procedure SetId_Caixa(const Value : Integer);
    procedure SetNr_Seq(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetTp_Lancto(const Value : Integer);
    procedure SetVl_Lancto(const Value : Real);
    procedure SetNr_Doc(const Value : Integer);
    procedure SetDs_Aux(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property Nr_Seq : Integer read fNr_Seq write SetNr_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Lancto : Integer read fTp_Lancto write SetTp_Lancto;
    property Vl_Lancto : Real read fVl_Lancto write SetVl_Lancto;
    property Nr_Doc : Integer read fNr_Doc write SetNr_Doc;
    property Ds_Aux : String read fDs_Aux write SetDs_Aux;
  end;

  TCaixamovs = class(TList)
  public
    function Add: TCaixamov; overload;
  end;

implementation

{ TCaixamov }

constructor TCaixamov.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCaixamov.Destroy;
begin

  inherited;
end;

//--

function TCaixamov.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'CAIXAMOV';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Caixa', 'ID_CAIXA');
    Add('Nr_Seq', 'NR_SEQ');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Caixa', 'ID_CAIXA');
    Add('Nr_Seq', 'NR_SEQ');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Tp_Lancto', 'TP_LANCTO');
    Add('Vl_Lancto', 'VL_LANCTO');
    Add('Nr_Doc', 'NR_DOC');
    Add('Ds_Aux', 'DS_AUX');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TCaixamov.SetId_Caixa(const Value : Integer);
begin
  fId_Caixa := Value;
end;

procedure TCaixamov.SetNr_Seq(const Value : Integer);
begin
  fNr_Seq := Value;
end;

procedure TCaixamov.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TCaixamov.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TCaixamov.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TCaixamov.SetTp_Lancto(const Value : Integer);
begin
  fTp_Lancto := Value;
end;

procedure TCaixamov.SetVl_Lancto(const Value : Real);
begin
  fVl_Lancto := Value;
end;

procedure TCaixamov.SetNr_Doc(const Value : Integer);
begin
  fNr_Doc := Value;
end;

procedure TCaixamov.SetDs_Aux(const Value : String);
begin
  fDs_Aux := Value;
end;

{ TCaixamovs }

function TCaixamovs.Add: TCaixamov;
begin
  Result := TCaixamov.Create(nil);
  Self.Add(Result);
end;

end.
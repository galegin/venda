unit uCaixacont;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TCaixacont = class(TmMapping)
  private
    fId_Caixa: Integer;
    fId_Histrel: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fVl_Contado: Real;
    fVl_Sistema: Real;
    fVl_Retirada: Real;
    fVl_Suprimento: Real;
    fVl_Diferenca: Real;
    procedure SetId_Caixa(const Value : Integer);
    procedure SetId_Histrel(const Value : Integer);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetVl_Contado(const Value : Real);
    procedure SetVl_Sistema(const Value : Real);
    procedure SetVl_Retirada(const Value : Real);
    procedure SetVl_Suprimento(const Value : Real);
    procedure SetVl_Diferenca(const Value : Real);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property Id_Histrel : Integer read fId_Histrel write SetId_Histrel;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Vl_Contado : Real read fVl_Contado write SetVl_Contado;
    property Vl_Sistema : Real read fVl_Sistema write SetVl_Sistema;
    property Vl_Retirada : Real read fVl_Retirada write SetVl_Retirada;
    property Vl_Suprimento : Real read fVl_Suprimento write SetVl_Suprimento;
    property Vl_Diferenca : Real read fVl_Diferenca write SetVl_Diferenca;
  end;

  TCaixaconts = class(TList)
  public
    function Add: TCaixacont; overload;
  end;

implementation

{ TCaixacont }

constructor TCaixacont.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCaixacont.Destroy;
begin

  inherited;
end;

//--

function TCaixacont.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'CAIXACONT';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Id_Caixa', 'ID_CAIXA');
    Add('Id_Histrel', 'ID_HISTREL');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Caixa', 'ID_CAIXA');
    Add('Id_Histrel', 'ID_HISTREL');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Vl_Contado', 'VL_CONTADO');
    Add('Vl_Sistema', 'VL_SISTEMA');
    Add('Vl_Retirada', 'VL_RETIRADA');
    Add('Vl_Suprimento', 'VL_SUPRIMENTO');
    Add('Vl_Diferenca', 'VL_DIFERENCA');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TCaixacont.SetId_Caixa(const Value : Integer);
begin
  fId_Caixa := Value;
end;

procedure TCaixacont.SetId_Histrel(const Value : Integer);
begin
  fId_Histrel := Value;
end;

procedure TCaixacont.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TCaixacont.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TCaixacont.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TCaixacont.SetVl_Contado(const Value : Real);
begin
  fVl_Contado := Value;
end;

procedure TCaixacont.SetVl_Sistema(const Value : Real);
begin
  fVl_Sistema := Value;
end;

procedure TCaixacont.SetVl_Retirada(const Value : Real);
begin
  fVl_Retirada := Value;
end;

procedure TCaixacont.SetVl_Suprimento(const Value : Real);
begin
  fVl_Suprimento := Value;
end;

procedure TCaixacont.SetVl_Diferenca(const Value : Real);
begin
  fVl_Diferenca := Value;
end;

{ TCaixaconts }

function TCaixaconts.Add: TCaixacont;
begin
  Result := TCaixacont.Create(nil);
  Self.Add(Result);
end;

end.
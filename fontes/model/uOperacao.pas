unit uOperacao;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TOperacao = class;
  TOperacaoClass = class of TOperacao;

  TOperacaoList = class;
  TOperacaoListClass = class of TOperacaoList;

  TOperacao = class(TmCollectionItem)
  private
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Operacao: String;
    fTp_Docfiscal: Integer;
    fTp_Modalidade: Integer;
    fTp_Operacao: Integer;
    fCd_Serie: String;
    fCd_Regrafiscal: Integer;
    fCd_Cfop: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Operacao: String read fCd_Operacao write fCd_Operacao;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Operacao: String read fDs_Operacao write fDs_Operacao;
    property Tp_Docfiscal: Integer read fTp_Docfiscal write fTp_Docfiscal;
    property Tp_Modalidade: Integer read fTp_Modalidade write fTp_Modalidade;
    property Tp_Operacao: Integer read fTp_Operacao write fTp_Operacao;
    property Cd_Serie: String read fCd_Serie write fCd_Serie;
    property Cd_Regrafiscal: Integer read fCd_Regrafiscal write fCd_Regrafiscal;
    property Cd_Cfop: Integer read fCd_Cfop write fCd_Cfop;
  end;

  TOperacaoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TOperacao;
    procedure SetItem(Index: Integer; Value: TOperacao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TOperacao;
    property Items[Index: Integer]: TOperacao read GetItem write SetItem; default;
  end;

implementation

{ TOperacao }

constructor TOperacao.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TOperacao.Destroy;
begin

  inherited;
end;

{ TOperacaoList }

constructor TOperacaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TOperacao);
end;

function TOperacaoList.Add: TOperacao;
begin
  Result := TOperacao(inherited Add);
  Result.create(Self);
end;

function TOperacaoList.GetItem(Index: Integer): TOperacao;
begin
  Result := TOperacao(inherited GetItem(Index));
end;

procedure TOperacaoList.SetItem(Index: Integer; Value: TOperacao);
begin
  inherited SetItem(Index, Value);
end;

end.

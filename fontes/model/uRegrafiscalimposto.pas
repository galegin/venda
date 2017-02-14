unit uRegrafiscalimposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TRegrafiscalimposto = class;
  TRegrafiscalimpostoClass = class of TRegrafiscalimposto;

  TRegrafiscalimpostoList = class;
  TRegrafiscalimpostoListClass = class of TRegrafiscalimpostoList;

  TRegrafiscalimposto = class(TmCollectionItem)
  private
    fCd_Regrafiscal: Integer;
    fCd_Imposto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fPr_Basecalculo: Real;
    fCd_Cst: String;
    fCd_Csosn: String;
    fIn_Isento: Boolean;
    fIn_Outro: Boolean;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Regrafiscal: Integer read fCd_Regrafiscal write fCd_Regrafiscal;
    property Cd_Imposto: Integer read fCd_Imposto write fCd_Imposto;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota: Real read fPr_Aliquota write fPr_Aliquota;
    property Pr_Basecalculo: Real read fPr_Basecalculo write fPr_Basecalculo;
    property Cd_Cst: String read fCd_Cst write fCd_Cst;
    property Cd_Csosn: String read fCd_Csosn write fCd_Csosn;
    property In_Isento: Boolean read fIn_Isento write fIn_Isento;
    property In_Outro: Boolean read fIn_Outro write fIn_Outro;
  end;

  TRegrafiscalimpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TRegrafiscalimposto;
    procedure SetItem(Index: Integer; Value: TRegrafiscalimposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRegrafiscalimposto;
    property Items[Index: Integer]: TRegrafiscalimposto read GetItem write SetItem; default;
  end;

implementation

{ TRegrafiscalimposto }

constructor TRegrafiscalimposto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TRegrafiscalimposto.Destroy;
begin

  inherited;
end;

{ TRegrafiscalimpostoList }

constructor TRegrafiscalimpostoList.Create(AOwner: TPersistent);
begin
  inherited Create(TRegrafiscalimposto);
end;

function TRegrafiscalimpostoList.Add: TRegrafiscalimposto;
begin
  Result := TRegrafiscalimposto(inherited Add);
  Result.create(Self);
end;

function TRegrafiscalimpostoList.GetItem(Index: Integer): TRegrafiscalimposto;
begin
  Result := TRegrafiscalimposto(inherited GetItem(Index));
end;

procedure TRegrafiscalimpostoList.SetItem(Index: Integer; Value: TRegrafiscalimposto);
begin
  inherited SetItem(Index, Value);
end;

end.

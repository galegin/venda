unit uCaixa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TCaixa = class;
  TCaixaClass = class of TCaixa;

  TCaixaList = class;
  TCaixaListClass = class of TCaixaList;

  TCaixa = class(TmCollectionItem)
  private
    fCd_Dnacaixa: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDt_Caixa: TDateTime;
    fNr_Seq: Integer;
    fVl_Abertura: Real;
    fDt_Fechado: TDateTime;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnacaixa: String read fCd_Dnacaixa write fCd_Dnacaixa;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Equip: String read fCd_Equip write fCd_Equip;
    property Dt_Caixa: TDateTime read fDt_Caixa write fDt_Caixa;
    property Nr_Seq: Integer read fNr_Seq write fNr_Seq;
    property Vl_Abertura: Real read fVl_Abertura write fVl_Abertura;
    property Dt_Fechado: TDateTime read fDt_Fechado write fDt_Fechado;
  end;

  TCaixaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TCaixa;
    procedure SetItem(Index: Integer; Value: TCaixa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TCaixa;
    property Items[Index: Integer]: TCaixa read GetItem write SetItem; default;
  end;
  
implementation

{ TCaixa }

constructor TCaixa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TCaixa.Destroy;
begin

  inherited;
end;

{ TCaixaList }

constructor TCaixaList.Create(AOwner: TPersistent);
begin
  inherited Create(TCaixa);
end;

function TCaixaList.Add: TCaixa;
begin
  Result := TCaixa(inherited Add);
  Result.create(Self);
end;

function TCaixaList.GetItem(Index: Integer): TCaixa;
begin
  Result := TCaixa(inherited GetItem(Index));
end;

procedure TCaixaList.SetItem(Index: Integer; Value: TCaixa);
begin
  inherited SetItem(Index, Value);
end;

end.
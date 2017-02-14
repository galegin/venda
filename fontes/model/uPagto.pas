unit uPagto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uPagtoparc;

type
  TPagto = class;
  TPagtoClass = class of TPagto;

  TPagtoList = class;
  TPagtoListClass = class of TPagtoList;

  TPagto = class(TmCollectionItem)
  private
    fCd_Dnapagto: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Equip: String;
    fDt_Pagto: TDateTime;
    fNr_Pagto: Integer;
    fVl_Pagto: Real;
    fVl_Entrada: Real;
    fVl_Troco: Real;
    fVl_Variacao: Real;
    fCd_Dnacaixa: String;

    fList_Parcela: TPagtoparcList;

    function GetVl_Parcelado() : Real;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnapagto: String read fCd_Dnapagto write fCd_Dnapagto;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Equip: String read fCd_Equip write fCd_Equip;
    property Dt_Pagto: TDateTime read fDt_Pagto write fDt_Pagto;
    property Nr_Pagto: Integer read fNr_Pagto write fNr_Pagto;
    property Vl_Pagto: Real read fVl_Pagto write fVl_Pagto;
    property Vl_Entrada: Real read fVl_Entrada write fVl_Entrada;
    property Vl_Troco: Real read fVl_Troco write fVl_Troco;
    property Vl_Variacao: Real read fVl_Variacao write fVl_Variacao;
    property Cd_Dnacaixa: String read fCd_Dnacaixa write fCd_Dnacaixa;

    property List_Parcela : TPagtoparcList read fList_Parcela write fList_Parcela;

    property Vl_Parcelado: Real read GetVl_Parcelado;
  end;

  TPagtoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPagto;
    procedure SetItem(Index: Integer; Value: TPagto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPagto;
    property Items[Index: Integer]: TPagto read GetItem write SetItem; default;
  end;
  
implementation

{ TPagto }

constructor TPagto.Create(ACollection: TCollection);
begin
  inherited;

  fList_Parcela:= TPagtoparcList.Create(nil);
end;

destructor TPagto.Destroy;
begin

  inherited;
end;

//--

function TPagto.GetVl_Parcelado() : Real;
begin
  Result := List_Parcela.Sum('Vl_Parcela');
end;

{ TPagtoList }

constructor TPagtoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPagto);
end;

function TPagtoList.Add: TPagto;
begin
  Result := TPagto(inherited Add);
  Result.create(Self);
end;

function TPagtoList.GetItem(Index: Integer): TPagto;
begin
  Result := TPagto(inherited GetItem(Index));
end;

procedure TPagtoList.SetItem(Index: Integer; Value: TPagto);
begin
  inherited SetItem(Index, Value);
end;

end.
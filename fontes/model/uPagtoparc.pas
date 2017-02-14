unit uPagtoparc;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPagtoparc = class;
  TPagtoparcClass = class of TPagtoparc;

  TPagtoparcList = class;
  TPagtoparcListClass = class of TPagtoparcList;

  TPagtoparc = class(TmCollectionItem)
  private
    fCd_Dnapagto: String;
    fNr_Parcela: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fVl_Parcela: Real;
    fTp_Docto: Integer;
    fNr_Docto: Integer;
    fDt_Vencto: TDateTime;
    fDs_Adicional: String;
    fCd_Dnabaixa: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnapagto: String read fCd_Dnapagto write fCd_Dnapagto;
    property Nr_Parcela: Integer read fNr_Parcela write fNr_Parcela;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Parcela: Real read fVl_Parcela write fVl_Parcela;
    property Tp_Docto: Integer read fTp_Docto write fTp_Docto;
    property Nr_Docto: Integer read fNr_Docto write fNr_Docto;
    property Dt_Vencto: TDateTime read fDt_Vencto write fDt_Vencto;
    property Ds_Adicional: String read fDs_Adicional write fDs_Adicional;
    property Cd_Dnabaixa: String read fCd_Dnabaixa write fCd_Dnabaixa;
  end;

  TPagtoparcList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPagtoparc;
    procedure SetItem(Index: Integer; Value: TPagtoparc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPagtoparc;
    property Items[Index: Integer]: TPagtoparc read GetItem write SetItem; default;
  end;
  
implementation

{ TPagtoparc }

constructor TPagtoparc.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPagtoparc.Destroy;
begin

  inherited;
end;

{ TPagtoparcList }

constructor TPagtoparcList.Create(AOwner: TPersistent);
begin
  inherited Create(TPagtoparc);
end;

function TPagtoparcList.Add: TPagtoparc;
begin
  Result := TPagtoparc(inherited Add);
  Result.create(Self);
end;

function TPagtoparcList.GetItem(Index: Integer): TPagtoparc;
begin
  Result := TPagtoparc(inherited GetItem(Index));
end;

procedure TPagtoparcList.SetItem(Index: Integer; Value: TPagtoparc);
begin
  inherited SetItem(Index, Value);
end;

end.
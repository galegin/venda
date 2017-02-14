unit uMunicipio;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uEstado;

type
  TMunicipio = class;
  TMunicipioClass = class of TMunicipio;

  TMunicipioList = class;
  TMunicipioListClass = class of TMunicipioList;

  TMunicipio = class(TmCollectionItem)
  private
    fCd_Municipio: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Municipio: String;
    fDs_Sigla: String;
    fCd_Estado: Integer;

    fObj_Estado: TEstado;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Municipio: Integer read fCd_Municipio write fCd_Municipio;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Municipio: String read fDs_Municipio write fDs_Municipio;
    property Ds_Sigla: String read fDs_Sigla write fDs_Sigla;
    property Cd_Estado: Integer read fCd_Estado write fCd_Estado;

    property Obj_Estado: TEstado read fObj_Estado write fObj_Estado;
  end;

  TMunicipioList = class(TmCollection)
  private
    function GetItem(Index: Integer): TMunicipio;
    procedure SetItem(Index: Integer; Value: TMunicipio);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TMunicipio;
    property Items[Index: Integer]: TMunicipio read GetItem write SetItem; default;
  end;

implementation

{ TMunicipio }

constructor TMunicipio.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Estado:= TEstado.Create(nil);
end;

destructor TMunicipio.Destroy;
begin

  inherited;
end;

{ TMunicipioList }

constructor TMunicipioList.Create(AOwner: TPersistent);
begin
  inherited Create(TMunicipio);
end;

function TMunicipioList.Add: TMunicipio;
begin
  Result := TMunicipio(inherited Add);
  Result.create(Self);
end;

function TMunicipioList.GetItem(Index: Integer): TMunicipio;
begin
  Result := TMunicipio(inherited GetItem(Index));
end;

procedure TMunicipioList.SetItem(Index: Integer; Value: TMunicipio);
begin
  inherited SetItem(Index, Value);
end;

end.

unit uPais;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPais = class;
  TPaisClass = class of TPais;

  TPaisList = class;
  TPaisListClass = class of TPaisList;

  TPais = class(TmCollectionItem)
  private
    fCd_Pais: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Pais: String;
    fDs_Sigla: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pais: Integer read fCd_Pais write fCd_Pais;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Pais: String read fDs_Pais write fDs_Pais;
    property Ds_Sigla: String read fDs_Sigla write fDs_Sigla;
  end;

  TPaisList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPais;
    procedure SetItem(Index: Integer; Value: TPais);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPais;
    property Items[Index: Integer]: TPais read GetItem write SetItem; default;
  end;

implementation

{ TPais }

constructor TPais.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPais.Destroy;
begin

  inherited;
end;

{ TPaisList } 

constructor TPaisList.Create(AOwner: TPersistent);
begin
  inherited Create(TPais);
end;

function TPaisList.Add: TPais;
begin
  Result := TPais(inherited Add);
  Result.create(Self);
end;

function TPaisList.GetItem(Index: Integer): TPais;
begin
  Result := TPais(inherited GetItem(Index));
end;

procedure TPaisList.SetItem(Index: Integer; Value: TPais);
begin
  inherited SetItem(Index, Value);
end;

end.

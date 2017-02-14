unit uEstado;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uPais;

type
  TEstado = class;
  TEstadoClass = class of TEstado;

  TEstadoList = class;
  TEstadoListClass = class of TEstadoList;

  TEstado = class(TmCollectionItem)
  private
    fCd_Estado: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Estado: String;
    fDs_Sigla: String;
    fCd_Pais: Integer;

    fObj_Pais: TPais;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Estado: Integer read fCd_Estado write fCd_Estado;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Estado: String read fDs_Estado write fDs_Estado;
    property Ds_Sigla: String read fDs_Sigla write fDs_Sigla;
    property Cd_Pais: Integer read fCd_Pais write fCd_Pais;

    property Obj_Pais: TPais read fObj_Pais write fObj_Pais;
  end;

  TEstadoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TEstado;
    procedure SetItem(Index: Integer; Value: TEstado);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TEstado;
    property Items[Index: Integer]: TEstado read GetItem write SetItem; default;
  end;

implementation

{ TEstado }

constructor TEstado.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Pais:= TPais.Create(nil);
end;

destructor TEstado.Destroy;
begin

  inherited;
end;

{ TEstadoList }

constructor TEstadoList.Create(AOwner: TPersistent);
begin
  inherited Create(TEstado);
end;

function TEstadoList.Add: TEstado;
begin
  Result := TEstado(inherited Add);
  Result.create(Self);
end;

function TEstadoList.GetItem(Index: Integer): TEstado;
begin
  Result := TEstado(inherited GetItem(Index));
end;

procedure TEstadoList.SetItem(Index: Integer; Value: TEstado);
begin
  inherited SetItem(Index, Value);
end;

end.

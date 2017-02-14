unit uRegrafiscal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uRegrafiscalimposto;

type
  TRegrafiscal = class;
  TRegrafiscalClass = class of TRegrafiscal;

  TRegrafiscalList = class;
  TRegrafiscalListClass = class of TRegrafiscalList;

  TRegrafiscal = class(TmCollectionItem)
  private
    fCd_Regrafiscal: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Regrafiscal: String;
    fIn_Calcimposto: Boolean;

    fList_Imposto: TRegrafiscalimpostoList;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Regrafiscal: Integer read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Regrafiscal: String read fDs_Regrafiscal write fDs_Regrafiscal;
    property In_Calcimposto: Boolean read fIn_CalcImposto write fIn_CalcImposto;

    property List_Imposto: TRegrafiscalimpostoList read fList_Imposto write fList_Imposto;
  end;

  TRegrafiscalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TRegrafiscal;
    procedure SetItem(Index: Integer; Value: TRegrafiscal);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRegrafiscal;
    property Items[Index: Integer]: TRegrafiscal read GetItem write SetItem; default;
  end;

implementation

{ TRegrafiscal }

constructor TRegrafiscal.Create(ACollection: TCollection);
begin
  inherited;

  fList_Imposto:= TRegrafiscalimpostoList.Create(nil);
  fList_Imposto.IsUpdate := True;
end;

destructor TRegrafiscal.Destroy;
begin

  inherited;
end;

{ TRegrafiscalList }

constructor TRegrafiscalList.Create(AOwner: TPersistent);
begin
  inherited Create(TRegrafiscal);
end;

function TRegrafiscalList.Add: TRegrafiscal;
begin
  Result := TRegrafiscal(inherited Add);
  Result.create(Self);
end;

function TRegrafiscalList.GetItem(Index: Integer): TRegrafiscal;
begin
  Result := TRegrafiscal(inherited GetItem(Index));
end;

procedure TRegrafiscalList.SetItem(Index: Integer; Value: TRegrafiscal);
begin
  inherited SetItem(Index, Value);
end;

end.

unit uEmpresa;

(* classe modelagem *)

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uPessoa;

type
  TEmpresa = class;
  TEmpresaClass = class of TEmpresa;

  TEmpresaList = class;
  TEmpresaListClass = class of TEmpresaList;

  TEmpresa = class(TmCollectionItem)
  private
    fNr_Cpfcnpj: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;

    fObj_Pessoa: TPessoa;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Nr_Cpfcnpj: String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;

    property Obj_Pessoa: TPessoa read fObj_Pessoa write fObj_Pessoa;
  end;

  TEmpresaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TEmpresa;
    procedure SetItem(Index: Integer; Value: TEmpresa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TEmpresa;
    property Items[Index: Integer]: TEmpresa read GetItem write SetItem; default;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Pessoa:= TPessoa.Create(nil);
  fObj_Pessoa.IsUpdate := True;
end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

{ TEmpresaList }

constructor TEmpresaList.Create(AOwner: TPersistent);
begin
  inherited Create(TEmpresa);
end;

function TEmpresaList.Add: TEmpresa;
begin
  Result := TEmpresa(inherited Add);
  Result.create(Self);
end;

function TEmpresaList.GetItem(Index: Integer): TEmpresa;
begin
  Result := TEmpresa(inherited GetItem(Index));
end;

procedure TEmpresaList.SetItem(Index: Integer; Value: TEmpresa);
begin
  inherited SetItem(Index, Value);
end;

end.

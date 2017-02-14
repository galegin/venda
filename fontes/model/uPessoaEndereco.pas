unit uPessoaEndereco;

(* classe modelagem *)

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uMunicipio;

type
  TPessoaEndereco = class;
  TPessoaEnderecoClass = class of TPessoaEndereco;

  TPessoaEnderecoList = class;
  TPessoaEnderecoListClass = class of TPessoaEnderecoList;

  TPessoaEndereco = class(TmCollectionItem)
  private
    fNr_Cpfcnpj: String;
    fNr_SeqEndereco: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Nr_Cpfcnpj: String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property Nr_SeqEndereco: Integer read fNr_SeqEndereco write fNr_SeqEndereco;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPessoaEnderecoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPessoaEndereco;
    procedure SetItem(Index: Integer; Value: TPessoaEndereco);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPessoaEndereco;
    property Items[Index: Integer]: TPessoaEndereco read GetItem write SetItem; default;
  end;

implementation

{ TPessoaEndereco }

constructor TPessoaEndereco.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Municipio:= TMunicipio.Create(nil);
end;

destructor TPessoaEndereco.Destroy;
begin

  inherited;
end;

{ TPessoaEnderecoList }

constructor TPessoaEnderecoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPessoaEndereco);
end;

function TPessoaEnderecoList.Add: TPessoaEndereco;
begin
  Result := TPessoaEndereco(inherited Add);
  Result.create(Self);
end;

function TPessoaEnderecoList.GetItem(Index: Integer): TPessoaEndereco;
begin
  Result := TPessoaEndereco(inherited GetItem(Index));
end;

procedure TPessoaEnderecoList.SetItem(Index: Integer; Value: TPessoaEndereco);
begin
  inherited SetItem(Index, Value);
end;

end.
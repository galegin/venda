unit uPessoa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uMunicipio;

type
  TPessoa = class;
  TPessoaClass = class of TPessoa;

  TPessoaList = class;
  TPessoaListClass = class of TPessoaList;

  TPessoa = class(TmCollectionItem)
  private
    fNr_Cpfcnpj: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fNr_Rgie: String;
    fCd_Pessoa: Integer;
    fNm_Pessoa: String;
    fNm_Fantasia: String;
    fCd_Cep: Integer;
    fNm_Logradouro: String;
    fNr_Logradouro: String;
    fDs_Bairro: String;
    fDs_Complemento: String;
    fCd_Municipio: Integer;
    fDs_Municipio: String;
    fCd_Estado: Integer;
    fDs_Estado: String;
    fDs_SiglaEstado: String;
    fCd_Pais: Integer;
    fDs_Pais: String;
    fDs_Fone: String;
    fDs_Celular: String;
    fDs_Email: String;

    fObj_Municipio: TMunicipio;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Nr_Cpfcnpj: String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Rgie: String read fNr_Rgie write fNr_Rgie;
    property Cd_Pessoa: Integer read fCd_Pessoa write fCd_Pessoa;
    property Nm_Pessoa: String read fNm_Pessoa write fNm_Pessoa;
    property Nm_Fantasia: String read fNm_Fantasia write fNm_Fantasia;
    property Cd_Cep: Integer read fCd_Cep write fCd_Cep;
    property Nm_Logradouro: String read fNm_Logradouro write fNm_Logradouro;
    property Nr_Logradouro: String read fNr_Logradouro write fNr_Logradouro;
    property Ds_Bairro: String read fDs_Bairro write fDs_Bairro;
    property Ds_Complemento: String read fDs_Complemento write fDs_Complemento;
    property Cd_Municipio: Integer read fCd_Municipio write fCd_Municipio;
    property Ds_Municipio: String read fDs_Municipio write fDs_Municipio;
    property Cd_Estado: Integer read fCd_Estado write fCd_Estado;
    property Ds_Estado: String read fDs_Estado write fDs_Estado;
    property Ds_SiglaEstado: String read fDs_SiglaEstado write fDs_SiglaEstado;
    property Cd_Pais: Integer read fCd_Pais write fCd_Pais;
    property Ds_Pais: String read fDs_Pais write fDs_Pais;
    property Ds_Fone: String read fDs_Fone write fDs_Fone;
    property Ds_Celular: String read fDs_Celular write fDs_Celular;
    property Ds_Email: String read fDs_Email write fDs_Email;

    property Obj_Municipio: TMunicipio read fObj_Municipio write fObj_Municipio;
  end;

  TPessoaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPessoa;
    procedure SetItem(Index: Integer; Value: TPessoa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPessoa;
    property Items[Index: Integer]: TPessoa read GetItem write SetItem; default;
  end;

implementation

{ TPessoa }

constructor TPessoa.Create(ACollection: TCollection);
begin
  inherited;

  fObj_Municipio:= TMunicipio.Create(nil);
end;

destructor TPessoa.Destroy;
begin

  inherited;
end;

{ TPessoaList }

constructor TPessoaList.Create(AOwner: TPersistent);
begin
  inherited Create(TPessoa);
end;

function TPessoaList.Add: TPessoa;
begin
  Result := TPessoa(inherited Add);
  Result.create(Self);
end;

function TPessoaList.GetItem(Index: Integer): TPessoa;
begin
  Result := TPessoa(inherited GetItem(Index));
end;

procedure TPessoaList.SetItem(Index: Integer; Value: TPessoa);
begin
  inherited SetItem(Index, Value);
end;

end.
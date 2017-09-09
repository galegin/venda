unit uclsPessoaServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uPessoa;

type
  TcPessoaServico = class(TComponent)
  private
    fPessoa : TPessoa;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function Listar() : TPessoas;

    function Consultar(AId_Pessoa: String) : TPessoa;

    procedure Salvar(
      ANr_Cpfcnpj: String;
      ANr_Rgie: String;
      ACd_Pessoa: Integer;
      ANm_Pessoa: String;
      ACd_Cep: Integer;
      ANm_Logradouro: String;
      ANr_Logradouro: String;
      ADs_Bairro: String;
      ADs_Complemento: String;
      ACd_Municipio: Integer;
      ADs_Municipio: String;
      ACd_Estado: Integer;
      ADs_Estado: String;
      ADs_SiglaEstado: String;
      ACd_Pais: Integer;
      ADs_Pais: String;
      ADs_Fone: String;
      ADs_Celular: String;
      ADs_Email: String);

    procedure Excluir(AId_Pessoa: String);

  published
  end;

  function Instance : TcPessoaServico;
  procedure Destroy;

implementation

uses
  mCollectionItem;

var
  _instance : TcPessoaServico;

  function Instance : TcPessoaServico;
  begin
    if not Assigned(_instance) then
      _instance := TcPessoaServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcPessoaServico.Create(AOwner : TComponent);
begin
  inherited;

  fPessoa := TPessoa.Create(nil);
end;

destructor TcPessoaServico.Destroy;
begin
  FreeAndNil(fPessoa);

  inherited;
end;

function TcPessoaServico.Listar;
begin
  Result := TPessoaList(fPessoa.Listar(nil));
end;

function TcPessoaServico.Consultar;
begin
  with fPessoa do begin
    Limpar();
    if ANr_Cpfcnpj <> '' then begin
      Nr_Cpfcnpj := ANr_Cpfcnpj;
      Consultar(nil);
      Result := fPessoa;
    end else begin
      Result := nil;
    end;
  end;
end;

procedure TcPessoaServico.Salvar;
begin
  with fPessoa do begin
    Limpar();

    Nr_Cpfcnpj := ANr_Cpfcnpj;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Nr_Rgie := ANr_Rgie;
    Cd_Pessoa := ACd_Pessoa;
    Nm_Pessoa := ANm_Pessoa;
    Cd_Cep := ACd_Cep;
    Nm_Logradouro := ANm_Logradouro;
    Nr_Logradouro := ANr_Logradouro;
    Ds_Bairro := ADs_Bairro;
    Ds_Complemento := ADs_Complemento;
    Cd_Municipio := ACd_Municipio;
    Ds_Municipio := ADs_Municipio;
    Cd_Estado := ACd_Estado;
    Ds_Estado := ADs_Estado;
    Ds_SiglaEstado := ADs_SiglaEstado;
    Cd_Pais := ACd_Pais;
    Ds_Pais := ADs_Pais;
    Ds_Fone := ADs_Fone;
    Ds_Celular := ADs_Celular;
    Ds_Email := ADs_Email;

    Salvar();
  end;
end;

procedure TcPessoaServico.Excluir;
begin
  with fPessoa do begin
    Nr_Cpfcnpj := '';

    Excluir();
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

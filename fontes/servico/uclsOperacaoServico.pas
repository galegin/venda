unit uclsOperacaoServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uOperacao;

type
  TcOperacaoServico = class(TComponent)
  private
    fOperacao : TOperacao;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function Listar() : TOperacaoList;

    function Consultar(ACd_Operacao: String) : TOperacao;

    procedure Salvar(
      ACd_Operacao : String;
      ADs_Operacao : String;
      ATp_Docfiscal: Integer;
      ATp_Modalidade: Integer;
      ATp_Operacao: Integer;
      ACd_Serie: String);

    procedure Excluir(ACd_Operacao : String);

  published
    property Operacao : TOperacao read fOperacao write fOperacao;
  end;

  function Instance : TcOperacaoServico;
  procedure Destroy;

implementation

uses
  mCollectionItem;

var
  _instance : TcOperacaoServico;

  function Instance : TcOperacaoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcOperacaoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcOperacaoServico.Create(AOwner : TComponent);
begin
  inherited;

  fOperacao := TOperacao.Create(nil);
end;

destructor TcOperacaoServico.Destroy;
begin
  FreeAndNil(fOperacao);

  inherited;
end;

function TcOperacaoServico.Listar;
begin
  Result := TOperacaoList(fOperacao.Listar(nil));
end;

function TcOperacaoServico.Consultar;
begin
  with fOperacao do begin
    Limpar();
    if ACd_Operacao <> '' then begin
      Cd_Operacao := ACd_Operacao;
      Consultar(nil);
      Result := fOperacao;
    end else begin
      Result := nil;
    end;
  end;
end;

procedure TcOperacaoServico.Salvar;
begin
  with fOperacao do begin
    Cd_Operacao := ACd_Operacao;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Tp_Docfiscal := ATp_Docfiscal;
    Tp_Modalidade := ATp_Modalidade;
    Tp_Operacao := ATp_Operacao;
    Cd_Serie := ACd_Serie;

    Salvar();
  end;
end;

procedure TcOperacaoServico.Excluir;
begin
  with fOperacao do begin
    Limpar();
    if ACd_Operacao <> '' then begin
      Cd_Operacao := ACd_Operacao;
      Excluir();
    end;
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

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

    function Listar() : TOperacaos;

    function Consultar(AId_Operacao: String) : TOperacao;

    procedure Salvar(
      AId_Operacao : String;
      ADs_Operacao : String;
      ATp_Modelonf : Integer;
      ATp_Modalidade : Integer;
      ATp_Operacao : Integer;
      ACd_Serie : String);

    procedure Excluir(AId_Operacao : String);

  published
    property Operacao : TOperacao read fOperacao write fOperacao;
  end;

  function Instance : TcOperacaoServico;
  procedure Destroy;

implementation

uses
  mContexto;

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
  Result := mContexto.Instance.GetLista(TOperacao, '', TOperacaos) as TOperacaos;
end;

function TcOperacaoServico.Consultar;
begin
  if AId_Operacao <> '' then begin
    fOperacao := mContexto.Instance.GetObjeto(TOperacao, 'Id_Operacao = ''' + AId_Operacao + '''') as TOperacao;
    Result := fOperacao;
  end else begin
    Result := nil;
  end;
end;

procedure TcOperacaoServico.Salvar;
begin
  with fOperacao do begin
    Id_Operacao := AId_Operacao;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Tp_Modelonf := ATp_Modelonf;
    Tp_Modalidade := ATp_Modalidade;
    Tp_Operacao := ATp_Operacao;
    Cd_Serie := ACd_Serie;
  end;

  mContexto.Instance.SetObjeto(fOperacao);
end;

procedure TcOperacaoServico.Excluir;
begin
  with fOperacao do begin
    if AId_Operacao <> '' then begin
      Id_Operacao := AId_Operacao;
      mContexto.Instance.RemObjeto(fOperacao);
    end;
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

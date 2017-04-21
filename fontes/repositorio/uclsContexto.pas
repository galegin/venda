unit uclsContexto;

(* contexto *)

interface

uses
  Classes, SysUtils, StrUtils,
  mContexto, mProjeto, mIniFiles;

type
  TcContexto = class(TmContexto)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcContexto;
  procedure Destroy;

implementation

uses
  uclsMigracao,
  uclsPopulador,

  uAliqicmsMap,
  uCaixaMap,
  uCfopMap,
  uEmpresaMap,
  uEquipMap,
  uEstadoMap,
  uHistrelMap,
  uMunicipioMap,
  uNcmMap,
  uNcmsubstMap,
  uOperacaoMap,
  uPagtoMap,
  uPagtoparcMap,
  uPaisMap,
  uPessoaMap,
  uProdutoMap,
  uRegrafiscalMap,
  uRegrafiscalImpostoMap,
  uTransacaoMap,
  uTransdfeMap,
  uTransfiscalMap,
  uTransimpostoMap,
  uTransitemMap,
  uTranspagtoMap,
  uTransvenctoMap,
  uUsuarioMap;

var
  _instance : TcContexto;

  function Instance : TcContexto;
  begin
    if not Assigned(_instance) then
      _instance := TcContexto.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcContexto.Create(AOwner : TComponent);
var
  vVersaoDat, vVersaoExe : String;
begin
  inherited;

  // versao arquivo

  vVersaoDat := TmIniFiles.PegarS('', 'VERSAO', 'Cd_Versao');
  vVersaoExe := mProjeto.Instance.Versao;
  if vVersaoDat = vVersaoExe then
    Exit;

  // database

  // mapeamento

  AddEntidadeList([
    TAliqicmsMap,
    TCaixaMap,
    TCfopMap,
    TEmpresaMap,
    TEquipMap,
    TEstadoMap,
    THistrelMap,
    TMunicipioMap,
    TNcmMap,
    TNcmsubstMap,
    TOperacaoMap,
    TPagtoMap,
    TPagtoparcMap,
    TPaisMap,
    TPessoaMap,
    TProdutoMap,
    TRegrafiscalMap,
    TRegrafiscalImpostoMap,
    TTransacaoMap,
    TTransdfeMap,
    TTransfiscalMap,
    TTransimpostoMap,
    TTransitemMap,
    TTranspagtoMap,
    TTransvenctoMap,
    TUsuarioMap]);

  // migracao

  uclsMigracao.Instance.Initialize(Self);

  // populador

  uclsPopulador.Instance.Initialize(Self);

  // grava versao

  TmIniFiles.Setar('', 'VERSAO', 'Cd_Versao', vVersaoExe);
end;

destructor TcContexto.Destroy;
begin

  inherited;
end;

//--

initialization
  //Instance();

finalization
  Destroy();

end.

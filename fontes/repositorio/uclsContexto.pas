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
  published
  end;

  function Instance : TcContexto;

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

  ClearEntidade();

  AddEntidade(TAliqicmsMap);
  AddEntidade(TCaixaMap);
  AddEntidade(TCfopMap);
  AddEntidade(TEmpresaMap);
  AddEntidade(TEquipMap);
  AddEntidade(TEstadoMap);
  AddEntidade(THistrelMap);
  AddEntidade(TMunicipioMap);
  AddEntidade(TNcmMap);
  AddEntidade(TNcmsubstMap);
  AddEntidade(TOperacaoMap);
  AddEntidade(TPagtoMap);
  AddEntidade(TPagtoparcMap);
  AddEntidade(TPaisMap);
  AddEntidade(TPessoaMap);
  AddEntidade(TProdutoMap);
  AddEntidade(TRegrafiscalMap);
  AddEntidade(TRegrafiscalImpostoMap);
  AddEntidade(TTransacaoMap);
  AddEntidade(TTransdfeMap);
  AddEntidade(TTransfiscalMap);
  AddEntidade(TTransimpostoMap);
  AddEntidade(TTransitemMap);
  AddEntidade(TTranspagtoMap);
  AddEntidade(TTransvenctoMap);
  AddEntidade(TUsuarioMap);

  // migracao

  uclsMigracao.Instance.Initialize(Self);

  // populador

  uclsPopulador.Instance.Initialize(Self);

  // grava versao

  TmIniFiles.Setar('', 'VERSAO', 'Cd_Versao', vVersaoExe);
end;

//--

end.

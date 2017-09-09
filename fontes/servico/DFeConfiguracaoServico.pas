unit DFeConfiguracaoServico; // uclsDFeServico

(* DFeConfiguracaoServico *)

interface

uses
  Classes, SysUtils, StrUtils,
  pcnConversao, pcnConversaoNFe,
  uTipoImpressaoDanfe;

type
  TcDFeConfiguracaoServico = class(TComponent)
  private
    fUf_Origem : String;   // 'PR'
    fTp_Ambiente : TpcnTipoAmbiente; // 1 - Producao / 2 - Homologacao
    fTp_Emissao : TpcnTipoEmissao;   // 1 - Normal / 9 - OffLine
    fTp_ModeloDF : TpcnModeloDF;       // NFE / NFCE
    fTp_VersaoDF : TpcnVersaoDF;       // 2.00 / 3.00 / 3.10

    fDs_ArquivoCert : String; // 'c:\projetos\venda\certificados\certificado.pfx'
    fDs_SenhaCert : String;   // '1234'
    fDs_SerieCert : String;   // '123456789ABCDEFGH'

    fId_CSC : String; // '1'
    fCd_CSC : String; // '0123456789'

    fTp_DANFE : TpcnTipoImpressao;
    fDs_LogoMarca : String;

    fIn_MostrarPreview : Boolean;
    fIn_MostrarStatus : Boolean;

    fTp_ImpressaoDanfe : TTipoImpressaoDanfe;
  protected
    procedure Carregar;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Uf_Origem : String read fUf_Origem write fUf_Origem;
    property Tp_Ambiente : TpcnTipoAmbiente read fTp_Ambiente write fTp_Ambiente;
    property Tp_Emissao : TpcnTipoEmissao read fTp_Emissao write fTp_Emissao;
    property Tp_ModeloDF : TpcnModeloDF read fTp_ModeloDF write fTp_ModeloDF;
    property Tp_VersaoDF : TpcnVersaoDF read fTp_VersaoDF write fTp_VersaoDF;

    property Ds_ArquivoCert : String read fDs_ArquivoCert write fDs_ArquivoCert;
    property Ds_SenhaCert : String read fDs_SenhaCert write fDs_SenhaCert;
    property Ds_SerieCert : String read fDs_SerieCert write fDs_SerieCert;

    property Id_CSC : String read fId_CSC write fId_CSC;
    property Cd_CSC : String read fCd_CSC write fCd_CSC;

    property Tp_DANFE : TpcnTipoImpressao read fTp_DANFE write fTp_DANFE;
    property Ds_LogoMarca : String read fDs_LogoMarca write fDs_LogoMarca;

    property In_MostrarPreview : Boolean read fIn_MostrarPreview write fIn_MostrarPreview;
    property In_MostrarStatus : Boolean read fIn_MostrarStatus write fIn_MostrarStatus;

    property Tp_ImpressaoDanfe : TTipoImpressaoDanfe read fTp_ImpressaoDanfe write fTp_ImpressaoDanfe;
  end;

  function Instance : TcDFeConfiguracaoServico;
  procedure Destroy;

implementation

uses
  mTipoParametro;

var
  _instance : TcDFeConfiguracaoServico;

  function Instance : TcDFeConfiguracaoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeConfiguracaoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cDFeConfiguracaoServico *)

constructor TcDFeConfiguracaoServico.Create(AOwner : TComponent);
begin
  inherited;

  Carregar;
end;

destructor TcDFeConfiguracaoServico.Destroy;
begin

  inherited;
end;

procedure TcDFeConfiguracaoServico.Carregar;
var
  vOk : Boolean;
begin
  fUf_Origem := mTipoParametro.Instance.Uf_Origem;
  fTp_Ambiente := StrToTpAmb(vOk, mTipoParametro.Instance.Tp_Ambiente);
  fTp_Emissao := StrToTpEmis(vOk, mTipoParametro.Instance.Tp_Emissao);
  fTp_ModeloDF := StrToModeloDF(vOk, mTipoParametro.Instance.Tp_ModeloDF);
  fTp_VersaoDF := StrToVersaoDF(vOk, mTipoParametro.Instance.Tp_VersaoDF);

  fDs_ArquivoCert := mTipoParametro.Instance.Ds_ArquivoCert;
  fDs_SenhaCert := mTipoParametro.Instance.Ds_SenhaCert;
  fDs_SerieCert := mTipoParametro.Instance.Ds_SerieCert;

  fId_CSC := mTipoParametro.Instance.Id_CSC;
  fCd_CSC := mTipoParametro.Instance.Cd_CSC;

  fTp_DANFE := StrToTpImp(vOk, mTipoParametro.Instance.Tp_DANFE);

  fIn_MostrarPreview := mTipoParametro.Instance.In_MostrarPreview = 'T';
  fIn_MostrarStatus := mTipoParametro.Instance.In_MostrarStatus = 'T';

  fTp_ImpressaoDanfe := StrToTipoImpressaoDanfe(mTipoParametro.Instance.Tp_ImpressaoDanfe);
end;

initialization
  //Instance();

finalization
  Destroy();

(*
procedure TcDFeServico.ConfigurarDFe;
begin

  CarregarParametro;

// GERAL

  with fACBrNFe.Configuracoes.Geral do begin
    ExibirErroSchema := True; // cbxExibirErroSchema.Checked;
    RetirarAcentos   := True; // cbxRetirarAcentos.Checked;
    FormatoAlerta    := ''; // edtFormatoAlerta.Text;
    FormaEmissao     := fTp_Emissao;
    ModeloDF         := fTp_ModeloDF;
    VersaoDF         := fTp_VersaoDF;
    IdCSC            := fId_CSC;
    CSC              := fCd_CSC;
    Salvar           := False;
  end;

// WEBSERVICES

  with fACBrNFe.Configuracoes.WebServices do begin
    UF         := fUf_Origem;
    Ambiente   := fTp_Ambiente;
    Visualizar := False; // cbxVisualizar.Checked;
    Salvar     := False; // cbxSalvarSOAP.Checked;

    AjustaAguardaConsultaRet := True; // cbxAjustarAut.Checked;
    AguardarConsultaRet      := 1000;
    Tentativas               := 10;
    IntervaloTentativas      := 1000;
    TimeOut                  := 120000; // 2 minutos

    ProxyHost := mProxy.Instance.Host; //edtProxyHost.Text;
    ProxyPort := mProxy.Instance.Porta; //edtProxyPorta.Text;
    ProxyUser := mProxy.Instance.User; //edtProxyUser.Text;
    ProxyPass := mProxy.Instance.Senha; //edtProxySenha.Text;
  end;

//ARQUIVOS

  with fACBrNFe.Configuracoes.Arquivos do begin
    Salvar             := True; //cbxSalvarArqs.Checked;
    SepararPorMes      := False; //cbxPastaMensal.Checked;
    AdicionarLiteral   := False; //cbxAdicionaLiteral.Checked;
    EmissaoPathNFe     := False; //cbxEmissaoPathNFe.Checked;
    SalvarEvento       := False; //cbxSalvaPathEvento.Checked;
    SepararPorCNPJ     := False; //cbxSepararPorCNPJ.Checked;
    SepararPorModelo   := False; //cbxSepararPorModelo.Checked;
    PathSalvar         := TmPath.Temp(); // edtPathLogs.Text;
    PathSchemas        := TmPath.Schemas(); // edtPathSchemas.Text;
    PathNFe            := TmPath.DFe(); // edtPathNFe.Text;
    PathInu            := TmPath.DFe(); // edtPathInu.Text;
    PathEvento         := TmPath.DFe(); // edtPathEvento.Text;
  end;

// CERTIFICADO

  with fACBrNFe.Configuracoes.Certificados do begin
    ArquivoPFX  := TmPath.Certificados() + fDs_ArquivoCert; // edtCaminho.Text;
    Senha       := fDs_SenhaCert; // edtSenha.Text;
    NumeroSerie := fDs_SerieCert; // edtNumSerie.Text;
  end;

// DANFE

  fACBrNFe.DANFE := nil;

end;
*)

end.
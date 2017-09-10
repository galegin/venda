unit uclsDFeServico;

(* classe servico *)

interface

uses
  Classes, SysUtils, StrUtils,
  ACBrNFe, ACBrNFeWebServices,
  ACBrDFeWebService, ACBrNFeNotasFiscais,
  ACBrNFeDANFEClass, ACBrNFeDANFeESCPOS,
  ACBrNFeDANFeRLClass, ACBrDANFCeFortesFr,
  pcnConversao, pcnNFe, pcnConversaoNFe,
  uclsContingenciaServico, uclsEmpresaServico,
  uTipoProcessamento, uTipoImpressaoDanfe, uTipoRetornoSefaz, uTipoPessoa,
  uTransacao, uTransfiscal, uTranspagto;

type
  TcDFeServico = class(TComponent)
  private
    fACBrNFe : TACBrNFe;
    fACBrNFeDANFe : TACBrNFeDANFeRL;
    fACBrNFeDANFCe : TACBrNFeDANFCeFortes;

    fTransacao : TTransacao;

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

    procedure AnalisaRetorno(ATipoRetornoSefaz : RTipoRetornoSefaz);
    function EmitirDFeGerada(
      ATransfiscal: TTransfiscal): RTipoRetornoSefaz;

  protected
    procedure ValidarParametro;
    procedure CarregarParametro;

    procedure LimparDFe;
    procedure ConfigurarDFe;
    procedure CarregarDFe;

    procedure GravarDFe(
      ATipoProcessamento : TTipoProcessamento;
      ADsChaveAcesso : String;
      ADsEnvioXml : String;
      ADtRecebimento : TDateTime;
      ANrRecibo : String;
      ADsRetornoXml : String);

    procedure GerarDFe;

    function GerarEnvioDFe(
      AXml : String) : RTipoRetornoSefaz;

    procedure GerarImpressaoDFe(
      AXml : String);

    function GerarCancelamentoDFe(
      AChave : String;
      ACNPJ : String;
      AJustificativa : String;
      AProtocolo : String) : RTipoRetornoSefaz;

    function GerarInutilizacaoDFe(
      ACNPJEmitente : String;
      AJustificativa : String;
      AAno : Integer;
      AModelo : Integer;
      ASerie : Integer;
      ANumeroInicial : Integer;
      ANumeroFinal : Integer) : RTipoRetornoSefaz;

    function GerarConsultaDFe(
      AXml : String) : RTipoRetornoSefaz;

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function EmitirDFe() : RTipoRetornoSefaz; overload;
    function EmitirDFe(ATransacao : TTransacao) : RTipoRetornoSefaz; overload;

    function EmitirDFeGerada() : RTipoRetornoSefaz; overload;
    function EmitirDFeGerada(ATransacao : TTransacao) : RTipoRetornoSefaz; overload;

    procedure ImprimirDFe(); overload;
    procedure ImprimirDFe(ATransacao : TTransacao); overload;

    function CancelarDFe() : RTipoRetornoSefaz; overload;
    function CancelarDFe(ATransacao : TTransacao) : RTipoRetornoSefaz; overload;

    function InutilizarDFe() : RTipoRetornoSefaz; overload;
    function InutilizarDFe(ATransacao : TTransacao) : RTipoRetornoSefaz; overload;

    function ConsultarDFe() : RTipoRetornoSefaz; overload;
    function ConsultarDFe(ATransacao : TTransacao) : RTipoRetornoSefaz; overload;
  published
  end;

  function Instance : TcDFeServico;
  procedure Destroy;

implementation

uses
  uTipoImposto,
  uMunicipio, uPessoa, uTransdfe, uTransitem, uTransimposto,
  mPath, mProxy, mTipoMensagem, mTipoParametro, mString, mException,
  TypInfo, ACBrDFeConfiguracoes,
  mContexto;

var
  _instance : TcDFeServico;

  function Instance : TcDFeServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcDFeServico.Create(AOwner : TComponent);
begin
  inherited;

  fACBrNFe := TACBrNFe.Create(Self);
  fTransacao := TTransacao.Create(nil);
end;

destructor TcDFeServico.Destroy;
begin
  FreeAndNil(fACBrNFe);
  FreeAndNil(fTransacao);

  inherited;
end;

//--

procedure TcDFeServico.ValidarParametro;
const
  cDS_METHOD = 'TcDFeServico.ValidarParametro()';
var
  I : Integer;
begin
  if not Assigned(fTransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  if not Assigned(fTransacao.Empresa) then
    raise Exception.Create('Empresa deve ser informada / ' + cDS_METHOD);
  if not Assigned(fTransacao.Empresa.Pessoa) then
    raise Exception.Create('Pessoa da empresa deve ser informada / ' + cDS_METHOD);
  if not Assigned(fTransacao.Pessoa) then
    raise Exception.Create('Pessoa deve ser informada / ' + cDS_METHOD);
  if not Assigned(fTransacao.Operacao) then
    raise Exception.Create('Operacao deve ser informada / ' + cDS_METHOD);
  if not Assigned(fTransacao.Fiscal) then
    raise Exception.Create('Fiscal deve ser informado / ' + cDS_METHOD);

  if fTransacao.Itens.Count = 0 then
    raise Exception.Create('Item deve ser informado / ' + cDS_METHOD);

  for I := 0 to fTransacao.Itens.Count - 1 do
    with TTransitem(fTransacao.Itens[I]) do
      if Impostos.Count = 0 then
        raise Exception.Create('Imposto do item ' + FloatToStr(Nr_Item) + ' deve ser informado / ' + cDS_METHOD);
end;

procedure TcDFeServico.CarregarParametro;
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

//--

procedure TcDFeServico.LimparDFe;
begin
  fACBrNFe.NotasFiscais.Clear;
end;

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

procedure TcDFeServico.CarregarDFe;
begin
  with TTransdfe(fTransacao.Fiscal.Eventos.Items[0]) do begin
    fACBrNFe.NotasFiscais.LoadFromString(Ds_Envioxml);
  end;
end;

procedure TcDFeServico.GravarDFe;
const
  cDS_METHOD = 'TcDFeServico.GravarDFe()';
begin
  if ADsChaveAcesso = '' then
    raise Exception.Create('Chave deve ser informado / ' + cDS_METHOD);
  if ADsEnvioXml = '' then
    raise Exception.Create('Xml protocolado deve ser informado / ' + cDS_METHOD);
  if ADtRecebimento = 0 then
    raise Exception.Create('Data recibo deve ser informado / ' + cDS_METHOD);
  if ANrRecibo = '' then
    raise Exception.Create('Numero recibo deve ser informado / ' + cDS_METHOD);
  if ADsRetornoXml = '' then
    raise Exception.Create('Retorno xml deve ser informado / ' + cDS_METHOD);

  with fTransacao.Fiscal do begin
    Ds_Chaveacesso := AnsiReplaceStr(ADsChaveAcesso, 'NFe', '');
    Nr_Recibo := ANrRecibo;
    Dt_Recebimento := ADtRecebimento;
    Tp_Processamento := TipoProcessamentoToStr(ATipoProcessamento);

    with Eventos.Add do begin
      Id_Transacao := fTransacao.Id_Transacao;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Ds_Envioxml := ADsEnvioXml;
      Ds_RetornoXml := ADsRetornoXml;
    end;
  end;
end;

//--

type
  TrProdEAN = record
    cProd : String;
    cEAN : String;
  end;

  function GetProdEAN(AcProd, AcEAN : String) : TrProdEAN;
  begin
    if not ((Length(AcEAN) = 13) and TmString.StartsWiths(AcEAN, '789')) then
      AcEAN := '';

    Result.cProd := AcProd;
    Result.cEAN := AcEAN;
  end;

procedure TcDFeServico.GerarDFe;
var
  vTipoPessoa : TTipoPessoa;
  vProdEAN : TrProdEAN;
  vVlTotTrib : Real;
  I, J : Integer;
  vOk : Boolean;
begin
  with fACBrNFe.NotasFiscais.Add.NFe do begin

// IDENTIFICACAO

    Ide.cNF       := fTransacao.Nr_Transacao; //Caso não seja preenchido será gerado um número aleatório pelo componente
    Ide.natOp     := fTransacao.Operacao.Ds_Operacao;
    Ide.indPag    := ipVista;
    Ide.modelo    := fTransacao.Fiscal.Tp_Modelonf;
    Ide.serie     := StrToIntDef(fTransacao.Fiscal.Cd_Serie, 1);
    Ide.nNF       := fTransacao.Fiscal.Nr_Nf;
    Ide.dEmi      := now;
    Ide.dSaiEnt   := now;
    Ide.hSaiEnt   := now;
    Ide.tpNF      := StrToTpNF(vOk, IntToStr(fTransacao.Fiscal.Tp_Operacao));
    Ide.tpEmis    := fTp_Emissao;
    Ide.tpAmb     := fTp_Ambiente; //Lembre-se de trocar esta variável quando for para ambiente de produção
    Ide.cUF       := UFtoCUF(fUf_Origem);
    Ide.cMunFG    := fTransacao.Empresa.Pessoa.Cd_Municipio;
    Ide.finNFe    := fnNormal;
    Ide.tpImp     := fTp_DANFE; // tiSemGeracao;
    Ide.indFinal  := cfConsumidorFinal;
    Ide.indPres   := pcPresencial;

//  Ide.dhCont := date;
//  Ide.xJust  := 'Justificativa Contingencia';

// EMITENTE

    with fTransacao.Empresa.Pessoa do begin
      Emit.CNPJCPF           := Nr_CpfCnpj;
      Emit.IE                := Nr_Rgie;
      Emit.xNome             := Nm_Pessoa;
      Emit.xFant             := Nm_Fantasia;

      Emit.EnderEmit.fone    := Ds_Fone;
      Emit.EnderEmit.CEP     := Cd_Cep;
      Emit.EnderEmit.xLgr    := Nm_Logradouro;
      Emit.EnderEmit.nro     := Nr_Logradouro;
      Emit.EnderEmit.xCpl    := Ds_Complemento;
      Emit.EnderEmit.xBairro := Ds_Bairro;
      Emit.EnderEmit.cMun    := Cd_Municipio;
      Emit.EnderEmit.xMun    := Ds_Municipio;
      Emit.EnderEmit.UF      := Ds_SiglaEstado;
      Emit.enderEmit.cPais   := Cd_Pais;
      Emit.enderEmit.xPais   := Ds_Pais;

      Emit.IEST              := '';
//    Emit.IM                := '2648800'; // Preencher no caso de existir serviços na nota
//    Emit.CNAE              := '6201500'; // Verifique na cidade do emissor da NFe se é permitido
                                           // a inclusão de serviços na NFe
      Emit.CRT               := crtRegimeNormal; // (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)
    end;

// DESTINATARIO

   vTipoPessoa := StrToTipoPessoa(fTransacao.Pessoa.Nr_CpfCnpj);

    with fTransacao.Pessoa do begin
      Dest.CNPJCPF           := Nr_CpfCnpj;

      if vTipoPessoa = tpJuridica then
        Dest.IE            := Nr_Rgie; //NFC-e não aceita IE

      case fTp_ModeloDF of
        moNFCe : begin
          Dest.indIEDest := inNaoContribuinte;
        end;

        moNFe : begin
          if (Nr_Rgie = '') or (In_Consumidorfinal = 'T') then
            Dest.indIEDest := inNaoContribuinte
          else if (Nr_Rgie = 'ISENTO') then
            Dest.indIEDest := inIsento
          else
            Dest.indIEDest := inContribuinte;
        end;
      end;

      Dest.ISUF              := '';
      Dest.xNome             := Nm_Pessoa;

      Dest.EnderDest.Fone    := Ds_Fone;
      Dest.EnderDest.CEP     := Cd_Cep;
      Dest.EnderDest.xLgr    := Nm_Logradouro;
      Dest.EnderDest.nro     := Nr_Logradouro;
      Dest.EnderDest.xCpl    := Ds_Complemento;
      Dest.EnderDest.xBairro := Ds_Bairro;
      Dest.EnderDest.cMun    := Cd_Municipio;
      Dest.EnderDest.xMun    := Ds_Municipio;
      Dest.EnderDest.UF      := Ds_SiglaEstado;
      Dest.EnderDest.cPais   := Cd_Pais;
      Dest.EnderDest.xPais   := Ds_Pais;
    end;

//Use os campos abaixo para informar o endereço de retirada quando for diferente do Remetente/Destinatário

{   Retirada.CNPJCPF := '';
    Retirada.xLgr    := '';
    Retirada.nro     := '';
    Retirada.xCpl    := '';
    Retirada.xBairro := '';
    Retirada.cMun    := 0;
    Retirada.xMun    := '';
    Retirada.UF      := ''; }

//Use os campos abaixo para informar o endereço de entrega quando for diferente do Remetente/Destinatário

{   Entrega.CNPJCPF := '';
    Entrega.xLgr    := '';
    Entrega.nro     := '';
    Entrega.xCpl    := '';
    Entrega.xBairro := '';
    Entrega.cMun    := 0;
    Entrega.xMun    := '';
    Entrega.UF      := ''; }

//Adicionando Produtos

    vVlTotTrib := 0;

    for I := 0 to fTransacao.Itens.Count - 1 do begin
      with Det.Add, TTransitem(fTransacao.Itens[I]) do begin

        vProdEAN := GetProdEAN(IntToStr(Cd_Produto), Id_Produto);

        Prod.nItem    := Nr_Item; // Número sequencial, para cada item deve ser incrementado
        Prod.cProd    := vProdEAN.cProd;
        Prod.cEAN     := vProdEAN.cEAN;
        Prod.xProd    := Ds_Produto;
        Prod.NCM      := Cd_Ncm; // Tabela NCM disponível em  http://www.receita.fazenda.gov.br/Aliquotas/DownloadArqTIPI.htm
        Prod.EXTIPI   := '';
        Prod.CFOP     := IntToStr(Cd_Cfop);
        Prod.uCom     := Cd_Especie;
        Prod.qCom     := Qt_Item;
        Prod.vUnCom   := Vl_Unitario;
        Prod.vProd    := Vl_Item;

        Prod.cEANTrib := vProdEAN.cEAN;
        Prod.uTrib    := Cd_Especie;
        Prod.qTrib    := Qt_Item;
        Prod.vUnTrib  := Vl_Unitario;

        Prod.vOutro   := Vl_Outro;
        Prod.vFrete   := Vl_Frete;
        Prod.vSeg     := Vl_Seguro;
        Prod.vDesc    := Vl_Desconto;

        Prod.CEST     := ''; // '1111111';

  //    infAdProd      := 'Informação Adicional do Produto';

// IMPOSTO

        for J := 0 to Impostos.Count - 1 do begin

          with Imposto, TTransimposto(Impostos[J]) do begin

            // lei da transparencia nos impostos
            vVlTotTrib := vVlTotTrib + Vl_Imposto;
            vTotTrib := vTotTrib + Vl_Imposto;

            case Tp_Imposto of

              tpiICMS: begin
                with ICMS do begin
                  CST    := StrToCSTICMS(vOk, Copy(Cd_Cst, 2, 2));
                  orig   := StrToOrig(vOk, Copy(Cd_Cst, 1, 1));
                  modBC  := dbiValorOperacao;
                  pRedBC := Pr_Redbasecalculo;
                  vBC    := Vl_Basecalculo;
                  pICMS  := Pr_Aliquota;
                  vICMS  := Vl_Imposto;
                end;
              end;

              tpiICMSST: begin
                with ICMS do begin
                  modBCST  := dbisMargemValorAgregado;
                  pRedBCST := Pr_Redbasecalculo;
                  vBCST    := Vl_Basecalculo;
                  pICMSST  := Pr_Aliquota;
                  vICMSST  := Vl_Imposto;
                  pMVAST   := 0;
                end;
              end;

              // partilha do ICMS e fundo de probreza
              tpiICMSUF: begin
                with ICMSUFDest do begin
                  vBCUFDest      := 0.00;
                  pFCPUFDest     := 0.00;
                  pICMSUFDest    := 0.00;
                  pICMSInter     := 0.00;
                  pICMSInterPart := 0.00;
                  vFCPUFDest     := 0.00;
                  vICMSUFDest    := 0.00;
                  vICMSUFRemet   := 0.00;
                end;
              end;

              tpiIPI: begin
                with IPI do begin
                  CST       := StrToCSTIPI(vOk, Cd_Cst);
                  vBC       := Vl_Basecalculo;
                  pIPI      := Pr_Aliquota;
                  vIPI      := Vl_Imposto;
                end;
              end;

              tpiPIS: begin
                with PIS do begin
                  CST       := StrToCSTPIS(vOk, Cd_Cst);
                  vBC       := Vl_Basecalculo;
                  pPIS      := Pr_Aliquota;
                  vPIS      := Vl_Imposto;
                  qBCProd   := 0;
                  vAliqProd := 0;
                end;
              end;

              tpiPISST: begin
                with PISST do begin
                  vBC       := Vl_Basecalculo;
                  pPIS      := Pr_Aliquota;
                  vPIS      := Vl_Imposto;
                  qBCProd   := 0;
                  vAliqProd := 0;
                end;
              end;

              tpiCOFINS: begin
                with COFINS do begin
                  CST       := StrToCSTCOFINS(vOk, Cd_Cst);
                  vBC       := Vl_Basecalculo;
                  pCOFINS   := Pr_Aliquota;
                  vCOFINS   := Vl_Imposto;
                  qBCProd   := 0;
                  vAliqProd := 0;
                end;
              end;

              tpiCOFINSST: begin
                with COFINSST do begin
                  vBC       := Vl_Basecalculo;
                  pCOFINS   := Pr_Aliquota;
                  vCOFINS   := Vl_Imposto;
                  qBCProd   := 0;
                  vAliqProd := 0;
                end;
              end;

              //Grupo para serviços
              tpiISSQN: begin
                with ISSQN do begin
                  vBC       := Vl_Basecalculo;
                  vAliq     := Pr_Aliquota;
                  vISSQN    := Vl_Imposto;
                  cMunFG    := 0;
                  cListServ := '1402'; // Preencha este campo usando a tabela disponível
                                       // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
                end;
              end;

              tpiII: begin
                with II do begin
                  vBC       := Vl_Basecalculo;
                  vDespAdu  := 0;
                  vII       := Vl_Imposto;
                  vIOF      := 0;
                end;
              end;

            end;
          end;

        end;

      end;
    end;

//Adicionando Serviços
{   with Det.Add do begin
      Prod.nItem    := 1; // Número sequencial, para cada item deve ser incrementado
      Prod.cProd    := '123457';
      Prod.cEAN     := '';
      Prod.xProd    := 'Descrição do Serviço';
      Prod.NCM      := '99';
      Prod.EXTIPI   := '';
      Prod.CFOP     := '5933';
      Prod.uCom     := 'UN';
      Prod.qCom     := 1 ;
      Prod.vUnCom   := 100;
      Prod.vProd    := 100 ;

      Prod.cEANTrib  := '';
      Prod.uTrib     := 'UN';
      Prod.qTrib     := 1;
      Prod.vUnTrib   := 100;

      Prod.vFrete    := 0;
      Prod.vSeg      := 0;
      Prod.vDesc     := 0;

      infAdProd      := 'Informação Adicional do Serviço';

//Grupo para serviços
      with Imposto.ISSQN do begin
        cSitTrib  := ISSQNcSitTribNORMAL;
        vBC       := 100;
        vAliq     := 2;
        vISSQN    := 2;
        cMunFG    := 3554003;
        cListServ := 1402; // Preencha este campo usando a tabela disponível
                           // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
      end;
    end; }

// TOTAL

    Total.ICMSTot.vBC      := fTransacao.Vl_Baseicms;
    Total.ICMSTot.vICMS    := fTransacao.Vl_Icms;
    Total.ICMSTot.vBCST    := fTransacao.Vl_Baseicmsst;
    Total.ICMSTot.vST      := fTransacao.Vl_Icmsst;
    Total.ICMSTot.vProd    := fTransacao.Vl_Item;
    Total.ICMSTot.vFrete   := fTransacao.Vl_Frete;
    Total.ICMSTot.vSeg     := fTransacao.Vl_Seguro;
    Total.ICMSTot.vDesc    := fTransacao.Vl_Desconto;
    Total.ICMSTot.vII      := fTransacao.Vl_Ii;
    Total.ICMSTot.vIPI     := fTransacao.Vl_Ipi;
    Total.ICMSTot.vPIS     := fTransacao.Vl_Pis;
    Total.ICMSTot.vCOFINS  := fTransacao.Vl_Cofins;
    Total.ICMSTot.vOutro   := fTransacao.Vl_Outro;
    Total.ICMSTot.vNF      := fTransacao.Vl_Total;
    Total.ICMSTot.vTotTrib := vVlTotTrib;

    // partilha do icms e fundo de probreza
    Total.ICMSTot.vFCPUFDest   := 0.00;
    Total.ICMSTot.vICMSUFDest  := 0.00;
    Total.ICMSTot.vICMSUFRemet := 0.00;

    Total.ISSQNtot.vServ   := 0;
    Total.ISSQNTot.vBC     := 0;
    Total.ISSQNTot.vISS    := 0;
    Total.ISSQNTot.vPIS    := 0;
    Total.ISSQNTot.vCOFINS := 0;

{   Total.retTrib.vRetPIS    := 0;
    Total.retTrib.vRetCOFINS := 0;
    Total.retTrib.vRetCSLL   := 0;
    Total.retTrib.vBCIRRF    := 0;
    Total.retTrib.vIRRF      := 0;
    Total.retTrib.vBCRetPrev := 0;
    Total.retTrib.vRetPrev   := 0; }

// FRETE

    Transp.modFrete := mfSemFrete; // NFC-e não pode ter FRETE

    case fTp_ModeloDF of

// PAGAMENTOS apenas para NFC-e

      moNFCe: begin
        pag.Clear();
        for I := 0 to fTransacao.Pagtos.Count - 1 do begin
          with pag.Add, TTranspagto(fTransacao.Pagtos[I]) do begin
            tPag := StrToFormaPagamento(vOk, IntToStr(Tp_Documento));
            vPag := Vl_Documento;
          end;
        end;
      end;

// COBRANCA

      moNFe: begin
        with Cobr do begin
          with Fat do begin
            nFat  := IntToStr(fTransacao.Fiscal.Nr_Nf);
            vOrig := fTransacao.Vl_Item;
            vDesc := fTransacao.Vl_Desconto;
            vLiq  := fTransacao.Vl_Total;
          end;

          Dup.Clear();
          for I := 0 to fTransacao.Pagtos.Count - 1 do begin
            with Dup.Add, TTranspagto(fTransacao.Pagtos[I]) do begin
              nDup  := IntToStr(Nr_Parcela);
              dVenc := Dt_Vencimento;
              vDup  := Vl_Documento;
            end;
          end;
        end;
      end;

    end;

    InfAdic.infCpl     :=  '';
    InfAdic.infAdFisco :=  '';

{   with InfAdic.obsCont.Add do begin
      xCampo := 'ObsCont';
      xTexto := 'Texto';
    end;

    with InfAdic.obsFisco.Add do begin
      xCampo := 'ObsFisco';
      xTexto := 'Texto';
    end; }
  end;

  fACBrNFe.NotasFiscais.GerarNFe;
end;

//--

function TcDFeServico.GerarEnvioDFe;
begin
  try
    fACBrNFe.NotasFiscais.Clear;
    fACBrNFe.NotasFiscais.LoadFromString(AXml);
    fACBrNFe.NotasFiscais.Assinar;
    fACBrNFe.NotasFiscais.Validar;
    fACBrNFe.Enviar(0);

    Result.tStatus := tsAutorizacao;
    Result.cStat := fACBrNFe.WebServices.Enviar.cStat;
    Result.xMotivo := fACBrNFe.WebServices.Enviar.xMotivo;
    Result.RetornoWS := fACBrNFe.WebServices.Enviar.RetornoWS;
    Result.RetWS := fACBrNFe.WebServices.Enviar.RetWS;
    AnalisaRetorno(Result);
  except
    on E : Exception do begin
      Result.tStatus := tsRejeicao;
      Result.xMotivo := E.Message;
      AnalisaRetorno(Result);
    end;
  end;
end;

procedure TcDFeServico.GerarImpressaoDFe;
const
  cDS_METHOD = 'TcDFeServico.GerarImpressaoDFe()';
var
  vModeloDF : TpcnModeloDF;
  vOk : Boolean;
begin
  if AXml = '' then
    raise Exception.Create('Xml deve ser informado / ' + cDS_METHOD);

  vModeloDF := StrToModeloDF(vOk, IntToStr(fACBrNFe.NotasFiscais[0].NFe.Ide.modelo));

  (* if Assigned(fACBrNFe.DANFE) then
    with fACBrNFe.DANFE do begin
      TipoDANFE := fTp_DANFE;
      Logo      := fDs_LogoMarca; // edtLogoMarca.Text;
    end; *)

  case vModeloDF of
    moNFCe : begin
      if not Assigned(fACBrNFeDANFCe) then
        fACBrNFeDANFCe := TACBrNFeDANFCeFortes.Create(Self);

      with fACBrNFeDANFCe do begin
        TipoDANFE := tiNFCe;
        Logo := fDs_LogoMarca; // edtLogoMarca.Text;
        MostrarPreview := fIn_MostrarPreview;
        MostrarStatus := fIn_MostrarStatus;
      end;

      fACBrNFe.DANFE := fACBrNFeDANFCe;
    end;

    moNFe : begin
      if not Assigned(fACBrNFeDANFe) then
        fACBrNFeDANFe := TACBrNFeDANFeRL.Create(Self);

      with fACBrNFeDANFe do begin
        TipoDANFE := tiRetrato;
        Logo := fDs_LogoMarca; // edtLogoMarca.Text;
        MostrarPreview := fIn_MostrarPreview;
        MostrarStatus := fIn_MostrarStatus;
      end;

      fACBrNFe.DANFE := fACBrNFeDANFe;
    end;
  end;

  fACBrNFe.NotasFiscais.Clear;
  fACBrNFe.NotasFiscais.LoadFromString(AXml);

  case fTp_ImpressaoDanfe of
    tpiImprimir:
      fACBrNFe.NotasFiscais.Imprimir;
    tpiImprimirPDF:
      fACBrNFe.NotasFiscais.ImprimirPDF;
    tpiImprimirResumido:
      fACBrNFe.NotasFiscais.ImprimirResumido;
    tpiImprimirResumidoPDF:
      fACBrNFe.NotasFiscais.ImprimirResumidoPDF;
  else
    fACBrNFe.NotasFiscais.Imprimir;
  end;

  fACBrNFe.DANFE := nil;
end;

//--

function TcDFeServico.GerarCancelamentoDFe;
const
  cDS_METHOD = 'TcDFeServico.GerarCancelamentoDFe()';
var
  idLote : Integer;
begin
  if AChave = '' then
    raise Exception.Create('Chave deve ser informada / ' + cDS_METHOD);
  if ACNPJ = '' then
    raise Exception.Create('CNPJ deve ser informada / ' + cDS_METHOD);
  if AJustificativa = '' then
    raise Exception.Create('Justificativa deve ser informada / ' + cDS_METHOD);
  if AProtocolo = '' then
    raise Exception.Create('Protocolo deve ser informado / ' + cDS_METHOD);

  idLote := 0;

  fACBrNFe.EventoNFe.Evento.Clear;
  fACBrNFe.EventoNFe.idLote := 1;

  with fACBrNFe.EventoNFe.Evento.Add do begin
    infEvento.chNFe := AChave;
    infEvento.CNPJ := ACNPJ;
    infEvento.dhEvento := now;
    infEvento.tpEvento := teCancelamento;
    infEvento.detEvento.xJust := AJustificativa;
    infEvento.detEvento.nProt := AProtocolo;
  end;

  try
    fACBrNFe.EnviarEvento(idLote);

    Result.tStatus := tsCancelamento;
    Result.cStat := fACBrNFe.WebServices.EnvEvento.cStat;
    Result.xMotivo := fACBrNFe.WebServices.EnvEvento.xMotivo;
    Result.RetornoWS := fACBrNFe.WebServices.EnvEvento.RetornoWS;
    Result.RetWS := fACBrNFe.WebServices.EnvEvento.RetWS;
    AnalisaRetorno(Result);
  except
    on E : Exception do begin
      Result.tStatus := tsRejeicao;
      Result.xMotivo := E.Message;
      AnalisaRetorno(Result);
    end;
  end;
end;

//--

function TcDFeServico.GerarInutilizacaoDFe;
const
  cDS_METHOD = 'TcDFeServico.GerarInutilizacaoDFe()';
begin
  if ACNPJEmitente = '' then
    raise Exception.Create('CNPJ emitente deve ser informada / ' + cDS_METHOD);
  if AJustificativa = '' then
    raise Exception.Create('Justificativa deve ser informada / ' + cDS_METHOD);
  if AAno = 0 then
    raise Exception.Create('Ano deve ser informada / ' + cDS_METHOD);
  if AModelo = 0 then
    raise Exception.Create('Modelo deve ser informada / ' + cDS_METHOD);
  if ASerie = 0 then
    raise Exception.Create('Serie deve ser informada / ' + cDS_METHOD);
  if ANumeroInicial = 0 then
    raise Exception.Create('Numero inicial deve ser informado / ' + cDS_METHOD);
  if ANumeroFinal = 0 then
    raise Exception.Create('Numero final deve ser informado / ' + cDS_METHOD);

  try
    fACBrNFe.WebServices.Inutiliza( ACNPJEmitente, AJustificativa, AAno,
      AModelo, ASerie, ANumeroInicial, ANumeroFinal);

    Result.tStatus := tsInutilizacao;
    Result.cStat := fACBrNFe.WebServices.Inutilizacao.cStat;
    Result.xMotivo := fACBrNFe.WebServices.Inutilizacao.xMotivo;
    Result.RetornoWS := fACBrNFe.WebServices.Inutilizacao.RetornoWS;
    Result.RetWS := fACBrNFe.WebServices.Inutilizacao.RetWS;
    AnalisaRetorno(Result);
  except
    on E : Exception do begin
      Result.tStatus := tsRejeicao;
      Result.xMotivo := E.Message;
      AnalisaRetorno(Result);
    end;
  end;
end;

//--

function TcDFeServico.GerarConsultaDFe;
const
  cDS_METHOD = 'TcDFeServico.GerarConsultaDFe()';
begin
  if AXml = '' then
    raise Exception.Create('Xml deve ser informado / ' + cDS_METHOD);

  try
    fACBrNFe.NotasFiscais.Clear;
    fACBrNFe.NotasFiscais.LoadFromString(AXml);
    fACBrNFe.Consultar;

    Result.tStatus := tsProcessado;
    Result.cStat := fACBrNFe.WebServices.Consulta.cStat;
    Result.xMotivo := fACBrNFe.WebServices.Consulta.xMotivo;
    Result.RetornoWS := fACBrNFe.WebServices.Consulta.RetornoWS;
    Result.RetWS := fACBrNFe.WebServices.Consulta.RetWS;
    AnalisaRetorno(Result);
  except
    on E : Exception do begin
      Result.tStatus := tsRejeicao;
      Result.xMotivo := E.Message;
      AnalisaRetorno(Result);
    end;
  end;
end;

//--

function TcDFeServico.EmitirDFe() : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.EmitirDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  GerarDFe;

  Result := GerarEnvioDFe;

  if (Result.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppAutorizada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].dhRecbto,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].XMLprotNFe);

    GerarImpressaoDFe(
      TTransdfe(fTransacao.Fiscal.Eventos.Items[0]).Ds_Envioxml);

  end else if (Result.tStatus in [tsContingencia]) then begin
    fACBrNFe.NotasFiscais[0].NFe.Ide.tpEmis := teOffLine;
    fACBrNFe.NotasFiscais[0].NFe.Ide.dhCont := Now;
    fACBrNFe.NotasFiscais[0].NFe.Ide.xJust := 'Sem conexão com a internet';
    fACBrNFe.NotasFiscais.GerarNFe;
    fACBrNFe.NotasFiscais.Assinar;
    fACBrNFe.NotasFiscais.Validar;

    GravarDFe(
      tppGerada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      Now,
      'NA',
      fACBrNFe.WebServices.Retorno.RetornoWS);

    GerarImpressaoDFe(
      TTransdfe(fTransacao.Fiscal.Eventos.Items[0]).Ds_Envioxml);

  end else if (Result.tStatus in [tsRejeicao]) then begin
    GravarDFe(
      tppCancelada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      Now,
      'NA',
      fACBrNFe.WebServices.Retorno.RetornoWS);

    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

  end;
end;

function TcDFeServico.EmitirDFe(ATransacao : TTransacao) : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.EmitirDFe()';
begin
  if not Assigned(ATransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fTransacao := ATransacao;

  if ATransacao.Nr_Transacao > 0 then
    EmitirDFe;
end;

//--

function TcDFeServico.EmitirDFeGerada() : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.EmitirDFeGerada()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  Result := GerarEnvioDFe;

  if (Result.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppAutorizada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].dhRecbto,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].XMLprotNFe);

  end else if (Result.tStatus in [tsRejeicao]) then begin
    GravarDFe(
      tppCancelada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      'NA',
      Now,
      '0',
      fACBrNFe.WebServices.Retorno.RetornoWS);

    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

  end;

end;

function TcDFeServico.EmitirDFeGerada(ATransacao : TTransacao) : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.EmitirDFeGerada()';
begin
  if not Assigned(ATransfiscal) then
    raise Exception.Create('Fiscal deve ser informado / ' + cDS_METHOD);

  fTransacao := mContexto.Instance.GetObjeto(TTransacao, 'Id_Transacao = ''' + ATransfiscal.Id_Transacao + '''') as TTransacao;
  if fTransacao.Nr_Transacao > 0 then
    EmitirDFeContingencia();
end;

//--

procedure TcDFeServico.ImprimirDFe();
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  GerarImpressaoDFe(
    TTransdfe(fTransacao.Fiscal.Eventos.Items[0]).Ds_Envioxml);
end;

procedure TcDFeServico.ImprimirDFe(ATransacao : TTransacao);
const
  cDS_METHOD = 'TcDFeServico.ImprimirDFe()';
begin
  if not Assigned(ATransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fTransacao := ATransacao;

  if ATransacao.Nr_Transacao > 0 then
    ImprimirDFe;
end;

//--

function TcDFeServico.CancelarDFe() : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.CancelarDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  Result := GerarCancelamentoDFe(
    fTransacao.Fiscal.Ds_Chaveacesso,
    fTransacao.Pessoa.Nr_Cpfcnpj,
    'CANCELAMENTO AUTOMATICO',
    fTransacao.Fiscal.Nr_Recibo);

  if (Result.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppCancelada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      'NA',
      Now,
      '0',
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (Result.tStatus in [tsRejeicao]) then

    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

end;

function TcDFeServico.CancelarDFe(ATransacao : TTransacao) : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.CancelarDFe()';
begin
  if not Assigned(ATransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fTransacao := ATransacao;

  if ATransacao.Nr_Transacao > 0 then
    CancelarDFe;
end;

//--

function TcDFeServico.InutilizarDFe() : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.InutilizarDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  Result := GerarInutilizacaoDFe(
    fTransacao.Pessoa.Nr_Cpfcnpj, // ACNPJEmitente : String;
    'CANCELAMENTO AUTOMATICO', // AJustificativa : String;
    StrToIntDef(FormatDateTime('yyyy', fTransacao.Dt_Transacao), 0), // AAno : Integer;
    fTransacao.Fiscal.Tp_Modelonf, // AModelo : Integer;
    StrToIntDef(fTransacao.Fiscal.Cd_Serie, 0), // ACd_Serie : Integer;
    fTransacao.Fiscal.Nr_Nf, // ANumeroInicial : Integer;
    fTransacao.Fiscal.Nr_Nf); // ANumeroFinal : Integer);

  if (Result.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppRejeitada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      'NA',
      Now,
      '0',
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (Result.tStatus in [tsRejeicao]) then

    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

end;

function TcDFeServico.InutilizarDFe(ATransacao : TTransacao) : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.InutilizarDFe()';
begin
  if not Assigned(ATransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fTransacao := ATransacao;

  if ATransacao.Nr_Transacao > 0 then
    InutilizarDFe;
end;

//--

function TcDFeServico.ConsultarDFe() : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.ConsultarDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  Result := GerarConsultaDFe(
    TTransdfe(fTransacao.Fiscal.Eventos.Items[0]).Ds_Envioxml);

  if (Result.tStatus in [tsRejeicao]) then
    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

end;

function TcDFeServico.ConsultarDFe(ATransacao : TTransacao) : RTipoRetornoSefaz;
const
  cDS_METHOD = 'TcDFeServico.ConsultarDFe()';
begin
  if not Assigned(ATransacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fTransacao := ATransacao;

  if ATransacao.Nr_Transacao > 0 then
    ConsultarDFe;
end;

//--

procedure TcDFeServico.AnalisaRetorno(ATipoRetornoSefaz: RTipoRetornoSefaz);
begin

end;

initialization
  //Instance();

finalization
  Destroy();

end.
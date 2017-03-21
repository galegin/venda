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
  uTipoProcessamento, uTipoImpressaoDanfe, uTipoRetornoSefaz,
  uTransacao, uTransfiscal;

type
  TcDFeServico = class(TComponent)
  private
    fACBrNFe : TACBrNFe;
    fACBrNFeDANFeRL : TACBrNFeDANFeRL;
    fACBrNFeDANFCeFortes : TACBrNFeDANFCeFortes;

    fObj_Transacao : TTransacao;

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

    fTipoRetorno : RTipoRetornoSefaz;

    fTp_Contingencia : TTipoContingencia;
    fTp_ImpressaoDanfe : TTipoImpressaoDanfe;
    
    procedure SetTipoRetorno(const Value: RTipoRetornoSefaz);

  protected
    procedure ValidarParametro;
    procedure CarregarParametro;

    procedure LimparDFe;
    procedure ConfigurarDFe;
    procedure CarregarDFe;

    procedure GravarDFe(
      ATipoProcessamento : TTipoProcessamento;
      AChave : String;
      AXmlProt : String;
      ADhRecibo : TDateTime;
      ANrRecibo : String;
      ARetornoXml : String);

    procedure GerarDFe;

    procedure EnviarDFe;

    procedure EnviarDFeContingencia;

    procedure LimparRetorno;

    procedure TratarRetorno(
      AMetodo : String;
      ANFeWebService : TNFeWebService);

    procedure ExceptionRetorno(
      AMetodo : String;
      AException : Exception);

    procedure GerarImpressaoDFe(
      AXml : String);

    procedure GerarCancelamentoDFe(
      AChave : String;
      ACNPJ : String;
      AJustificativa : String;
      AProtocolo : String);

    procedure GerarInutilizacaoDFe(
      ACNPJEmitente : String;
      AJustificativa : String;
      AAno : Integer;
      AModelo : Integer;
      ASerie : Integer;
      ANumeroInicial : Integer;
      ANumeroFinal : Integer);

    procedure GerarConsultaDFe(
      AXml : String);

  public
    constructor Create(AOwner : TComponent); override;

    procedure EmitirDFe(); overload;
    procedure EmitirDFe(AObj_Transacao : TTransacao); overload;

    procedure EmitirDFeContingencia(); overload;
    procedure EmitirDFeContingencia(AObj_Fiscal : TTransfiscal); overload;

    procedure ImprimirDFe(); overload;
    procedure ImprimirDFe(AObj_Transacao : TTransacao); overload;

    procedure CancelarDFe(); overload;
    procedure CancelarDFe(AObj_Transacao : TTransacao); overload;

    procedure InutilizarDFe(); overload;
    procedure InutilizarDFe(AObj_Transacao : TTransacao); overload;

    procedure ConsultarDFe(); overload;
    procedure ConsultarDFe(AObj_Transacao : TTransacao); overload;
  published
    property TipoRetorno : RTipoRetornoSefaz read fTipoRetorno write SetTipoRetorno;
    property cStat : Integer read fTipoRetorno.cStat;
    property xMotivo : String read fTipoRetorno.xMotivo;
    property RetornoWS : String read fTipoRetorno.RetornoWS;
    property RetWS : String read fTipoRetorno.RetWS;
  end;

  function Instance : TcDFeServico;

implementation

uses
  uTipoImposto,
  uMunicipio, uPessoa, uTransdfe, uTransitem, uTransimposto,
  mPath, mProxy, mTipoMensagem, mTipoParametro, mString, mException,
  TypInfo, ACBrDFeConfiguracoes;

var
  _instance : TcDFeServico;

  function Instance : TcDFeServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeServico.Create(nil);
    Result := _instance;
  end;

constructor TcDFeServico.Create(AOwner : TComponent);
begin
  inherited;
  fACBrNFe := TACBrNFe.Create(Self);
  fObj_Transacao := TTransacao.Create(nil);
end;

//--

procedure TcDFeServico.ValidarParametro;
const
  cDS_METHOD = 'TcDFeServico.ValidarParametro()';
var
  I : Integer;
begin
  if not Assigned(fObj_Transacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fObj_Transacao.Obj_Empresa := uclsEmpresaServico.Instance.Consultar();

  if not Assigned(fObj_Transacao.Obj_Empresa) then
    raise Exception.Create('Empresa deve ser informada / ' + cDS_METHOD);
  if not Assigned(fObj_Transacao.Obj_Empresa.Obj_Pessoa) then
    raise Exception.Create('Pessoa da empresa deve ser informada / ' + cDS_METHOD);
  if not Assigned(fObj_Transacao.Obj_Pessoa) then
    raise Exception.Create('Pessoa deve ser informada / ' + cDS_METHOD);
  if not Assigned(fObj_Transacao.Obj_Operacao) then
    raise Exception.Create('Operacao deve ser informada / ' + cDS_METHOD);
  if not Assigned(fObj_Transacao.Obj_Fiscal) then
    raise Exception.Create('Fiscal deve ser informado / ' + cDS_METHOD);

  if fObj_Transacao.List_Item.Count = 0 then
    raise Exception.Create('Item deve ser informado / ' + cDS_METHOD);

  for I := 0 to fObj_Transacao.List_Item.Count - 1 do
    with fObj_Transacao.List_Item[I] do
      if List_Imposto.Count = 0 then
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

  (* if Assigned(fACBrNFe.DANFE) then
    with fACBrNFe.DANFE do begin
      TipoDANFE := fTp_DANFE;
      Logo      := fDs_LogoMarca; // edtLogoMarca.Text;
    end; *)

end;

procedure TcDFeServico.CarregarDFe;
begin
  with fObj_Transacao.Obj_Fiscal.List_DFe.Items[0] do begin
    fACBrNFe.NotasFiscais.LoadFromString(Ds_Xml);
  end;
end;

procedure TcDFeServico.GravarDFe;
const
  cDS_METHOD = 'TcDFeServico.GravarDFe()';
begin
  if AChave = '' then
    raise Exception.Create('Chave deve ser informado / ' + cDS_METHOD);
  if AXmlProt = '' then
    raise Exception.Create('Xml protocolado deve ser informado / ' + cDS_METHOD);
  if ADhRecibo = 0 then
    raise Exception.Create('Data recibo deve ser informado / ' + cDS_METHOD);
  if ANrRecibo = '' then
    raise Exception.Create('Numero recibo deve ser informado / ' + cDS_METHOD);
  if ARetornoXml = '' then
    raise Exception.Create('Retorno xml deve ser informado / ' + cDS_METHOD);

  with fObj_Transacao.Obj_Fiscal do begin
    Ds_Chave := AnsiReplaceStr(AChave, 'NFe', '');
    Nr_Recibo := ANrRecibo;
    Dh_Recibo := ADhRecibo;
    Tp_Processamento := TipoProcessamentoToStr(ATipoProcessamento);

    with List_DFe.Add do begin
      Cd_Dnatrans := fObj_Transacao.Cd_Dnatrans;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Ds_Xml := AXmlProt;
      Ds_RetornoXml := ARetornoXml;
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
    if (Length(AcEAN) <> 13) or not TmString.StartsWiths(AcEAN, '789') then
      AcEAN := '';

    Result.cProd := AcProd;
    Result.cEAN := AcEAN;
  end;

procedure TcDFeServico.GerarDFe;
var
  vProdEAN : TrProdEAN;
  vVlTotTrib : Real;
  I, J : Integer;
  vOk : Boolean;
begin
  with fACBrNFe.NotasFiscais.Add.NFe do begin

// IDENTIFICACAO

    Ide.cNF       := fObj_Transacao.Nr_Transacao; //Caso não seja preenchido será gerado um número aleatório pelo componente
    Ide.natOp     := fObj_Transacao.Obj_Operacao.Ds_Operacao;
    Ide.indPag    := ipVista;
    Ide.modelo    := fObj_Transacao.Obj_Fiscal.Tp_Docfiscal;
    Ide.serie     := StrToIntDef(fObj_Transacao.Obj_Fiscal.Cd_Serie, 1);
    Ide.nNF       := fObj_Transacao.Obj_Fiscal.Nr_Docfiscal;
    Ide.dEmi      := now;
    Ide.dSaiEnt   := now;
    Ide.hSaiEnt   := now;
    Ide.tpNF      := StrToTpNF(vOk, IntToStr(fObj_Transacao.Obj_Fiscal.Tp_Operacao));
    Ide.tpEmis    := fTp_Emissao;
    Ide.tpAmb     := fTp_Ambiente; //Lembre-se de trocar esta variável quando for para ambiente de produção
    Ide.cUF       := UFtoCUF(fUf_Origem);
    Ide.cMunFG    := fObj_Transacao.Obj_Empresa.Obj_Pessoa.Obj_Municipio.Cd_Municipio;
    Ide.finNFe    := fnNormal;
    Ide.tpImp     := fTp_DANFE; // tiSemGeracao;
    Ide.indFinal  := cfConsumidorFinal;
    Ide.indPres   := pcPresencial;

//  Ide.dhCont := date;
//  Ide.xJust  := 'Justificativa Contingencia';

// EMITENTE

    with fObj_Transacao.Obj_Empresa.Obj_Pessoa do begin
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

    with fObj_Transacao.Obj_Pessoa do begin
      Dest.CNPJCPF           := Nr_CpfCnpj;

      case fTp_ModeloDF of
        moNFCe : begin
          Dest.IE        := ''; //NFC-e não aceita IE
          Dest.indIEDest := inNaoContribuinte;
        end;

        moNFe : begin
          case Length(Dest.CNPJCPF) of
            11 : begin
              Dest.IE        := '';
              Dest.indIEDest := inNaoContribuinte;
            end;
            15 : begin
              if StrToFloatDef(Nr_Rgie,0) > 0 then begin
                Dest.IE        := Nr_Rgie;
                Dest.indIEDest := inContribuinte;
              end
              else begin
                Dest.IE        := '';
                Dest.indIEDest := inIsento;
              end;
            end;
          end;
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

    for I := 0 to fObj_Transacao.List_Item.Count - 1 do begin
      with Det.Add, fObj_Transacao.List_Item[I] do begin

        vProdEAN := GetProdEAN(IntToStr(Cd_Produto), Cd_Barraprd);

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

        for J := 0 to List_Imposto.Count - 1 do begin

          with Imposto, List_Imposto[J] do begin

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

    Total.ICMSTot.vBC      := fObj_Transacao.Vl_Baseicms;
    Total.ICMSTot.vICMS    := fObj_Transacao.Vl_Icms;
    Total.ICMSTot.vBCST    := fObj_Transacao.Vl_Baseicmsst;
    Total.ICMSTot.vST      := fObj_Transacao.Vl_Icmsst;
    Total.ICMSTot.vProd    := fObj_Transacao.Vl_Item;
    Total.ICMSTot.vFrete   := fObj_Transacao.Vl_Frete;
    Total.ICMSTot.vSeg     := fObj_Transacao.Vl_Seguro;
    Total.ICMSTot.vDesc    := fObj_Transacao.Vl_Desconto;
    Total.ICMSTot.vII      := fObj_Transacao.Vl_Ii;
    Total.ICMSTot.vIPI     := fObj_Transacao.Vl_Ipi;
    Total.ICMSTot.vPIS     := fObj_Transacao.Vl_Pis;
    Total.ICMSTot.vCOFINS  := fObj_Transacao.Vl_Cofins;
    Total.ICMSTot.vOutro   := fObj_Transacao.Vl_Outro;
    Total.ICMSTot.vNF      := fObj_Transacao.Vl_Total;
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
        for I := 0 to fObj_Transacao.List_Pagto.Count - 1 do begin
          with pag.Add, fObj_Transacao.List_Pagto[I] do begin
            tPag := StrToFormaPagamento(vOk, IntToStr(Tp_Pagto));
            vPag := Vl_Pagto;
          end;
        end;
      end;

// COBRANCA

      moNFe: begin
        with Cobr do begin
          with Fat do begin
            nFat  := IntToStr(fObj_Transacao.Obj_Fiscal.Nr_Docfiscal);
            vOrig := fObj_Transacao.Vl_Item;
            vDesc := fObj_Transacao.Vl_Desconto;
            vLiq  := fObj_Transacao.Vl_Total;
          end;

          Dup.Clear();
          for I := 0 to fObj_Transacao.List_Vencto.Count - 1 do begin
            with Dup.Add, fObj_Transacao.List_Vencto[I] do begin
              nDup  := IntToStr(Nr_Parcela);
              dVenc := Dt_Parcela;
              vDup  := Vl_Parcela;
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

procedure TcDFeServico.EnviarDFe;
const
  cDS_METHOD = 'TcDFeServico.EnviarDFe()';
begin
  //-- limpar retorno
  LimparRetorno;

  //-- verifica status contingencia
  fTp_Contingencia := uclsContingenciaServico.Instance.Tipo;

  //-- envia contingencia pendente
  if fTp_Contingencia in [tpcSemContingencia] then begin
    uclsContingenciaServico.Instance.EnviarPendente;

    fTp_Contingencia := uclsContingenciaServico.Instance.Tipo;
  end;

  //-- envia corrente
  if fTp_Contingencia in [tpcSemContingencia] then begin
    LimparRetorno;

    try
      fACBrNFe.NotasFiscais.Assinar;
      fACBrNFe.NotasFiscais.Validar;
      fACBrNFe.Enviar(0);

      TratarRetorno(cDS_METHOD, fACBrNFe.WebServices.Enviar);
    except
      on E : Exception do
        ExceptionRetorno(cDS_METHOD, E);
    end;

    fTp_Contingencia := uclsContingenciaServico.Instance.Tipo;
  end;

  //-- gera contingencia
  if fTp_Contingencia in [tpcContingencia] then begin
    fACBrNFe.NotasFiscais[0].NFe.Ide.tpEmis := teOffLine;
    fACBrNFe.NotasFiscais.GerarNFe;
    fACBrNFe.NotasFiscais.Assinar;
    fACBrNFe.NotasFiscais.Validar;
  end;
end;

procedure TcDFeServico.EnviarDFeContingencia;
const
  cDS_METHOD = 'TcDFeServico.EnviarDFeContingencia';
begin
  LimparRetorno;

  try
    fACBrNFe.Enviar(0);

    TratarRetorno(cDS_METHOD, fACBrNFe.WebServices.Enviar);
  except
    on E : Exception do
      ExceptionRetorno(cDS_METHOD, E);
  end;      
end;

//--

procedure TcDFeServico.SetTipoRetorno(const Value: RTipoRetornoSefaz);
var
  vOk : Boolean;
begin
  with uclsContingenciaServico.Instance do begin
    TipoEmissao := fACBrNFe.NotasFiscais[0].NFe.Ide.tpEmis;
    ModeloDF := StrToModeloDF(vOk, IntToStr(fACBrNFe.NotasFiscais[0].NFe.Ide.modelo));
    TipoRetorno := fTipoRetorno;
  end;
end;

//--

procedure TcDFeServico.LimparRetorno;
var
  vTipoRetorno : RTipoRetornoSefaz;
begin
  with vTipoRetorno do begin
    tStatus := TTipoStatusSefaz(Ord(-1));
    cStat := 0;
    xMotivo := '';
    RetornoWS := '';
    RetWS := '';
  end;

  TipoRetorno := vTipoRetorno;
end;

procedure TcDFeServico.TratarRetorno;
var
  vTipoRetorno : RTipoRetornoSefaz;
begin
  if Assigned(ANFeWebService) then begin
    if GetPropInfo(ANFeWebService, 'cStat') <> nil then
      vTipoRetorno.cStat := GetOrdProp(ANFeWebService, 'cStat');
    if GetPropInfo(ANFeWebService, 'xMotivo') <> nil then
      vTipoRetorno.xMotivo := GetStrProp(ANFeWebService, 'xMotivo');
    if GetPropInfo(ANFeWebService, 'RetornoWS') <> nil then
      vTipoRetorno.RetornoWS := GetStrProp(ANFeWebService, 'RetornoWS');
    if GetPropInfo(ANFeWebService, 'RetWS') <> nil then
      vTipoRetorno.RetWS := GetStrProp(ANFeWebService, 'RetWS');
  end;

  (* if ANFeWebService is TNFeStatusServico then begin
    with ANFeWebService as TNFeStatusServico do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeRecepcao then begin
    with ANFeWebService as TNFeRecepcao do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeRetRecepcao then begin
    with ANFeWebService as TNFeRetRecepcao do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeRecibo then begin
    with ANFeWebService as TNFeRecibo do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeConsulta then begin
    with ANFeWebService as TNFeConsulta do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeInutilizacao then begin
    with ANFeWebService as TNFeInutilizacao do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeConsultaCadastro then begin
    with ANFeWebService as TNFeConsultaCadastro do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  end else if ANFeWebService is TNFeEnvEvento then begin
    with ANFeWebService as TNFeEnvEvento do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end;

  { end else if ANFeWebService is TNFeConsNFeDest then begin
    with ANFeWebService as TNFeConsNFeDest do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end; }

  { end else if ANFeWebService is TNFeDownloadNFe then begin
    with ANFeWebService as TNFeDownloadNFe do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end; }

  { end else if ANFeWebService is TNFeEnvioWebService then begin
    with ANFeWebService as TNFeEnvioWebService do begin
      vTipoRetorno.cStat := cStat;
      vTipoRetorno.xMotivo := xMotivo;
      vTipoRetorno.RetornoWS := RetornoWS;
      vTipoRetorno.RetWS := RetWS;
    end; }

  end; *)

  TipoRetorno := uTipoRetornoSefaz.GetTipoRetorno(vTipoRetorno);
end;

procedure TcDFeServico.ExceptionRetorno;
begin
  TipoRetorno := uTipoRetornoSefaz.StrToTipoRetorno(AException.Message);
end;

//--

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

  case vModeloDF of
    moNFCe : begin
      if not Assigned(fACBrNFeDANFCeFortes) then
        fACBrNFeDANFCeFortes := TACBrNFeDANFCeFortes.Create(Self);

      with fACBrNFeDANFCeFortes do begin
        TipoDANFE := tiNFCe;
        MostrarPreview := fIn_MostrarPreview;
        MostrarStatus := fIn_MostrarStatus;
      end;

      fACBrNFe.DANFE := fACBrNFeDANFCeFortes;
    end;

    moNFe : begin
      if not Assigned(fACBrNFeDANFeRL) then
        fACBrNFeDANFeRL := TACBrNFeDANFeRL.Create(Self);

      with fACBrNFeDANFeRL do begin
        TipoDANFE := tiRetrato;
        MostrarPreview := fIn_MostrarPreview;
        MostrarStatus := fIn_MostrarStatus;
      end;

      fACBrNFe.DANFE := fACBrNFeDANFeRL;
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

procedure TcDFeServico.GerarCancelamentoDFe;
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

  //fACBrNFe.EvnvEvento.EnvEventoNFe.idLote := StrToInt(idLote) ;
  with fACBrNFe.EventoNFe.Evento.Add do begin
    infEvento.chNFe := AChave;
    infEvento.CNPJ := ACNPJ;
    infEvento.dhEvento := now;
    infEvento.tpEvento := teCancelamento;
    infEvento.detEvento.xJust := AJustificativa;
    infEvento.detEvento.nProt := AProtocolo;
  end;

  LimparRetorno;

  try
    fACBrNFe.EnviarEvento(idLote);

    TratarRetorno(cDS_METHOD, fACBrNFe.WebServices.EnvEvento);
  except
    on E : Exception do
      ExceptionRetorno(cDS_METHOD, E);
  end;
end;

//--

procedure TcDFeServico.GerarInutilizacaoDFe;
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

  LimparRetorno;

  try
    fACBrNFe.WebServices.Inutiliza(
      ACNPJEmitente,
      AJustificativa,
      AAno,
      AModelo,
      ASerie,
      ANumeroInicial,
      ANumeroFinal);

    TratarRetorno(cDS_METHOD, fACBrNFe.WebServices.Inutilizacao);
  except
    on E : Exception do
      ExceptionRetorno(cDS_METHOD, E);
  end;      
end;

//--

procedure TcDFeServico.GerarConsultaDFe;
const
  cDS_METHOD = 'TcDFeServico.GerarConsultaDFe()';
begin
  if AXml = '' then
    raise Exception.Create('Xml deve ser informado / ' + cDS_METHOD);

  LimparRetorno;

  try
    fACBrNFe.NotasFiscais.Clear;
    fACBrNFe.NotasFiscais.LoadFromString(AXml);
    fACBrNFe.Consultar;

    TratarRetorno(cDS_METHOD, fACBrNFe.WebServices.Consulta);
  except
    on E : Exception do
      ExceptionRetorno(cDS_METHOD, E);
  end;      
end;

//--

procedure TcDFeServico.EmitirDFe();
const
  cDS_METHOD = 'TcDFeServico.EmitirDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  GerarDFe;
  EnviarDFe;

  if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.cStat in [100, 105, 204]) then begin
    GravarDFe(
      tppAutorizada,
      fACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].XMLprotNFe,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].dhRecbto,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt,
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (fTp_Contingencia in [tpcContingencia]) then begin
    GravarDFe(
      tppGerada,
      fACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      Now,
      'NA',
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (fTipoRetorno.tStatus in [tsRejeicao]) then
    raise TmException.Create(fTipoRetorno.xMotivo, cDS_METHOD);

  GerarImpressaoDFe(
    fObj_Transacao.Obj_Fiscal.List_DFe.Items[0].Ds_Xml);
end;

procedure TcDFeServico.EmitirDFe(AObj_Transacao : TTransacao);
const
  cDS_METHOD = 'TcDFeServico.EmitirDFe()';
begin
  if not Assigned(AObj_Transacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fObj_Transacao := AObj_Transacao;

  if AObj_Transacao.Nr_Transacao > 0 then
    EmitirDFe;
end;

//--

procedure TcDFeServico.EmitirDFeContingencia();
const
  cDS_METHOD = 'TcDFeServico.EmitirDFeContingencia()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;
  EnviarDFeContingencia;

  if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.cStat in [100, 105, 204]) then begin
    GravarDFe(
      tppAutorizada,
      fACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].XMLprotNFe,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].dhRecbto,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt,
      fACBrNFe.WebServices.Retorno.RetornoWS);
  
  end else if (fTp_Contingencia in [tpcSemContingencia]) and not (fTipoRetorno.cStat in [100]) then begin
    GravarDFe(
      tppCancelada,
      fACBrNFe.NotasFiscais.Items[0].NFe.infNFe.ID,
      'NA',
      Now,
      '0',
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (fTipoRetorno.tStatus in [tsRejeicao]) then
    raise TmException.Create(fTipoRetorno.xMotivo, cDS_METHOD);

end;

procedure TcDFeServico.EmitirDFeContingencia(AObj_Fiscal : TTransfiscal);
const
  cDS_METHOD = 'TcDFeServico.EmitirDFeContingencia()';
begin
  if not Assigned(AObj_Fiscal) then
    raise Exception.Create('Fiscal deve ser informado / ' + cDS_METHOD);

  fObj_Transacao.Limpar();
  fObj_Transacao.Cd_Dnatrans := AObj_Fiscal.Cd_Dnatrans;
  fObj_Transacao.Consultar(nil);
  if fObj_Transacao.Nr_Transacao > 0 then
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
    fObj_Transacao.Obj_Fiscal.List_DFe.Items[0].Ds_Xml);
end;

procedure TcDFeServico.ImprimirDFe(AObj_Transacao : TTransacao);
const
  cDS_METHOD = 'TcDFeServico.ImprimirDFe()';
begin
  if not Assigned(AObj_Transacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fObj_Transacao := AObj_Transacao;

  if AObj_Transacao.Nr_Transacao > 0 then
    ImprimirDFe;
end;

//--

procedure TcDFeServico.CancelarDFe();
const
  cDS_METHOD = 'TcDFeServico.CancelarDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  if (fTipoRetorno.tStatus in [tsRejeicao]) then
    raise TmException.Create(fTipoRetorno.xMotivo, cDS_METHOD);

  GerarCancelamentoDFe(
    fObj_Transacao.Obj_Fiscal.Ds_Chave,
    fObj_Transacao.Nr_Cpfcnpj,
    'CANCELAMENTO AUTOMATICO',
    fObj_Transacao.Obj_Fiscal.Nr_Recibo);
end;

procedure TcDFeServico.CancelarDFe(AObj_Transacao : TTransacao);
const
  cDS_METHOD = 'TcDFeServico.CancelarDFe()';
begin
  if not Assigned(AObj_Transacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fObj_Transacao := AObj_Transacao;

  if AObj_Transacao.Nr_Transacao > 0 then
    CancelarDFe;
end;

//--

procedure TcDFeServico.InutilizarDFe();
const
  cDS_METHOD = 'TcDFeServico.InutilizarDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  if (fTipoRetorno.tStatus in [tsRejeicao]) then
    raise TmException.Create(fTipoRetorno.xMotivo, cDS_METHOD);

  GerarInutilizacaoDFe(
    fObj_Transacao.Nr_Cpfcnpj, // ACNPJEmitente : String;
    'CANCELAMENTO AUTOMATICO', // AJustificativa : String;
    StrToIntDef(FormatDateTime('yyyy', fObj_Transacao.Dt_Transacao), 0), // AAno : Integer;
    fObj_Transacao.Obj_Fiscal.Tp_Docfiscal, // AModelo : Integer;
    StrToIntDef(fObj_Transacao.Obj_Fiscal.Cd_Serie, 0), // ACd_Serie : Integer;
    fObj_Transacao.Obj_Fiscal.Nr_Docfiscal, // ANumeroInicial : Integer;
    fObj_Transacao.Obj_Fiscal.Nr_Docfiscal); // ANumeroFinal : Integer);
end;

procedure TcDFeServico.InutilizarDFe(AObj_Transacao : TTransacao);
const
  cDS_METHOD = 'TcDFeServico.InutilizarDFe()';
begin
  if not Assigned(AObj_Transacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fObj_Transacao := AObj_Transacao;

  if AObj_Transacao.Nr_Transacao > 0 then
    InutilizarDFe;
end;

//--

procedure TcDFeServico.ConsultarDFe();
const
  cDS_METHOD = 'TcDFeServico.ConsultarDFe()';
begin
  ValidarParametro;

  LimparDFe;
  ConfigurarDFe;
  CarregarDFe;

  if (fTipoRetorno.tStatus in [tsRejeicao]) then
    raise TmException.Create(fTipoRetorno.xMotivo, cDS_METHOD);

  GerarConsultaDFe(
    fObj_Transacao.Obj_Fiscal.List_DFe.Items[0].Ds_Xml);
end;

procedure TcDFeServico.ConsultarDFe(AObj_Transacao : TTransacao);
const
  cDS_METHOD = 'TcDFeServico.ConsultarDFe()';
begin
  if not Assigned(AObj_Transacao) then
    raise Exception.Create('Transacao deve ser informada / ' + cDS_METHOD);

  fObj_Transacao := AObj_Transacao;

  if AObj_Transacao.Nr_Transacao > 0 then
    ConsultarDFe;
end;

//--

end.
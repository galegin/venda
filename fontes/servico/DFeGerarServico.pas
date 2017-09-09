unit DFeGerarServico; // uclsDFeServico

(* DFeGerarServico *)

interface

uses
  Classes, SysUtils, StrUtils;

type
  TcDFeGerarServico = class(TComponent)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcDFeGerarServico;
  procedure Destroy;

implementation

var
  _instance : TcDFeGerarServico;

  function Instance : TcDFeGerarServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeGerarServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cDFeGerarServico *)

constructor TcDFeGerarServico.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcDFeGerarServico.Destroy;
begin

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

(*
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

   vTipoPessoa := StrToTipoPessoa(fObj_Transacao.Obj_Pessoa.Nr_CpfCnpj);

    with fObj_Transacao.Obj_Pessoa do begin
      Dest.CNPJCPF           := Nr_CpfCnpj;

      if vTipoPessoa = tpJuridica then
        Dest.IE            := Nr_Rgie; //NFC-e não aceita IE

      case fTp_ModeloDF of
        moNFCe : begin
          Dest.indIEDest := inNaoContribuinte;
        end;

        moNFe : begin
          if (Nr_Rgie = '') or (In_Consumidorfinal) then
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
  fACBrNFe.NotasFiscais.Assinar;
end;

*)

end.
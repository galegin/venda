unit DFeEmissaoServico; // uclsDFeServico

(* DFeEmissaoServico *)

interface

uses
  Classes, SysUtils, StrUtils;

type
  TcDFeEmissaoServico = class(TComponent)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcDFeEmissaoServico;
  procedure Destroy;

implementation

var
  _instance : TcDFeEmissaoServico;

  function Instance : TcDFeEmissaoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeEmissaoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cDFeEmissaoServico *)

constructor TcDFeEmissaoServico.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcDFeEmissaoServico.Destroy;
begin

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

(*
procedure TcDFeServico.LimparDFe;
begin
  fACBrNFe.NotasFiscais.Clear;
end;

procedure TcDFeServico.CarregarDFe;
begin
  with fObj_Transacao.Obj_Fiscal.List_DFe.Items[0] do begin
    fACBrNFe.NotasFiscais.LoadFromString(Ds_Xml);
  end;
end;

//--

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
    fACBrNFe.NotasFiscais[0].NFe.Ide.dhCont := Now;
    fACBrNFe.NotasFiscais[0].NFe.Ide.xJust := 'Sem conexão com a internet';
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

  { if ANFeWebService is TNFeStatusServico then begin
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
    end; }

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

  // end;

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

  { if Assigned(fACBrNFe.DANFE) then
    with fACBrNFe.DANFE do begin
      TipoDANFE := fTp_DANFE;
      Logo      := fDs_LogoMarca; // edtLogoMarca.Text;
    end; }

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
  fACBrNFe.EventoNFe.idLote := 1;

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
    fACBrNFe.WebServices.Inutiliza( ACNPJEmitente, AJustificativa, AAno,
      AModelo, ASerie, ANumeroInicial, ANumeroFinal);

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

  if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppAutorizada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].dhRecbto,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].XMLprotNFe);

    GerarImpressaoDFe(
      fObj_Transacao.Obj_Fiscal.List_DFe.Items[0].Ds_Xml);

  end else if (fTp_Contingencia in [tpcContingencia]) then begin
    GravarDFe(
      tppGerada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      Now,
      'NA',
      fACBrNFe.WebServices.Retorno.RetornoWS);

    GerarImpressaoDFe(
      fObj_Transacao.Obj_Fiscal.List_DFe.Items[0].Ds_Xml);

  end else if (fTipoRetorno.tStatus in [tsRejeicao]) then begin
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

  if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppAutorizada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      fACBrNFe.NotasFiscais[0].GerarXML,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].dhRecbto,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt,
      fACBrNFe.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].XMLprotNFe);

  end else if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.tStatus in [tsRejeicao]) then begin
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

  GerarCancelamentoDFe(
    fObj_Transacao.Obj_Fiscal.Ds_Chave,
    fObj_Transacao.Nr_Cpfcnpj,
    'CANCELAMENTO AUTOMATICO',
    fObj_Transacao.Obj_Fiscal.Nr_Recibo);

  if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppCancelada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      'NA',
      Now,
      '0',
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (fTipoRetorno.tStatus in [tsRejeicao]) then

    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

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

  GerarInutilizacaoDFe(
    fObj_Transacao.Nr_Cpfcnpj, // ACNPJEmitente : String;
    'CANCELAMENTO AUTOMATICO', // AJustificativa : String;
    StrToIntDef(FormatDateTime('yyyy', fObj_Transacao.Dt_Transacao), 0), // AAno : Integer;
    fObj_Transacao.Obj_Fiscal.Tp_Docfiscal, // AModelo : Integer;
    StrToIntDef(fObj_Transacao.Obj_Fiscal.Cd_Serie, 0), // ACd_Serie : Integer;
    fObj_Transacao.Obj_Fiscal.Nr_Docfiscal, // ANumeroInicial : Integer;
    fObj_Transacao.Obj_Fiscal.Nr_Docfiscal); // ANumeroFinal : Integer);

  if (fTp_Contingencia in [tpcSemContingencia]) and (fTipoRetorno.tStatus in [tsAutorizacao, tsProcessado]) then begin
    GravarDFe(
      tppRejeitada,
      fACBrNFe.NotasFiscais[0].NFe.infNFe.ID,
      'NA',
      Now,
      '0',
      fACBrNFe.WebServices.Retorno.RetornoWS);

  end else if (fTipoRetorno.tStatus in [tsRejeicao]) then

    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);

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

  GerarConsultaDFe(
    fObj_Transacao.Obj_Fiscal.List_DFe.Items[0].Ds_Xml);

  if (fTipoRetorno.tStatus in [tsRejeicao]) then  
    raise TmException.Create(cDS_METHOD, fTipoRetorno.xMotivo);
    
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

*)

end.
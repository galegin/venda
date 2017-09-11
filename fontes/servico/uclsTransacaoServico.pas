unit uclsTransacaoServico;

interface

uses
  Classes, SysUtils, StrUtils, Math,
  uEmpresa, uPessoa, uProduto, uOperacao,
  uTransacao, uTransitem, uTransimposto;

type
  TcTransacaoServico = class(TComponent)
  private
    fEmpresa : TEmpresa;
    fPessoa : TPessoa;
    fProduto : TProduto;
    fOperacao : TOperacao;
    fTransacao : TTransacao;
    fTransitem : TTransitem;
    function GetVl_Total: Real;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function Listar() : TTransacaos;

    procedure LimparCapa();

    procedure BuscarCapa(AId_Transacao : String);

    function NumerarCapa() : Integer;
    function NumerarFiscal(ACd_Serie : String) : Integer;

    procedure Salvar(
      ADt_Transacao: TDateTime;
      AId_Empresa: Integer;
      AId_Pessoa: String;
      AId_Operacao: String);

    procedure Excluir(AId_Transacao: String);

    procedure AdicionarItem(
      AId_Produto: String;
      AQt_Item: Real = 1;
      AVl_Variacao: Real = 0;
      AVl_VariacaoCapa: Real = 0);

    procedure RecalcularImpostoItem(
      AObj_Item : TTransitem);

    function BuscarItem(ANr_Item: Integer) : TTransitem;
    procedure ExcluirItem(ANr_Item: Integer);

    procedure GravarVariacaoCapa(AVl_Variacao: Real);
    procedure ExcluirVariacaoCapa();

    procedure GravarVariacaoItem(ANr_Item: Integer; AVl_Variacao: Real);
    procedure ExcluirVariacaoItem(ANr_Item: Integer);

    procedure LimparPagto();
    procedure GerarPagto(
      ATp_Documento : Integer;
      AVl_Documento : Real);

    procedure EmitirDFe();

  published
    property Transacao : TTransacao read fTransacao write fTransacao;
    property Vl_Total : Real read GetVl_Total;
  end;

  function Instance : TcTransacaoServico;
  procedure Destroy;

implementation

uses
  uclsEmpresaServico,
  uclsPessoaServico,
  uclsProdutoServico,
  uclsOperacaoServico,
  uclsImpostoServico,
  uclsDFeServico,
  mContexto, mSequence, mFloat,
  uTransfiscal, uTranspagto, uTipoProcessamento;

var
  _instance : TcTransacaoServico;

  function Instance : TcTransacaoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcTransacaoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcTransacaoServico.Create(AOwner : TComponent);
begin
  inherited;

  fEmpresa := TEmpresa.Create(nil);
  fTransacao := TTransacao.Create(nil);
end;

destructor TcTransacaoServico.Destroy;
begin
  FreeAndNil(fTransacao);
  FreeAndNil(fEmpresa);

  inherited;
end;

function TcTransacaoServico.Listar;
begin
  Result := mContexto.Instance.GetLista(TTransacao, '', TTransacaos) as TTransacaos;
end;

procedure TcTransacaoServico.LimparCapa;
begin
  fTransacao := Transacao.Create(nil);
end;

procedure TcTransacaoServico.BuscarCapa;
begin
  LimparCapa();
  if AId_Transacao <> '' then
    fTransacao := mContexto.Instance.GetObjeto(TTransacao, 'Id_Transacao = ''' + AId_Transacao + '''') as TTransacao;
end;

function TcTransacaoServico.NumerarCapa;
begin
  Result := mSequence.Instance.GetSequencia('TRANSACAO');
end;

function TcTransacaoServico.NumerarFiscal;
begin
  Result := mSequence.Instance.GetSequencia('TRANSACAO', 'NF', 0, 0, ACd_Serie);
end;

procedure TcTransacaoServico.Salvar;
const
  cDS_METHOD = 'TcTransacaoServico.Salvar()';
var
  vNr_Transacao, vNr_Nf : Integer;
begin
  if AId_Pessoa = '' then
    raise Exception.Create('Pessoa deve ser informado / ' + cDS_METHOD);
  if AId_Operacao = '' then
    raise Exception.Create('Operacao deve ser informado / ' + cDS_METHOD);

  fEmpresa := uclsEmpresaServico.Instance.Consultar(AId_Empresa);
  if not Assigned(fEmpresa) then
    raise Exception.Create('Empresa nao encontrada / ' + cDS_METHOD);

  fPessoa := uclsPessoaServico.Instance.Consultar(AId_Pessoa);
  if not Assigned(fPessoa) then
    raise Exception.Create('Pessoa ' + AId_Pessoa + ' nao encontrada / ' + cDS_METHOD);

  fOperacao := uclsOperacaoServico.Instance.Consultar(AId_Operacao);
  if not Assigned(fOperacao) then
    raise Exception.Create('Operacao ' + AId_Operacao + ' nao encontrada / ' + cDS_METHOD);

  vNr_Transacao := NumerarCapa();
  vNr_Nf := NumerarFiscal(fOperacao.Cd_Serie);

  with fTransacao do begin
    Id_Transacao :=
      IntToStr(AId_Empresa) + '#' +
      FormatDateTime('yyyymmdd', ADt_Transacao) + '#' +
      IntToStr(vNr_Transacao);

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Id_Empresa := AId_Empresa;
    Dt_Transacao := ADt_Transacao;
    Nr_Transacao := vNr_Transacao;
    Id_Pessoa := fPessoa.Id_Pessoa;
    Id_Operacao := fOperacao.Id_Operacao;
    Dt_Cancelamento := 0;

    Empresa := fEmpresa;
    Operacao := fOperacao;
    Pessoa := fPessoa;

    mContexto.Instance.SetObjeto(fTransacao);

    with Fiscal do begin
      Id_Transacao := fTransacao.Id_Transacao;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Tp_Modelonf := fOperacao.Tp_Modelonf;
      Nr_Nf := vNr_Nf;
      Tp_Modalidade := fOperacao.Tp_Modalidade;
      Tp_Operacao := fOperacao.Tp_Operacao;
      Cd_Serie := fOperacao.Cd_Serie;
      //Tp_Ambiente := 0;
      //Tp_Emissao := 0;
      //Dh_Emissao := Now;
      //Dh_EntradaSaida := Now;
      Dt_Recebimento := 0;
      Nr_Recibo := '';
      Tp_Processamento := TipoProcessamentoToStr(tppGerada);
    end;

    mContexto.Instance.SetObjeto(Fiscal);
  end;
end;

procedure TcTransacaoServico.Excluir;
begin
  with fTransacao do begin
    if AId_Transacao <> '' then begin
      Id_Transacao := AId_Transacao;
      mContexto.Instance.RemObjeto(fTransacao);
    end;
  end;
end;

//--

procedure TcTransacaoServico.AdicionarItem;
const
  cDS_METHOD = 'TcTransacaoServico.AdicionarItem()';
begin
  if AId_Produto = '' then
    raise Exception.Create('Produto deve ser informado / ' + cDS_METHOD);

  fProduto := uclsProdutoServico.Instance.Consultar(AId_Produto);
  if not Assigned(fProduto) then
    raise Exception.Create('Produto ' + AId_Produto + ' nao encontrado / ' + cDS_METHOD);

  fTransitem := fTransacao.Itens.Add;
  fTransitem.Produto := fProduto;

  with fTransitem do begin
    Id_Transacao := fTransacao.Id_Transacao;
    Nr_Item := fTransacao.Itens.Count;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Id_Produto := fProduto.Id_Produto;
    Cd_Produto := fProduto.Cd_Produto;
    Ds_Produto := fProduto.Ds_Produto;
    Cd_Especie := fProduto.Cd_Especie;
    Cd_Ncm := fProduto.Cd_Ncm;
    Cd_Cfop := fOperacao.Cd_Cfop;
    Qt_Item := AQt_Item;
    Vl_Custo := fProduto.Vl_Custo;
    Vl_Unitario := fProduto.Vl_Venda;
    Vl_Item := Vl_Unitario * Qt_Item;
    Vl_Variacao := AVl_Variacao;
    Vl_VariacaoCapa := AVl_VariacaoCapa;

    uclsImpostoServico.Instance.Gerar(
      fTransacao,
      fTransitem);

    mContexto.Instance.SetObjeto(fTransitem);
  end;
end;

function TcTransacaoServico.BuscarItem;
var
  I : Integer;
begin
  Result := nil;

  with fTransacao do
    for I := 0 to Itens.Count - 1 do
      with TTransitem(Itens[I]) do
        if Nr_Item = ANr_Item then begin
          Result := Itens[I];
          Break;
        end;
end;

procedure TcTransacaoServico.ExcluirItem;
var
  I : Integer;
begin
  with fTransacao do
    for I := Itens.Count - 1 downto 0 do
      with TTransitem(Itens[I]) do
        if Nr_Item = ANr_Item then begin
          mContexto.Instance.RemObjeto(TTransitem(Itens[I]));
          Itens.Delete(I);
          Break;
        end;
end;

//--

procedure TcTransacaoServico.GravarVariacaoCapa;
var
  vVl_Resto, vPr_Proporcao : Real;
  vTransitemMaior : TTransitem;
  I : Integer;
begin
  vVl_Resto := AVl_Variacao;
  vTransitemMaior := nil;

  with fTransacao do begin
    for I := 0 to Itens.Count - 1 do begin
      with TTransitem(Itens[I]) do begin
        vPr_Proporcao := Vl_Item / fTransacao.Vl_Item;
        Vl_VariacaoCapa := TmFloat.Rounded(AVl_Variacao * vPr_Proporcao, 2);
        vVl_Resto := vVl_Resto - Vl_VariacaoCapa;

        if not Assigned(vTransitemMaior) or (Vl_Item > vTransitemMaior.Vl_Item) then
          vTransitemMaior := TTransitem(Itens[I]);
      end;

      if Assigned(vTransitemMaior) or (vVl_Resto <> 0) then
        with vTransitemMaior do begin
          Vl_VariacaoCapa := Vl_VariacaoCapa + vVl_Resto;
          mContexto.Instance.SetObjeto(vTransitemMaior);
        end;
    end;
  end;
end;

procedure TcTransacaoServico.ExcluirVariacaoCapa;
var
  I : Integer;
begin
  with fTransacao do begin
    for I := 0 to Itens.Count - 1 do
      with TTransitem(Itens[I]) do begin
        Vl_VariacaoCapa := 0;
        mContexto.Instance.SetObjeto(TTransitem(Itens[I]));
      end;
  end;
end;

//--

procedure TcTransacaoServico.GravarVariacaoItem;
var
  vTransitem : TTransitem;
begin
  vTransitem := BuscarItem(ANr_Item);
  if Assigned(vTransitem) then begin
    with vTransitem do begin
      Vl_Variacao := AVl_Variacao;
      RecalcularImpostoItem(vTransitem);
      mContexto.Instance.SetObjeto(vTransitem);
    end;
  end;
end;

procedure TcTransacaoServico.ExcluirVariacaoItem;
var
  vTransitem : TTransitem;
begin
  vTransitem := BuscarItem(ANr_Item);
  if Assigned(vTransitem) then begin
    with vTransitem do begin
      Vl_Variacao := 0;
      RecalcularImpostoItem(vTransitem);
      mContexto.Instance.SetObjeto(vTransitem);
    end;
  end;
end;

//--

procedure TcTransacaoServico.RecalcularImpostoItem;
var
  vVl_Imposto : Real;
  I : Integer;
begin
  with AObj_Item do
    for I := 0 to Impostos.Count - 1 do
      with TTransimposto(Impostos[I]) do begin
        Vl_Basecalculo := Vl_Totitem;

        vVl_Imposto := TmFloat.Rounded(Vl_Basecalculo * (Pr_Aliquota / 100) * (Pr_Basecalculo / 100), 2);

        Vl_Imposto := IfThen(Vl_Imposto > 0, vVl_Imposto, 0);
        Vl_Outro := IfThen(Vl_Outro > 0, vVl_Imposto, 0);
        Vl_Isento := IfThen(Vl_Isento > 0, vVl_Imposto, 0);

        mContexto.Instance.SetObjeto(TTransimposto(Impostos[I]));
      end;
end;

//-- PAGTO - NFCe

procedure TcTransacaoServico.LimparPagto();
var
  I: Integer;
begin
  with fTransacao.Pagtos do begin
    for I := 0 to Count - 1 do
      with TTranspagto(fTransacao.Pagtos[I]) do
        mContexto.Instance.SetObjeto(TTranspagto(fTransacao.Pagtos[I]));
    Clear;
  end;
end;

procedure TcTransacaoServico.GerarPagto;
const
  cDS_METHOD = 'TcTransacaoServico.GerarPagto()';
var
  vTranspagto : TTranspagto;
begin
  if ATp_Documento = 0 then
    raise Exception.Create('Tipo documento deve ser informada / ' + cDS_METHOD);
  if AVl_Documento = 0 then
    raise Exception.Create('Valor documento deve ser informado / ' + cDS_METHOD);

  vTranspagto := fTransacao.Pagtos.Add;
  with vTranspagto do begin
    Id_Transacao := fTransacao.Id_Transacao;
    Nr_Seq := fTransacao.Pagtos.Count;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Tp_Documento := ATp_Documento;
    Vl_Documento := AVl_Documento;
  end;

  mContexto.Instance.SetObjeto(vTranspagto);
end;

//--

procedure TcTransacaoServico.EmitirDFe;
begin
  with fTransacao do
    if Operacao.Tp_Modelonf in [55, 65] then
      if Id_Transacao <> '' then
        uclsDFeServico.Instance.EmitirDFe(Transacao);
end;

//--

function TcTransacaoServico.GetVl_Total: Real;
begin
  Result := 0; 
  with fTransacao do
    if Id_Transacao <> '' then
      Result := Vl_Total;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

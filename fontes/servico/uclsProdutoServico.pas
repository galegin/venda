unit uclsProdutoServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uProduto;

type
  TcProdutoServico = class(TComponent)
  private
    fProduto : TProduto;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function Listar() : TProdutos;

    function Consultar(AId_Produto: String) : TProduto;

    procedure Salvar(
      AId_Produto: String;
      ACd_Produto: Integer;
      ADs_Produto: String;
      ACd_Especie: String;
      ACd_Cst: String;
      ACd_Ncm: String;
      APr_Aliquota: Real;
      AVl_Custo: Real;
      AVl_Venda: Real;
      AVl_Promocao: Real);

    procedure Excluir(AId_Produto: String);
    
  published
    property Produto : TProduto read fProduto write fProduto;
  end;

  function Instance : TcProdutoServico;
  procedure Destroy;

implementation

uses
  mContexto;

var
  _instance : TcProdutoServico;

  function Instance : TcProdutoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcProdutoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcProdutoServico.Create(AOwner : TComponent);
begin
  inherited;

  fProduto := TProduto.Create(nil);
end;

destructor TcProdutoServico.Destroy;
begin
  FreeAndNil(fProduto);

  inherited;
end;

function TcProdutoServico.Listar;
begin
  Result := mContexto.Instance.GetLista(TProduto, '', TProdutos) as TProdutos;
end;

function TcProdutoServico.Consultar;
begin
  if AId_Produto <> '' then begin
    Result := mContexto.Instance.GetObjeto(TProduto, 'Id_Produto = ''' + AId_Produto + '''') as TProduto;
  end else begin
    Result := nil;
  end;
end;

procedure TcProdutoServico.Salvar;
begin
  with fProduto do begin
    Id_Produto := AId_Produto;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Cd_Produto := ACd_Produto;
    Ds_Produto := ADs_Produto;
    Cd_Especie := ACd_Especie;
    Cd_Cst := ACd_Cst;
    Cd_Ncm := ACd_Ncm;
    Pr_Aliquota := APr_Aliquota;
    Vl_Custo := AVl_Custo;
    Vl_Venda := AVl_Venda;
    Vl_Promocao := AVl_Promocao;
  end;

  mContexto.Instance.SetObjeto(fProduto);
end;

procedure TcProdutoServico.Excluir;
begin
  with fProduto do begin
    if AId_Produto <> '' then begin
      Id_Produto := AId_Produto;
      mContexto.Instance.RemObjeto(fProduto);
    end;
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

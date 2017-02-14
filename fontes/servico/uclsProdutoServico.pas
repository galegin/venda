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

    function Listar() : TProdutoList;

    function Consultar(ACd_Barraprd: String) : TProduto;

    procedure Salvar(
      ACd_Barraprd: String;
      ACd_Produto: Integer;
      ADs_Produto: String;
      ACd_Especie: String;
      ACd_Cst: String;
      ACd_Ncm: String;
      APr_Aliquota: Real;
      AVl_Custo: Real;
      AVl_Venda: Real;
      AVl_Promocao: Real);

    procedure Excluir(ACd_Barraprd: String);
    
  published
    property Produto : TProduto read fProduto write fProduto;
  end;

  function Instance : TcProdutoServico;

implementation

uses mCollectionItem;

var
  _instance : TcProdutoServico;

  function Instance : TcProdutoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcProdutoServico.Create(nil);
    Result := _instance;
  end;

constructor TcProdutoServico.Create(AOwner : TComponent);
begin
  inherited;
  fProduto := TProduto.Create(nil);
end;

function TcProdutoServico.Listar;
begin
  Result := TProdutoList(fProduto.Listar(nil));
end;

function TcProdutoServico.Consultar;
begin
  with fProduto do begin
    Limpar();
    if ACd_Barraprd <> '' then begin
      Cd_Barraprd := ACd_Barraprd;
      Consultar(nil);
      Result := fProduto;
    end else begin
      Result := nil;
    end;
  end;
end;

procedure TcProdutoServico.Salvar;
begin
  with fProduto do begin
    Cd_Barraprd := ACd_Barraprd;

    U_Version := '';
    Cd_Operador := 0;
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

    Salvar();
  end;
end;

procedure TcProdutoServico.Excluir;
begin
  with fProduto do begin
    Limpar();
    if ACd_Barraprd <> '' then begin
      Cd_Barraprd := ACd_Barraprd;
      Excluir();
    end;
  end;
end;

end.

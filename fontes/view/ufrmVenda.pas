unit ufrmVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, StdCtrls, ExtCtrls,
  uclsTransacaoServico, uTransitem;

type
  TF_Venda = class(TForm)
    LabelCliente: TLabel;
    EditCliente: TEdit;
    EditProduto: TEdit;
    tItem: TClientDataSet;
    dItem: TDataSource;
    gItem: TDBGrid;
    LabelProduto: TLabel;
    Bevel1: TBevel;
    PanelTotal: TPanel;
    EditValorTotal: TEdit;
    LabelValorTotal: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProdutoExit(Sender: TObject);
  private
    fTransitem : TTransitem;
    function GetObj_Item: TTransitem;
    procedure SetObj_Item(const Value: TTransitem);
  protected
    fDevolucaoServico: TcTransacaoServico;
    fVendaServico: TcTransacaoServico;
    procedure Limpar;
    procedure Finalizar;
  public
    constructor Create(AOwner : TComponent); override;
    class procedure Execute();
  published
    property Obj_Item : TTransitem read GetObj_Item write SetObj_Item;
  end;

//var
//  F_Venda: TF_Venda;

implementation

{$R *.dfm}

uses
  mClientDataSet, mDataSet, mProperty, mClasse, mObjeto,
  mComputador, mAmbienteConf,
  uclsEquipServico, uclsOperacaoServico, ufrmPagto, uTransacao,
  uclsDFeServico;

  function TF_Venda.GetObj_Item: TTransitem;
  begin
    TmObjeto.SetValues(fTransitem, TmDataSet.GetValues(tItem));
    Result := fTransitem;
  end;

  procedure TF_Venda.SetObj_Item(const Value: TTransitem);
  begin
    TmDataSet.SetValues(tItem, TmObjeto.GetValues(fTransitem));
  end;

class procedure TF_Venda.Execute;
var
  F_Venda: TF_Venda;
begin
  Application.CreateForm(TF_Venda, F_Venda);
  with F_Venda do begin
    try
      ShowModal;
    finally
      Free;
    end;  
  end;
end;

constructor TF_Venda.Create(AOwner: TComponent);
begin
  inherited;

  fDevolucaoServico:= TcTransacaoServico.Create(Self);
  fVendaServico:= TcTransacaoServico.Create(Self);
  fTransitem:= TTransitem.Create(nil);

  TmClientDataSet.SetFields(tItem, TmClasse.GetProperties(TTransitem));
  TmClientDataSet.SetInVisible(tItem, ['cd_dnatrans', 'u_version', 'cd_operador', 'dt_cadastro']);
  TmClientDataSet.SetFieldList(tItem, [
    TmClientDataSet_Field.Create('Nr_Item', 'Seq', 3),
    TmClientDataSet_Field.Create('Cd_Barraprd', 'Barra', 8),
    TmClientDataSet_Field.Create('Cd_Produto', 'Codigo', 8),
    TmClientDataSet_Field.Create('Ds_Produto', 'Descricao', 20),
    TmClientDataSet_Field.Create('Cd_Cfop', 'CFOP', 3),
    TmClientDataSet_Field.Create('Qt_Item', 'Qtde', 3),
    TmClientDataSet_Field.Create('Vl_Custo', 'Custo', 6),
    TmClientDataSet_Field.Create('Vl_Unitario', 'Unit', 6),
    TmClientDataSet_Field.Create('Vl_Item', 'Valor', 6),
    TmClientDataSet_Field.Create('Vl_Variacao', 'Desc', 6),
    TmClientDataSet_Field.Create('Vl_VariacaoCapa', 'Desc.Capa', 6),
    TmClientDataSet_Field.Create('Vl_Totitem', 'Total', 6)]);

  uclsEquipServico.Instance.Salvar(
    mComputador.Instance.NumeroDisco,
    UpperCase(mComputador.Instance.UsuarioSistema),
    UpperCase(mAmbienteConf.Instance.CodigoAmbiente),
    mAmbienteConf.Instance.CodigoEmpresa,
    mAmbienteConf.Instance.CodigoTerminal);
  uclsEquipServico.Instance.Consultar(mComputador.Instance.NumeroDisco);

  uclsOperacaoServico.Instance.Consultar('VENDA_NFE');

end;

procedure TF_Venda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F2: Limpar;
    VK_F9: Finalizar;
  end;
end;

procedure TF_Venda.EditProdutoExit(Sender: TObject);
begin
  if EditProduto.Text = '' then
    Exit;

  if EditCliente.Text = '' then
    raise Exception.Create('Cliente deve ser informado');

  if fVendaServico.Transacao.Nr_Transacao = 0 then
    fVendaServico.Salvar(
      uclsEquipServico.Instance.Equip.Cd_Dnaequip,
      Date,
      EditCliente.Text,
      uclsOperacaoServico.Instance.Operacao.Cd_Operacao);

      fVendaServico.AdicionarItem(EditProduto.Text);

  TmDataSet.SetCollection(tItem, fVendaServico.Transacao.List_Item);

  EditValorTotal.Text := FormatFloat('0.00', fVendaServico.Transacao.Vl_Total);

  EditProduto.Text := '';
  EditProduto.SetFocus;
end;

procedure TF_Venda.Limpar;
begin
  fDevolucaoServico.LimparCapa();
  fVendaServico.LimparCapa();
end;

procedure TF_Venda.Finalizar;
var
  vCdDnapagto : String;
  vVlPagto : Real;
begin
  // total

  vVlPagto :=
    fVendaServico.Vl_Total -
    fDevolucaoServico.Vl_Total;

  // pagamento

  if vVlPagto > 0 then begin
    vCdDnapagto := TF_Pagto.Execute(vVlPagto);
    if vCdDnapagto = '' then
      Exit;
  end;

  // gerar transacao vencto

  // gerar transacao pagto

  // emitir DFe

  fDevolucaoServico.EmitirDFe();
  fVendaServico.EmitirDFe();

  // gerar estoque    
end;

end.

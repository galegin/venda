unit ufrmVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, StdCtrls, ExtCtrls, ComCtrls,
  uclsTransacaoServico, uTransitem, mField, mGrade;

type
  TF_Venda = class(TForm)
    LabelCliente: TLabel;
    EditCliente: TEdit;
    EditProduto: TEdit;
    LabelProduto: TLabel;
    Bevel1: TBevel;
    PanelTotal: TPanel;
    EditValorTotal: TEdit;
    LabelValorTotal: TLabel;
    gItem: TmGrade;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProdutoExit(Sender: TObject);
  private
    fTransitem : TTransitem;
    fFieldsList : TmFieldList;
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
  mClientDataSet, mDataSet, mValue, mClasse, mObjeto,
  mComputador, mAmbienteConf,
  uclsEquipServico, uclsOperacaoServico, ufrmPagto, uTransacao,
  uclsDFeServico;

  function TF_Venda.GetObj_Item: TTransitem;
  begin
    //TmObjeto.SetValues(fTransitem, TmDataSet.GetValues(tItem));
    Result := fTransitem;
  end;

  procedure TF_Venda.SetObj_Item(const Value: TTransitem);
  begin
    //TmDataSet.SetValues(tItem, TmObjeto.GetValues(fTransitem));
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

  fFieldsList:= TmFieldList.Create;
  with fFieldsList do begin
    Add(TmField.Create('Nr_Item', 'Seq', ftInteger, 3));
    Add(TmField.Create('Cd_Barraprd', 'Barra', ftString, 8));
    Add(TmField.Create('Cd_Produto', 'Codigo', ftString, 8));
    Add(TmField.Create('Ds_Produto', 'Descricao', ftString, 20));
    Add(TmField.Create('Cd_Cfop', 'CFOP', ftInteger, 3));
    Add(TmField.Create('Qt_Item', 'Qtde', ftFloat, 3));
    Add(TmField.Create('Vl_Custo', 'Custo', ftFloat, 6));
    Add(TmField.Create('Vl_Unitario', 'Unit', ftFloat, 6));
    Add(TmField.Create('Vl_Item', 'Valor', ftFloat, 6));
    Add(TmField.Create('Vl_Variacao', 'Desc', ftFloat, 6));
    Add(TmField.Create('Vl_VariacaoCapa', 'Desc.Capa', ftFloat, 6));
    Add(TmField.Create('Vl_Totitem', 'Total', ftFloat, 6));
  end;

  //TmClientDataSet.SetFields(tItem, fFieldsList);

  uclsEquipServico.Instance.Salvar(
    mComputador.Instance.NumeroDisco,
    UpperCase(mComputador.Instance.UsuarioSistema),
    UpperCase(mAmbienteConf.Instance.CodigoAmbiente),
    mAmbienteConf.Instance.CodigoEmpresa,
    mAmbienteConf.Instance.CodigoTerminal);
  uclsEquipServico.Instance.Consultar(mComputador.Instance.NumeroDisco);

  gItem.Fields := fFieldsList;

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
      uclsEquipServico.Instance.Equip.Cd_Equip,
      Date,
      EditCliente.Text,
      uclsOperacaoServico.Instance.Operacao.Cd_Operacao);

      fVendaServico.AdicionarItem(EditProduto.Text);

  //TmDataSet.SetCollection(tItem, fVendaServico.Transacao.List_Item);

  with fVendaServico.Transacao do
    gItem.Add(List_Item[List_Item.Count - 1]);

  EditValorTotal.Text := FormatFloat('0.00', fVendaServico.Transacao.Vl_Total);

  EditProduto.Text := '';
  EditProduto.SetFocus;
end;

procedure TF_Venda.Limpar;
begin
  fDevolucaoServico.LimparCapa();
  fVendaServico.LimparCapa();
  gItem.Clear();
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

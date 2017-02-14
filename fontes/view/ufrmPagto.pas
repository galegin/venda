unit ufrmPagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPagto, uPagtoparc, StdCtrls, DB, DBClient, Grids, DBGrids,
  mClientDataSet, mDataSet, mClasse, mFloat;

type
  TF_Pagto = class(TForm)
    LabelValorPagto: TLabel;
    EditValorPagto: TEdit;
    EditValorEntrada: TEdit;
    LabelValorEntrada: TLabel;
    EditValorParcelado: TEdit;
    LabelValorParcelado: TLabel;
    LabelParcelamento: TLabel;
    gParcelamento: TDBGrid;
    tParcelamento: TClientDataSet;
    dParcelamento: TDataSource;
    LabelTipoDocto: TLabel;
    ComboBoxTipoDocto: TComboBox;
    EditQtdeParcela: TEdit;
    LabelQtdeParcela: TLabel;
    ButtonLancar: TButton;
    ButtonLimpar: TButton;
    ButtonFinalizar: TButton;
    LabelTroco: TLabel;
    EditValorTroco: TEdit;
    LabelTotalParcelado: TLabel;
    EditTotalParcelado: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonLancarClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonFinalizarClick(Sender: TObject);
    procedure EditValorEntradaKeyPress(Sender: TObject; var Key: Char);
  private
    fObj_Pagto : TPagto;
    function GetCd_Dnapagto: String;
    function GetVl_Pagto: Real;
    procedure SetVl_Pagto(const Value: Real);
  public
    constructor Create(Aowner : TComponent); override;
    class function Execute(AVl_Pagto : Real) : String;
    procedure Limpar;
    procedure Lancar;
    procedure Finalizar;
  published
    property Cd_Dnapagto : String read GetCd_Dnapagto;
    property Vl_Pagto : Real read GetVl_Pagto write SetVl_Pagto;
  end;

//var
//  F_Pagto: TF_Pagto;

implementation

{$R *.dfm}

uses
  uclsPagamentoServico, uclsEquipServico;

{ TF_Pagto }

constructor TF_Pagto.Create(Aowner: TComponent);
begin
  inherited;

  fObj_Pagto := TPagto.Create(nil);

  TmClientDataSet.SetFields(tParcelamento, TmClasse.GetProperties(TPagtoparc));
  TmClientDataSet.SetVisible(tParcelamento, [
    'Nr_Parcela', 'Vl_Parcela', 'Tp_Docto', 'Nr_Docto', 'Dt_Vencto', 'Ds_Adicional']);
  TmClientDataSet.SetFieldList(tParcelamento, [
    TmClientDataSet_Field.Create('Nr_Parcela', 'Parc', 4),
    TmClientDataSet_Field.Create('Vl_Parcela', 'Valor', 8, 2),
    TmClientDataSet_Field.Create('Tp_Docto', 'Tipo', 4),
    TmClientDataSet_Field.Create('Nr_Docto', 'Numero', 4),
    TmClientDataSet_Field.Create('Dt_Vencto', 'Vencto', 4),
    TmClientDataSet_Field.Create('Ds_Adicional', 'Adicional', 4) ]);

  EditQtdeParcela.Text := '1';  
end;

class function TF_Pagto.Execute;
var
  F_Pagto: TF_Pagto;
begin
  Application.CreateForm(TF_Pagto, F_Pagto);
  with F_Pagto do begin
    try
      Vl_Pagto := AVl_Pagto;
      if ShowModal = mrOk then
        Result := Cd_Dnapagto;
    finally
      Free;
    end;
  end;
end;

function TF_Pagto.GetCd_Dnapagto: String;
begin
  Result := fObj_Pagto.Cd_Dnapagto;
end;

function TF_Pagto.GetVl_Pagto: Real;
begin
  Result := fObj_Pagto.Vl_Pagto;
end;

procedure TF_Pagto.SetVl_Pagto(const Value: Real);
begin
  fObj_Pagto.Vl_Pagto := Value;
  EditValorPagto.Text := FormatFloat('0.00', Value);
  EditValorEntrada.Text := FormatFloat('0.00', Value);
end;

procedure TF_Pagto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F2: Limpar;
    VK_F5: Lancar;
    VK_F9: Finalizar;
  end;
end;

procedure TF_Pagto.EditValorEntradaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',', Chr(8)]) then
    Key := #0;
end;

procedure TF_Pagto.Limpar;
begin
  tParcelamento.EmptyDataSet;

  EditValorEntrada.Text := '';
  EditValorTroco.Text := '';
  EditValorParcelado.Text := '';
  EditTotalParcelado.Text := '';
  EditQtdeParcela.Text := '';

  EditValorEntrada.SetFocus;
end;

procedure TF_Pagto.Finalizar;
begin
  with uclsPagamentoServico.Instance do begin
    Limpar();

    Salvar(
      uclsEquipServico.Instance.Equip.Cd_Equip, {Cd_Equip}
      Date, {ADt_Pagto}
      0, {ANr_Pagto}
      StrToFloatDef(EditValorPagto.Text, 0), {AVl_Pagto}
      StrToFloatDef(EditValorEntrada.Text, 0), {AVl_Entrada}
      0, {AVl_Troco}
      0); {AVl_Variacao}

    with tParcelamento do begin
      DisableControls;
      First;

      while not EOF do begin
        AdicionarParcela(
          TmDataSet.PegarI(tParcelamento, 'Nr_Parcela'),
          TmDataSet.PegarF(tParcelamento, 'Vl_Parcela'),
          TmDataSet.PegarI(tParcelamento, 'Tp_Docto'),
          TmDataSet.PegarI(tParcelamento, 'Nr_Docto'),
          TmDataSet.PegarD(tParcelamento, 'Dt_Vencto'),
          TmDataSet.PegarS(tParcelamento, 'Ds_Adicional'),
          TmDataSet.PegarS(tParcelamento, 'Cd_Dnabaixa'));

        Next;
      end;

      First;
      EnableControls;
    end;

    fObj_Pagto.Cd_Dnapagto := Pagto.Cd_Dnapagto;
  end;

  ModalResult := mrOk;
end;

procedure TF_Pagto.Lancar;
var
  vValorParcelamento, vValorParcela, vValorResto : Real;
  vQtdeParcela, vNumeroDocto, vTipoDocto, I : Integer;
  vDataVencto : TDateTime;
begin
  vValorParcelamento := StrToFloatDef(EditValorParcelado.Text, 0);
  vQtdeParcela := StrToIntDef(EditQtdeParcela.Text, 0);

  if vValorParcelamento = 0 then
    raise Exception.Create('Valor de parcelamento deve ser informada');
  if vQtdeParcela = 0 then
    raise Exception.Create('Qtde de parcela deve ser informada');

  vValorParcela := TmFloat.Rounded(vValorParcelamento / vQtdeParcela, 2);
  vValorResto := vValorParcelamento - (vValorParcela * vQtdeParcela);

  vNumeroDocto := StrToIntDef(FormatDateTime('yymmddhh', Now), 0);
  vTipoDocto := ComboBoxTipoDocto.ItemIndex + 1;
  vDataVencto := Date + 30;

  for I := 1 to vQtdeParcela do begin
    tParcelamento.Append;
    TmDataSet.SetarI(tParcelamento, 'Nr_Parcela', I);
    TmDataSet.SetarF(tParcelamento, 'Vl_Parcela', vValorParcela + vValorResto);
    TmDataSet.SetarI(tParcelamento, 'Tp_Docto', vTipoDocto);
    TmDataSet.SetarI(tParcelamento, 'Nr_Docto', vNumeroDocto);
    TmDataSet.SetarD(tParcelamento, 'Dt_Vencto', vDataVencto);
    TmDataSet.SetarS(tParcelamento, 'Ds_Adicional', '');
    tParcelamento.Post;
    vDataVencto := vDataVencto + 30;
    vValorResto := 0;
  end;

  EditTotalParcelado.Text := FormatFloat('0.00', TmDataSet.Sum(tParcelamento, 'Vl_Parcela'));

  EditValorParcelado.Text := '';
  EditValorParcelado.SetFocus;
end;

procedure TF_Pagto.ButtonLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TF_Pagto.ButtonLancarClick(Sender: TObject);
begin
  Lancar;
end;

procedure TF_Pagto.ButtonFinalizarClick(Sender: TObject);
begin
  Finalizar;
end;

end.

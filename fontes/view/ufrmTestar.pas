unit ufrmTestar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mFormControl, mCollectionItem, mKeyValue, mTipoFormato, mValue,
  mForm, mOrientacaoFrame;

type
  TF_Testar = class(TmForm)
  private
    fObj_Testar : TmCollectionItem;
  public
    constructor Create(AOwner : TComponent); override;
    class procedure Execute();
  end;

//var
//  F_Testar: TF_Testar;

implementation

{$R *.dfm}

{ TF_Testar }

constructor TF_Testar.Create(AOwner: TComponent);
begin
  inherited;

  (*
  mForm
    mFrame
      mPanel
      mGrade
      mLabel ( Requerido / Opcional )
      mButton
      mField ( mComboBox / mCheckBox / mTextBox )
    mPanel
      mPanel
      mGrade
      mLabel ( Requerido / Opcional )
      mButton
      mField ( mComboBox / mCheckBox / mTextBox )
    mGrade
    mLabel ( Requerido / Opcional )
    mButton
    mField ( mComboBox / mCheckBox / mTextBox )
  *)

  with AddFrame(toVertical) do begin

    with AddFrame(toHorizontal) do begin
      AddLabel(100, 'Código');
      AddTextBox(100, fObj_Testar, 'Cd_Testar', tvFloat, tfCodigo);
    end;

    with AddFrame(toHorizontal) do begin
      AddLabel(100, 'Descrição');
      AddTextBox(200, fObj_Testar, 'Ds_Testar', tvString, tfDescricao);
    end;

    with AddFrame(toHorizontal) do begin
      AddLabel(100, 'Situacao');
      AddComboBox(100, fObj_Testar, 'Tp_Testar', [
        TmKeyValueTexto.Create('1', 'Ativo'),
        TmKeyValueTexto.Create('2', 'Inativo')]);
    end;

    with AddFrame(toHorizontal) do begin
      AddLabel(100, 'Inativo');
      AddCheckBox(100, fObj_Testar, 'In_Testar');
    end;
    
  end;

end;

class procedure TF_Testar.Execute;
var
  F_Testar: TF_Testar;
begin
  Application.CreateForm(TF_Testar, F_Testar);
  with F_Testar do begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.

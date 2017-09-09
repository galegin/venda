unit DFeFiscalServico; // uclsDFeServico

(* DFeFiscalServico *)

interface

uses
  Classes, SysUtils, StrUtils;

type
  TcDFeFiscalServico = class(TComponent)
  private
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
  end;

  function Instance : TcDFeFiscalServico;
  procedure Destroy;

implementation

var
  _instance : TcDFeFiscalServico;

  function Instance : TcDFeFiscalServico;
  begin
    if not Assigned(_instance) then
      _instance := TcDFeFiscalServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* cDFeFiscalServico *)

constructor TcDFeFiscalServico.Create(AOwner : TComponent);
begin
  inherited;

end;

destructor TcDFeFiscalServico.Destroy;
begin

  inherited;
end;

initialization
  //Instance();

finalization
  Destroy();

(*
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
*)

end.
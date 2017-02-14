unit uclsUsuarioServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uUsuario;

type
  TcUsuarioServico = class(TComponent)
  private
    fUsuario : TUsuario;
  protected
  public
    constructor Create(AOwner : TComponent); override;

    function Listar() : TUsuarioList;

    procedure Salvar(
      ACd_Usuario : String;
      ANm_Usuario : String;
      ANm_Login : String;
      ACd_Senha : String;
      ACd_Papel : String;
      ATp_Bloqueio : Integer;
      ADt_Bloqueio : TDateTime);

    procedure Excluir(ACd_Usuario : String);
    
  published
    property Usuario : TUsuario read fUsuario write fUsuario;
  end;

  function Instance : TcUsuarioServico;

implementation

uses mCollectionItem;

var
  _instance : TcUsuarioServico;

  function Instance : TcUsuarioServico;
  begin
    if not Assigned(_instance) then
      _instance := TcUsuarioServico.Create(nil);
    Result := _instance;
  end;

constructor TcUsuarioServico.Create(AOwner : TComponent);
begin
  inherited;

  fUsuario := TUsuario.Create(nil);
end;

function TcUsuarioServico.Listar;
begin
  Result := TUsuarioList(fUsuario.Listar(nil));
end;

procedure TcUsuarioServico.Salvar;
begin
  with fUsuario do begin
    Cd_Usuario := ACd_Usuario;

    U_Version := '';
    Cd_Operador := 0;
    Dt_Cadastro := Now;

    Nm_Usuario := ANm_Usuario;
    Nm_Login := ANm_Login;
    Cd_Senha := ACd_Senha;
    Cd_Papel := ACd_Papel;
    Tp_Bloqueio := ATp_Bloqueio;
    Dt_Bloqueio := ADt_Bloqueio;

    Salvar();
  end;
end;

procedure TcUsuarioServico.Excluir;
begin
  with fUsuario do begin
    Limpar();
    if ACd_Usuario <> '' then begin
      Cd_Usuario := ACd_Usuario;
      Excluir();
    end;
  end;
end;

end.

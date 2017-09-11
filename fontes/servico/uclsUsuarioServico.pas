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
    destructor Destroy; override;

    function Listar() : TUsuarios;

    procedure Salvar(
      AId_Usuario : Integer;
      ANm_Usuario : String;
      ANm_Login : String;
      ACd_Senha : String;
      ACd_Papel : String;
      ATp_Bloqueio : Integer;
      ADt_Bloqueio : TDateTime);

    procedure Excluir(AId_Usuario : Integer);

  published
  end;

  function Instance : TcUsuarioServico;
  procedure Destroy;

implementation

uses
  mContexto;

var
  _instance : TcUsuarioServico;

  function Instance : TcUsuarioServico;
  begin
    if not Assigned(_instance) then
      _instance := TcUsuarioServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcUsuarioServico.Create(AOwner : TComponent);
begin
  inherited;

  fUsuario := TUsuario.Create(nil);
end;

destructor TcUsuarioServico.Destroy;
begin
  FreeAndNil(fUsuario);

  inherited;
end;

function TcUsuarioServico.Listar;
begin
  Result := mContexto.Instance.GetLista(TUsuario, '', TUsuarios) as TUsuarios;
end;

procedure TcUsuarioServico.Salvar;
begin
  with fUsuario do begin
    Id_Usuario := AId_Usuario;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Nm_Usuario := ANm_Usuario;
    Nm_Login := ANm_Login;
    Cd_Senha := ACd_Senha;
    Cd_Papel := ACd_Papel;
    Tp_Bloqueio := ATp_Bloqueio;
    Dt_Bloqueio := ADt_Bloqueio;
  end;

  mContexto.Instance.SetObjeto(fUsuario);
end;

procedure TcUsuarioServico.Excluir;
begin
  with fUsuario do begin
    if AId_Usuario <> 0 then begin
      Id_Usuario := AId_Usuario;
      mContexto.Instance.RemObjeto(fUsuario);
    end;
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

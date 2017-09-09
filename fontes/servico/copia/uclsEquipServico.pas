unit uclsEquipServico;

interface

uses
  Classes, SysUtils, StrUtils,
  uEquip;

type
  TcEquipServico = class(TComponent)
  private
    fEquip : TEquip;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function Listar() : TEquipList;

    function Consultar(ACd_Equip : String) : TEquip;

    procedure Salvar(
      ACd_Equip : String;
      ADs_Equip : String;
      ACd_Ambiente : String;
      ACd_Empresa : Integer;
      ACd_Terminal : Integer);

    procedure Excluir(ACd_Dnaequip : String);

  published
    property Equip : TEquip read fEquip write fEquip;
  end;

  function Instance : TcEquipServico;
  procedure Destroy;

implementation

uses
  mCollectionItem;

var
  _instance : TcEquipServico;

  function Instance : TcEquipServico;
  begin
    if not Assigned(_instance) then
      _instance := TcEquipServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcEquipServico.Create(AOwner : TComponent);
begin
  inherited;

  fEquip := TEquip.Create(nil);
end;

destructor TcEquipServico.Destroy;
begin
  FreeAndNil(fEquip);

  inherited;
end;

function TcEquipServico.Listar;
begin
  Result := TEquipList(fEquip.Listar(nil));
end;

function TcEquipServico.Consultar;
begin
  with fEquip do begin
    Limpar();
    if ACd_Equip <> '' then begin
      Cd_Equip := ACd_Equip;
      ConsultarAll(nil);
      Result := fEquip;
    end else begin
      Result := nil;
    end;
  end;
end;

procedure TcEquipServico.Salvar;
begin
  with fEquip do begin
    Cd_Dnaequip :=
      ACd_Equip + '#' +
      ACd_Ambiente + '#' +
      IntToStr(ACd_Empresa) + '#' +
      IntToStr(ACd_Terminal);

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Cd_Equip := ACd_Equip;
    Ds_Equip := ADs_Equip;
    Cd_Ambiente := ACd_Ambiente;
    Cd_Empresa := ACd_Empresa;
    Cd_Terminal := ACd_Terminal;

    Salvar();
  end;
end;

procedure TcEquipServico.Excluir;
begin
  with fEquip do begin
    Limpar();
    if ACd_Dnaequip <> '' then begin
      Cd_Dnaequip := ACd_Dnaequip;
      Excluir();
    end;
  end;
end;

initialization
  //Instance();

finalization
  Destroy();

end.

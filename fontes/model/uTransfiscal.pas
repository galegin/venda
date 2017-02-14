unit uTransfiscal;

(* classe modelagem *)

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem,
  uTransdfe;

type
  TTransfiscal = class;
  TTransfiscalClass = class of TTransfiscal;

  TTransfiscalList = class;
  TTransfiscalListClass = class of TTransfiscalList;

  TTransfiscal = class(TmCollectionItem)
  private
    fCd_Dnatrans: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Ambiente: Integer;
    fTp_Emissao: Integer;
    fTp_Modalidade: Integer;
    fTp_Operacao: Integer;
    fTp_Docfiscal: Integer;
    fNr_Docfiscal: Integer;
    fCd_Serie: String;
    fDh_Emissao: TDateTime;
    fDh_EntradaSaida: TDateTime;
    fDs_Chave: String;
    fDh_Recibo: TDateTime;
    fNr_Recibo: String;
    fTp_Processamento: String;

    fList_DFe: TTransdfeList;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Dnatrans: String read fCd_Dnatrans write fCd_Dnatrans;
    property U_Version: String read fU_Version write fU_Version;
    property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Ambiente: Integer read fTp_Ambiente write fTp_Ambiente;
    property Tp_Emissao: Integer read fTp_Emissao write fTp_Emissao;
    property Tp_Modalidade: Integer read fTp_Modalidade write fTp_Modalidade;
    property Tp_Operacao: Integer read fTp_Operacao write fTp_Operacao;
    property Tp_Docfiscal: Integer read fTp_Docfiscal write fTp_Docfiscal;
    property Nr_Docfiscal: Integer read fNr_Docfiscal write fNr_Docfiscal;
    property Cd_Serie: String read fCd_Serie write fCd_Serie;
    property Dh_Emissao: TDateTime read fDh_Emissao write fDh_Emissao;
    property Dh_EntradaSaida: TDateTime read fDh_EntradaSaida write fDh_EntradaSaida;
    property Ds_Chave: String read fDs_Chave write fDs_Chave;
    property Dh_Recibo: TDateTime read fDh_Recibo write fDh_Recibo;
    property Nr_Recibo: String read fNr_Recibo write fNr_Recibo;
    property Tp_Processamento: String read fTp_Processamento write fTp_Processamento;

    property List_DFe: TTransdfeList read fList_DFe write fList_DFe;
  end;

  TTransfiscalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransfiscal;
    procedure SetItem(Index: Integer; Value: TTransfiscal);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTransfiscal;
    property Items[Index: Integer]: TTransfiscal read GetItem write SetItem; default;
  end;

implementation

{ TTransfiscal }

constructor TTransfiscal.Create(ACollection: TCollection);
begin
  inherited;

  fList_DFe:= TTransdfeList.Create(nil);
  fList_DFe.IsUpdate := True;
end;

destructor TTransfiscal.Destroy;
begin

  inherited;
end;

{ TTransfiscalList }

constructor TTransfiscalList.Create(AOwner: TPersistent);
begin
  inherited Create(TTransfiscal);
end;

function TTransfiscalList.Add: TTransfiscal;
begin
  Result := TTransfiscal(inherited Add);
  Result.create(Self);
end;

function TTransfiscalList.GetItem(Index: Integer): TTransfiscal;
begin
  Result := TTransfiscal(inherited GetItem(Index));
end;

procedure TTransfiscalList.SetItem(Index: Integer; Value: TTransfiscal);
begin
  inherited SetItem(Index, Value);
end;

end.

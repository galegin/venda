unit uTransdfe;

 (* classe modelagem *)

 interface

 uses
   Classes, SysUtils,
   mCollection, mCollectionItem;

 type
   TTransdfe = class;
   TTransdfeClass = class of TTransdfe;

   TTransdfeList = class;
   TTransdfeListClass = class of TTransdfeList;

   TTransdfe = class(TmCollectionItem)
   private
     fCd_Dnatrans: String;
     fNr_Sequencia: Integer;
     fU_Version: String;
     fCd_Operador: Integer;
     fDt_Cadastro: TDateTime;
     fDs_Xml: String;
     fDs_RetornoXml: String;
   public
     constructor Create(ACollection: TCollection); override;
     destructor Destroy; override;
   published
     property Cd_Dnatrans: String read fCd_Dnatrans write fCd_Dnatrans;
     property Nr_Sequencia: Integer read fNr_Sequencia write fNr_Sequencia;
     property U_Version: String read fU_Version write fU_Version;
     property Cd_Operador: Integer read fCd_Operador write fCd_Operador;
     property Dt_Cadastro: TDateTime read fDt_Cadastro write fDt_Cadastro;
     property Ds_Xml: String read fDs_Xml write fDs_Xml;
     property Ds_RetornoXml: String read fDs_RetornoXml write fDs_RetornoXml;
   end;

   TTransdfeList = class(TmCollection)
   private
     function GetItem(Index: Integer): TTransdfe;
     procedure SetItem(Index: Integer; Value: TTransdfe);
   public
     constructor Create(AOwner: TPersistent);
     function Add: TTransdfe;
     property Items[Index: Integer]: TTransdfe read GetItem write SetItem; default;
   end;

 implementation

 { TTransdfe }

 constructor TTransdfe.Create(ACollection: TCollection);
 begin
   inherited;

 end;

 destructor TTransdfe.Destroy;
 begin

   inherited;
 end;

 { TTransdfeList }

 constructor TTransdfeList.Create(AOwner: TPersistent);
 begin
   inherited Create(TTransdfe);
 end;

 function TTransdfeList.Add: TTransdfe;
 begin
   Result := TTransdfe(inherited Add);
   Result.create(Self);
 end;

 function TTransdfeList.GetItem(Index: Integer): TTransdfe;
 begin
   Result := TTransdfe(inherited GetItem(Index));
 end;

 procedure TTransdfeList.SetItem(Index: Integer; Value: TTransdfe);
 begin
   inherited SetItem(Index, Value);
 end;

 end.

unit uclsTestar;

interface

uses
  Classes, SysUtils,
  mCollectionCmd, mCollectionSet, mContexto, mFilter,
  uTransacao;

type
  TcTestar = class
  public
    class procedure TestarComando();
  end;

implementation

{ TcTestar }

class procedure TcTestar.TestarComando;
var
  vContexto : TmContexto;
  vTransacao : TTransacao;
  vCollectionCmdList : TmCollectionCmdList;
  vCollectionSet : TmCollectionSet;
  vFilter : TList;
begin
  vContexto := TmContexto.Create(nil);

  vCollectionCmdList := TmCollectionCmdList.Create;
  vCollectionCmdList.Add(TmCollectionCmd.Create('Nr_Transacao', tpcCount));
  vCollectionCmdList.Add(TmCollectionCmd.Create('Nr_Transacao', tpcMax));
  vCollectionCmdList.Add(TmCollectionCmd.Create('Nr_Transacao', tpcMin));

  vTransacao := TTransacao.Create(nil);
  vTransacao.Dt_Transacao := Date;

  vFilter := TList.Create;
  vFilter.Add(TmFilter.Create('Dt_Transacao', tpfNaoNulo));
  vFilter.Add(TmFilter.CreateF('Nr_Transacao', 1, 999));

  vCollectionSet := TmCollectionSet.Create(vContexto, TTransacao);
  vCollectionSet.GetSelect(vTransacao, vCollectionCmdList, vFilter);
end;

initialization
  TcTestar.TestarComando;

end.

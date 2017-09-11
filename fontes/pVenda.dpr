program pVenda;

// mCreateEnt

uses
  Forms,
  Classes,
  //mForm in '..\..\_comps\view\mForm.pas' {mForm},
  //mFrame in '..\..\_comps\view\mFrame.pas' {mFrame},
  uAliqicms in 'model\uAliqicms.pas',
  uCaixa in 'model\uCaixa.pas',
    uCaixacont in 'model\uCaixacont.pas',
    uCaixamov in 'model\uCaixamov.pas',
    uTerminal in 'model\uTerminal.pas',
  uCfop in 'model\uCfop.pas',
  uEmpresa in 'model\uEmpresa.pas',
  uPais in 'model\uPais.pas',
    uEstado in 'model\uEstado.pas',
      uMunicipio in 'model\uMunicipio.pas',
  uHistrel in 'model\uHistrel.pas',
  uNcm in 'model\uNcm.pas',
  uNcmsubst in 'model\uNcmsubst.pas',
  uOperacao in 'model\uOperacao.pas',
  uPessoa in 'model\uPessoa.pas',
  uProduto in 'model\uProduto.pas',
  uRegrafiscal in 'model\uRegrafiscal.pas',
    uRegraimposto in 'model\uRegraimposto.pas',
  uTransacao in 'model\uTransacao.pas',
    uTransfiscal in 'model\uTransfiscal.pas',
      uTransdfe in 'model\uTransdfe.pas',
      uTranscont in 'model\uTranscont.pas',
      uTransinut in 'model\uTransinut.pas',
    uTranspagto in 'model\uTranspagto.pas',
    uTransitem in 'model\uTransitem.pas',
      uTransimposto in 'model\uTransimposto.pas',
  uUsuario in 'model\uUsuario.pas',
  uTipoDocumentoFiscal in 'tipagem\uTipoDocumentoFiscal.pas',
  uTipoImposto in 'tipagem\uTipoImposto.pas',
  uTipoImpressaoDanfe in 'tipagem\uTipoImpressaoDanfe.pas',
  uTipoModalidade in 'tipagem\uTipoModalidade.pas',
  uTipoOperacao in 'tipagem\uTipoOperacao.pas',
  uTipoPessoa in 'tipagem\uTipoPessoa.pas',
  uTipoProcessamento in 'tipagem\uTipoProcessamento.pas',
  uTipoRetornoSefaz in 'tipagem\uTipoRetornoSefaz.pas',
  uclsCaixaServico in 'servico\uclsCaixaServico.pas',
  uclsContingenciaServico in 'servico\uclsContingenciaServico.pas',
  uclsDFeServico in 'servico\uclsDFeServico.pas',
  uclsEmpresaServico in 'servico\uclsEmpresaServico.pas',
  uclsImpostoServico in 'servico\uclsImpostoServico.pas',
  uclsOperacaoServico in 'servico\uclsOperacaoServico.pas',
  uclsPagamentoServico in 'servico\uclsPagamentoServico.pas',
  uclsPessoaServico in 'servico\uclsPessoaServico.pas',
  uclsProdutoServico in 'servico\uclsProdutoServico.pas',
  uclsRegrafiscalServico in 'servico\uclsRegrafiscalServico.pas',
  uclsTefServico in 'servico\uclsTefServico.pas',
  uclsTransacaoServico in 'servico\uclsTransacaoServico.pas',
  uclsTransacaoTef in 'servico\uclsTransacaoTef.pas',
  uclsUsuarioServico in 'servico\uclsUsuarioServico.pas',
  ufrmVenda in 'view\ufrmVenda.pas' {F_Venda},
  ufrmPagto in 'view\ufrmPagto.pas' {F_Pagto},
  uclsTestar in 'view\uclsTestar.pas',
  ufrmTestar in 'view\ufrmTestar.pas' {F_Testar};

{$R *.res}

begin
  Application.Initialize;
  uclsContexto.Instance;
  //TF_Testar.Execute();
  TF_Venda.Execute();
  Application.Run;
end.

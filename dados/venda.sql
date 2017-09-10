/*
Created		09/09/2017
Modified		09/09/2017
Project		
Model		
Company		
Author		
Version		
Database		Firebird 
*/


Drop Table "TERMINAL";
Drop Table "TRANSCONT";
Drop Table "TRANSINUT";
Drop Table "USUARIO";
Drop Table "CAIXACONT";
Drop Table "CAIXAMOV";
Drop Table "OPERACAO";
Drop Table "NCMSUBST";
Drop Table "NCM";
Drop Table "EMPRESA";
Drop Table "CFOP";
Drop Table "ALIQICMS";
Drop Table "CAIXA";
Drop Table "HISTREL";
Drop Table "REGRAIMPOSTO";
Drop Table "REGRAFISCAL";
Drop Table "PAIS";
Drop Table "ESTADO";
Drop Table "MUNICIPIO";
Drop Table "PRODUTO";
Drop Table "PESSOA";
Drop Table "TRANSIMPOSTO";
Drop Table "TRANSPAGTO";
Drop Table "TRANSDFE";
Drop Table "TRANSFISCAL";
Drop Table "TRANSITEM";
Drop Table "TRANSACAO";


Create Table "TRANSACAO"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"ID_EMPRESA" Integer NOT NULL,
	"ID_PESSOA" Varchar(20) NOT NULL,
	"ID_OPERACAO" Varchar(20) NOT NULL,
	"DT_TRANSACAO" Date NOT NULL,
	"NR_TRANSACAO" Integer NOT NULL,
	"TP_SITUACAO" Integer NOT NULL,
	"DT_CANCELAMENTO" Timestamp,
 Primary Key ("ID_TRANSACAO")
);

Create Table "TRANSITEM"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"NR_ITEM" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"ID_PRODUTO" Varchar(40) NOT NULL,
	"CD_PRODUTO" Integer NOT NULL,
	"DS_PRODUTO" Varchar(60) NOT NULL,
	"CD_CFOP" Integer NOT NULL,
	"CD_ESPECIE" Varchar(10) NOT NULL,
	"CD_NCM" Varchar(8) NOT NULL,
	"QT_ITEM" Numeric(8,3) NOT NULL,
	"VL_CUSTO" Numeric(15,2) NOT NULL,
	"VL_UNITARIO" Numeric(15,2) NOT NULL,
	"VL_ITEM" Numeric(15,2) NOT NULL,
	"VL_VARIACAO" Numeric(15,2) NOT NULL,
	"VL_VARIACAOCAPA" Numeric(15,2) NOT NULL,
	"VL_FRETE" Numeric(15,2) NOT NULL,
	"VL_SEGURO" Numeric(15,2) NOT NULL,
	"VL_OUTRO" Numeric(15,2) NOT NULL,
	"VL_DESPESA" Numeric(15,2) NOT NULL,
 Primary Key ("ID_TRANSACAO","NR_ITEM")
);

Create Table "TRANSFISCAL"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"TP_OPERACAO" Integer NOT NULL,
	"TP_MODALIDADE" Integer NOT NULL,
	"TP_MODELONF" Integer NOT NULL,
	"CD_SERIE" Varchar(5) NOT NULL,
	"NR_NF" Integer NOT NULL,
	"TP_PROCESSAMENTO" Char(1) NOT NULL,
	"DS_CHAVEACESSO" Varchar(44),
	"DT_RECEBIMENTO" Timestamp,
	"NR_RECIBO" Varchar(20),
 Primary Key ("ID_TRANSACAO")
);

Create Table "TRANSDFE"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"NR_SEQUENCIA" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"TP_EVENTO" Integer NOT NULL,
	"TP_AMBIENTE" Integer NOT NULL,
	"TP_EMISSAO" Integer NOT NULL,
	"DS_ENVIOXML" blob sub_type 0 segment size 80 NOT NULL,
	"DS_RETORNOXML" blob sub_type 0 segment size 80,
 Primary Key ("ID_TRANSACAO","NR_SEQUENCIA")
);

Create Table "TRANSPAGTO"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"NR_SEQ" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"ID_CAIXA" Integer NOT NULL,
	"TP_DOCUMENTO" Integer NOT NULL,
	"ID_HISTREL" Integer NOT NULL,
	"NR_PARCELA" Integer NOT NULL,
	"NR_PARCELAS" Integer NOT NULL,
	"NR_DOCUMENTO" Integer,
	"VL_DOCUMENTO" Numeric(15,2) NOT NULL,
	"DT_VENCIMENTO" Date NOT NULL,
	"CD_AUTORIZACAO" Varchar(10),
	"NR_NSU" Integer,
	"DS_REDETEF" Varchar(20),
	"NM_OPERADORA" Varchar(20),
	"NR_BANCO" Integer,
	"NR_AGENCIA" Integer,
	"DS_CONTA" Varchar(10),
	"NR_CHEQUE" Integer,
	"DS_CMC7" Varchar(40),
	"TP_BAIXA" Integer,
	"CD_OPERBAIXA" Integer,
	"DT_BAIXA" Timestamp,
 Primary Key ("ID_TRANSACAO","NR_SEQ")
);

Create Table "TRANSIMPOSTO"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"NR_ITEM" Integer NOT NULL,
	"CD_IMPOSTO" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"PR_ALIQUOTA" Numeric(6,2) NOT NULL,
	"VL_BASECALCULO" Numeric(15,2) NOT NULL,
	"PR_BASECALCULO" Numeric(6,2) NOT NULL,
	"PR_REDBASECALCULO" Numeric(6,2) NOT NULL,
	"VL_IMPOSTO" Numeric(15,2) NOT NULL,
	"VL_OUTRO" Numeric(15,2) NOT NULL,
	"VL_ISENTO" Numeric(15,2) NOT NULL,
	"CD_CST" Varchar(5) NOT NULL,
	"CD_CSOSN" Varchar(5),
 Primary Key ("ID_TRANSACAO","NR_ITEM","CD_IMPOSTO")
);

Create Table "PESSOA"  (
	"ID_PESSOA" Varchar(20) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"CD_PESSOA" Integer NOT NULL,
	"NM_PESSOA" Varchar(60) NOT NULL,
	"NR_CPFCNPJ" Varchar(20) NOT NULL,
	"NR_RGIE" Varchar(20) NOT NULL,
	"NM_FANTASIA" Varchar(60),
	"CD_CEP" Integer NOT NULL,
	"NM_LOGRADOURO" Varchar(100) NOT NULL,
	"NR_LOGRADOURO" Varchar(10) NOT NULL,
	"DS_BAIRRO" Varchar(30) NOT NULL,
	"DS_COMPLEMENTO" Varchar(100),
	"CD_MUNICIPIO" Integer NOT NULL,
	"DS_MUNICIPIO" Varchar(60) NOT NULL,
	"CD_ESTADO" Integer NOT NULL,
	"DS_ESTADO" Varchar(30) NOT NULL,
	"DS_SIGLAESTADO" Char(2) NOT NULL,
	"CD_PAIS" Integer NOT NULL,
	"DS_PAIS" Varchar(30) NOT NULL,
	"DS_FONE" Varchar(20),
	"DS_CELULAR" Varchar(20),
	"DS_EMAIL" Varchar(40),
	"IN_CONSUMIDORFINAL" Char(1),
 Primary Key ("ID_PESSOA")
);

Create Table "PRODUTO"  (
	"ID_PRODUTO" Varchar(40) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTO" Timestamp NOT NULL,
	"CD_PRODUTO" Integer NOT NULL,
	"DS_PRODUTO" Varchar(60) NOT NULL,
	"CD_ESPECIE" Varchar(10) NOT NULL,
	"CD_NCM" Varchar(8) NOT NULL,
	"CD_CST" Varchar(5) NOT NULL,
	"CD_CSOSN" Varchar(5) NOT NULL,
	"PR_ALIQUOTA" Numeric(6,2) NOT NULL,
	"TP_PRODUCAO" Integer NOT NULL,
	"VL_CUSTO" Numeric(15,2) NOT NULL,
	"VL_VENDA" Numeric(15,2) NOT NULL,
	"VL_PROMOCAO" Numeric(15,2) NOT NULL,
 Primary Key ("ID_PRODUTO")
);

Create Table "MUNICIPIO"  (
	"ID_MUNICIPIO" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"CD_MUNICIPIO" Integer NOT NULL,
	"DS_MUNICIPIO" Varchar(40) NOT NULL,
	"DS_SIGLA" Varchar(5) NOT NULL,
	"ID_ESTADO" Integer NOT NULL,
 Primary Key ("ID_MUNICIPIO")
);

Create Table "ESTADO"  (
	"ID_ESTADO" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"CD_ESTADO" Integer NOT NULL,
	"DS_ESTADO" Varchar(40) NOT NULL,
	"DS_SIGLA" Varchar(5) NOT NULL,
	"ID_PAIS" Integer NOT NULL,
 Primary Key ("ID_ESTADO")
);

Create Table "PAIS"  (
	"ID_PAIS" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"CD_PAIS" Integer NOT NULL,
	"DS_PAIS" Varchar(40) NOT NULL,
	"DS_SIGLA" Varchar(5) NOT NULL,
 Primary Key ("ID_PAIS")
);

Create Table "REGRAFISCAL"  (
	"ID_REGRAFISCAL" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"DS_REGRAFISCAL" Varchar(60) NOT NULL,
	"IN_CALCIMPOSTO" Char(1) NOT NULL,
 Primary Key ("ID_REGRAFISCAL")
);

Create Table "REGRAIMPOSTO"  (
	"ID_REGRAFISCAL" Integer NOT NULL,
	"CD_IMPOSTO" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"PR_ALIQUOTA" Numeric(6,2) NOT NULL,
	"PR_BASECALCULO" Numeric(6,2) NOT NULL,
	"CD_CST" Varchar(5) NOT NULL,
	"CD_CSOSN" Varchar(5),
	"IN_ISENTO" Char(1) NOT NULL,
	"IN_OUTRO" Char(1) NOT NULL,
 Primary Key ("ID_REGRAFISCAL","CD_IMPOSTO")
);

Create Table "HISTREL"  (
	"ID_HISTREL" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"TP_DOCUMENTO" Integer NOT NULL,
	"CD_HISTREL" Integer NOT NULL,
	"DS_HISTREL" Varchar(20) NOT NULL,
	"NR_PARCELAS" Integer NOT NULL,
 Primary Key ("ID_HISTREL")
);

Create Table "CAIXA"  (
	"ID_CAIXA" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"ID_EMPRESA" Integer NOT NULL,
	"ID_TERMINAL" Integer NOT NULL,
	"DT_ABERTURA" Date NOT NULL,
	"VL_ABERTURA" Numeric(15,2) NOT NULL,
	"IN_FECHADO" Char(1) NOT NULL,
	"DT_FECHADO" Timestamp,
 Primary Key ("ID_CAIXA")
);

Create Table "ALIQICMS"  (
	"UF_ORIGEM" Varchar(2) NOT NULL,
	"UF_DESTINO" Varchar(2) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"PR_ALIQUOTA" Numeric(6,2) NOT NULL,
 Primary Key ("UF_ORIGEM","UF_DESTINO")
);

Create Table "CFOP"  (
	"CD_CFOP" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"DS_CFOP" Varchar(60) NOT NULL,
 Primary Key ("CD_CFOP")
);

Create Table "EMPRESA"  (
	"ID_EMPRESA" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"ID_PESSOA" Varchar(20) NOT NULL,
 Primary Key ("ID_EMPRESA")
);

Create Table "NCM"  (
	"CD_NCM" Varchar(10) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"DS_NCM" Char(60) NOT NULL,
 Primary Key ("CD_NCM")
);

Create Table "NCMSUBST"  (
	"UF_ORIGEM" Varchar(2) NOT NULL,
	"UF_DESTINO" Varchar(2) NOT NULL,
	"CD_NCM" Varchar(8) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer,
	"DT_CADASTRO" Timestamp,
	"CD_CEST" Varchar(10),
 Primary Key ("UF_ORIGEM","UF_DESTINO","CD_NCM")
);

Create Table "OPERACAO"  (
	"ID_OPERACAO" Varchar(20) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer,
	"DT_CADASTRO" Timestamp,
	"DS_OPERACAO" Varchar(60),
	"TP_MODELONF" Integer,
	"TP_MODALIDADE" Integer,
	"TP_OPERACAO" Integer,
	"CD_SERIE" Varchar(5),
	"CD_CFOP" Integer,
	"ID_REGRAFISCAL" Integer NOT NULL,
 Primary Key ("ID_OPERACAO")
);

Create Table "CAIXAMOV"  (
	"ID_CAIXA" Integer NOT NULL,
	"NR_SEQ" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"TP_LANCTO" Integer NOT NULL,
	"VL_LANCTO" Numeric(15,2) NOT NULL,
	"NR_DOC" Integer NOT NULL,
	"DS_AUX" Varchar(30) NOT NULL,
 Primary Key ("ID_CAIXA","NR_SEQ")
);

Create Table "CAIXACONT"  (
	"ID_CAIXA" Integer NOT NULL,
	"ID_HISTREL" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"VL_CONTADO" Numeric(15,2) NOT NULL,
	"VL_SISTEMA" Numeric(15,2) NOT NULL,
	"VL_RETIRADA" Numeric(15,2) NOT NULL,
	"VL_SUPRIMENTO" Numeric(15,2) NOT NULL,
	"VL_DIFERENCA" Numeric(15,2) NOT NULL,
 Primary Key ("ID_CAIXA","ID_HISTREL")
);

Create Table "USUARIO"  (
	"ID_USUARIO" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"NM_USUARIO" Varchar(60) NOT NULL,
	"NM_LOGIN" Varchar(20) NOT NULL,
	"CD_SENHA" Varchar(60) NOT NULL,
	"CD_PAPEL" Varchar(20),
	"TP_BLOQUEIO" Integer NOT NULL,
	"DT_BLOQUEIO" Timestamp,
 Primary Key ("ID_USUARIO")
);

Create Table "TRANSINUT"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"DT_EMISSAO" Date NOT NULL,
	"TP_MODELONF" Integer NOT NULL,
	"CD_SERIE" Varchar(4) NOT NULL,
	"NR_NF" Integer NOT NULL,
	"DT_RECEBIMENTO" Timestamp,
	"NR_RECIBO" Varchar(20),
 Primary Key ("ID_TRANSACAO")
);

Create Table "TRANSCONT"  (
	"ID_TRANSACAO" Varchar(20) NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"TP_SITUACAO" Integer NOT NULL,
	"CD_TERMINAL" Integer NOT NULL,
 Primary Key ("ID_TRANSACAO")
);

Create Table "TERMINAL"  (
	"ID_TERMINAL" Integer NOT NULL,
	"U_VERSION" Char(1),
	"CD_OPERADOR" Integer NOT NULL,
	"DT_CADASTRO" Timestamp NOT NULL,
	"CD_TERMINAL" Integer NOT NULL,
	"DS_TERMINAL" Varchar(30) NOT NULL,
 Primary Key ("ID_TERMINAL")
);


Alter Table "TRANSITEM" add Foreign Key ("ID_TRANSACAO") references "TRANSACAO" ("ID_TRANSACAO") on update no action on delete no action ;
Alter Table "TRANSFISCAL" add Foreign Key ("ID_TRANSACAO") references "TRANSACAO" ("ID_TRANSACAO") on update no action on delete no action ;
Alter Table "TRANSPAGTO" add Foreign Key ("ID_TRANSACAO") references "TRANSACAO" ("ID_TRANSACAO") on update no action on delete no action ;
Alter Table "TRANSIMPOSTO" add Foreign Key ("ID_TRANSACAO","NR_ITEM") references "TRANSITEM" ("ID_TRANSACAO","NR_ITEM") on update no action on delete no action ;
Alter Table "TRANSDFE" add Foreign Key ("ID_TRANSACAO") references "TRANSFISCAL" ("ID_TRANSACAO") on update no action on delete no action ;
Alter Table "TRANSCONT" add Foreign Key ("ID_TRANSACAO") references "TRANSFISCAL" ("ID_TRANSACAO") on update no action on delete no action ;
Alter Table "TRANSINUT" add Foreign Key ("ID_TRANSACAO") references "TRANSFISCAL" ("ID_TRANSACAO") on update no action on delete no action ;
Alter Table "TRANSACAO" add Foreign Key ("ID_PESSOA") references "PESSOA" ("ID_PESSOA") on update no action on delete no action ;
Alter Table "EMPRESA" add Foreign Key ("ID_PESSOA") references "PESSOA" ("ID_PESSOA") on update no action on delete no action ;
Alter Table "TRANSITEM" add Foreign Key ("ID_PRODUTO") references "PRODUTO" ("ID_PRODUTO") on update no action on delete no action ;
Alter Table "MUNICIPIO" add Foreign Key ("ID_ESTADO") references "ESTADO" ("ID_ESTADO") on update no action on delete no action ;
Alter Table "ESTADO" add Foreign Key ("ID_PAIS") references "PAIS" ("ID_PAIS") on update no action on delete no action ;
Alter Table "REGRAIMPOSTO" add Foreign Key ("ID_REGRAFISCAL") references "REGRAFISCAL" ("ID_REGRAFISCAL") on update no action on delete no action ;
Alter Table "OPERACAO" add Foreign Key ("ID_REGRAFISCAL") references "REGRAFISCAL" ("ID_REGRAFISCAL") on update no action on delete no action ;
Alter Table "TRANSPAGTO" add Foreign Key ("ID_HISTREL") references "HISTREL" ("ID_HISTREL") on update no action on delete no action ;
Alter Table "CAIXACONT" add Foreign Key ("ID_HISTREL") references "HISTREL" ("ID_HISTREL") on update no action on delete no action ;
Alter Table "TRANSPAGTO" add Foreign Key ("ID_CAIXA") references "CAIXA" ("ID_CAIXA") on update no action on delete no action ;
Alter Table "CAIXACONT" add Foreign Key ("ID_CAIXA") references "CAIXA" ("ID_CAIXA") on update no action on delete no action ;
Alter Table "CAIXAMOV" add Foreign Key ("ID_CAIXA") references "CAIXA" ("ID_CAIXA") on update no action on delete no action ;
Alter Table "TRANSACAO" add Foreign Key ("ID_EMPRESA") references "EMPRESA" ("ID_EMPRESA") on update no action on delete no action ;
Alter Table "CAIXA" add Foreign Key ("ID_EMPRESA") references "EMPRESA" ("ID_EMPRESA") on update no action on delete no action ;
Alter Table "TRANSACAO" add Foreign Key ("ID_OPERACAO") references "OPERACAO" ("ID_OPERACAO") on update no action on delete no action ;
Alter Table "CAIXA" add Foreign Key ("ID_TERMINAL") references "TERMINAL" ("ID_TERMINAL") on update no action on delete no action ;


Create Exception "except_del_p" 'Children still exist in child table. Cannot delete parent.';
Create Exception "except_ins_ch" 'Parent does not exist. Cannot create child.';
Create Exception "except_upd_ch" 'Parent does not exist. Cannot update child.';
Create Exception "except_upd_p" 'Children still exist in child table. Cannot update parent.';
Create Exception "except_ins_ch_card" 'Maximum cardinality exceeded. Cannot insert into child.';
Create Exception "except_upd_ch_card" 'Maximum cardinality exceeded. Cannot update child.';


set term ^;


set term ;^


/* Roles permissions */


/* Users permissions */



DROP TABLE usuario;
DROP TABLE jogadores;
DROP TABLE desenvolvedores;
DROP TABLE jogos;
DROP TABLE convidados;
DROP TABLE guildas;
DROP TABLE planos;
DROP TABLE desconto;

DROP TABLE jogar;
DROP TABLE desenvolve;
DROP TABLE contrata;


CREATE TABLE usuarios(
    CPF NUMBER(11),
    email VARCHAR2(20),
    nome VARCHAR2(30),
    COD_PL NUMBER(5),
    CONSTRAINT cpf_PK PRIMARY KEY (CPF),
    CONSTRAINT cod_pl_fk FOREIGN KEY REFERENCES planos
);

CREATE TABLE jogadores(
    USR NUMBER(11),
    nickname VARCHAR2(20),
    data_criacao DATE,
    ranking NUMBER(3),
    GLD NUMBER(5),
    CONSTRAINT jogadores_pk PRIMARY KEY(USR),
    CONSTRAINT usr_cpf_fk FOREIGN KEY REFERENCES usuario(CPF),
    CONSTRAINT gld_fk FOREIGN KEY REFERENCES guildas
);
CREATE TABLE desenvolvedores(
    USR NUMBER(11),
    especializacao VARCHAR2(20),
    ultimo_jogo_lanc VARCHAR2(20),
    comissao NUMBER(5),
    DEV_SUP NUMBER(11),
    CONSTRAINT dev_pk PRIMARY KEY(USR),
    CONSTRAINT usr_cpf_fk FOREIGN KEY REFERENCES usuario(CPF),
    CONSTRAINT dev_sup_fk FOREIGN KEY REFERENCES desenvolvedores(USR)
);
CREATE TABLE jogos(
    codigo NUMBER(5),
    nome VARCHAR2(20),
    descricao VARCHAR2(50),
    CONSTRAINT cod_pk PRIMARY KEY(codigo) 
);
CREATE TABLE convidados(
    JDRS NUMBER(11) UNIQUE,
    nickname VARCHAR2(20),
    cpf NUMBER(11) UNIQUE,
    nome VARCHAR2(30),
    email VARCHAR2(20),
    CONSTRAINT convidados PRIMARY KEY(cpf),
    CONSTRAINT jdrs_fk FOREIGN KEY jogadores(USR)

);
CREATE TABLE guildas(
    id NUMBER(5),
    nome VARCHAR2(15),
    descricao VARCHAR2(50)
    CONSTRAINT guildas_pk PRIMARY KEY(id)
);
CREATE TABLE planos(
    codigo NUMBER(3),
    preco NUMBER(5) NOT NULL,
    nome VARCHAR2(20) NOT NULL
    CONSTRAINT planos_pk PRIMARY KEY(codigo)
);
CREATE TABLE desconto(
    codigo NUMBER(3),
    data_validade DATE,
    porcentagem NUMBER(3)
    CONSTRAINT cod_pk PRIMARY KEY(codigo)
);

CREATE TABLE jogar(
    JGRS NUMBER(11),
    JGO NUMBER(5),
    CONV NUMBER(11) NOT NULL,
    date_time DATE,
    CONSTRAINT jgr_pk PRIMARY KEY (JGRS, JGO)
    CONSTRAINT jgrs_fk FOREIGN KEY jogadores(USR),
    CONSTRAINT jgo_fk FOREIGN KEY jogos(codigo),
    CONSTRAINT conv_fk FOREIGN KEY convidados(CPF)
);
CREATE TABLE desenvolve(
    DEV NUMBER(11),
    JGO NUMBER(5),
    CONSTRAINT desvolv_pk PRIMARY KEY(DEV, JGO),
    CONSTRAINT dev_fk FOREIGN KEY desenvolvedores(USR),
    CONSTRAINT jgo_fk FOREIGN KEY jogos(codigo)
);
CREATE TABLE contrata(
    USR NUMBER(11),
    COD_PL NUMBER(3),
    codigo_desconto NUMBER(5),
    CONSTRAINT contrata_pk PRIMARY KEY(USR, COD_PL),
    CONSTRAINT USR FOREIGN KEY usuario(CPF),
    CONSTRAINT COD_PL FOREIGN KEY plano(codigo)
);
--eliminar tabelas, se existentes
DROP TABLE condutores               CASCADE CONSTRAINTS purge;
DROP TABLE veiculos_condutores      CASCADE CONSTRAINTS purge;
DROP TABLE veiculos                 CASCADE CONSTRAINTS purge;
DROP TABLE viagens                  CASCADE CONSTRAINTS purge;
DROP TABLE pedidos_viagens          CASCADE CONSTRAINTS purge;
DROP TABLE servicos                 CASCADE CONSTRAINTS purge;
DROP TABLE custos_servicos          CASCADE CONSTRAINTS purge;
DROP TABLE itinerarios_viagens      CASCADE CONSTRAINTS purge;
DROP TABLE pontos_turisticos        CASCADE CONSTRAINTS purge;
DROP TABLE resumosveiculos        CASCADE CONSTRAINTS purge;

--## tabela condutores ##
CREATE TABLE condutores (
    nr_idCivil                      INTEGER         CONSTRAINT pk_condutores_nr_idCivil                             PRIMARY KEY
                                                    CONSTRAINT ck_condutores_nr_idCivil                             CHECK(REGEXP_LIKE(nr_idCivil, '^\d{9}$')),
    nr_idCivil_supervisor           INTEGER         CONSTRAINT ck_condutores_nr_idCivil_supervisor                  CHECK(REGEXP_LIKE(nr_idCivil_supervisor, '^\d{9}$')),
    nome                            VARCHAR(40)     CONSTRAINT nn_condutores_nome                                   NOT NULL,
    data_nascimento                DATE            CONSTRAINT nn_condutores_data_nascimento                        NOT NULL,
    nr_carta_conducao               VARCHAR(11)         CONSTRAINT uk_nr_carta_conducao                                 UNIQUE,
    data_validade_carta_conducao    DATE            CONSTRAINT nn_condutores_data_validade_carta_conducao           NOT NULL
);

--## tabela veiculos_condutores ##
CREATE TABLE veiculos_condutores (
    matricula         CHAR(8),
    nr_idCivil        INTEGER,
    data_inicio       DATE          CONSTRAINT nn_veiculos_condutores_data_inicio            PRIMARY KEY,
    data_fim          DATE          CONSTRAINT nn_veiculos_condutores_data_fim               NOT NULL
);
    
--## tabela veiculos ##    
CREATE TABLE veiculos (
    matricula       CHAR(8)         CONSTRAINT pk_automoveis_matricula      PRIMARY KEY,
    marca           VARCHAR(40)     CONSTRAINT nn_automoveis_marca          NOT NULL,
    modelo          VARCHAR(40)     CONSTRAINT nn_automoveis_modelo         NOT NULL,
    nr_chassis      INTEGER         CONSTRAINT uk_veiculos_nr_chassis       UNIQUE,
    data_matricula  DATE            CONSTRAINT nn_veiculos_data_matricula   NOT NULL,
    
    CHECK(REGEXP_LIKE(matricula, '[A-Z]{2}-[0-9]{2}-[0-9]{2}|[0-9]{2}-[A-Z]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}'))
);
    
--## tabela viagens ##
CREATE TABLE viagens (
    cod_viagem                      INTEGER         CONSTRAINT pk_viagens_cod_viagem                        PRIMARY KEY,
    cod_pedido                      INTEGER         CONSTRAINT uk_viagens_cod_pedido                        UNIQUE,
    atraso_passageiro_minutos       INTEGER         CONSTRAINT nn_viagens_atraso_passageiro_minutos         NOT NULL,
    duracao_minutos                 INTEGER         CONSTRAINT nn_viagens_duracao_minutos                   NOT NULL
);
    
--## tabela pedidos_viagens ##
CREATE TABLE pedidos_viagens (
    cod_pedido                          INTEGER                               CONSTRAINT pk_pedidos_viagens_cod_pedido                      PRIMARY KEY,
    matricula                           CHAR(8),
    nr_idCivil                          INTEGER,
    data_inicio                         DATE,
    cod_servico                         INTEGER,
    data_hora_pedido                    TIMESTAMP                             CONSTRAINT nn_pedidos_viagens_data_hora_pedido                NOT NULL,
                                                                              CONSTRAINT ck_pedidos_viagens_data_hora_pedido                CHECK(data_hora_pedido < data_hora_recolha_passageiro),
    data_hora_recolha_passageiro        TIMESTAMP                             CONSTRAINT nn_pedidos_viagens_data_hora_recolha_passageiro    NOT NULL,
    distancia_km                        INTEGER                               CONSTRAINT nn_pedidos_viagens_distancia_km                    NOT NULL,
    cancelado                           CHAR                                  DEFAULT 'N'
                                                                              CONSTRAINT nn_pedidos_viagens_cancelado                       NOT NULL,
                                                                              CONSTRAINT ck_pedidos_viagens_cancelado                       CHECK(REGEXP_LIKE(cancelado, 'S|N', 'i')),
                                                                              
    CONSTRAINT ck_pedidos_viagens_distancia_km                    CHECK (distancia_km > 0)                                                                   
);    
    
--## tabela servicos ##
CREATE TABLE servicos (
    cod_servico     INTEGER                             CONSTRAINT pk_servicos_cod_servico       PRIMARY KEY,
    descricao       VARCHAR(40)                         CONSTRAINT nn_servicos_descricao         NOT NULL,
   
    
    
    CONSTRAINT ck_servicos_descricao            CHECK(REGEXP_LIKE(descricao, '^(Casual|Eco|Luxo|Grupo)$'))
);
    
--## tabela itinerarios_viagens ##
CREATE TABLE itinerarios_viagens(
    cod_viagem              INTEGER,
    cod_ponto_turistico     INTEGER,
    hora_passagem           TIMESTAMP       CONSTRAINT nn_itinerarios_viagens_hora_passagem         NOT NULL
);
    
--## tabela pontos_turisticos ##
CREATE TABLE pontos_turisticos (
    cod_ponto_turistico        INTEGER                              CONSTRAINT pk_pontos_turisticos_cod_ponto_turistico         PRIMARY KEY,
    nome_ponto_turistico       VARCHAR(40)                          CONSTRAINT nn_pontos_turisticos_nome_ponto_turistico        NOT NULL,
    tipo_ponto_turistico       VARCHAR(2)                           CONSTRAINT nn_pontos_turisticos_tipo_ponto_turistico        NOT NULL,
    
    CONSTRAINT ck_pontos_turisticos_tipo_ponto_turistico            CHECK(REGEXP_LIKE(tipo_ponto_turistico, '^(M|MU|PN|MI)$'))
);

--## tabela custos_servicos ##
CREATE TABLE custos_servicos (

    cod_servico                         INTEGER,
    data_ultima_atualizacao             DATE                                        CONSTRAINT nn_data_ultima_atualizacao                           NOT NULL,
    data_inicio_custo                   NUMERIC(6,2)                                 CONSTRAINT pk_custos_servicos_data_inicio_custo                 PRIMARY KEY,
    data_fim_custo                      NUMERIC(6,2)                                 CONSTRAINT nn_custos_servicos_data_fim_custo                    NULL,
    preco_base                          NUMERIC(6,2)                                 CONSTRAINT nn_custo_servicos_preco_base                         NOT NULL,
    custo_minuto                        NUMERIC(6,2)                                 CONSTRAINT nn_custo_servicos_custo_minuto                       NOT NULL,
    custo_km                            NUMERIC(6,2)                                 CONSTRAINT nn_custo_servicos_custo_km                           NOT NULL,
    taxa_iva                            NUMERIC(6,2)                                 CONSTRAINT nn_custo_servicos_taxa_iva                           NOT NULL,
    tempo_maximo_espera_minutos         INTEGER                                      CONSTRAINT nn_custo_servicos_tempo_maximo_espera_minutos        NOT NULL,
    custo_espera_minuto                 NUMERIC(6,2)                                 CONSTRAINT nn_custo_servicos_custo_espera_minuto                NOT NULL,
    custo_cancelamento_pedido           NUMERIC(6,2)                                 CONSTRAINT nn_custo_servicos_custo_cancelamento_pedido          NOT NULL
    
);  

CREATE TABLE ResumosVeiculos (
    instante            TIMESTAMP           CONSTRAINT nn_resumos_veiculos_instante NOT NULL,
    data_inicio         DATE                CONSTRAINT nn_resumos_veiculos_data_inicio NOT NULL,
    data_fim            DATE                CONSTRAINT nn_resumos_veiculos_data_fim NOT NULL,
    matricula           VARCHAR2(8)         CONSTRAINT nn_resumos_veiculos_matricula NOT NULL,
    nr_viagens          INTEGER             CONSTRAINT ck_resumos_veiculos_nr_viagens CHECK ( nr_viagens > 0 ),
    soma_km             INTEGER             CONSTRAINT ck_resumos_veiculos_soma_km CHECK ( soma_km > 0 ),
    soma_duracao        INTEGER             CONSTRAINT ck_resumos_veiculos_soma_duracao CHECK ( soma_duracao > 0 ),
                                            CONSTRAINT ck_resumos_veiculos_data_fim CHECK ( data_fim > data_inicio ) ,
                                            CONSTRAINT pk_resumos_veiculos_data_inicio_data_fim_matricula PRIMARY KEY (matricula, data_inicio, data_fim )
);

ALTER TABLE condutores              ADD CONSTRAINT fk_condutores_nr_idCivil_supervisor              FOREIGN KEY (nr_idCivil_supervisor)     REFERENCES condutores (nr_idCivil);
ALTER TABLE veiculos_condutores     ADD CONSTRAINT fk_veiculos_condutores_matricula                 FOREIGN KEY (matricula)                 REFERENCES veiculos (matricula);
ALTER TABLE veiculos_condutores     ADD CONSTRAINT fk_veiculos_condutores_nr_idCivil                FOREIGN KEY (nr_idCivil)                REFERENCES condutores (nr_idCivil);
ALTER TABLE viagens                 ADD CONSTRAINT fk_viagens_cod_pedido                            FOREIGN KEY (cod_pedido)                REFERENCES pedidos_viagens (cod_pedido);
ALTER TABLE pedidos_viagens         ADD CONSTRAINT fk_pedidos_viagens_matricula                     FOREIGN KEY (matricula)                 REFERENCES veiculos (matricula);
ALTER TABLE pedidos_viagens         ADD CONSTRAINT fk_pedidos_nr_idCivil                            FOREIGN KEY (nr_idCivil)                REFERENCES condutores (nr_idCivil);    
ALTER TABLE pedidos_viagens         ADD CONSTRAINT fk_pedidos_data_inicio                           FOREIGN KEY (data_inicio)               REFERENCES veiculos_condutores (data_inicio); 
ALTER TABLE pedidos_viagens         ADD CONSTRAINT fk_pedidos_cod_servico                           FOREIGN KEY (cod_servico)               REFERENCES servicos (cod_servico);
ALTER TABLE itinerarios_viagens     ADD CONSTRAINT fk_itinerarios_viagens_cod_viagem                FOREIGN KEY (cod_viagem)                REFERENCES  viagens (cod_viagem);
ALTER TABLE itinerarios_viagens     ADD CONSTRAINT fk_itinerarios_viagens_cod_ponto_turistico       FOREIGN KEY (cod_ponto_turistico)       REFERENCES pontos_turisticos (cod_ponto_turistico);
ALTER TABLE custos_servicos         ADD CONSTRAINT fk_custo_servicos_cod_servico                    FOREIGN KEY (cod_servico)               REFERENCES servicos (cod_servico)

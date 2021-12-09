-- elimina tabelas, se existentes
DROP TABLE Recibo_mes                   CASCADE CONSTRAINTS purge;
DROP TABLE Condutores                   CASCADE CONSTRAINTS purge;
DROP TABLE Carta_conducao               CASCADE CONSTRAINTS purge;
DROP TABLE Servico                      CASCADE CONSTRAINTS purge;
DROP TABLE Custos_Servicos              CASCADE CONSTRAINTS purge;
DROP TABLE Recibo_viagem                CASCADE CONSTRAINTS purge;
DROP TABLE Veiculos                     CASCADE CONSTRAINTS purge;
DROP TABLE Pedidos_Viagens              CASCADE CONSTRAINTS purge;
DROP TABLE Veiculos_Condutores          CASCADE CONSTRAINTS purge;
DROP TABLE Tipo_servico                 CASCADE CONSTRAINTS purge;
DROP TABLE Percentagem_condutor         CASCADE CONSTRAINTS purge;
DROP TABLE Veiculo_chassis              CASCADE CONSTRAINTS purge;
DROP TABLE Chassis                      CASCADE CONSTRAINTS purge;
DROP TABLE Modelo_veiculo               CASCADE CONSTRAINTS purge;
DROP TABLE Viagens                      CASCADE CONSTRAINTS purge;
DROP TABLE Login                        CASCADE CONSTRAINTS purge;
DROP TABLE Login_cliente                CASCADE CONSTRAINTS purge;
DROP TABLE Cliente                      CASCADE CONSTRAINTS purge;
DROP TABLE Itenerarios_Viagens          CASCADE CONSTRAINTS purge;
DROP TABLE Ponto_Turistico              CASCADE CONSTRAINTS purge;
DROP TABLE Tipo_ponto_turistico         CASCADE CONSTRAINTS purge;
DROP TABLE Fatura                       CASCADE CONSTRAINTS purge;

create table Veiculos_Condutores (
    matricula                               char(8), 
    nr_idCivil_condutor                     number(8), 
    data_inicio                             date                constraint pk_veiculos_condutores_data_inicio                          primary key, 
    data_fim                                date                constraint nn_veiculos_condutores_data_fim                             not null
);

create table Condutores (
    nr_idCivil_condutor                     number(8)           constraint pk_condutores_nr_idCivil                                    primary key
                                                                constraint ck_condutores_nr_idCivil                                    check(regexp_like(nr_idCivil_condutor, '^\d{8}$')),
    nr_idCivil_supervisor                   number(8)           constraint n_condutores_nr_idCivil_supervisor                          null
                                                                constraint ck_condutores_nr_idCivil_supervisor                         check(regexp_like(nr_idCivil_supervisor, '^\d{8}$')),
    nr_cartaConducao                        number(8), 
    nome                                    varchar2(40)        constraint nn_condutores_nome                                          not null, 
    data_nascimento                         date                constraint nn_condutores_data_nascimento                               not null, 
    nr_contribuinte                         number(9)           constraint nn_condutores_nr_contribuinte                               not null, 
    morada                                  varchar2(60)        constraint nn_condutores_morada                                        not null
);

create table Carta_Conducao (
    nr_cartaConducao                        number(8)           constraint pk_carta_conducao_nr_carta_conducao                         primary key, 
    data_validade_cartaConducao             date                constraint nn_carta_conducao_data_validade_cartaConducao               not null
);

create table Veiculos (
    matricula                               char(8)             constraint pk_veiculos_matricula                                       primary key, 
    data_matricula                          date                constraint nn_veiculos_data_matricula                                  not null, 
    kms_percorridos                         float(10)           constraint nn_veiculos_kms_percorridos                                 not null, 
    kms_semanais                            float(10)           constraint nn_veiculos_kms_semanais                                    not null,
    
    check(regexp_like(matricula, '[A-Z]{2}-[0-9]{2}-[0-9]{2}|[0-9]{2}-[A-Z]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}'))
);

create table Veiculo_Chassis (
    matricula                               char(8), 
    nr_chassis                              varchar2(20)
);

create table Chassis (
    nr_chassis                              varchar2(20)        constraint pk_chassis_nr_chassis                                       primary key, 
    modelo                                  varchar2(10)
);

create table Modelo_Veiculo (
    modelo                                  varchar2(10)        constraint pk_modelo_veiculo_modelo                                    primary key, 
    marca                                   varchar2(10)        constraint nn_modelo_veiculo_marca                                     not null
);

create table Recibo_Mes (
    nr_recibo_mes                           number(10)          constraint pk_recibo_mes_nr_recibo_mes                                 primary key, 
    nr_idCivil_condutor                     number(8), 
    valor_total_comissoes                   float(10)           constraint nn_recibo_mes_valor_total_comissoes                         not null, 
    data_emissao                            date                constraint nn_recibo_mes_data_emissao                                  not null
);

create table Recibo_Viagem (
    nr_recibo                               number(10)          constraint pk_recibo_viagem_nr_recibo                                  primary key, 
    nr_recibo_mes                           number(10), 
    cod_tipo_servico                        number(10), 
    cod_viagem                              number(10), 
    nr_idCivil_Condutor                     number(8), 
    percentagem_viagem                      number(3, 2), 
    comissao_tipo_servico                   float(10)           constraint nn_recibo_viagem_comissao_tipo_servico                      not null
);

create table Viagens (
    cod_viagem                              number(10)          constraint pk_viagens_cod_viagens                                      primary key, 
    cod_pedido                              number(10), 
    duracao_minutos                         timestamp(9)        constraint nn_viagens_duracao_minutos                                  not null, 
    atraso_passageiros_minutos              timestamp(1)        constraint nn_viagens_atraso_passageiros_minutos                       not null,   
    local_inicio                            varchar2(40)        constraint nn_viagens_local_inicio                                     not null
);

create table Pedidos_Viagens (
    cod_pedido                              number(10)          constraint pk_pedidos_viagens_cod_pedido                               primary key, 
    matricula                               char(8), 
    nr_idCivil_condutor                     number(8), 
    data_inicio                             date, 
    cod_servico                             number(10), 
    login                                   varchar2(20),
    data_hora_pedido                        Date, 
    data_hora_recolha_passageiro            Date, 
    distancia_km                            number(10), 
    estimativa_duracao                      number(10) 
);

create table Servico (
    cod_servico                             number(10)          constraint pk_servico_cod_servico                                      primary key, 
    cod_tipo_servico                        number(10)
);

create table Tipo_Servico (
    cod_tipo_servico                        number(10)          constraint pk_tipo_servico_cod_tipo_servico                            primary key, 
    descricao                               varchar2(30)        constraint nn_tipo_servico_descricao                                   not null, 
    custo_cancelamento                      float(5)            constraint nn_tipo_servico_custo_cancelamento                          not null, 
    percentagem_comissao_supervisor         number(3, 2)        constraint nn_tipo_servico_percentagem_comissao_supervisor             not null,
    
    constraint ck_tipo_servico_descricao            check(regexp_like(descricao, '^(Casual|Eco|Luxo|Grupo)$'))
);

create table Percentagem_Condutor (
    percentagem_comissao_condutor           number(3, 2)        constraint pk_percentagem_condutor_percentagem_comissao_condutor       primary key, 
    cod_tipo_servico                        number(10)
);

create table Login (
    login                                   varchar2(20)        constraint pk_login_login                                              primary key, 
    passwordCliente                                varchar2(20)        constraint nn_login_password                                           not null
);

create table Cliente (
    nr_idCivil_cliente                      number(8)           constraint pk_cliente_nr_idCivil_cliente                               primary key, 
    nr_contribuinte_cliente                 number(9)           constraint nn_cliente_nr_constribuinte_cliente                         not null, 
    data_nascimento_cliente                 date                constraint nn_cliente_data_nascimento_cliente                          not null, 
    nome_cliente                            varchar2(30)        constraint nn_cliente_nome_cliente                                     not null, 
    morada_cliente                          varchar2(30)        constraint nn_cliente_morada_cliente                                   not null
);

create table Login_Cliente (
    login                                   varchar2(20), 
    nr_idCivil_Cliente                      number(8)
);

create table Fatura (
    id_fatura                               number(10)          constraint pk_fatura_id_fatura                                         primary key, 
    cod_pedido                              number(10), 
    custo_viagem                            float(10)           constraint nn_fatura_custo_viagem                                      not null, 
    data_emissao                            date                constraint nn_fatura_data_emissao                                      not null, 
    nr_idCivil_Cliente                      number(8)
);

create table Custos_Servicos (
    data_inicio_custo                       date                constraint pk_custos_servicos_data_inicio_custo                        primary key, 
    cod_servico                             number(10), 
    data_fim_custo                          date                constraint nn_custos_servicos_data_fim_custo                           not null, 
    preco_base                              float(10)           constraint nn_custos_servicos_preco_base                               not null, 
    custo_minuto                            float(10)           constraint nn_custos_servicos_custo_minuto                             not null, 
    custo_km                                float(10)           constraint nn_custos_servicos_custo_km                                 not null, 
    tempo_maximo_espera_minutos             timestamp(5)        constraint nn_custos_servicos_tempo_maximo_espera_minutos              not null, 
    custo_espera_minutos                    float(10)           constraint nn_custos_servicos_custo_espera_minutos                     not null, 
    taxa_iva                                number(3, 2)        constraint nn_custos_servicos_taxa_iva                                 not null
);

create table Tipo_Ponto_Turistico (
    cod_tipo_ponto_turistico                char(2)             constraint pk_tipo_ponto_turistico_cod_tipo_ponto_turistico            primary key
);

create table Ponto_Turistico (
    cod_ponto_turistico                     number(10)          constraint pk_ponto_turistico_cod_ponto_turistico                      primary key, 
    cod_tipo_ponto_turistico                char(2), 
    nome_ponto_turistico                    varchar2(20)        constraint nn_ponto_turistico_nome_ponto_turistico                     not null,
    
    constraint ck_ponto_turistico_cod_tipo_ponto_turistico            check(regexp_like(cod_tipo_ponto_turistico, '^(M|MU|PN|MI)$'))
);

create table Itenerarios_Viagens (
    cod_viagem                              number(10), 
    cod_ponto_turistico                     number(10), 
    hora_passagem                           timestamp(0)        constraint nn_itenerarios_viagens_hora_passagem                        not null
);

alter table veiculos_condutores         add constraint fk_veiculos_matricula                                    foreign key (matricula)                         references Veiculos (matricula);
alter table veiculos_condutores         add constraint fk_veiculos_nr_idCivil_condutor                          foreign key (nr_idCivil_condutor)               references Condutores (nr_idCivil_condutor);
alter table condutores                  add constraint fk_condutores_nr_carta_conducao                          foreign key (nr_cartaConducao)                  references carta_conducao(nr_cartaConducao);
alter table veiculo_chassis             add constraint fk_veiculo_chassis_matricula                             foreign key (matricula)                         references veiculos(matricula);
alter table veiculo_chassis             add constraint fk_veiculo_chassis_nr_chassis                            foreign key (nr_chassis)                        references chassis(nr_chassis);
alter table chassis                     add constraint fk_chassis_modelo                                        foreign key (modelo)                            references modelo_veiculo(modelo);
alter table recibo_mes                  add constraint fk_recibo_mes_nr_idCivil_condutor                        foreign key (nr_idCivil_condutor)               references condutores(nr_idCivil_condutor);
alter table recibo_viagem               add constraint fk_recibo_viagem_nr_recibo_mes                           foreign key (nr_recibo_mes)                     references recibo_mes (nr_recibo_mes);
alter table recibo_viagem               add constraint fk_recibo_viagem_cod_tipo_servico                        foreign key (cod_tipo_servico)                  references tipo_servico (cod_tipo_servico);
alter table recibo_viagem               add constraint fk_recibo_viagem_cod_viagem                              foreign key (cod_viagem)                        references viagens (cod_viagem);
alter table recibo_viagem               add constraint fk_recibo_viagem_nr_idCivil_Condutor                     foreign key (nr_idCivil_Condutor)               references condutores (nr_idCivil_Condutor);  
alter table viagens                     add constraint fk_viagens_cod_pedido                                    foreign key(cod_pedido)                         references pedidos_viagens (cod_pedido);
alter table pedidos_viagens             add constraint fk_pedidos_viagens_matricula                             foreign key (matricula)                         references veiculos (matricula);
alter table pedidos_viagens             add constraint fk_pedidos_viagens_nr_idCivil_condutor                   foreign key (nr_idCivil_condutor)               references condutores (nr_idCivil_condutor);
alter table pedidos_viagens             add constraint fk_pedidos_viagens_data_inicio                           foreign key (data_inicio)                       references veiculos_condutores (data_inicio);
alter table pedidos_viagens             add constraint fk_pedidos_viagens_cod_servico                           foreign key (cod_servico)                       references servico (cod_servico);       
alter table pedidos_viagens             add constraint fk_pedidos_viagens_login                                 foreign key (login)                             references login (login);
alter table servico                     add constraint fk_servico_cod_tipo_servico                              foreign key (cod_tipo_servico)                  references tipo_servico (cod_tipo_servico);
alter table percentagem_condutor        add constraint fk_percentagem_condutor_cod_tipo_servico                 foreign key (cod_tipo_servico)                  references tipo_servico (cod_tipo_servico);
alter table login_cliente               add constraint fk_login_cliente_login                                   foreign key (login)                             references login (login);
alter table login_cliente               add constraint fk_login_cliente_nr_idCivil_Cliente                      foreign key (nr_idCivil_Cliente)                references cliente (nr_idCivil_Cliente); 
alter table fatura                      add constraint fk_fatura_cod_pedido                                     foreign key (cod_pedido)                        references pedidos_viagens (cod_pedido);
alter table fatura                      add constraint fk_fatura_nr_idCivil_cliente                             foreign key (nr_idCivil_cliente)                references cliente (nr_idCivil_Cliente);
alter table custos_servicos             add constraint fk_custos_servicos_cod_servico                           foreign key (cod_servico)                       references servico (cod_servico);
alter table Itenerarios_Viagens         add constraint fk_itenerarios_viagens_cod_viagem                        foreign key (cod_viagem)                        references viagens (cod_viagem);
alter table Itenerarios_Viagens         add constraint fk_itenerarios_viagens_cod_ponto_turistico               foreign key (cod_ponto_turistico)               references ponto_turistico (cod_ponto_turistico);

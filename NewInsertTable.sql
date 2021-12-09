-- ** inserir dados nas tabelas **

-- ## tabela clientes ##
INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(111111111, 'António Atanásio', 111111111, TO_DATE('01-01-1999', 'dd-mm-yyyy'), 'a.atanasio@isep.com', 'a1b2c3');

INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(222222222, 'Bernardo Bernardino', 111111112, TO_DATE('18-02-2000', 'dd-mm-yyyy'), 'b.bernardino@isep.com', 'd4e5f6');

INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(333333333, 'Carla Costa', 111111113, TO_DATE('28-11-1969', 'dd-mm-yyyy'), 'b.costa@isep.com', 'g7h8i9');

INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(444444444, 'Diogo Damião', 111111114, TO_DATE('30-11-1970', 'dd-mm-yyyy'), 'd.damiao@isep.com', 'j10l11m12');

INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(555555555, 'Eduardo Espadarte', 111111115, TO_DATE('2-12-1966', 'dd-mm-yyyy'), 'e.espadarte@isep.com', 'n13o14p15');

INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(666666666, 'Franscisca Frade', 111111116, TO_DATE('12-02-2000', 'dd-mm-yyyy'), 'f.frade@isep.com', 'q16r17s18');

INSERT INTO clientes(nr_idcivil_cliente, nome, nr_contribuinte, data_nascimento, login, password)
VALUES(777777777, 'Guilherme Guarda', 111111117, TO_DATE('01-02-1994', 'dd-mm-yyyy'), 'g.guarda@isep.com', 't19u20v21');

-- ## tabela Veiculos ##
INSERT INTO veiculos(matricula ,marca ,modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('45-XX-98', 'Toyota', 'yaris', 2000, TO_DATE('08-12', 'mm-yy'), 500);

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('15-WW-12', 'Toyota', 'Camry', 2001, TO_DATE('08-12', 'mm-yy'), 550);

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('56-ZD-18', 'Mercedes', 'AMG GT', 2002, TO_DATE('08-99', 'mm-yy'), 600);

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('05-PP-90', 'Tesla', 'Model S', 2003, TO_DATE('11-11', 'mm-yy'), 700);

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('15-EQ-18', 'Opel', 'Corsa', 2004, TO_DATE('01-00', 'mm-yy'), 800);                          

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('01-MN-01', 'Ferrari', '488', 2005, TO_DATE('01-99', 'mm-yy'), 900);

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula, km_semanais) 
VALUES('99-AA-99', 'Fiat', '500', 2006, TO_DATE('04-18', 'mm-yy'), 950);

 -- ## tabela Servico ##   
INSERT INTO servicos(cod_servico, descricao)
VALUES(1,'Casual');

INSERT INTO servicos(cod_servico, descricao)
VALUES(2,'Eco');

INSERT INTO servicos(cod_servico, descricao)
VALUES(3, 'Luxo');

INSERT INTO servicos(cod_servico, descricao)
VALUES(4,'Grupo');

-- ## tabela Pontos Turisticos ##
INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(1,'Torre Eiffel','M');
    
INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(2,'Museu de Historia Nacional','MU');

INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(3,'Parque da Pedra','PN');

INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(4,'Miradouro do Monte','MI');
        
INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(5,'Estatua do Ardina','M');

-- ## tabela Condutores ##
INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(152594660, NULL, 'Oracio Carneiro', TO_DATE('26-05-1999', 'dd-mm-yyyy'), 'P-1702118 1',TO_DATE('26-03-2018', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(199999999, 152594660, 'Esteves Malandreco',TO_DATE('18-02-1987', 'dd-mm-yyyy'), 'P-1502118 5',TO_DATE('18-05-2017', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(188888888, 152594660, 'Hernaldo Zafit', TO_DATE('18-05-2017', 'dd-mm-yyyy'), 'P-1711111 2',TO_DATE('02-12-2031', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(177777777, 152594660, 'Josefino Jose',TO_DATE('21-05-1930', 'dd-mm-yyyy'), 'P-1880018 1',TO_DATE('17-07-2017', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(108888888, 152594660, 'Jaqueline Zuzu', TO_DATE('30-05-1981', 'dd-mm-yyyy'), 'P-1702003 2',TO_DATE('12-01-2019', 'dd-mm-yyyy'));                        

INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(111111777, 152594660, 'Bruno Cerqueira', TO_DATE('04-04-2001', 'dd-mm-yyyy'), 'P-1000118 1',TO_DATE('11-12-2026', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_condutor_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao) 
VALUES(177775555, 152594660, 'Romeo Julieta' ,TO_DATE('07-08-1989', 'dd-mm-yyyy'), 'P-1234567 8',TO_DATE('04-04-2001', 'dd-mm-yyyy'));

-- ## tabela Veiculos_Condutores ##
INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('26-04-2008', 'dd-mm-yyyy'),TO_DATE('26-04-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('26-10-2008', 'dd-mm-yyyy'),TO_DATE('26-10-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('21-01-2008', 'dd-mm-yyyy'),TO_DATE('21-01-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('45-XX-98', 152594660,TO_DATE('19-04-2008', 'dd-mm-yyyy'),TO_DATE('19-04-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('25-07-2005', 'dd-mm-yyyy'),TO_DATE('25-07-2005', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('16-08-2014', 'dd-mm-yyyy'),TO_DATE('16-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('17-08-2014', 'dd-mm-yyyy'),TO_DATE('17-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('01-01-2001', 'dd-mm-yyyy'),TO_DATE('01-01-2001', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('56-ZD-18', 188888888,TO_DATE('23-04-2008', 'dd-mm-yyyy') ,TO_DATE('23-04-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('56-ZD-18', 188888888,TO_DATE('01-11-2001', 'dd-mm-yyyy') ,TO_DATE('01-11-2001', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('56-ZD-18', 188888888,TO_DATE('30-01-2001', 'dd-mm-yyyy') ,TO_DATE('30-01-2001', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('99-AA-99', 177777777,TO_DATE('18-08-2014', 'dd-mm-yyyy'),TO_DATE('18-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('99-AA-99', 177777777,TO_DATE('19-08-2014', 'dd-mm-yyyy'),TO_DATE('19-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('01-MN-01', 111111777,TO_DATE('29-04-2009', 'dd-mm-yyyy'),TO_DATE('29-04-2009', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('01-MN-01', 111111777,TO_DATE('02-05-2009', 'dd-mm-yyyy'),TO_DATE('02-05-2009', 'dd-mm-yyyy'));    

INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
VALUES('01-MN-01', 111111777,TO_DATE('17-07-2009', 'dd-mm-yyyy'),TO_DATE('17-07-2009', 'dd-mm-yyyy')); 

-- ## tabela Custos Servicos ##
INSERT INTO custos_servicos(data_inicio_custo, cod_servico, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_iva, tempo_maximo_espera_minutos, custo_espera_minuto, custo_cancelamento_pedido, percentagem_cancelamento_pedido)
VALUES(TO_DATE('03-04-2018', 'dd-mm-yyyy'), 1, TO_DATE('05-04-2018', 'dd-mm-yyyy'), 2.5, 0.15, 0.20, 0.23, 7.0, 0.50, 2.50, 0.50);
    
INSERT INTO custos_servicos(data_inicio_custo, cod_servico, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_iva, tempo_maximo_espera_minutos, custo_espera_minuto, custo_cancelamento_pedido, percentagem_cancelamento_pedido)
VALUES(TO_DATE('21-04-2011', 'dd-mm-yyyy'), 2, TO_DATE('22-04-2011', 'dd-mm-yyyy'), 2.5, 0.15, 0.20, 0.23, 7.0, 0.50, 2.50, 0.50);

INSERT INTO custos_servicos(data_inicio_custo, cod_servico, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_iva, tempo_maximo_espera_minutos, custo_espera_minuto, custo_cancelamento_pedido, percentagem_cancelamento_pedido)
VALUES(TO_DATE('17-03-2017', 'dd-mm-yyyy'), 3, TO_DATE('18-03-2017', 'dd-mm-yyyy'), 2.5, 0.15, 0.20, 0.23, 7.0, 0.50, 2.50, 0.50);

INSERT INTO custos_servicos(data_inicio_custo, cod_servico, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_iva, tempo_maximo_espera_minutos, custo_espera_minuto, custo_cancelamento_pedido, percentagem_cancelamento_pedido)
VALUES(TO_DATE('07-08-2018', 'dd-mm-yyyy'), 4, TO_DATE('08-08-2018', 'dd-mm-yyyy'), 2.5, 0.15, 0.20, 0.23, 7.0, 0.50, 2.50, 0.50);

-- ## tabela Pedidos_Viagens ##
INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(1,1,'45-XX-98',111111111,152594660, TO_DATE('26-04-2008', 'dd-mm-yyyy'), TO_TIMESTAMP('26/03/2007 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('26 22:35', 'dd hh24:mi'),30,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(2,1,'56-ZD-18',111111111,152594660,TO_DATE('23-04-2008', 'dd-mm-yyyy'), TO_TIMESTAMP('23/03/2008 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('23 22:35', 'dd hh24:mi'),40,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(3,1,'45-XX-98',111111111,152594660,TO_DATE('26-10-2008', 'dd-mm-yyyy'), TO_TIMESTAMP('26/09/1999 06:38',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('26 16:30', 'dd hh24:mi'),310,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(4,1,'45-XX-98',222222222,152594660,TO_DATE('21-01-2008', 'dd-mm-yyyy'), TO_TIMESTAMP('18/01/2008 16:35', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('21 22:35', 'dd hh24:mi'),30,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(5,2,'01-MN-01',222222222,199999999,TO_DATE('29-04-2009', 'dd-mm-yyyy'), TO_TIMESTAMP('25/04/2009 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('29 16:35', 'dd hh24:mi'),250,'S');

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(6,2,'01-MN-01',222222222,199999999,TO_DATE('02-05-2009', 'dd-mm-yyyy'), TO_TIMESTAMP('02/04/2009 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('02 16:35', 'dd hh24:mi'),220,'N');

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(7,2,'01-MN-01',333333333,188888888,TO_DATE('17-07-2009', 'dd-mm-yyyy'), TO_TIMESTAMP('17/07/2008 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('17 16:35', 'dd hh24:mi'),123,'N');

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(8,2,'45-XX-98',333333333,188888888,TO_DATE('19-04-2008', 'dd-mm-yyyy'), TO_TIMESTAMP('19/03/2008 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('19 16:35', 'dd hh24:mi'),250,'N');

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(9,3,'15-WW-12',333333333,177777777,TO_DATE('01-01-2001', 'dd-mm-yyyy'), TO_TIMESTAMP('01/12/2000 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('01 16:45', 'dd hh24:mi'),60,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(10,3,'56-ZD-18',444444444,177777777,TO_DATE('01-11-2001', 'dd-mm-yyyy'), TO_TIMESTAMP('01/10/2001 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('01 16:45', 'dd hh24:mi'),68,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(11,3,'56-ZD-18',444444444,108888888,TO_DATE('30-01-2001', 'dd-mm-yyyy'), TO_TIMESTAMP('30/01/2019 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('30 16:45', 'dd hh24:mi'),250,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(12,3,'15-WW-12',444444444,108888888,TO_DATE('25-07-2005', 'dd-mm-yyyy'), TO_TIMESTAMP('23/07/2005 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('25 16:45', 'dd hh24:mi'),47,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(13,4,'15-WW-12',777777777,111111777,TO_DATE('16-08-2014', 'dd-mm-yyyy'), TO_TIMESTAMP('16/04/2014 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('16 19:15', 'dd hh24:mi'),125,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(14,4,'15-WW-12',555555555,111111777,TO_DATE('17-08-2014', 'dd-mm-yyyy'), TO_TIMESTAMP('17/05/2019 06:00','dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('17 19:15', 'dd hh24:mi'),56,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(15,4,'99-AA-99',555555555,111111777,TO_DATE('18-08-2014', 'dd-mm-yyyy'), TO_TIMESTAMP('18/06/2019 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('18 19:15', 'dd hh24:mi'),188,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(16,4,'99-AA-99',666666666,177775555,TO_DATE('19-08-2014', 'dd-mm-yyyy'), TO_TIMESTAMP('19/07/2019 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('19 19:15', 'dd hh24:mi'),98,'N' );

INSERT INTO pedidos_viagens(cod_pedido,cod_servico, matricula, nr_idcivil_cliente, nr_idcivil_condutor, data_inicio,data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado )
VALUES(17,4,'99-AA-99',777777777,177775555,TO_DATE('17-08-2014', 'dd-mm-yyyy'), TO_TIMESTAMP('17/04/2019 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('17 19:15', 'dd hh24:mi'),97,'S' );

-- ## tabela Viagens ##
INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(1,1,111111111, 15, 60);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(2,2,111111111, 30, 150);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(3,3,111111111, 0, 180);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(4,4,222222222, 12, 115);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(5,6,222222222, 12, 150);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(6,7,222222222, 0, 150);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(7,8,333333333, 0, 75);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(8,9,333333333, 12, 115);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(9,10,333333333, 3, 45);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(10,11,444444444, 7, 67);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(11,12,444444444, 2, 210);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(12,13,777777777, 5, 301);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(13,14,555555555, 12, 45);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(14,15,555555555, 3, 78);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(15,16,555555555, 1, 87);

INSERT INTO viagens(cod_viagem, cod_pedido, nr_idcivil_cliente, atraso_passageiro_minutos, duracao_minutos)
VALUES(16,17,666666666, 3, 12);

-- ## tabela Itinerarios_Viagens ##
INSERT INTO itinerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(14, 5, TO_TIMESTAMP('15','hh24'));
    
INSERT INTO itinerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(13, 4,TO_TIMESTAMP('16', 'hh24'));

INSERT INTO itinerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(12, 3,TO_TIMESTAMP('17','hh24'));

INSERT INTO itinerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(11, 2,TO_TIMESTAMP('18','hh24'));


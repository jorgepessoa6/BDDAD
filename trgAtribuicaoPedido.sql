create or replace TRIGGER trgAtribuicaoPedido
BEFORE INSERT ON Pedidos_Viagens
FOR EACH ROW
DECLARE
ex_nenhum_veiculo_condutor_disponivel EXCEPTION;
l_condutor   Condutores.nr_idCivil_condutor%TYPE;
l_matricula  Veiculos.matricula%type;
l_veiculos_disponiveis INTEGER;

CURSOR c_veiculos IS
    SELECT v.matricula 
    FROM Veiculos v 
    WHERE v.kms_semanais - :NEW.distancia_km >= 0;

BEGIN
    OPEN c_veiculos;
    LOOP 
        FETCH c_veiculos INTO l_matricula;

        SELECT COUNT(*) INTO l_veiculos_disponiveis 
        FROM Veiculos v 
        WHERE v.matricula NOT IN (select cv.matricula 
                                  from Veiculos_Condutores cv
                                  where CURRENT_TIMESTAMP between cv.data_inicio and cv.data_fim);

        IF l_veiculos_disponiveis != 0 THEN
            SELECT c.nr_idCivil_condutor INTO l_condutor 
            FROM Condutores c 
            WHERE c.nr_idCivil_condutor NOT IN (select cv.nr_idCivil_condutor 
                                                 from Veiculos_Condutores cv
                                                 where CURRENT_TIMESTAMP between cv.data_inicio and cv.data_fim)
            FETCH FIRST 1 ROW ONLY;
        END IF;

    EXIT WHEN l_condutor IS NOT NULL AND l_veiculos_disponiveis > 0;

    IF l_veiculos_disponiveis = 0 THEN
        RAISE ex_nenhum_veiculo_condutor_disponivel;
    END IF;
    END LOOP;

    UPDATE Veiculos v SET kms_semanais = kms_semanais - :NEW.distancia_km;

    INSERT INTO Veiculos_Condutores VALUES(l_matricula,l_condutor, CURRENT_TIMESTAMP, (CURRENT_TIMESTAMP + :NEW.estimativa_duracao));

    :NEW.matricula := l_matricula;
    :NEW.nr_idCivil_Condutor := l_condutor;
    :NEW.data_inicio :=  CURRENT_TIMESTAMP;

    EXCEPTION
    WHEN ex_nenhum_veiculo_condutor_disponivel THEN
        raise_application_error(-20111,'Não foram encontrados Veiculos');
END;


INSERT INTO Modelo_Veiculo(modelo ,marca)
VALUES ('yaris', 'Toyota');

INSERT INTO Chassis(nr_chassis, modelo)
VALUES ('1234', 'yaris');

INSERT INTO Veiculos(matricula, data_matricula, kms_percorridos, kms_semanais)
VALUES ('45-XX-98', TO_DATE('1999/06/24', 'YYYY/MM/DD'), 185, 300);

INSERT INTO Veiculo_Chassis(matricula, nr_chassis)
VALUES ('45-XX-98', '1234');

INSERT INTO carta_conducao(nr_cartaConducao, data_validade_cartaConducao)
VALUES (1122,  TO_DATE('03-11-2010', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada)
VALUES(11111111, null, 1122, 'Pedro Carneiro', TO_DATE('16-04-1984', 'dd-mm-yyyy'), 11111, 'Rua Feliz');
INSERT INTO Cliente(nr_idCivil, nr_contribuinte, data_nascimento, nome, morada)
VALUES (101010, 010101, TO_DATE('10-07-1976', 'dd-mm-yyyy'), 'Pedro J.', 'Rua Triste');

INSERT INTO Login(login, passwordCliente)
VALUES ('pedro85', 'banana');

INSERT INTO Login_Cliente(login, nr_idCivil_Cliente)
VALUES ('pedro85', 101010);

INSERT INTO Tipo_Servico(cod_tipo_servico, descricao, custo_cancelamento, percentagem_comissao_supervisor)
VALUES (1, 'Luxo', 10, 0.3);

INSERT INTO Servico(cod_servico, cod_tipo_servico)
VALUES (1, 1);
INSERT INTO Pedidos_Viagens(cod_pedido, cod_servico, login_Cliente, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, estimativa_duracao)
VALUES(12, 1, 'pedro85' , TO_TIMESTAMP('25/03/2008 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('25/03/2008 22:35', 'dd/mm/yyyy hh24:mi'),30, 20);
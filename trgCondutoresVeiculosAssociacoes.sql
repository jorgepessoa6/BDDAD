CREATE OR REPLACE TRIGGER trgCondutoresVeiculosAssociacoes
    BEFORE INSERT ON Veiculos_Condutores
    FOR EACH ROW
    DECLARE
        cp_matricula VEICULOS_CONDUTORES.matricula%type;
        cp_nr_idcivil VEICULOS_CONDUTORES.nr_idCivil_condutor%type;
        cp_data_inicio VEICULOS_CONDUTORES.data_inicio%type;
        cp_data_fim VEICULOS_CONDUTORES.data_fim%type;
        existem_sobreposicoes EXCEPTION;
        
        cursor cur_veiculos_condutores is select v1.matricula, v1.nr_idCivil_condutor, v1.data_inicio, v1.data_fim
        from Veiculos_Condutores v1;
    begin
        open cur_veiculos_condutores;
            loop
                exit when cur_veiculos_condutores%notfound;
                fetch cur_veiculos_condutores into cp_matricula, cp_nr_idcivil, cp_data_inicio, cp_data_fim;
                if ((( cp_matricula = :new.matricula and cp_nr_idcivil != :new.nr_idCivil_condutor) OR ( cp_matricula != :new.matricula and cp_nr_idcivil = :new.nr_idCivil_condutor)) 
                and  :new.data_inicio >= cp_data_inicio and :new.data_inicio < cp_data_fim) THEN
                    raise existem_sobreposicoes;
                end if;
                if ((( cp_matricula = :new.matricula and cp_nr_idcivil != :new.nr_idCivil_condutor) OR ( cp_matricula != :new.matricula and cp_nr_idcivil = :new.nr_idCivil_condutor)) 
                and  :new.data_inicio <= cp_data_inicio and :new.data_fim > cp_data_inicio) THEN
                    raise existem_sobreposicoes;
                end if;
            end loop;
    EXCEPTION
        WHEN existem_sobreposicoes THEN
            raise_application_error(-20001, 'Nao foi possivel efetuar registo devido a sobreposicoes.');
    end;
--Testes

    delete Itenerarios_Viagens;
    delete Viagens;
    delete Pedidos_Viagens;
    delete Veiculos_Condutores;

    INSERT INTO Modelo_Veiculo(modelo,marca)
    VALUES('yaris','Toyota');
    
    INSERT INTO Modelo_Veiculo(modelo,marca)
    VALUES('Camry','Toyota');
    
    INSERT INTO Modelo_Veiculo(modelo,marca)
    VALUES('AMG GT','Mercedes');

    INSERT INTO Chassis(nr_chassis,modelo)
    VALUES(2000,'yaris');
    
    INSERT INTO Chassis(nr_chassis,modelo)
    VALUES(2001,'Camry');
    
    INSERT INTO Chassis(nr_chassis,modelo)
    VALUES(2002,'AMG GT');
    
    INSERT INTO veiculos(matricula, data_matricula, kms_percorridos, kms_semanais) 
    VALUES('45-XX-98', TO_DATE('08-12', 'mm-yy'),0, 500);

    INSERT INTO veiculos(matricula, data_matricula, kms_percorridos, kms_semanais) 
    VALUES('15-WW-12', TO_DATE('08-12', 'mm-yy'),0, 550);
    
    INSERT INTO veiculos(matricula, data_matricula, kms_percorridos, kms_semanais) 
    VALUES('56-ZD-18', TO_DATE('08-99', 'mm-yy'),0, 600);
    
    INSERT INTO carta_conducao (nr_cartaConducao, data_validade_cartaConducao)
    VALUES (21212121, TO_DATE('23-04-2025', 'dd-mm-yyyy'));
    
    INSERT INTO carta_conducao (nr_cartaConducao, data_validade_cartaConducao)
    VALUES (23232323, TO_DATE('23-04-2026', 'dd-mm-yyyy'));

    INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada) 
    VALUES(15259466, NULL,21212121, 'Oracio Carneiro', TO_DATE('26-05-1999', 'dd-mm-yyyy'),123456789,'Porto');

    INSERT INTO condutores(nr_idCivil_condutor, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada) 
    VALUES(19999999, NULL,23232323, 'Esteves Malandreco',TO_DATE('18-02-1987', 'dd-mm-yyyy'), 123456780,'Lisboa');

    INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
    VALUES('15-WW-12', 15259466, TO_DATE('12-01-2019', 'dd-mm-yyyy'),TO_DATE('18-01-2019', 'dd-mm-yyyy'));
    --sobreposicao com o primeiro
    INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
    VALUES('45-XX-98', 15259466, TO_DATE('11-01-2019', 'dd-mm-yyyy'),TO_DATE( '15-01-2019' , 'dd-mm-yyyy'));
    --sobreposicao com o primeiro
    INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
    VALUES('45-XX-98', 15259466, TO_DATE('11-01-2019', 'dd-mm-yyyy'),TO_DATE( '19-01-2019' , 'dd-mm-yyyy'));
        
    INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
    VALUES('56-ZD-18', 15259466, TO_DATE('09-01-2019', 'dd-mm-yyyy'),TO_DATE( '11-01-2019' , 'dd-mm-yyyy'));
    --sobreposicao com o anterior
    INSERT INTO veiculos_condutores(matricula, nr_idCivil_condutor, data_inicio, data_fim)
    VALUES('56-ZD-18', 19999999, TO_DATE('10-01-2019', 'dd-mm-yyyy'),TO_DATE( '20-01-2019' , 'dd-mm-yyyy'));
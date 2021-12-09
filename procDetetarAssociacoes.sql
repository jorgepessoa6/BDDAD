CREATE OR REPLACE PROCEDURE procDetetarAssociacoes as

    cursor cur_detetar_associacoes is select v1.matricula, v1.nr_idCivil, v1.data_inicio, v1.data_fim
        from Veiculos_Condutores v1
        INNER JOIN(
            select * from Veiculos_Condutores) v2
        ON(( v2.matricula = v1.matricula and v2.nr_idCivil != v1.nr_idCivil) OR ( v2.matricula != v1.matricula and v2.nr_idCivil = v1.nr_idCivil))
        Where( v2.data_inicio >= v1.data_inicio and  v2.data_inicio < v1.data_fim);
        
    cursor cur_data(cmatricula VEICULOS_CONDUTORES.matricula%type, cnr_idcivil VEICULOS_CONDUTORES.nr_idcivil%type, cnr_datafim VEICULOS_CONDUTORES.data_fim%type, cnr_datainicio VEICULOS_CONDUTORES.data_fim%type ) is select v4.data_inicio
        from Veiculos_Condutores v4
        Where((( cmatricula = v4.matricula and cnr_idcivil != v4.nr_idCivil) OR ( cmatricula != v4.matricula and cnr_idcivil = v4.nr_idCivil)) and (cnr_datafim between v4.data_inicio and v4.data_fim OR  
        (v4.data_inicio between cnr_datainicio and cnr_datafim AND v4.data_fim between   cnr_datainicio and cnr_datafim)));    

    cp_matricula VEICULOS_CONDUTORES.matricula%type;
    cp_nr_idcivil VEICULOS_CONDUTORES.nr_idcivil%type;
    cp_data_inicio VEICULOS_CONDUTORES.data_inicio%type;
    cp_data_fim VEICULOS_CONDUTORES.data_fim%type;
    cs_data_inicio VEICULOS_CONDUTORES.data_inicio%type;
    existem_sobreposicoes EXCEPTION;
    
begin   
    open cur_detetar_associacoes;
    loop
        exit when cur_detetar_associacoes%notfound;
        fetch cur_detetar_associacoes into cp_matricula, cp_nr_idcivil, cp_data_inicio, cp_data_fim;
        open cur_data(cp_matricula, cp_nr_idcivil, cp_data_fim, cp_data_inicio);
            fetch cur_data into cs_data_inicio;
            UPDATE Veiculos_Condutores vc
            SET data_fim = cs_data_inicio
            WHERE(( cp_matricula = vc.matricula OR cp_nr_idCivil = vc.nr_idCivil) AND (cp_data_inicio = vc.data_inicio));
        close cur_data;    
    end loop;
    if(funcSobreposicoesVeiculosCondutores = true) then
        RAISE existem_sobreposicoes;
    end if;
    EXCEPTION
        WHEN existem_sobreposicoes then
            raise_application_error(-20001, 'Nao foi possivel corrigir todas as sobreposicoes.');
    END;

BEGIN
    procDetetarAssociacoes;
    END;

delete Itinerarios_Viagens;
delete Viagens;
delete Pedidos_Viagens;
delete Veiculos_Condutores;
-- ## tabela Veiculos_Condutores ##
INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('01-10-2019', 'dd-mm-yyyy'),TO_DATE( '30-10-2019' , 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('45-XX-98', 199999999, TO_DATE('04-10-2019', 'dd-mm-yyyy'),TO_DATE('08-10-2019', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('45-XX-98', 188888888, TO_DATE('06-10-2019', 'dd-mm-yyyy'),TO_DATE('09-10-2019', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('15-WW-12', 152594660,TO_DATE('08-10-2019', 'dd-mm-yyyy'),TO_DATE('14-10-2019', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('10-10-2019', 'dd-mm-yyyy'),TO_DATE( '30-10-2019' , 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('56-ZD-18', 152594660, TO_DATE('18-10-2019', 'dd-mm-yyyy'),TO_DATE( '30-10-2019', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idCivil, data_inicio, data_fim)
VALUES('99-AA-99', 152594660, TO_DATE('01-10-2019', 'dd-mm-yyyy'),TO_DATE('30-10-2019', 'dd-mm-yyyy'));

    
    
    
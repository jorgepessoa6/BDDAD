CREATE OR REPLACE TRIGGER trgClientesImpedirMenor18Anos
    AFTER INSERT OR UPDATE OF data_nascimento ON clientes
    FOR EACH ROW
    DECLARE
        ex_menor18 EXCEPTION;
    BEGIN
        IF TRUNC(MONTHS_BETWEEN(SYSDATE, :new.data_nascimento)/12) < 18 THEN
            RAISE ex_menor18;
        END IF;

    EXCEPTION
        WHEN ex_menor18 THEN
            raise_application_error(-20001, 'Utilizador com menos de 18 anos');
    end;


INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel)
     VALUES (123456780, '4200-197', 'Jorge', TO_DATE('27-03-2000', 'DD-MM-YYYY'), 'Rua',  '910000000');

INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel)
     VALUES (123456789, '4200-197', 'Joana', TO_DATE('27-03-2005', 'DD-MM-YYYY'), 'Rua',  '960000000');

UPDATE clientes
SET DATA_NASCIMENTO = TO_DATE('27-03-2005', 'DD-MM-YYYY')
WHERE NIF_CLIENTE = 123456780;

--////////////////////////////////////////////////////////////////////////////////////////////////////////
--EX 02
CREATE OR REPLACE TRIGGER trgVendasImpedirAlteracoesForaExpediente
    AFTER INSERT OR UPDATE OF data_hora ON vendas
    FOR EACH ROW
    DECLARE
        ex_fim_semana EXCEPTION;
        ex_fora_horario EXCEPTION;
        l_dia_semana Number;
    BEGIN
        l_dia_semana := TO_NUMBER(TO_CHAR(:new.data_hora, 'd'));
        IF l_dia_semana IN (1, 7) THEN
            RAISE ex_fim_semana;
        END IF;
        IF TO_NUMBER(TO_CHAR(:new.data_hora, 'SSSSS')) NOT BETWEEN (60*60*9) AND (60*60*19) THEN
            RAISE ex_fora_horario;
        END IF;


    EXCEPTION
        WHEN ex_fim_semana THEN
            raise_application_error(-20002, 'Hor?rio de fim de semana');
        WHEN ex_fora_horario THEN
            raise_application_error(-20003, 'Fora do hor?rio permitido');
end;
    
INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade)
     VALUES (15, 900800100, '500-1234567891', TO_DATE('2019-11-13 13:30','YYYY-MM-DD HH24:MI'),  1);

INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade)
     VALUES (16, 900800100, '500-1234567891', TO_DATE('2019-11-10 15:00','YYYY-MM-DD HH24:MI'),  1);

INSERT INTO vendas(nr_venda, nif_cliente, isbn, data_hora, quantidade)
     VALUES (17, 900800100, '500-1234567891', TO_DATE('2019-11-12 23:00','YYYY-MM-DD HH24:MI'),  1);

UPDATE VENDAS
SET DATA_HORA = TO_DATE('2019-11-13 23:30','YYYY-MM-DD HH24:MI')
WHERE NR_VENDA = 15;
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--EX04
select vendas.*, to_char(data_hora, 'd') dia_da_semana
from vendas
where to_char(data_hora, 'd') in (1,7) or to_char(data_hora, 'hh24') not between 9  and 19;
alter trigger tgr_vendas_impedir_alteracoes disable;
update vendas
    set data_hora = case to_char(data_hora, 'd')
        when '7' then data_hora-1
        when '1' then data_hora-2
        end
where to_char(data_hora, 'd') in (1,7) or to_char(data_hora, 'hh24') not between 9  and 19;
alter trigger trg_vendas_impedir_alteracoes enable;
--
select* from vendas where to_char(data_hora, 'd') in (1,7) or to_char(data_hora, 'hh24') not between 9 and 19;
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--EX05
CREATE OR REPLACE TRIGGER trgPrecosEdicoesLivrosImpedirRegisto
    before INSERT OR UPDATE or delete ON Precos_Edicoes_Livros
    FOR EACH ROW
    DECLARE
        ex_del EXCEPTION;
        ex_data1 exception;
        ex_data2 exception;
        
    BEGIN
        :new.data_inicio := sysdate;
        IF deleting THEN
            RAISE ex_del;
        else
        IF :new.data_inicio <= sysdate THEN
            RAISE ex_data1;
        ELSIF :old.data_inicio <= sysdate THEN
            RAISE ex_data2;
        END IF;
        end if;
        
    EXCEPTION
        WHEN ex_del THEN
            raise_application_error(-20001, 'Nao sao permitidas eliminaceos de precos');
        WHEN ex_data1 THEN
            raise_application_error(-20001, 'nao soao permitidos registos de precos anteriores a data atual');
        WHEN ex_data2 THEN
            raise_application_error(-20001, 'nao sao permitidoas modificacoes de regisotos de preos anteirores a data atual');
    end;


INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel)
     VALUES (123456780, '4200-197', 'Jorge', TO_DATE('27-03-2000', 'DD-MM-YYYY'), 'Rua',  '910000000');

INSERT INTO clientes(nif_cliente, cod_postal, nome, data_nascimento, morada, nr_telemovel)
     VALUES (123456789, '4200-197', 'Joana', TO_DATE('27-03-2005', 'DD-MM-YYYY'), 'Rua',  '960000000');

UPDATE clientes
SET DATA_NASCIMENTO = TO_DATE('27-03-2005', 'DD-MM-YYYY')
WHERE NIF_CLIENTE = 123456780;
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--EX06
ALTER TABLE PRECOS_EDICOES_LIVROS ADD data_hora DATE;
create or replace trigger trgPrecosEdicoesLivrosImpedirRegisto
    before INSERT OR UPDATE OR DELETE ON PRECOS_EDICOES_LIVROS
    FOR EACH ROW
 begin
    IF DELETING THEN
        raise_application_error(-20004, 'Elemincao probida.');
    ELSIF TRUNC(:new.DATA_INICIO) <= TRUNC(SYSDATE) THEN
            raise_application_error(-20005, 'Ação proibida');
    END IF;
    :new.data_hora := SYSDATE;
 END;
insert INTO precos_edicoes_livros(isbn, data_inicio, preco)
     VALUES ('500-1234567891', TO_DATE('2020-11-15','YYYY-MM-DD'), 70.00);
SELECT * FROM Precos_edicoes_livros
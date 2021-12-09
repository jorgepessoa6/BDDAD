DROP TABLE Excecoes CASCADE CONSTRAINTS PURGE;

CREATE TABLE Excecoes (
    ex_id int,
    ex_text VARCHAR(500) CONSTRAINT nn_excecoes_ex_text NOT NULL,
    CONSTRAINT pk_excecoes_ex_id PRIMARY KEY(ex_id),
    CONSTRAINT ck_excecoes_ex_id CHECK (ex_id BETWEEN -20999 AND -20000)

);

INSERT INTO excecoes(ex_id, ex_text) VALUES (-20001,'Horário de fim de semana');
INSERT INTO excecoes(ex_id, ex_text) VALUES (-20002,'Fora do horário de funcionamento');
INSERT INTO excecoes(ex_id, ex_text) VALUES (-20003,'Não é permitido eliminações de preços');
INSERT INTO excecoes(ex_id, ex_text) VALUES (-20004, 'Não são permitidos registos de preços anteirores à data atual.');
INSERT INTO excecoes(ex_id, ex_text) VALUES (-20005, 'Não são permitidas modificações de registos de preços anteirores à data atual.');
INSERT INTO excecoes(ex_id, ex_text) VALUES (-20006, 'Não são permitidos registos de preços com valores iguais para datas consecutivas.');

CREATE OR REPLACE PROCEDURE raiseMyAppException(p_ex_id excecoes.ex_id%type) as
    v_ex_text excecoes.ex_text%type;
    begin
        select ex_text into v_ex_text
        from excecoes
        where ex_id = p_ex_id;
            raise_application_error(p_ex_id, v_ex_text);
    exception
        when others then
            raise_application_error(p_ex_id, v_ex_text);
    end;
        


CREATE OR REPLACE TRIGGER trg_precos_edicoes_imp_reg_slt
    AFTER INSERT OR UPDATE ON PRECOS_EDICOES_LIVROS
    declare
        ex_preco exception;
        v_count int;
    begin
        select count(*) into v_count
        from precos_edicoes_livros a
        where preco = (select preco
                        from precos_edicoes_livros b
                        where b.isbn = a.isbn and b.data_inicio = (select max(data_inicio)
                                                         from precos_edicoes_livros c
                                                         where c.isbn = a.isbn and c.data_inicio < a.data_inicio));
                                                         
        if v_count > 0 then
            raise ex_preco;
        end if;
    exception
        when ex_preco then
            raiseMyAppException(-20006);
    end;
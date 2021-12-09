-- trigger ex 1
CREATE OR REPLACE TRIGGER trgPrecosEdicoesLivrosImpedirPrecosConsecutivosIguais
    AFTER INSERT OR UPDATE ON Precos_Edicoes_Livros

    DECLARE
        ex_preco EXCEPTION;
        v_count int;
        
    BEGIN
        Select count (*) into v_count
        from precos_edicoes_livros a
        where preco = (Select preco 
            from precos_edicoes_livros b
            where b.isbn = a.isbn and b.data_inicio = (select max(data_inicio)
                                                        from precos_edicoes_livros c
                                                        where c.isbn = a.isbn and c.data_inicio < a.data_inicio));
        if v_count>0 then
            raise ex_preco;
        end if;
    EXCEPTION
        WHEN ex_preco THEN
            raiseMyAppException(-20006);
    end;
--procedure para execucao de trigger ex 01 nao finalizado    
create or replace procedure raiseMyAppException(p_ex_id excecoes.ex_id%type) as v ex_text excecoes.ex_text%type);
begin
select e_text into v_ex_text
from excecoes where ex_id=p_ex_id;
raise application_error(p_err
    


--- ex03
create Table excecoes
(ex_id int, ex_test varchar(20),
constraint pk_excecoes primary key(ex_id), 
constraint ck_excecoes check(ex_id<=20000));
insert into excecoes(ex_id, ex_test) values(-20001, 'Horario de fim de semana');
insert into excecoes(ex_id, ex_test) values(-20001, 'Fora de horario de funcinamento');
insert into excecoes(ex_id, ex_test) values(-20001, 'Nao sao permitidas eliminacoes de precoes');
insert into excecoes(ex_id, ex_test) values(-20001, 'Nao sao permitidaos registos de precoes anteriores `data aual');
insert into excecoes(ex_id, ex_test) values(-20001, 'nao sao permitidas modificaoes de registos de precoes anteriores a data atual');
insert into excecoes(ex_id, ex_test) values(-20001, 'Nao sao permitidaos registos de precoes com valores iguais para datas consecutivas');


-- ex 04
CREATE OR REPLACE TRIGGER trgVendasAtualizarSaldosCartaoCliente
    AFTER INSERT OR DELETE ON Vendas
    For each row
    DECLARE
         ex_preco exception;
         nif_cli INTEGER ;
    BEGIN
    if( to_char(new.data_hora) in (3,4)) then 
       nif_cli := :new.nif_cliente;
    end if;
   Update Cartoes_Clientes 
    Set saldo_atual = saldo_atual + :new.quantidade*0.05,
        saldo acumulado = saldo_acumulado + :new.quantidade*0.05
    Where nif_cliente =  nif_cli;  
    EXCEPTION
        when ex_preco then 
            raiseMyAppException(-20007);
    end;
/
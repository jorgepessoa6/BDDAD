set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE PROCGUARDARINFORMACAOSEMANAL (p_date in DATE) AS 

l_cursor SYS_REFCURSOR;
l_auxiliar resumosveiculos%rowtype;
l_veiculosNaoNulos INTEGER;
l_veiculosTotal INTEGER;
l_percentagem FLOAT;

l_resumo resumosveiculos%rowtype;
l_matricula resumosveiculos.matricula%type;

l_sim CHAR(3) := 'SIM';
l_nao CHAR(3) := 'NAO';

Cursor fezViagem is 
        select rv1.matricula as Matricula
        from resumosveiculos rv1
        where rv1.nr_viagens is not null;

Cursor naoFezViagem is        
        select rv2.matricula as Matricula
        from resumosveiculos rv2
        where rv2.nr_viagens is null;

BEGIN 

    l_cursor := FUNCOBTERINFOSEMANALVEICULOS(p_date);
    LOOP 
        FETCH l_cursor into l_auxiliar;
        EXIT WHEN l_cursor%NOTFOUND;
        INSERT INTO resumosveiculos VALUES(CURRENT_TIMESTAMP,l_auxiliar.data_inicio,l_auxiliar.data_fim,l_auxiliar.matricula,l_auxiliar.nr_viagens,l_auxiliar.soma_km,l_auxiliar.soma_duracao);
    END LOOP;
    
    select count(*) into l_veiculosNaoNulos 
    from resumosveiculos rv
    where rv.nr_viagens is not null;
    
    select count(*) into l_veiculosTotal
    from resumosveiculos;

    l_percentagem := l_veiculosNaoNulos/l_veiculosTotal * 100; 
    
    --DBMS_OUTPUT.PUT_LINE('Percentagem : ' || l_percentagem);
    
    OPEN fezViagem;
        LOOP 
        FETCH fezViagem into l_matricula;
        EXIT WHEN fezViagem%notfound;
            DBMS_OUTPUT.PUT_LINE(RPAD(l_sim,5,' ') || RPAD(l_percentagem,5,' ') || l_matricula);
        END LOOP;
    CLOSE fezViagem;
    
    OPEN naoFezViagem;
        LOOP 
        FETCH naoFezViagem into l_matricula;
        EXIT WHEN naoFezViagem%notfound;
            DBMS_OUTPUT.PUT_LINE(RPAD(l_nao,5,' ') || RPAD(100 - l_percentagem,5,' ') || l_matricula);
        END LOOP;
    CLOSE naoFezViagem;

END PROCGUARDARINFORMACAOSEMANAL;

/
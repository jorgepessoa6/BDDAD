--Funcao exercicio1
CREATE OR REPLACE FUNCTION funcTopServico(p_cod_servico servicos.cod_servico%type,
                            p_data_inicial TIMESTAMP, p_data_final TIMESTAMP,
                            n int ) return sys_refcursor
is
    cursor_id sys_refcursor;
    cod_servico_invalido EXCEPTION;
    n_invalido EXCEPTION;
    maximo_cod_servico int;
Begin
Select MAX(cod_servico) into maximo_cod_servico
From Servicos;

if(p_cod_servico > maximo_cod_servico
    OR p_cod_servico<1)then
    raise cod_servico_invalido;
end if;
if(n <1)then
    raise n_invalido;
end if;
Open cursor_id For
    With CalcularCusto as(
    SELECT CASE WHEN(pv.cancelado = 'N')
                THEN cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
                    + (cs.custo_espera_minuto * v.atraso_passageiro_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
                     + (cs.custo_espera_minuto * v.atraso_passageiro_minutos)) * cs.taxa_IVA
                ELSE cs.custo_cancelamento_pedido  END 
                AS custo, pv.nr_idCivil, s.cod_servico, pv.cod_pedido, pv.data_hora_pedido
                FROM Custos_Servicos cs, Servicos s, Pedidos_Viagens pv, Viagens v
                WHERE( s.cod_servico = cs.cod_servico AND s.cod_servico = pv.cod_servico AND  pv.cod_pedido = v.cod_pedido)) 
    select nr_idCivil
    From CalcularCusto c1
    Where c1.cod_servico= p_cod_servico 
        and (c1.data_hora_pedido between p_data_inicial and p_data_final)
        and (select count(*) 
            from CalcularCusto c2
            where c2.cod_servico = c1.cod_servico
            and (c2.data_hora_pedido between p_data_inicial and p_data_final)
            and c2.custo >= c1.custo) <= n  ;
Return(cursor_id);
Exception 
    WHEN cod_servico_invalido Then
        return null;
    WHEN n_invalido Then
        return null;   
end;

-- BLOCO ANONIMOS #1
Set SERVEROUTPUT ON;
Declare
    l_valores sys_refcursor;
    l_item Condutores.nr_idCivil%type;
Begin
 
 if funcTopServico(1, TO_TIMESTAMP('17/05/2000 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3 ) IS null then
        DBMS_OUTPUT.PUT_LINE('DADOS INVALIDOS');
    else
    l_valores:=funcTopServico(1 ,TO_TIMESTAMP('17/05/2000 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3 );
    Loop
        Fetch l_valores into l_item;
        Exit when l_valores%NOTFOUND;
       dbms_output.put_line (l_item);
    END LOOP;
end if;
END;
/

-- BLOCO ANONIMOS #2
Set SERVEROUTPUT ON;
Declare
    l_valores sys_refcursor;
    l_item Condutores.nr_idCivil%type;
Begin
 
 if funcTopServico(1, TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3 ) IS null then
        DBMS_OUTPUT.PUT_LINE('DADOS INVALIDOS');
    else
    l_valores:=funcTopServico(1 ,TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3 );
    Loop
        Fetch l_valores into l_item;
        Exit when l_valores%NOTFOUND;
       dbms_output.put_line (l_item);
    END LOOP;
end if;
END;
/

-- BLOCO ANONIMOS #3
Set SERVEROUTPUT ON;
Declare
    l_valores sys_refcursor;
    l_item Condutores.nr_idCivil%type;
Begin
 
 if funcTopServico(20, TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3 ) IS null then
        DBMS_OUTPUT.PUT_LINE('DADOS INVALIDOS');
    else
    l_valores:=funcTopServico(20 ,TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3 );
    Loop
        Fetch l_valores into l_item;
        Exit when l_valores%NOTFOUND;
       dbms_output.put_line (l_item);
    END LOOP;
end if;
END;
/

-- BLOCO ANONIMOS #4
Set SERVEROUTPUT ON;
Declare
    l_valores sys_refcursor;
    l_item Condutores.nr_idCivil%type;
Begin
 
 if funcTopServico(1, TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),0 ) IS null then
        DBMS_OUTPUT.PUT_LINE('DADOS INVALIDOS');
    else
    l_valores:=funcTopServico(1 ,TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),0 );
    Loop
        Fetch l_valores into l_item;
        Exit when l_valores%NOTFOUND;
       dbms_output.put_line (l_item);
    END LOOP;
end if;
END;
/

-- BLOCO ANONIMOS #5
Set SERVEROUTPUT ON;
Declare
    l_valores sys_refcursor;
    l_item Condutores.nr_idCivil%type;
Begin
 
 if funcTopServico(3, TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),2 ) IS null then
        DBMS_OUTPUT.PUT_LINE('DADOS INVALIDOS');
    else
    l_valores:=funcTopServico(3 ,TO_TIMESTAMP('17/05/1999 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),2 );
    Loop
        Fetch l_valores into l_item;
        Exit when l_valores%NOTFOUND;
       dbms_output.put_line (l_item);
    END LOOP;
end if;
END;
/
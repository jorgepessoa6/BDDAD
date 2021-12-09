--funcao exercicio 3
create or replace function funcObterInfoSemanalVeiculos(p_data date) return sys_refcursor

is
    my_cursor sys_refcursor;
        
begin
    open my_cursor for
    with sum_total as(
         select vc.matricula matricula, vc.data_inicio, vc.data_fim, pv.distancia_km, v.duracao_minutos
         from veiculos_condutores vc
            inner join pedidos_viagens pv on vc.matricula = pv.matricula and 
                                             vc.matricula = pv.matricula and
                                             vc.nr_idCivil = pv.nr_idCivil and
                                             vc.data_inicio = pv.data_inicio 
            inner join viagens v on pv.cod_pedido = v.cod_pedido
        where vc.matricula = pv.matricula and
              (pv.data_hora_recolha_passageiro >= trunc(p_data, 'iw') and
              pv.data_hora_recolha_passageiro <= trunc(p_data, 'iw') +7 - 1/86400))
        select matricula, trunc(p_data, 'iw') data_inicio, trunc(p_data, 'iw') +7 - 1/86400 data_fim, count(*) nr_viagens, sum(distancia_km), sum(duracao_minutos)
        from sum_total
        group by matricula;
        
        return my_cursor;
        
end;
/
        

set serveroutput on;
declare
    l_valores sys_refcursor;
    cp_matricula VEICULOS_CONDUTORES.matricula%type;
    cp_data_inicio VEICULOS_CONDUTORES.data_inicio%type;
    cp_data_fim VEICULOS_CONDUTORES.data_fim%type;
    cp_dist PEDIDOS_VIAGENS.distancia_km%type;
     cp_dur VIAGENS.duracao_minutos%type;
      nr_viagens int;
begin
    l_valores := funcObterInfoSemanalVeiculos(TO_TIMESTAMP('09/04/26','dd/mm/yyyy'));
    loop
        fetch l_valores into cp_matricula, cp_data_inicio, cp_data_fim, nr_viagens, cp_dist, cp_dur;
        exit when l_valores%NOTFOUND;
        dbms_output.put_line(cp_matricula);
        dbms_output.put_line(cp_data_inicio);
        dbms_output.put_line(cp_data_fim);
        dbms_output.put_line(nr_viagens);        
        dbms_output.put_line(cp_dist);
        dbms_output.put_line(cp_dur);
    end loop;
end;
/
-- ex04
select vendas.*, to_char(data_hora, 'd') dia_da_semana
from vendas
where to_char(data_hora, 'd') in (1, 7) or to_char(data_hora, 'hh24') not between 9 and 19;

alter trigger trg_vendas_impedir_alteracoes disable;

update vendas
    set data_hora = case to_char(data_hora, 'd')
                        when '7' then data_hora-1
                        when '1' then data_hora-2
                    end
    where to_char(data_hora, 'd') in (1, 7) or to_char(data_hora, 'hh24') not between 9 and 19;
    
alter trigger trg_vendas_impedir_alteracoes enable;

select * from vendas where to_char(data_hora, 'd') in (1, 7) or to_char(data_hora, 'hh24') not between 9 and 19;
    
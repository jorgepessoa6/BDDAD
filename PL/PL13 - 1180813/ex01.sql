-- ex01
create or replace trigger trgClientesImpedirMenor18Anos
    before
    insert or update
    of data_nascimento
    on clientes
    for each row

    declare
        ex_menor_idade exception;
    
begin
    if months_between(sysdate, :new.data_nascimento) < 18 * 12 then
        raise ex_menor_idade;
    end if;
exception
    when ex_menor_idade then
        raise_application_error(-20001, 'Utilizador com menos de 18 anos');
end trgClientesImpedirMenor18Anos;
/
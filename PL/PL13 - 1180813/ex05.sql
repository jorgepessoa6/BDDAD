-- ex05
create or replace trigger trg_precos_edicoes_imp_reg 
before insert or update or delete on precos_edicoes_livros
for each row
declare
    ex_de1 exception;
    ex_data1 exception;
    ex_data2 exception;
begin
    :new.data_hora := sysdate;
    
    if deleting then
        raise ex_de1;
    else
        if :new.data_inicio <= sysdate then
            raise ex_data1;
        elseif :old.data_inicio <= sysdate then
            raise ex_data2;
        endif;
    endif;
    
exception 
    when ex_de1 then
        raise_application_error(-20003, 'nao sao permitidas eliminacoes de precos');
    when ex_data1 then
        raise_application_error(-20004, 'nao sao permitidos registos de precos anteriores à data atual');
    when ex_data2 then
        raise_application_error(-20005, 'nao sao permitidas modificacoes de registos de precos anteriores à data atual');
end;
/
        
CREATE OR REPLACE FUNCTION funcSobreposicoesVeiculosCondutores return boolean
is 
    contador int;

    BEGIN
        select count(*) into contador
        from Veiculos_Condutores v1
        INNER JOIN(
            select * from Veiculos_Condutores) v2
        ON(( v2.matricula = v1.matricula and v2.nr_idCivil != v1.nr_idCivil) OR ( v2.matricula != v1.matricula and v2.nr_idCivil = v1.nr_idCivil))
        Where( v2.data_inicio >= v1.data_inicio and  v2.data_inicio < v1.data_fim);

        IF (contador = 0) THEN
            RETURN false;
        else
            RETURN true;
        end if;
    end;
    
SET SERVEROUTPUT ON
BEGIN
    if (funcSobreposicoesVeiculosCondutores = false) then
        DBMS_OUTPUT.PUT_LINE('Nao existem sobreposicoes temporais');
    else
        DBMS_OUTPUT.PUT_LINE('Existem sobreposicoes temporais');
    end if;
end;



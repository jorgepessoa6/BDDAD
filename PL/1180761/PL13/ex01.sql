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
ALTER TABLE PRECOS_EDICOES_LIVROS ADD data_hora DATE;

CREATE OR REPLACE TRIGGER trgPrecosEdicoesLivrosImpedirRegisto
    BEFORE INSERT OR UPDATE OR DELETE ON PRECOS_EDICOES_LIVROS
    FOR EACH ROW
    BEGIN
        IF DELETING THEN
            raise_application_error(-20004, 'N�o podem ser eliminados listagens de pre�os de edi��es de livros.');
        ELSIF TRUNC(:new.DATA_INICIO) <= TRUNC(SYSDATE) THEN
            raise_application_error(-20005, 'N�o pode alterar elementos de momentos anteriores ao atual.');
        END IF;
           :new.data_hora := SYSDATE;

    END;

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco)
     VALUES ('500-1234567891', TO_DATE('2020-11-15','YYYY-MM-DD'), 70.00);

UPDATE PRECOS_EDICOES_LIVROS
SET DATA_INICIO = TO_DATE('2019-11-12 16:30','YYYY-MM-DD HH24:MI')
WHERE  ISBN = '500-1234567891';

SELECT * FROM Precos_edicoes_livros
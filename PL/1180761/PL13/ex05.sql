CREATE OR REPLACE TRIGGER trgPrecosEdicoesLivrosImpedirRegisto
    AFTER INSERT OR UPDATE OR DELETE ON PRECOS_EDICOES_LIVROS
    FOR EACH ROW
    BEGIN
        IF DELETING THEN
            raise_application_error(-20004, 'Não pode eliminar listagens de preços de edições de livros.');
        ELSIF TRUNC(:new.DATA_INICIO) <= TRUNC(SYSDATE) THEN
            raise_application_error(-20005, 'Não pode alterar elementos de momentos anteriores ao atual.');
        END IF;

    END;

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco)
     VALUES ('500-1234567891', TO_DATE('2020-11-13','YYYY-MM-DD'), 70.00);

UPDATE PRECOS_EDICOES_LIVROS
SET DATA_INICIO = TO_DATE('2019-11-12 16:30','YYYY-MM-DD HH24:MI')
WHERE  ISBN = '500-1234567891';

DELETE FROM PRECOS_EDICOES_LIVROS
WHERE  ISBN = '500-1234567891';
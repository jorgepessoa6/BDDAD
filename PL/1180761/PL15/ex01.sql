CREATE OR REPLACE TRIGGER trgPrecosEdicoesLivrosImpedirPrecosConsecutivosIguais
    BEFORE INSERT OR UPDATE ON PRECOS_EDICOES_LIVROS
    FOR EACH ROW
    DECLARE
        el_preco precos_edicoes_livros.preco%type;
        ex_preco_consecutivo EXCEPTION;
    BEGIN
        SELECT preco INTO el_preco
            FROM PRECOS_EDICOES_LIVROS
            WHERE DATA_INICIO < :new.data_inicio
            ORDER BY DATA_INICIO DESC
            FETCH FIRST ROW ONLY;

        if (:new.preco = el_preco) THEN
            raise ex_preco_consecutivo;
        end if;

        SELECT preco INTO el_preco
            FROM PRECOS_EDICOES_LIVROS
            WHERE DATA_INICIO > :new.data_inicio
            ORDER BY DATA_INICIO
            FETCH FIRST ROW ONLY;

        if (:new.preco = el_preco) THEN
            raise ex_preco_consecutivo;
        end if;

    EXCEPTION
        WHEN ex_preco_consecutivo THEN
            raiseMyAppException(-20006);
    end;

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
     VALUES ('978-1449777452', TO_DATE('2019-09-02','YYYY-MM-DD'), 70.00);

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
     VALUES ('978-1449777452', TO_DATE('2019-09-02','YYYY-MM-DD'), 60.00);

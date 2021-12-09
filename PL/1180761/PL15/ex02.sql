CREATE OR REPLACE TRIGGER trgPrecosEdicoesLivrosImpedirPrecosConsecutivosIguais
    AFTER INSERT OR UPDATE ON PRECOS_EDICOES_LIVROS
    DECLARE
        ex_preco_consecutivo EXCEPTION;
        cur_precoIgual sys_refcursor;
        l_isbn_cur PRECOS_EDICOES_LIVROS.ISBN%type;
        l_isbn_nxt PRECOS_EDICOES_LIVROS.ISBN%type;
        l_preco_cur PRECOS_EDICOES_LIVROS.PRECO%type;
        l_preco_nxt PRECOS_EDICOES_LIVROS.PRECO%type;
    BEGIN
        OPEN cur_precoIgual FOR
        SELECT isbn_cur, isbn_nxt, preco_cur, preco_nxt
            FROM (SELECT curr.ISBN AS isbn_cur, curr.PRECO AS preco_cur, ROW_NUMBER() OVER (ORDER BY ISBN) AS A
                    FROM PRECOS_EDICOES_LIVROS curr
                    ORDER BY ISBN) cur
                INNER JOIN (SELECT next.ISBN AS isbn_nxt, next.PRECO AS preco_nxt, ROW_NUMBER() OVER (ORDER BY ISBN) + 1 AS B
                                FROM PRECOS_EDICOES_LIVROS next
                                ORDER BY ISBN) nxt ON cur.A = nxt.B
            ORDER BY cur.isbn_cur;

        LOOP
            FETCH cur_precoIgual INTO l_isbn_cur, l_isbn_nxt, l_preco_cur, l_preco_nxt;
            EXIT WHEN cur_precoIgual%notfound;
            IF ((l_isbn_cur LIKE l_isbn_nxt) AND (l_preco_cur = l_preco_nxt)) THEN
                raise ex_preco_consecutivo;
            end if;
        end loop;


    EXCEPTION
        WHEN ex_preco_consecutivo THEN
            raiseMyAppException(-20006);
    end;

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
     VALUES ('978-1449777452', TO_DATE('2019-09-05','YYYY-MM-DD'), 110.00);

INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
     VALUES ('978-1449777452', TO_DATE('2019-09-06','YYYY-MM-DD'), 110.00);
     
INSERT INTO precos_edicoes_livros(isbn, data_inicio, preco) 
     VALUES ('978-1449777452', TO_DATE('2019-09-06','YYYY-MM-DD'), 100.00);
     
UPDATE PRECOS_EDICOES_LIVROS
SET preco = 110.00
WHERE isbn = '978-1449777452' and data_inicio = '2019-09-06';

UPDATE PRECOS_EDICOES_LIVROS
SET preco = 120.00
WHERE isbn = '978-1449777452' and data_inicio = '2019-09-06';
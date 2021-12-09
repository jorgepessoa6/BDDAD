--ex04

CREATE OR REPLACE PROCEDURE procQtdEdicoesLivrosEditora(p_editora IN Editoras.ID_EDITORA%type) AS
    l_nLivros integer;
    l_editora_valida integer;

BEGIN
    SELECT COUNT(*) INTO l_editora_valida
    FROM EDITORAS WHERE EDITORAS.ID_EDITORA = p_editora;

    IF (l_editora_valida != 0) THEN

            SELECT COUNT(*) INTO l_nLivros
            FROM EDICOES_LIVROS el
                INNER JOIN EDITORAS e ON e.ID_EDITORA = el.ID_EDITORA
            WHERE e.ID_EDITORA = p_editora;

           dbms_output.put_line('Editora: ' || p_editora);
           dbms_output.put_line('Número de edições de livros: ' || l_nLivros);

    ELSE
        dbms_output.put_line('Editora' || NVL(' ' || TO_CHAR(p_editora) || ' ', ' ') || 'não existe');
    end if;
end;

BEGIN
    procQtdEdicoesLivrosEditora(1800);
END;

--retorna como não existente--
BEGIN
    procQtdEdicoesLivrosEditora(6000);
END;
--retorna como não existente--
BEGIN
    procQtdEdicoesLivrosEditora(null);
END;

--ex05

CREATE OR REPLACE PROCEDURE procStockEdicaoLivro(p_isbn IN Edicoes_Livros.isbn%type) AS
    l_stock integer;
    l_stock_minimo integer;

BEGIN

    SELECT stock_min, stock INTO l_stock_minimo, l_stock
    FROM EDICOES_LIVROS WHERE ISBN = p_isbn;
    DBMS_OUTPUT.put_line('ISBN: ' || p_isbn);
    DBMS_OUTPUT.put_line('Stock: ' || l_stock);
    DBMS_OUTPUT.put_line('Stock minimo: ' || l_stock_minimo);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_line('O ISBN não existe');

end;

BEGIN
    procStockEdicaoLivro('500-1211111191');
end;

BEGIN
    procStockEdicaoLivro(123);
end;

BEGIN
    procStockEdicaoLivro(null);
end;

--ex06

CREATE OR REPLACE PROCEDURE procAutores AS
    l_id_autor integer;
    l_nome_autor VARCHAR(35);

    CURSOR c_id_autor IS
        SELECT ID_AUTOR
        FROM AUTORES;

BEGIN
    dbms_output.put_line('ID   | NOME');
    dbms_output.put_line('--------------------------------------------');
    OPEN c_id_autor;
        LOOP
            FETCH c_id_autor INTO l_id_autor;
            EXIT WHEN c_id_autor%notfound;
            SELECT nome INTO l_nome_autor
            FROM AUTORES WHERE l_id_autor = ID_AUTOR;

            dbms_output.put_line(RPAD(TO_CHAR(l_id_autor), 4, ' ') || ' | ' ||RPAD(l_nome_autor, 35, ' '));

        END LOOP;
    CLOSE c_id_autor;

end;

BEGIN
    procAutores();
end;

--ex07

CREATE OR REPLACE PROCEDURE procAutores AS
    i integer;

    CURSOR cur_id_autor IS
        SELECT ID_AUTOR c_id_autor, NOME c_nome
        FROM AUTORES;

BEGIN
    i := 0;
    dbms_output.put_line('-  | ID   | NOME');
    dbms_output.put_line('--------------------------------------------');
    FOR c_autores IN cur_id_autor
        LOOP
            BEGIN
                dbms_output.put_line(RPAD(TO_CHAR(i), 2, ' ') || ' | ' || RPAD(TO_CHAR(c_autores.c_id_autor), 4, ' ') || ' | ' ||RPAD(c_autores.c_nome, 35, ' '));
                i := i + 1;
            END;
        END LOOP;
end;

BEGIN
    procAutores();
end;

--ex08

CREATE OR REPLACE PROCEDURE procAutores AS
    i integer;

BEGIN
    i := 0;
    dbms_output.put_line('-  | ID   | NOME');
    dbms_output.put_line('--------------------------------------------');
    FOR c_autores IN (SELECT ID_AUTOR c_id_autor, NOME c_nome FROM AUTORES)
        LOOP
            BEGIN
                dbms_output.put_line(RPAD(TO_CHAR(i), 2, ' ') || ' | ' || RPAD(TO_CHAR(c_autores.c_id_autor), 4, ' ') || ' | ' ||RPAD(c_autores.c_nome, 35, ' '));
                i := i + 1;
            END;
        END LOOP;
end;

BEGIN
    procAutores();
end;

--ex09

CREATE OR REPLACE PROCEDURE procQtdVendasMensaisAnoEditora(p_idEditora IN Editoras.id_editora%type, p_ano IN INTEGER) AS

    l_nlivros_mes integer;
    exep_ano_invalido EXCEPTION;
    l_id_editora_test integer;


    CURSOR cur_qtd_vendida (
        c_id_editora IN Editoras.id_editora%TYPE,
        c_ano IN INTEGER,
        c_mes IN INTEGER)
        IS
        SELECT SUM(QUANTIDADE) INTO l_nlivros_mes
            FROM vendas v
            INNER JOIN EDICOES_LIVROS el ON v.ISBN = el.ISBN
            WHERE TO_NUMBER(TO_CHAR(v.DATA_HORA, 'MM')) = c_mes
                AND TO_NUMBER(TO_CHAR(v.DATA_HORA, 'YYYY')) = p_ano
                AND p_idEditora = el.ID_EDITORA;

    BEGIN
        SELECT ID_EDITORA INTO l_id_editora_test
            FROM EDITORAS
            WHERE ID_EDITORA = p_idEditora;

        IF p_ano >=EXTRACT(YEAR FROM SYSDATE) OR p_ano IS NULL THEN
            RAISE exep_ano_invalido;
        end if;

        dbms_output.put_line('Editora ' || p_idEditora);
        dbms_output.put_line('Vendas  ' || p_ano);
        dbms_output.put_line(' ');
        dbms_output.put_line('MÊS  QTD');
        dbms_output.put_line('----------');
        FOR c_mes IN 1..12
        LOOP
            OPEN cur_qtd_vendida(p_idEditora, p_ano, c_mes);
            FETCH cur_qtd_vendida INTO l_nlivros_mes;
            CLOSE cur_qtd_vendida;
            dbms_output.put_line(RPAD(TO_CHAR(c_mes), 5, ' ') || RPAD(TO_CHAR(NVL(l_nlivros_mes, 0)), 5, ' '));
        end loop;

EXCEPTION

    WHEN exep_ano_invalido THEN
        dbms_output.put_line('O ano é inválido.');
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Não existe essa editora, ou é inválida.');
    WHEN OTHERS THEN
        dbms_output.put_line('Erro inesperado');
    end;

begin
    procQtdVendasMensaisAnoEditora(1500, 2016);
end;

begin
    procQtdVendasMensaisAnoEditora(1500, 2020);
end;

begin
    procQtdVendasMensaisAnoEditora(NULL, NULL);
end;
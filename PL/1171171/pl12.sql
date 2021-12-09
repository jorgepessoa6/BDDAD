--FUNCAO EX4 
CREATE OR REPLACE FUNCTION funcStockMax return int
is
    contador int;
begin
    select MAX(el.stock) into contador
                From edicoes_livros el;
    return contador;
end;
/
set SERVEROUTPUT ON
Begin
    dbms_output.put_line(funcStockMax);
end;


CREATE OR REPLACE PROCEDURE procTitulosEdicoesStockMax 
is 
    titulo_final Livros.titulo%type;
    sem_stock exception;
    contador int;
    cursor c1 is 
        select titulo
         From Livros;
BEGIN
OPEN c1;
    Select max(stock) into contador
    From Edicoes_livros;
    if  contador=0 then
        raise sem_stock;
    end if;
    select l.titulo into titulo_final
    from Livros l
    Where l.id_livro in(Select el.id_livro
                        From Edicoes_livros el
                        where el.stock = (select Max(el.stock)
                                          From Edicoes_livros el));
    Fetch c1 into titulo_final;
EXCEPTION
    when sem_stock then
        dbms_output.put_line('UUUUUU');
end;
/
set SERVEROUTPUT ON
EXEC procTitulosEdicoesStockMax();




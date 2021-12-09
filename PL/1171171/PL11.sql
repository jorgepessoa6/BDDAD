-- FUNCAO a)
CREATE OR REPLACE FUNCTION funcMenorIdadeClientes return DATE
is
    data_recente DATE;
begin
    Select MAX(c.data_nascimento) into data_recente
    From Clientes c;
    if data_recente IS EMPTY then
        return NULL;
    end if;    
    return data_recente;
end;
/
set SERVEROUTPUT ON
Begin
    dbms_output.put_line(funcMenorIdadeClientes);
end;
-- #############################################################################################
-- FUNCAO 5)
CREATE OR REPLACE FUNCTION funcTemLivrosEditora(p_id_editora Editoras.id_editora%type) return varchar
is
    contador int;
begin
    select count(el.id_livro) into contador
                From edicoes_livros el
                Inner Join Editoras e
                On e.id_editora = el.id_editora
                Where e.id_editora= p_id_editora;
    if contador >0 then
        return 'V';
    else
        return 'F';
    end if;
end;
/
set SERVEROUTPUT ON
Begin
    dbms_output.put_line(funcTemLivrosEditora('1800'));
end;

-- #############################################################################################
-- FUNCAO 6)     



-- #############################################################################################
-- FUNCAO 7)    
CREATE OR REPLACE FUNCTION funcStockAnoEditora(p_id_editora Edicoes_livros.id_editora%type,
                                            p_ano_edicao Edicoes_livros.ano_edicao%type DEFAULT to_number(sysdate, 'YYYY')) return int
is
    stock int;
begin
    select count(el.id_livro) into stock
                From edicoes_livros el
                Inner Join Editoras e
                On e.id_editora = el.id_editora
                Where el.id_editora= p_id_editora
                AND el.ano_edicao= p_ano_edicao;
    return stock;
end;
/
set SERVEROUTPUT ON
Begin
    dbms_output.put_line(funcStockAnoEditora('1500','2016' ));
end;

-- #############################################################################################
-- FUNCAO 8)
CREATE OR REPLACE FUNCTION funcPrecoVenda(p_nr_venda Vendas.nr_venda%type) return float
is
    preco_total float;
begin
    select (v.quantidade * pel.preco) into preco_total
    From Precos_edicoes_livros pel 
    where pel.isbn in (select el.Edicoes_livros.isbn
                      FROM Edicoes_livros el 
                      inner join Vendas v
                      on v.isnb=el.isbn
                      where v.nr_venda=p_nr_venda);
    return preco_total;
end;
/

set SERVEROUTPUT ON
Begin
    dbms_output.put_line(funcPrecoVenda(2));
end;



    
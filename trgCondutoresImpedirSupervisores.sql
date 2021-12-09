create or replace trigger trgCondutoresImpedirSupervisores
    after insert or update on condutores
    for each row declare
        data_nascimento_supervisor date;
        data_nascimento_condutor date;
        n_viagens_supervisor int;
        n_viagens_condutor int;
        ex_idade exception;
        ex_viagens exception;
        
    begin
        -- calculo da data de nascimento do condutor supervisor
                select data_nascimento into data_nascimento_supervisor
                from condutores c
                where c.nr_idCivil_supervisor != c.nr_idCivil_condutor;

        -- levantamento da excecao da idade
                if months_between(data_nascimento_condutor, data_nascimento_supervisor) < 5 * 12 then
                    raise ex_idade;
                end if;
        
        -- calculo do numero de viagens efetudas pelo condutor supervisionado
                select count(*) into n_viagens_condutor
                from viagens v
                where v.cod_pedido = (select cod_pedido
                                      from pedidos_viagens pv
                                      where pv.nr_idCivil_condutor = (select nr_idCivil_condutor
                                                                      from condutores c
                                                                      where c.nr_idCivil_condutor = pv.nr_idCivil_condutor
                                                                     )
                                     );
                             
        -- calculo do numero de viagens efetudas pelo condutor supervisor
                select count(*) into n_viagens_supervisor
                    from viagens v
                    where v.cod_pedido = (select cod_pedido
                                          from pedidos_viagens pv
                                          where pv.nr_idCivil_condutor = (select nr_idCivil_supervisor
                                                                          from condutores c
                                                                          where c.nr_idCivil_supervisor = pv.nr_idCivil_condutor
                                                                         )
                                         );
        
        -- levantamento da excecao do numero de viagens
                if n_viagens_condutor > n_viagens_supervisor then
                    raise ex_viagens;
                end if;
        
        -- declaracao das mensagens de cada excecao
                exception
                    when ex_idade then
                        dbms_output.put_line('O supervisor não tem mais 5 anos que o supervisionado!');
                        --raise_application_error(-20001, 'O supervisor não tem mais 5 anos que o supervisionado!');
                    when ex_viagens then
                        dbms_output.put_line('O supervisor não tem mais viagens realizadas que o supervisionado!');
                        --raise_application_error(-20002, 'O supervisor não tem mais viagens realizadas que o supervisionado!');
    end;
    /
    
-- bloco anonimo #1 -> testar a restricao da idade --
alter trigger trgCondutoresImpedirSupervisores enable;

insert into carta_conducao (nr_cartaConducao, data_validade_cartaConducao)
values (12345678, TO_DATE('23-04-2025', 'dd-mm-yyyy'));
insert into condutores (nr_idCivil_condutor, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada)
values (11111111, null, 12345678, 'João António', TO_DATE('23-04-1970', 'dd-mm-yyyy'), 111111112, 'Rua 1');

insert into carta_conducao (nr_cartaConducao, data_validade_cartaConducao)
values (23456789, TO_DATE('18-02-2026', 'dd-mm-yyyy'));
insert into condutores (nr_idCivil_condutor, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada)
values (22222222, 11111111, 23456789, 'Carlos Miguel', TO_DATE('18-02-1971', 'dd-mm-yyyy'), 222222223, 'Rua 56');

alter trigger trgCondutoresImpedirSupervisores disable;

-- bloco anonimo #2 -> testar a restricao do numero de viagens --

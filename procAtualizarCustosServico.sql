CREATE OR REPLACE FUNCTION valorMaisVol
    RETURN Servicos.cod_servico%TYPE
AS
    cod_serv servicos.cod_servico%TYPE;

BEGIN
with CalcularCusto as(
         SELECT CASE WHEN(pv.cancelado = 'N') THEN cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
         + (cs.custo_espera_minuto * v.atraso_passageiro_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
         + (cs.custo_espera_minuto * v.atraso_passageiro_minutos)) * cs.taxa_IVA ELSE cs.custo_cancelamento_pedido END AS custo, pv.nr_idCivil, s.cod_servico, pv.cod_pedido, pv.data_hora_pedido FROM Custos_Servicos cs, 
         Servicos s, Pedidos_Viagens pv, Viagens v
         WHERE( s.cod_servico = cs.cod_servico AND s.cod_servico = pv.cod_servico AND  pv.cod_pedido = v.cod_pedido) and pv.data_hora_pedido between  add_months( trunc(sysdate), -12) and sysdate)
SELECT sT.cod_servico into cod_serv
FROM  (Select cc1.cod_servico, sum(cc1.custo) as soma
        From CalcularCusto cc1
        group by cc1.cod_servico) sT
where  sT.soma = (Select MAX(y.nume)
                               FROM (SELECT SUM(cc2.custo) as nume
                               From CalcularCusto cc2 
                               Group by cod_servico) y);



RETURN cod_serv;
END;


CREATE OR REPLACE PROCEDURE procAtualizarCustosServico(x NUMERIC,
                                                       data_atualizar DATE DEFAULT sysdate)
AS
    n servicos.cod_servico%TYPE;
    data_ultima DATE;
    ex_ultima_atualizacao_tempo_insuficiente EXCEPTION;
    checker int;
BEGIN

    n := valorMaisVol;
    SELECT data_ultima_atualizacao
    INTO
        data_Ultima
    FROM custos_servicos
    WHERE (custos_servicos.cod_servico = n);
    IF (add_months(TRUNC(data_ultima), 6) > data_atualizar)
    THEN
        RAISE ex_ultima_atualizacao_tempo_insuficiente;
    END IF;
    UPDATE custos_servicos
    SET custos_servicos.preco_base= custos_servicos.preco_base * (1 + (x * 0.01)),
        custos_servicos.custo_minuto = custos_servicos.custo_minuto * (1 + (x * 0.01)),
        custos_servicos.custo_espera_minuto = custos_servicos.custo_espera_minuto * (1 + (x * 0.01)),
        custos_servicos.custo_cancelamento_pedido = custos_servicos.custo_cancelamento_pedido * (1 + (x * 0.01)),
        custos_servicos.data_ultima_atualizacao = data_Atualizar
    WHERE cod_servico = n;

EXCEPTION
    WHEN ex_ultima_atualizacao_tempo_insuficiente
        THEN
            raise_application_error(-20001, 'A última atualização não tem 6 meses ainda.');
END;

set SERVEROUTPUT ON
EXEC procAtualizarCustosServico(500);

Select * 
From custos_servicos;


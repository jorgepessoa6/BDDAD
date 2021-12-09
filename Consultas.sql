--a)
with Toyota_counter as
                    (select C.nome, (select count(nr_idCivil)
                    from veiculos_condutores VC2
                    inner join veiculos V on VC2.matricula = V.matricula
                    and upper (marca) like 'TOYOTA'
                    and C.nr_idCivil = VC2.nr_idCivil) as Toyota_count
from condutores C)

select nome from Toyota_counter TC1
where TC1.Toyota_count = (select min(Toyota_count) from Toyota_counter);


--b)
with CalcularCusto as(
 SELECT CASE WHEN(pv.cancelado = 'N') THEN cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
+ (cs.custo_espera_minuto * v.atraso_passageiro_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
+ (cs.custo_espera_minuto * v.atraso_passageiro_minutos)) * cs.taxa_IVA ELSE cs.custo_cancelamento_pedido END AS custo, pv.nr_idCivil, s.cod_servico, pv.cod_pedido FROM Custos_Servicos cs, 
Servicos s, Pedidos_Viagens pv, Viagens v
WHERE( s.cod_servico = cs.cod_servico AND s.cod_servico = pv.cod_servico AND  pv.cod_pedido = v.cod_pedido))

select nr_idCivil, custo, cod_servico
from CalcularCusto c1
where (
   select count(*) from CalcularCusto c2
   where c2.cod_servico = c1.cod_servico and c2.custo >= c1.custo
) <= 3;

--c)
select *
from viagens
where cod_viagem in(
                    select cod_viagem
                    from itinerarios_viagens
                    where (extract (hour from hora_passagem)/60 + extract (minute from hora_passagem))>(
                    
                            select avg ((extract (hour from iv.hora_passagem)/60) + extract (minute from iv.hora_passagem))
                            from itinerarios_viagens iv
                            where cod_ponto_turistico in (
                            
                                    select cod_ponto_turistico
                                    from pontos_turisticos pt
                                    where pt.tipo_ponto_turistico = 'MU'
                                    )
                            )
                    );
--d)
SELECT * FROM Pedidos_Viagens pd
INNER JOIN(SELECT matricula, MAX(data_inicio) AS MaxDataInicio
            FROM Veiculos_condutores vc
            GROUP BY matricula) gm
ON pd.matricula = gm.matricula
AND pd.data_inicio = gm.MaxDataInicio
INNER JOIN(SELECT cod_viagem, cod_pedido
            FROM Viagens v
            WHERE v.duracao_minutos  + v.atraso_passageiro_minutos >= 120) vp
ON vp.cod_pedido = pd.cod_pedido;

--i)
Select c.nome, c.nr_idCivil
From condutores c 
Inner Join pedidos_viagens pv ON C.nr_idCivil = pv.nr_idCivil 
Inner Join viagens v ON v.cod_pedido = pv.cod_pedido
Where (Select COUNT(Distinct  A.nr_idCivil) 
    From (Select pvDif.nr_idCivil, vDif.cod_viagem, pvDif.cod_pedido
        From pedidos_viagens pvDif
        Inner Join viagens vDif ON pvDif.cod_pedido = vDif.cod_pedido
        Where v.cod_viagem = vDif.cod_viagem 
         OR vDif.cod_viagem IN 
            (Select a.cod_viagem 
             From itinerarios_viagens a
             Group by a.cod_viagem 
             Having  not exists 
                (Select iv.cod_ponto_turistico 
                 From itinerarios_viagens iv
                Where v.cod_viagem = iv.cod_viagem
                   Minus
                  Select iv.cod_ponto_turistico  
                 From itinerarios_viagens iv
                 Where a.cod_viagem = iv.cod_viagem)) and v.cod_viagem IN
                        (Select cod_viagem From itinerarios_viagens)) a ) >= 5;

--f)
Select c.nome, c.nr_idCivil, cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)+ (cs.custo_espera_minuto * v.atraso_passageiro_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)+ (cs.custo_espera_minuto * v.atraso_passageiro_minutos)) * cs.taxa_IVA 
FROM condutores c, viagens v, custos_servicos cs, pedidos_viagens p
WHERE p.cod_servico=a.cod_servico and p.cod_pedido=d.cod_pedido 
AND c.nr_idCivil=p.nr_idCivil and nr_idCivil_superior is not NULL and
cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
+ (cs.custo_espera_minuto * v.atraso_passageiro_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
+ (cs.custo_espera_minuto * v.atraso_passageiro_minutos)) * cs.taxa_IVA 
    < (Select avg(  
         e.nr_idCivil,  a.preco_base + (a.custo_minuto * d.duracao_minutos) + (a.custo_km * p.distancia_km)
        + (a.custo_espera_minuto * d.atraso_passageiro_minutos) + ((a.preco_base + (a.custo_minuto * d.duracao_minutos) + (a.custo_km * p.distancia_km)
        + a.custo_espera_minuto * d.atraso_passageiro_minutos)) * a.taxa_IVA 
        FROM Condutores e, VIagens d, custos_servicos a, pedidos_viagens p
        where p.cod_servico=a.cod_servico and p.doc_pedido=d.cod_pediddo and e.nr_idCivil=p.nr_idCivil and nr_idCivil_superior is not null));
    


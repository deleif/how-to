create or replace view superficie_por_parcela_sincb_a as 
SELECT a.codconcentracion,
sum(st_area(a.geom)) / 10000::double precision AS area,
a.refparcela
FROM t01a_parcela a 
inner join t44a_descrcomunidad b on a.numinvesti = b.numinvesti and a.codconcentracion = b.codconcentracion
and a.parcelaexc = 'N' and b.descripcion <> 'DESCUENTOS'
GROUP BY a.codconcentracion, a.refparcela, b.descripcion
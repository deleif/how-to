CREATE or replace view vista_parcelas_por_cb_a as
 SELECT a.numinvesti,
    count(*) AS numlotes,
    a.codconcentracion,
    sum(st_area(a.geom) / 10000::double precision) / count(*)::double precision AS area
   FROM t01a_parcela a  
   	inner join t44a_descrcomunidad b
	 on (a.numinvesti = b.numinvesti and a.codconcentracion = b.codconcentracion )
   and   b.descripcion <> 'DESCUENTOS' 
   and  a.parcelaexc='N'  
  GROUP BY a.numinvesti, a.codconcentracion
  ORDER BY a.numinvesti;
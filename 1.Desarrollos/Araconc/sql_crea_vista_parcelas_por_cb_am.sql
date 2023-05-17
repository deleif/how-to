 create or replace view vista_parcelas_por_cb_am as
 SELECT a.numinvesti,
    count(*) AS numlotes,
    a.codconcentracion,
    sum(st_area(a.geom) / 10000::double precision) / count(*)::double precision AS area
   FROM t01am_parcela a
     JOIN t44am_descrcomunidad b ON a.numinvesti = b.numinvesti AND a.codconcentracion::text = b.codconcentracion::text AND b.descripcion::text <> 'DESCUENTOS'::text AND a.parcelaexc::text = 'N'::text
  GROUP BY a.numinvesti, a.codconcentracion
  ORDER BY a.numinvesti;
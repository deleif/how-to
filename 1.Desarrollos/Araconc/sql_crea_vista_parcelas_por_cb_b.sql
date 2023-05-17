create or replace view vista_parcelas_por_cb_b as
 SELECT t01b_parcela.numinvesti,
    count(*) AS numlotes,
    t01b_parcela.codconcentracion,
    sum(st_area(t01b_parcela.geom) / 10000::double precision) / count(*)::double precision AS area
   FROM t01b_parcela
  GROUP BY t01b_parcela.numinvesti, t01b_parcela.codconcentracion
  ORDER BY t01b_parcela.numinvesti;
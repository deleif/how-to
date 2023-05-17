create or replace view vista_parcelas_por_cb_am
as
 SELECT t01am_parcela.numinvesti,
    count(*) AS numlotes,
    t01am_parcela.codconcentracion,
    sum(st_area(t01am_parcela.geom) / 10000::double precision) / count(*)::double precision AS area
   FROM t01am_parcela
  GROUP BY t01am_parcela.numinvesti, t01am_parcela.codconcentracion
  ORDER BY t01am_parcela.numinvesti;
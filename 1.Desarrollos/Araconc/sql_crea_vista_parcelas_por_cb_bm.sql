create or replace view vista_parcelas_por_cb_bm as
 SELECT t01bm_parcela.numinvesti,
    count(*) AS numlotes,
    t01bm_parcela.codconcentracion,
    sum(st_area(t01bm_parcela.geom) / 10000::double precision) / count(*)::double precision AS area
   FROM t01bm_parcela
  GROUP BY t01bm_parcela.numinvesti, t01bm_parcela.codconcentracion
  ORDER BY t01bm_parcela.numinvesti;
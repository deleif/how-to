create or replace view vista_parcelas_por_propietario_bm as
 SELECT t01bm_parcela.numinvesti,
    count(*) AS numparcelas,
    sum(st_area(t01bm_parcela.geom)) / 10000::double precision AS sum,
    t01bm_parcela.codconcentracion
   FROM t01bm_parcela
  WHERE t01bm_parcela.parcelaexc::text = 'N'::text
  GROUP BY t01bm_parcela.numinvesti, t01bm_parcela.codconcentracion, t01bm_parcela.parcelaexc
  ORDER BY t01bm_parcela.numinvesti;
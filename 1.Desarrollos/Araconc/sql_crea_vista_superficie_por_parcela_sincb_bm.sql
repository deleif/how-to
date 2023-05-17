create or replace view superficie_por_parcela_sincb_bm as
 SELECT t01bm_parcela.codconcentracion,
    sum(st_area(t01bm_parcela.geom)) / 10000::double precision AS area,
    t01bm_parcela.refparcela
   FROM t01bm_parcela
  GROUP BY t01bm_parcela.codconcentracion, t01bm_parcela.refparcela;
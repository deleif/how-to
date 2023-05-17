create or replace view superficie_por_parcela_sincb_am
as
 SELECT t01am_parcela.codconcentracion,
    sum(st_area(t01am_parcela.geom)) / 10000::double precision AS area,
    t01am_parcela.refparcela
   FROM t01am_parcela
  GROUP BY t01am_parcela.codconcentracion, t01am_parcela.refparcela;
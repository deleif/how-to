create or replace view superficie_por_parcela_am as
 SELECT t01am_parcela.codconcentracion,
    sum(st_area(t01am_parcela.geom)) / 10000::double precision AS area,
    t01am_parcela.numinvesti,
    count(*) AS numlotes
   FROM t01am_parcela
  GROUP BY t01am_parcela.codconcentracion, t01am_parcela.numinvesti;



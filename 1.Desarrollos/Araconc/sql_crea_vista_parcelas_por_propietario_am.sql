create or replace view vista_parcelas_por_propietario_am as
SELECT t01am_parcela.numinvesti,
    count(*) AS numparcelas,
    sum(st_area(t01am_parcela.geom)) / 10000::double precision AS sum,
    t01am_parcela.codconcentracion
   FROM t01am_parcela
  WHERE t01am_parcela.parcelaexc::text = 'N'::text
  GROUP BY t01am_parcela.numinvesti, t01am_parcela.codconcentracion, t01am_parcela.parcelaexc
  ORDER BY t01am_parcela.numinvesti;
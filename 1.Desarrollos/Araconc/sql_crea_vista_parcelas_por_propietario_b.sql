create  or replace view vista_parcelas_por_propietario_b as
 SELECT t01b_parcela.numinvesti,
    count(*) AS numparcelas,
    sum(st_area(t01b_parcela.geom)) / 10000::double precision AS sum,
    t01b_parcela.codconcentracion
   FROM t01b_parcela
  WHERE t01b_parcela.parcelaexc::text = 'N'::text
  GROUP BY t01b_parcela.numinvesti, t01b_parcela.codconcentracion, t01b_parcela.parcelaexc
  ORDER BY t01b_parcela.numinvesti;
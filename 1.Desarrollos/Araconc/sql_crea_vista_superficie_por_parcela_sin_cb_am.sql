create or replace view superficie_por_parcela_sincb_am as
SELECT a.codconcentracion,
    sum(st_area(a.geom)) / 10000::double precision AS area,
    a.refparcela
   FROM t01am_parcela a
     JOIN t44am_descrcomunidad b ON a.numinvesti = b.numinvesti AND a.codconcentracion::text = b.codconcentracion::text AND a.parcelaexc::text = 'N'::text AND b.descripcion::text <> 'DESCUENTOS'::text
  GROUP BY a.codconcentracion, a.refparcela, b.descripcion;
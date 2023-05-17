create or replace view vista_lotes_por_propietario_cm as

 SELECT t01cm_lotes.numinvesti,
    count(*) AS numlotes,
    sum(st_area(t01cm_lotes.geom)) / 10000::double precision AS sum,
    t01cm_lotes.codconcentracion
   FROM t01cm_lotes
  GROUP BY t01cm_lotes.numinvesti, t01cm_lotes.codconcentracion
  ORDER BY t01cm_lotes.numinvesti;
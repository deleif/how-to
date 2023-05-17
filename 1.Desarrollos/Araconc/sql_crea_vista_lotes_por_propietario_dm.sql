create or replace view vista_lotes_por_propietario_dm as
 SELECT t01dm_lotes.numinvesti,
    count(*) AS numlotes,
    sum(st_area(t01dm_lotes.geom)) / 10000::double precision AS sum,
    t01dm_lotes.codconcentracion
   FROM t01dm_lotes
  GROUP BY t01dm_lotes.numinvesti, t01dm_lotes.codconcentracion
  ORDER BY t01dm_lotes.numinvesti;
insert into grupoanaliticas (name,jerarquia) values ('Analizador TOC', 9)

insert into tipoanaliticas (name,metodologia,udanalitica,udvolumen,grupoanalitica_id,limiteparam,visible,udgas)
values('TC(liq)','Oxidación Catalítica','mg/L','%',9,1,1,'mg/L');
insert into tipoanaliticas (name,metodologia,udanalitica,udvolumen,grupoanalitica_id,limiteparam,visible,udgas)
values('IC(liq)','Oxidación Catalítica','mg/L','%',9,1,1,'mg/L');
insert into tipoanaliticas (name,metodologia,udanalitica,udvolumen,grupoanalitica_id,limiteparam,visible,udgas)
values('TOC(liq)','Oxidación Catalítica','mg/L','%',9,1,1,'mg/L');
insert into tipoanaliticas (name,metodologia,udanalitica,udvolumen,grupoanalitica_id,limiteparam,visible,udgas)
values('TN(liq)','Oxidación Catalítica','mg/L','mg/L',9,1,1,'mg/L');



CREATE OR REPLACE VIEW public.v_grafico_analizadortoc
 AS
 SELECT a.punto_id,
    t.id,
    to_char(a.fechaanalitica, 'DD-MM-YYYY'::text) AS fecha,
    t.name,
    avg(
        CASE
            WHEN r.resultado > a.limitevolatil THEN r.resultado
            ELSE 0::numeric
        END) AS resultado
   FROM analiticas a
     JOIN resultados r ON a.id = r.analitica_id
     JOIN tipoanaliticas t ON t.id = r.tipoanalitica_id
     JOIN grupoanaliticas g ON g.id = t.grupoanalitica_id
  WHERE g.id = 9 AND t.visible = 1
  GROUP BY a.fechaanalitica, a.limitevolatil, t.name, a.punto_id, t.id;

ALTER TABLE public.v_grafico_analizadortoc
    OWNER TO postgres;
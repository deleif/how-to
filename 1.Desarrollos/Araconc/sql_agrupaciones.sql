ALTER TABLE t44_descrcomunidad ADD numagrupacion integer;
ALTER TABLE t56_agrupaciones ADD numagrupacion2 integer;
ALTER TABLE t56_agrupaciones ADD descripcion text;

--CREA LA FUNCIÓN PARA NUMERAR LAS AGRUPACIONES BIEN
ALTER TABLE public.t56_agrupaciones
    ADD CONSTRAINT unique_codconcentracion_numagrupacion2 UNIQUE(codconcentracion, numagrupacion2);

CREATE OR REPLACE FUNCTION AutoincrementoAgrupaciones() RETURNS trigger AS $body_start$
BEGIN
    SELECT COALESCE(MAX(numagrupacion2) + 1, 1)
        INTO NEW.numagrupacion2
        FROM public.t56_agrupaciones
        WHERE codconcentracion = NEW.codconcentracion;
    RETURN NEW;
END;
$body_start$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerAgrupaciones BEFORE INSERT ON public.t56_agrupaciones
    FOR EACH ROW
    WHEN (NEW.numagrupacion2 IS NULL) 
    EXECUTE PROCEDURE AutoincrementoAgrupaciones();

--AÑADE RESTRICCIÓN UNIQUE codconcentracion,numagrupacion2 a t56_agrupaciones
ALTER TABLE IF EXISTS public.t56_agrupaciones
    ADD CONSTRAINT unique_codconcentracion_numagrupacion UNIQUE (codconcentracion, numagrupacion2);

--AÑADE CLAVE FORÁNEA A t44
ALTER TABLE IF EXISTS public.t44_descrcomunidad
    ADD CONSTRAINT fk_t44_numagrupacion2 FOREIGN KEY (codconcentracion, numagrupacion)
    REFERENCES public.t56_agrupaciones (codconcentracion, numagrupacion2) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;
	
ALTER TABLE public.t44_descrcomunidad DROP CONSTRAINT fk_t56_numinvesti1;
ALTER TABLE public.t44_descrcomunidad DROP CONSTRAINT fk_t56_numinvesti2;


create or replace view vista_veratribucionesagrupacion as
 SELECT a.idlote,
    a.reflote,
    a.lote,
    a.codconcentracion,
    a.numinvesti,
    b.numagrupacion,
    a.geom
   FROM t01_lotes a
     JOIN t44_descrcomunidad b ON a.numinvesti = b.numinvesti AND a.codconcentracion::text = b.codconcentracion::text;


create or replace view vista_veraportacionesagrupacion AS SELECT a.idparcela,
    a.refparcela,
    a.codconcentracion,
    a.codsubperimetro,
    a.numinvesti,
    b.numagrupacion,
    a.geom
   FROM t01_parcela a
     JOIN t44_descrcomunidad b ON a.numinvesti = b.numinvesti AND a.codconcentracion::text = b.codconcentracion::text;





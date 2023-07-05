# CONVIERTE UN PORCENTAJE (ENTERO) A FRACCIÓN

* Utiliza la función __procmcd que calcula el Máximo Común Divisor de dos números

``` 
CREATE OR REPLACE FUNCTION __procobtenerfraccion(porcentaje NUMERIC)
  RETURNS TEXT AS
$$
DECLARE

  fraccion TEXT;
  valor NUMERIC;
BEGIN
	valor := __procmcd (cast((porcentaje *10000000) as integer) , 1000000000);	
	fraccion :=  cast((porcentaje *10000000 / valor ) as integer) || '/' || cast( 1000000000 / valor  as integer);
  RETURN fraccion;
  
END;
$$
LANGUAGE plpgsql;

``` 
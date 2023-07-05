# CALCULA MÁXIMO COMÚN DIVISOR DE DOS NÚMEROS

``` 
CREATE OR REPLACE FUNCTION public.__procmcd(a INT, b INT)
  RETURNS INTEGER AS
$$
DECLARE
  divisor INTEGER;
BEGIN
  IF b = 0 THEN
    RETURN a;
  END IF;
  divisor := a % b;
  RETURN __procmcd(b, divisor);
END;
$$
LANGUAGE plpgsql;

```

create or replace view tg10_t15_t12_proyecto_modificado as
SELECT t10.idclase,
    t10.clase,
    t10.geom,
    t10.reflote,
    s1.numclase,
    s1.puntos,
    s1.descripcion,
    s1.idclaseterr,
    s1.idsubperimetro,
    s1.nombresubperimetro,
    s1.numsubperimetro,
    s1.tipo,
    t10.codconcentracion
   FROM tg10cm_clase t10
     JOIN ( SELECT t15.memoclase,
            t15.numclase,
            t15.puntos,
            t15.descripcion,
            t15.codconcentracion,
            t15.idclaseterr,
            t15.regadio,
            s2.idsubperimetro,
            s2.codconcentracion,
            s2.nombresubperimetro,
            s2.numsubperimetro,
            s2.tipo,
            s2.cod12,
            t15.codconcentracion AS cod15
           FROM t15_claseterr t15
             JOIN ( SELECT t12_subperimetros.idsubperimetro,
                    t12_subperimetros.codconcentracion,
                    t12_subperimetros.nombresubperimetro,
                    t12_subperimetros.numsubperimetro,
                    t12_subperimetros.tipo,
                    t12_subperimetros.codconcentracion AS cod12
                   FROM t12_subperimetros) s2 ON s2.cod12::text = t15.codconcentracion::text AND s2.numsubperimetro = t15.regadio) s1(memoclase, numclase, puntos, descripcion, codconcentracion, idclaseterr, regadio, idsubperimetro, codconcentracion_1, nombresubperimetro, numsubperimetro, tipo, cod12, cod15) ON s1.memoclase::text = t10.clase::text AND s1.cod15::text = t10.codconcentracion::text;
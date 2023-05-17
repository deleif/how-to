--b3 2aselect *
from
((select t44a_descrcomunidad.numinvesti as num,
1 as nivel,
t44a_descrcomunidad.descripcion as nombretmp,
t44a_descrcomunidad.descripcion as nombre,
'' dni,
'' as residencia,
'' as estadocivil,
'' as nombreconyu,
'' as dniconyu,
(select count(*) from t02a_titulares where t44a_descrcomunidad.numinvesti = t02a_titulares.numinvesti and t44a_descrcomunidad.codconcentracion = t02a_titulares.codconcentracion) as numtit,
0 as comprobarnumtit
from t44a_descrcomunidad
inner join t01a_parcela on t01a_parcela.numinvesti = t44a_descrcomunidad.numinvesti and t44a_descrcomunidad.codconcentracion = t01a_parcela.codconcentracion
where t44a_descrcomunidad.codconcentracion=$P{codconcentracion} and t44a_descrcomunidad.descripcion<> 'DESCUENTOS')
union
(select t44a_descrcomunidad.numinvesti as num,
2 as nivel,
t44a_descrcomunidad.descripcion as nombretmp,
t17a_datospersonales.nombreapellidos as nombre,
t17a_datospersonales.dnipropieta as dni,
t17a_datospersonales.domicilio1||' '||t17a_datospersonales.domicilio2 as residencia,
CASE WHEN t17a_datospersonales.estado = '1' THEN 'S'
     WHEN t17a_datospersonales.estado = '2' THEN 'C'
     WHEN t17a_datospersonales.estado = '3' THEN 'V'
     WHEN t17a_datospersonales.estado = '4' THEN 'SE'
     WHEN t17a_datospersonales.estado = '5' THEN 'D'
     ELSE ''
END as estadocivil,
(select nombreapellidos from t17a_datospersonales as dp where t17a_datospersonales.dniconyuge = dp.dnipropieta  and t17a_datospersonales.codconcentracion=codconcentracion) as nombreconyu,
t17a_datospersonales.dniconyuge as dniconyu,
0 as numtit,
(select count(*) from t02a_titulares where t44a_descrcomunidad.numinvesti = t02a_titulares.numinvesti and t44a_descrcomunidad.codconcentracion = t02a_titulares.codconcentracion) as comprobarnumtit
from t44a_descrcomunidad
 inner join t02a_titulares on t44a_descrcomunidad.numinvesti = t02a_titulares.numinvesti and t44a_descrcomunidad.codconcentracion = t02a_titulares.codconcentracion
 inner join t17a_datospersonales on t02a_titulares.dnipropieta=t17a_datospersonales.dnipropieta and t02a_titulares.codconcentracion=t17a_datospersonales.codconcentracion
inner join t01a_parcela on t01a_parcela.numinvesti = t44a_descrcomunidad.numinvesti and t44a_descrcomunidad.codconcentracion = t01a_parcela.codconcentracion
where t44a_descrcomunidad.codconcentracion=$P{codconcentracion} and t17a_datospersonales.codconcentracion=$P{codconcentracion} and t44a_descrcomunidad.descripcion<> 'DESCUENTOS' and t01a_parcela.parcelaexc='N')
 order by num,nivel,nombre) as a
 where numtit<>1
and nombre!= 'MASA COMUN'
and (0=$P{auxcomunidad} or (1=$P{auxcomunidad} and num>=$P{cb1} and num <=$P{cb2}));
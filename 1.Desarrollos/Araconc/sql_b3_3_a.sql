select
titconc.numinvesti as numinvestipropieta,
(select numinvesti from t02a_titulares where t02a_titulares.codconcentracion='5408101' and dnipropieta=t17a_datospersonales.dnirepresenta limit 1) as numinvestirepresentante,
t17a_datospersonales.nombreapellidos as nombre,
(select nombreapellidos from t17a_datospersonales as dp where dp.dnipropieta=t17a_datospersonales.dnirepresenta and t17a_datospersonales.codconcentracion=codconcentracion) as nombrerep,
t17a_datospersonales.dnirepresenta as dnirep,
(select domicilio1||' '||domicilio2 from t17a_datospersonales as dp where dp.dnipropieta=t17a_datospersonales.dnirepresenta and t17a_datospersonales.codconcentracion=codconcentracion) as domiciliorep
from t17a_datospersonales
inner join (select distinct(dnipropieta) as dnipropieta,numinvesti from t02a_titulares where t02a_titulares.codconcentracion='5408101' 
) as titconc on titconc.dnipropieta = t17a_datospersonales.dnipropieta
where t17a_datospersonales.dnirepresenta is not null and t17a_datospersonales.codconcentracion='5408101'
order by numinvestipropieta
/*crea fase vigente*/

/*crea tablas*/

create table t01v_lotes ( like t01c_lotes including all);
create table t02v_titulares ( like t02c_titulares including all);
create table t11v_cargas ( like t11c_cargas including all);
create table t44v_descrcomunidad ( like t44c_descrcomunidad including all);
create table tg10v_clase ( like tg10c_clase including all);
create table tg54v_masas ( like tg54c_masas including all); 
create table t17v_datospersonales ( like t17c_datospersonales including all); 



//añadir a proceso 5
	-- Traspaso de parcelas y clases entre los diferentes estados de la concentración 
	IF tipotraspaso = 'Vigente' THEN
		DELETE FROM public.t01v_lotes WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02v_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11v_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44v_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10v_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg54v_masas WHERE codconcentracion=vcodconcentracion;
		DELETE FROM public.t17v_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		insert into t01v_lotes(reflote,codconcentracion,numinvesti,poligono,masa,lote,numcarga,tipologia,sublote,justificacion,tipojustificacion,idnaturbienes,dnicultivador,codfinca,periferia,geom,provincia,municipio)  
		select reflote, codconcentracion, numinvesti, poligono, masa, lote, numcarga, tipologia, sublote, justificacion, tipojustificacion,idnaturbienes, dnicultivador, codfinca, periferia,t01.geom,(left((codmuni::Character varying),2))::integer as prov,(right((codmuni::Character varying),3))::integer as muni
		from tg12_municipios tg12,t01_lotes t01 where st_intersects(ST_PointOnSurface(t01.geom),tg12.geom)	and t01.codconcentracion=vcodconcentracion;
		
		INSERT INTO public.t02v_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11v_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44v_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17v_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc21_asignarrefparcelaalote(vcodconcentracion,tipotraspaso);

	END IF;
	
	/*añadir a proc 21*/
			select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon' or  tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10v_clase(geom,reflote,clase,numinvesti,codconcentracion,subperimetro) values (r_clases.geom,r_clases.reflote,r_clases.clase,r_clases.numinvesti,vcodconcentracion,subperimetro);
			end if;
		end if;
 
  DECLARE 

  BEGIN

	-- Traspaso de parcelas y clases entre los diferentes estados de la concentración 
	IF tipotraspaso = 'Bases provisionales' THEN
		DELETE FROM public.t01a_parcela WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02a_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11a_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44a_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10a_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t17a_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		INSERT INTO t01a_parcela(
		idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup)
		select idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup
		from t01_parcela where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t02a_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11a_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44a_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17a_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;
		
		perform   __proc20_asignarrefparcelaaclase(vcodconcentracion,tipotraspaso);

	END IF;
	IF tipotraspaso = 'Bases definitivas' THEN
		DELETE FROM public.t01b_parcela WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02b_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11b_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44b_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10b_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t17b_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		INSERT INTO t01b_parcela(
		idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup)
		select idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup
		from t01_parcela where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t02b_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11b_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44b_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17b_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc20_asignarrefparcelaaclase(vcodconcentracion,tipotraspaso);

	END IF;
	IF tipotraspaso = 'Modulo proyecto' THEN
		DELETE FROM public.t01c_lotes WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02c_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11c_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44c_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10c_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg54c_masas WHERE codconcentracion=vcodconcentracion;
		DELETE FROM public.t17c_datospersonales WHERE codconcentracion= vcodconcentracion;

		insert into t01c_lotes(reflote,codconcentracion,numinvesti,poligono,masa,lote,numcarga,tipologia,sublote,justificacion,tipojustificacion,idnaturbienes,dnicultivador,codfinca,periferia,geom,provincia,municipio)  
		select reflote, codconcentracion, numinvesti, poligono, masa, lote, numcarga, tipologia, sublote, justificacion, tipojustificacion,idnaturbienes, dnicultivador, codfinca, periferia,t01.geom,(left((codmuni::Character varying),2))::integer as prov,(right((codmuni::Character varying),3))::integer as muni
		from tg12_municipios tg12,t01_lotes t01 where st_intersects(ST_PointOnSurface(t01.geom),tg12.geom)	and t01.codconcentracion=vcodconcentracion;
		
		INSERT INTO public.t02c_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11c_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44c_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17c_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc21_asignarrefparcelaalote(vcodconcentracion,tipotraspaso);

		INSERT INTO public.tg54c_masas(codconcentracion, geom, info, poligono, masa,subperimetro)
		select codconcentracion, geom, info, poligono, masa,subperimetro
		from tg54_masas where codconcentracion=vcodconcentracion;
		
	END IF;
	IF tipotraspaso = 'Modulo acuerdo' THEN
		DELETE FROM public.t01d_lotes WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02d_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11d_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44d_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10d_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg54d_masas WHERE codconcentracion=vcodconcentracion;
		DELETE FROM public.t17d_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		insert into t01d_lotes(reflote,codconcentracion,numinvesti,poligono,masa,lote,numcarga,tipologia,sublote,justificacion,tipojustificacion,idnaturbienes,dnicultivador,codfinca,periferia,geom,provincia,municipio)  
		select reflote, codconcentracion, numinvesti, poligono, masa, lote, numcarga, tipologia, sublote, justificacion, tipojustificacion,idnaturbienes, dnicultivador, codfinca, periferia,t01.geom,(left((codmuni::Character varying),2))::integer as prov,(right((codmuni::Character varying),3))::integer as muni
		from tg12_municipios tg12,t01_lotes t01 where st_intersects(ST_PointOnSurface(t01.geom),tg12.geom)	and t01.codconcentracion=vcodconcentracion;
		
		INSERT INTO public.t02d_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11d_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44d_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17d_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc21_asignarrefparcelaalote(vcodconcentracion,tipotraspaso);

		INSERT INTO public.tg54d_masas(codconcentracion, geom, info, poligono, masa,subperimetro)
		select codconcentracion, geom, info, poligono, masa,subperimetro
		from tg54_masas where codconcentracion=vcodconcentracion;
		
	END IF;
    
    IF tipotraspaso = 'Bases provisionales modificadas' THEN
		DELETE FROM public.t01am_parcela WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02am_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11am_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44am_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10am_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t17am_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		INSERT INTO t01am_parcela(
		idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup)
		select idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup
		from t01_parcela where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t02am_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11am_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44am_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17am_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;
		
		perform   __proc20_asignarrefparcelaaclase(vcodconcentracion,tipotraspaso);

	END IF;
    
    IF tipotraspaso = 'Bases definitivas modificadas' THEN
		DELETE FROM public.t01bm_parcela WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02bm_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11bm_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44bm_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10bm_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t17bm_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		INSERT INTO t01bm_parcela(
		idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup)
		select idnotario, codparaje, iddocumento, idnaturbienes, idadquisicion, idsituregist, refparcela, codconcentracion, provcat, muncat, codcatast, numinvesti, numcarga, sistexplot, dnicultivador, parcelaexc, parcelainc, parcelatip, tomo, libro, folio, finca, inscripcion, descripcion, pobregistro, supfija, supcatastro, documentacion, numprotocolo, fechaemision, tipodocumento, motivoex, desccatast, geom, cultsubparc, regadio, codsubperimetro, hoja, peticion, tipo,tipologia,etiqueta,idregistroparcela,area,backup
		from t01_parcela where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t02bm_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11bm_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44bm_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17bm_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc20_asignarrefparcelaaclase(vcodconcentracion,tipotraspaso);

	END IF;
    
    IF tipotraspaso = 'Modulo proyecto modificado' THEN
		DELETE FROM public.t01cm_lotes WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02cm_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11cm_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44cm_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10cm_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg54cm_masas WHERE codconcentracion=vcodconcentracion;
		DELETE FROM public.t17cm_datospersonales WHERE codconcentracion= vcodconcentracion;

		insert into t01cm_lotes(reflote,codconcentracion,numinvesti,poligono,masa,lote,numcarga,tipologia,sublote,justificacion,tipojustificacion,idnaturbienes,dnicultivador,codfinca,periferia,geom,provincia,municipio)  
		select reflote, codconcentracion, numinvesti, poligono, masa, lote, numcarga, tipologia, sublote, justificacion, tipojustificacion,idnaturbienes, dnicultivador, codfinca, periferia,t01.geom,(left((codmuni::Character varying),2))::integer as prov,(right((codmuni::Character varying),3))::integer as muni
		from tg12_municipios tg12,t01_lotes t01 where st_intersects(ST_PointOnSurface(t01.geom),tg12.geom)	and t01.codconcentracion=vcodconcentracion;
		
		INSERT INTO public.t02cm_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11cm_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44cm_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17cm_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc21_asignarrefparcelaalote(vcodconcentracion,tipotraspaso);

		INSERT INTO public.tg54cm_masas(codconcentracion, geom, info, poligono, masa,subperimetro)
		select codconcentracion, geom, info, poligono, masa,subperimetro
		from tg54_masas where codconcentracion=vcodconcentracion;
		
	END IF;
    
    	IF tipotraspaso = 'Modulo acuerdo modificado' THEN
		DELETE FROM public.t01dm_lotes WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t02dm_titulares WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t11dm_cargas WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.t44dm_descrcomunidad WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg10dm_clase WHERE codconcentracion= vcodconcentracion;
		DELETE FROM public.tg54dm_masas WHERE codconcentracion=vcodconcentracion;
		DELETE FROM public.t17dm_datospersonales WHERE codconcentracion= vcodconcentracion;
		
		insert into t01dm_lotes(reflote,codconcentracion,numinvesti,poligono,masa,lote,numcarga,tipologia,sublote,justificacion,tipojustificacion,idnaturbienes,dnicultivador,codfinca,periferia,geom,provincia,municipio)  
		select reflote, codconcentracion, numinvesti, poligono, masa, lote, numcarga, tipologia, sublote, justificacion, tipojustificacion,idnaturbienes, dnicultivador, codfinca, periferia,t01.geom,(left((codmuni::Character varying),2))::integer as prov,(right((codmuni::Character varying),3))::integer as muni
		from tg12_municipios tg12,t01_lotes t01 where st_intersects(ST_PointOnSurface(t01.geom),tg12.geom)	and t01.codconcentracion=vcodconcentracion;
		
		INSERT INTO public.t02dm_titulares(codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart)
		select codconcentracion, idnaturbienes, numinvesti, dnipropieta, coefpart, comentario, tipopart
		from t02_titulares where codconcentracion = vcodconcentracion;
		
		INSERT INTO public.t11dm_cargas(numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo)
		select numcarga, dnibeneficiario, tipocarga, sitregcarga, nombrenotario, localidaddomnotario, fechadocumento, cuotausufructuaria, filler, coefpropiedad, temporalidadcarga, tiempocarga, tipodocumento, numdeclaracion, numpresentacion, idjuzgado, orgpresentacion, descripcion, iddocumento, simultaneo, memodelote, numinvesti, codconcentracion, numprotocolo,memoproyecto,memoacuerdo
		from t11_cargas where codconcentracion = vcodconcentracion;

		INSERT INTO public.t44dm_descrcomunidad( numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto)
		select  numinvesti, descripcion, codconcentracion, comentario, codexp, totalpuntos, puntosfaltan, investigado, numsubperimetro,texto
		from t44_descrcomunidad where codconcentracion = vcodconcentracion;

		INSERT INTO public.t17dm_datospersonales(dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,codconcentracion,capitulacionmatrimonial)
		SELECT  t17_datospersonales.dnipropieta, estadotit, nombreapellidos, persojur, sexo, fechanaci, estado, hijos, domicilio1, domicilio2, codfiscal, dniconyuge, dnirepresenta, telefonopropieta, telefonopropieta2, email, regimeneconomicomatrimonial, vecindadcivil,vcodconcentracion,capitulacionmatrimonial
		FROM public.t17_datospersonales;

		perform   __proc21_asignarrefparcelaalote(vcodconcentracion,tipotraspaso);

		INSERT INTO public.tg54dm_masas(codconcentracion, geom, info, poligono, masa,subperimetro)
		select codconcentracion, geom, info, poligono, masa,subperimetro
		from tg54_masas where codconcentracion=vcodconcentracion;
		
	END IF;

	RETURN 1;
		
END;  
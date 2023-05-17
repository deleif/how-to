 
  DECLARE 
-- cursor con los cortes de las geometrias
	vc_clases CURSOR FOR select (st_dump((ST_CollectionExtract(st_intersection(tg10.geom,t01.geom),3)))).geom as geom,reflote,clase,numinvesti
				from t01_lotes t01,tg10_clase tg10				
				where t01.codconcentracion = vcodconcentracion and tg10.codconcentracion = vcodconcentracion and st_intersects(tg10.geom,t01.geom) and st_area(st_intersection(tg10.geom,t01.geom))>0.001
				order by reflote;


	r_clases RECORD;
subperimetro integer;
tipo character varying;	
  BEGIN
tipo = '';
	--recogemos todas las geometrias
	OPEN vc_clases;
		LOOP
		FETCH vc_clases  INTO r_clases;
		exit when NOT FOUND;
		IF tipotraspaso = 'Modulo proyecto' THEN
		select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon' or tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10c_clase(geom,reflote,clase,numinvesti,codconcentracion,subperimetro) values (r_clases.geom,r_clases.reflote,r_clases.clase,r_clases.numinvesti,vcodconcentracion,subperimetro);
			end if;
		end if;
		IF tipotraspaso = 'Modulo acuerdo' THEN
		select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon' or  tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10d_clase(geom,reflote,clase,numinvesti,codconcentracion,subperimetro) values (r_clases.geom,r_clases.reflote,r_clases.clase,r_clases.numinvesti,vcodconcentracion,subperimetro);
			end if;
		end if;
		IF tipotraspaso = 'Modulo proyecto modificado' THEN
		select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon' or  tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10cm_clase(geom,reflote,clase,numinvesti,codconcentracion,subperimetro) values (r_clases.geom,r_clases.reflote,r_clases.clase,r_clases.numinvesti,vcodconcentracion,subperimetro);
			end if;
		end if;
		IF tipotraspaso = 'Modulo acuerdo modificado' THEN
		select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon' or  tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10dm_clase(geom,reflote,clase,numinvesti,codconcentracion,subperimetro) values (r_clases.geom,r_clases.reflote,r_clases.clase,r_clases.numinvesti,vcodconcentracion,subperimetro);
			end if;
		end if;
		
	END LOOP;
	CLOSE vc_clases;



	return 1;
	
		
END;  
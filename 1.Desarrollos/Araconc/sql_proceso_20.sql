 
  DECLARE 
-- cursor con los cortes de las geometrias
	vc_clases CURSOR FOR select (st_dump(st_intersection(tg10.geom,t01.geom))).geom as geom,refparcela,clase,numinvesti,t01.supfija
				from t01_parcela t01,tg10_clase tg10				
				where t01.codconcentracion = vcodconcentracion and tg10.codconcentracion = vcodconcentracion and st_intersects(tg10.geom,t01.geom) and st_area(st_intersection(tg10.geom,t01.geom))>0.001
				
				order by refparcela;


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
		IF tipotraspaso = 'Bases provisionales' THEN
			select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon'or tipo='ST_Multipolygon' then
				
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10a_clase(geom,refparcela,clase,numinvesti,supfija,codconcentracion,subperimetro) values (r_clases.geom,r_clases.refparcela,r_clases.clase,r_clases.numinvesti,r_clases.supfija,vcodconcentracion,subperimetro);
			end if;
		end if;
		IF tipotraspaso = 'Bases provisionales modificadas' THEN
			select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon'or tipo='ST_Multipolygon' then
				
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10am_clase(geom,refparcela,clase,numinvesti,supfija,codconcentracion,subperimetro) values (r_clases.geom,r_clases.refparcela,r_clases.clase,r_clases.numinvesti,r_clases.supfija,vcodconcentracion,subperimetro);
			end if;
		end if;
		IF tipotraspaso = 'Bases definitivas' THEN
		select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon'or tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10b_clase(geom,refparcela,clase,numinvesti,supfija,codconcentracion,subperimetro) values (r_clases.geom,r_clases.refparcela,r_clases.clase,r_clases.numinvesti,r_clases.supfija,vcodconcentracion,subperimetro);
			end if;
		end if;
        IF tipotraspaso = 'Bases definitivas modificadas' THEN
		select ST_GeometryType(r_clases.geom)into tipo;
			if tipo = 'ST_Polygon'or tipo='ST_Multipolygon' then
				select regadio into subperimetro from t15_claseterr where t15_claseterr.codconcentracion = vcodconcentracion and memoclase=r_clases.clase;
				insert into tg10bm_clase(geom,refparcela,clase,numinvesti,supfija,codconcentracion,subperimetro) values (r_clases.geom,r_clases.refparcela,r_clases.clase,r_clases.numinvesti,r_clases.supfija,vcodconcentracion,subperimetro);
			end if;
		end if;
		
	END LOOP;
	CLOSE vc_clases;



	return 1;
	
		
END;    
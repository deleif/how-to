/*bases provisionales modificadas*/
create table t01am_parcela ( like t01a_parcela including all);
create table t02am_titulares ( like t02a_titulares including all);
create table t11am_cargas ( like t11a_cargas including all);
create table t44am_descrcomunidad ( like t44a_descrcomunidad including all);
create table tg10am_clase ( like tg10a_clase including all);
create table t17am_datospersonales ( like t17a_datospersonales including all); 

/*bases definitivas modificadas*/
create table t01bm_parcela ( like t01b_parcela including all);
create table t02bm_titulares ( like t02b_titulares including all);
create table t11bm_cargas ( like t11b_cargas including all);
create table t44bm_descrcomunidad ( like t44b_descrcomunidad including all);
create table tg10bm_clase ( like tg10b_clase including all);
create table t17bm_datospersonales ( like t17b_datospersonales including all); 

/*proyecto modificado*/
create table t01cm_lotes ( like t01c_lotes including all);
create table t02cm_titulares ( like t02c_titulares including all);
create table t11cm_cargas ( like t11c_cargas including all);
create table t44cm_descrcomunidad ( like t44c_descrcomunidad including all);
create table tg10cm_clase ( like tg10c_clase including all);
create table tg54cm_masas ( like tg54c_masas including all); 
create table t17cm_datospersonales ( like t17c_datospersonales including all); 

/*acuerdo modificado*/
create table t01dm_lotes ( like t01d_lotes including all);
create table t02dm_titulares ( like t02d_titulares including all);
create table t11dm_cargas ( like t11d_cargas including all);
create table t44dm_descrcomunidad ( like t44d_descrcomunidad including all);
create table tg10dm_clase ( like tg10d_clase including all);
create table tg54dm_masas ( like tg54d_masas including all); 
create table t17dm_datospersonales ( like t17d_datospersonales including all); 


insert into SYS_DB_VERSION values('5012',sysdate);

--Ìí¼Ó¼æÖ°¸ÚÎ»
alter table EMP_CONPOST add  CON_POSTID1 varchar2(32);
alter table EMP_CONPOST add  CON_POSTID2 varchar2(32);

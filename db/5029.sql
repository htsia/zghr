
insert into SYS_DB_VERSION values('5029',sysdate);

--修改系统管理导航图
insert into sys_navigate (NAVI_ID, MODULE_ID, OPERATE_ID, COORDS)
values ('0891', 'XTGL', '0891', '130,75,190,150');

insert into SYS_DB_VERSION values('5024',sysdate);


--人员异动导航图增加人员划转
insert into sys_navigate (NAVI_ID, MODULE_ID, OPERATE_ID, COORDS)
values ('0329', 'RYDP', '0329', '435,270,505,335');


insert into SYS_DB_VERSION values('5011',sysdate);

--添加人员是否验证编制
insert into sys_parameter (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN, ROWID)
values ('CHECK_POST_WEAVE', '0', null, null, null, null, null);

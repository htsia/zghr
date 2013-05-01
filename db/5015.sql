
insert into SYS_DB_VERSION values('5015',sysdate);

--公共查询、统计权限
insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('131201', '公共查询', null, '2', '0003000900010001', '1312', 'RYGL', '0', null, '1', null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('131301', '公用统计', null, '2', '0003000900020001', '1313', 'RYGL', '0', null, '1', null, null, null, null, null, null, null, null, null, null, null, null);


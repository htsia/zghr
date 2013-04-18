insert into SYS_DB_VERSION values('5005',sysdate);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('0225', '岗位排序', '/post/sort/postSortIndex.jsf', '1', '000200010006', '0215', 'GWGL', '0', null, '1', null, null, null, '编制管理', '編制管理', 'Preparation Manager', null, null, null, null, null, null);

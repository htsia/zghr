
insert into SYS_DB_VERSION values('5017',sysdate);

--计算工资保存临时数据
insert into sys_parameter (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('WAGE_FOR_STATISTIC', '1', null, null, null, null);

insert into SYS_DB_VERSION values('5017',sysdate);

--���㹤�ʱ�����ʱ����
insert into sys_parameter (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('WAGE_FOR_STATISTIC', '1', null, null, null, null);
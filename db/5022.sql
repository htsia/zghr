
insert into SYS_DB_VERSION values('5022',sysdate);


--添加工资临时数据标识字段
alter table A815 add tempflag char(1);
insert into SYS_DB_VERSION values('5004',sysdate);

alter table SYS_NEWS_PARA add itemOrder varchar2(50);
alter table train_courcewareitem add top char(1);
alter table train_courcewareitem add itemOrder varchar2(50);

insert into SYS_DB_VERSION values('5018',sysdate);

--×ªÕıÉèÖÃ
alter table org_probation add jianxi varchar(50);

update org_probation p set p.jianxi=p.normail_type;

update org_probation p set p.normail_type=null;
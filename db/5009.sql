
insert into SYS_DB_VERSION values('5009',sysdate);

alter table sys_info_item add item_class char(1);

alter table sys_info_item add jbm number;

update sys_info_item s set jbm=to_number(substr(item_id,5)) where len(s.item_id)=7 and s.item_id not in ('PARTYID','POSTID','ORGUID') and  s.item_id not like '%000';

update sys_info_item s set s.item_class=1 where jbm is not null and jbm<200;
update sys_info_item s set s.item_class=2 where jbm is not null and jbm>=700;

alter table sys_info_item drop column jbm;
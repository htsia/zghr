--数据库升级版本
insert into SYS_DB_VERSION values('5004',sysdate);

alter table rpt_set_user add role_id varchar2(32);
alter table sys_rpt_operate_r add role_id varchar2(32);
alter table sys_rpt_operate_r drop column person_id;

update sys_operate s set s.is_use=null where s.operate_id in ('0921','0924');

create or replace view v_userrptinfo as
select
contentid,role_id as RID,OPERATE_ID as OID,r.RPTCODE as RPTID,DESCRIPTION as
RPTNAME,SHOW_QUE,PRPTCODE as RptDir,case PRPTCODE when 0 then '统计表' when 1 then
'登记表' when 2 then '花名册' when 3 then '台账' else (select description from rpt_info
where rptcode=c.prptcode) end as RPT_DIR_NAME,achives_Type,rpttype,datatype,wage_sets from
sys_rpt_operate_r r left join rpt_info c on r.rptcode=c.rptcode left join
RPT_PROPERTY d on c.rptcode=d.rptcode;
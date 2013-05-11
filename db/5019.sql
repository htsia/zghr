
insert into SYS_DB_VERSION values('5019',sysdate);

--人员类别变动设置
-- Create table
create table ORG_TYPECHANGE
(
  orguid    VARCHAR2(32) not null,
  wage_item VARCHAR2(1000)
)
tablespace DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    minextents 1
    maxextents unlimited
  );

-- Create table
create table EMP_TYPECHANGE
(
  typechange_id     VARCHAR2(50),
  person_id         VARCHAR2(50),
  old_type          VARCHAR2(50),
  new_type          VARCHAR2(50),
  change_date       VARCHAR2(50),
  status            VARCHAR2(50),
  linkadjustid      VARCHAR2(50),
  changed_date      VARCHAR2(50),
  apply_person_id   VARCHAR2(50),
  apply_person_name VARCHAR2(50)
)
tablespace DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
alter table emp_postchange add apply_person_id varchar2(50);
alter table emp_postchange add apply_person_name varchar2(50);

--菜单
delete from sys_operate s where s.operate_id in ('1990','1991');
insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1990', '异动', null, '1', '19000004', '1900', 'RYDP', '0', null, '1', null, null, null, null, null, null, null, null, null, null, '/images/maininterface/menu/power.gif', null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1991', '人员类别变动', '/custom/emp/typeChangeMgr.jsf', '1', '190000040001', '1990', 'RYDP', '0', null, '1', null, null, null, null, null, null, null, null, null, null, null, null);



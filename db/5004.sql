
insert into SYS_DB_VERSION values('5004',sysdate);

-- Create table
create table EMP_AUDIT_INFO
(
  id         VARCHAR2(50),
  changedate VARCHAR2(50),
  changetype VARCHAR2(50),
  status     VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column EMP_AUDIT_INFO.changedate
  is '�䶯ʱ��';
comment on column EMP_AUDIT_INFO.changetype
  is '״̬ 1������ 2����ְ';
comment on column EMP_AUDIT_INFO.status
  is '�Ƿ����ʼ� 1���ѷ���';
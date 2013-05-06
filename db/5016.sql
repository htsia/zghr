
insert into SYS_DB_VERSION values('5016',sysdate);

--ÉÏ´«¸½¼þ
create table SET_FILE
(
  id        VARCHAR2(50),
  person_id VARCHAR2(50),
  setid     VARCHAR2(50),
  itemid    VARCHAR2(50),
  filepath  VARCHAR2(500),
  filename  VARCHAR2(500)
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

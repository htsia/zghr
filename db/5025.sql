
insert into SYS_DB_VERSION values('5025',sysdate);


--��Ա��ѯ��Ϣά��Ĭ�ϲ�ѯ����������ʾ��Ŀ
-- Create table
create table EMP_QUERY_ITEM
(
  id         VARCHAR2(50),
  person_id  VARCHAR2(50),
  show_item  VARCHAR2(500),
  order_item VARCHAR2(500)
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


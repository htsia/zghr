--���ݿ������汾
insert into SYS_DB_VERSION values('5002',sysdate);

update a001 a set a.a001750 =(select s.code_item_id from sys_code_item s where s.code_set_id='0188' and rownum=1) where a001750 is null;
--��Ӵ���
create or replace trigger a001_set_team_trigger
  after insert on a001
begin
  update a001 a set a.a001750 =(select s.code_item_id from sys_code_item s where s.code_set_id='0188' and rownum=1) where a001750 is null;
end;
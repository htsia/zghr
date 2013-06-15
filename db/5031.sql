
insert into SYS_DB_VERSION values('5031',sysdate);

--�޸Ĳ����½�����·�����ɲ����쳣
create or replace trigger "B001_SET_CHANGE_FLAG_TRIGGER" 
  after insert or update of b001005 on b001
  for each row
begin
  --���Ҫ���ɲ���·����orguid
  if (:new.b001005 is not null and :old.b001005 is null) or :new.b001005 <> :old.b001005
  then
    b001_updated.orguid:=:new.orguid;
  end if;
end;
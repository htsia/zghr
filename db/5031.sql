
insert into SYS_DB_VERSION values('5031',sysdate);

--修改部门新建部门路径生成不了异常
create or replace trigger "B001_SET_CHANGE_FLAG_TRIGGER" 
  after insert or update of b001005 on b001
  for each row
begin
  --标记要生成部门路径的orguid
  if (:new.b001005 is not null and :old.b001005 is null) or :new.b001005 <> :old.b001005
  then
    b001_updated.orguid:=:new.orguid;
  end if;
end;

insert into SYS_DB_VERSION values('5026',sysdate);


--�����Ա�����ֶ�
alter table a001 add deptempsort varchar2(500);

--��Ա���򴥷�
create or replace trigger A001_SET_SORT_TRIGGER
  before insert or update of A001746 on a001
  for each row  
begin
   select b001715 || '000000000000000000000000000000' || nvl(:new.A001746,'') into :new.deptempsort from b001 where orguid=:new.a001705;
end;

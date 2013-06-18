
insert into SYS_DB_VERSION values('5032',sysdate);

--兼职部门路径
create or replace trigger "A001_SET_SUBDEPT_TRIGGER" 
  before insert or update of a001705 on a001
  for each row
declare

begin

   if (:new.a001705 is not null and :old.a001705 is null) or :new.a001705 <> :old.a001705
   then
     --二级部门
     select '3053' || b.orguid into :new.A001239 from b001 b,b001 b2 where b.b001003=substr(b2.b001003,1,9) and b2.orguid=:new.a001705;

     --部门路径
     select B001219 into :new.A001252 from b001 where orguid=:new.a001705;
   end if;
end;

alter table emp_conpost add condate varchar2(50);
alter table a704 add conpostid varchar2(50);

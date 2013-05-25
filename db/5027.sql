
insert into SYS_DB_VERSION values('5027',sysdate);


--生成部门路径
update sys_info_item s set s.item_type=3,s.code_set_id=null where s.item_id='A001252'

CREATE OR REPLACE PACKAGE B001_UPDATED AS
  --标记要生成部门路径的orguid
  orguid varchar2(200) ;
end;


create or replace trigger B001_SET_CHANGE_FLAG_TRIGGER 
  after insert or update of b001005 on b001
  for each row
begin
  --标记要生成部门路径的orguid
  if :new.b001005 <> :old.b001005
  then
    b001_updated.orguid:=:new.orguid;
  end if;
end;


create or replace trigger B001_SET_DEPTPATH_TRIGGER
  after update or insert of b001005 on b001
declare
  deptpath varchar2(500);
begin
    --生成部门路径
    if b001_updated.orguid is not null
    then
      select replace(wm_concat(b001005),',','/') into deptpath from (select b1.b001005 from b001 b1,b001 b2 where b2.orguid=b001_updated.orguid and b2.b001003 like b1.b001003 || '%' and b1.b001075<>'089110' order by b1.b001003);
      update b001 set B001202=deptpath where orguid=b001_updated.orguid;
      update a001 set A001252=deptpath where a001705=b001_updated.orguid;
      b001_updated.orguid:=null;
    end if;
end;


--优化二级部门和部门路径写法
create or replace trigger A001_SET_SUBDEPT_TRIGGER 
  before insert or update of a001705 on a001
  for each row
declare

begin
  
   if :new.a001705<>:old.a001705
   then
     --二级部门
     select '3053' || b.orguid into :new.A001239 from b001 b,b001 b2 where b.b001003=substr(b2.b001003,1,9) and b2.orguid=:new.a001705;
     
     --部门路径     
     select B001202 into :new.A001252 from b001 where orguid=:new.a001705;    
   end if;         
end;


--批量更新数据
--需要先把B001_SET_CHANGE_FLAG_TRIGGER里if :new.b001005 <> :old.b001005改成if :new.b001005 = :old.b001005之后再改过来
begin
for dept in (select * from b001)  
loop
    update b001 set b001005=b001005 where orguid=dept.orguid;
end loop;
end;
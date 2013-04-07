
insert into SYS_DB_VERSION values('5008',sysdate);

create or replace trigger "B001_SET_SECDEPT_TRIGGER" 
  after insert or update or delete on b001
--生成二级部门、部门路径代码
declare
  depPath varchar2(2000);
  i number;
  temp number;
  cursor c_rows is select * from b001 b  ;
begin
    --二级部门
     delete from sys_code_item where code_set_id='3053';
     insert into sys_code_item (code_item_id,code_set_id,code_item_name,code_item_status,super_id,code_tree_id)
     select '3053'||b2.orguid,'3053',b2.b001005,'1',
       case when b2.b001075='089110' then '-1' else '3053'||b2.b001002 end,
       case when b2.b001075='089110' then substr(b2.b001715,len(b2.b001715)-3) else substr(b2.b001715,len(b2.b001715)-7) end
       from b001 b1,b001 b2 where b1.b001075='089110' and b2.b001002=b1.orguid and b2.b001730='00900';  

   
      
    --部门路径
    delete from sys_code_item where code_set_id='3060';
    for c_row in c_rows loop
        depPath := c_row.b001005;
        i := len(c_row.b001003);--机构编码的长度，以每级长度为3，因此长度大于9的才有必要生成机构路径
        while i > 9 loop
          i:=i-3;
          select count(*) into temp from b001 where b001003 = substr(c_row.b001003,0,i);
          if temp > 0 then
            select  b001005 
            ||'/'||depPath into  depPath
            from b001 where b001003 = substr(c_row.b001003,0,i);
          end if;
        end loop;
         insert into sys_code_item (code_item_id,code_set_id,code_item_name,code_item_status,super_id,code_tree_id)
         select '3060'||b2.orguid,'3060',depPath,'1',
         case when b2.b001075='089110' then '-1' else '3060'||b2.b001002 end,
         case when b2.b001075='089110' then substr(b2.b001715,len(b2.b001715)-3) else substr(b2.b001715,len(b2.b001715)-7) end
       from b001 b2 where  b2.b001730='00900' and b2.orguid = c_row.orguid;

    end loop;
    
     
end;




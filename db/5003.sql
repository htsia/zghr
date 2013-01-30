--数据库升级版本
insert into SYS_DB_VERSION values('5003',sysdate);

create or replace function getPostEmpCount (postID varchar2)
   return int
   is c int;
begin
  select count(*) into c from a001 where a001715=postID and a001054 in ('013511','013512','013525','0135700491','0135700572','0135700573','0135700575');
  return c;
end;

create or replace procedure proc_calc_postweave(superID in varchar2)
as
   treeID varchar2(50);
begin
    if superID is null then return; end if;
    select b001003 into treeID from b001 where orguid=superID;
    update c001 c set c001736=(select count(*) from a001 where a001715=postID),
           c001025=getPostEmpCount(c.postid) ,c001737=getPostEmpCount(c.postid)-c001735,c001738=c001735-getPostEmpCount(c.postid) where c001701 like concat(treeID,'%');
    update c001 set c001737=case when cast(c001737 as int)<0 then 0 else cast(c001737 as int) end,c001738=case when cast(c001738 as int)<0 then 0 else cast(c001738 as int) end where cast(c001737 as int)<0 or cast(c001738 as int)<0;
end;

delete from qry_query_item where qry_id='138';

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138001', '138', 'C001', 'C001005', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138002', '138', 'C001', 'C001010', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138003', '138', 'C001', 'C001015', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138004', '138', 'C001', 'C001001', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138005', '138', 'C001', 'C001003', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138006', '138', 'C001', 'C001735', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138007', '138', 'C001', 'C001736', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138009', '138', 'C001', 'C001737', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138010', '138', 'C001', 'C001738', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('138008', '138', 'C001', 'C001025', null, 0, null, 0, 0, '0', null);
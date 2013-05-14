
insert into SYS_DB_VERSION values('5020',sysdate);

--岗位变动子集
alter table A017 add A017200 varchar2(200);
alter table A017 add A017201 varchar2(200);

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A017200', 'A017', '原单位', null, '7', '20', null, null, null, 'OU', '0', '99', '1', '4', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2');

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A017201', 'A017', '调往单位', null, '7', '20', null, null, null, 'OU', '0', '99', '1', '4', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2');

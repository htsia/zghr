
insert into SYS_DB_VERSION values('5023',sysdate);


--添加增减情况子集字段
delete from sys_info_item s where s.item_id in ('A016200','A016201','A016202','A016203','A016204','A016205');

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A016200', 'A016', '原单位', null, '7', '50', null, null, null, 'OU', '0', '50', '0', '2', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A016201', 'A016', '新单位', null, '7', '50', null, null, null, 'OU', '0', '51', '0', '2', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A016202', 'A016', '原部门', null, '7', '50', null, null, null, 'OU', '0', '52', '0', '2', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A016203', 'A016', '新部门', null, '7', '20', null, null, null, 'OU', '0', '53', '0', '2', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A016204', 'A016', '原岗位', null, '11', '50', null, null, null, 'PO', '0', '54', '0', '2', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_info_item (ITEM_ID, SET_ID, ITEM_NAME, ITEM_DESC, ITEM_TYPE, ITEM_LENGTH, ITEM_PRECISION, ITEM_MAX, ITEM_MIN, CODE_SET_ID, ITEM_NOTNULL, ITEM_SEQ, ITEM_STATUS, ITEM_PROPERTY, ITEM_DEFAULTVALUE, ITEM_FORMULA, ITEM_ISSUE, IS_SELF_SHOW, SELECT_TYPE, ITEM_NAME_CN, ITEM_NAME_TW, ITEM_NAME_EN, ITEM_DESC_CN, ITEM_DESC_TW, ITEM_DESC_EN, IS_UNIQUE, CHARSET, ITEM_CANINPORT, ITEM_TRIGGER, ITEM_INWAGE, ITEM_MUST, CODE_BY_ORG, JY1006BH, JY1006NAME, GB14946, ITEM_CLASS)
values ('A016205', 'A016', '新岗位', null, '11', '50', null, null, null, 'PO', '0', '55', '0', '2', null, null, null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

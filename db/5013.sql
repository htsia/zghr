
insert into SYS_DB_VERSION values('5013',sysdate);

--是否加载数据 1是 0否
insert into sys_parameter (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('EMP_DATA_LOAD', '0', null, null, null, null);
insert into sys_parameter (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('ORG_DATA_LOAD', '0', null, null, null, null);
insert into sys_parameter (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('POST_DATA_LOAD', '0', null, null, null, null);

--简单查询用
insert into qry_query (CLASS_ID, QRY_ID, QRY_NAME, QS_TYPE, SET_TYPE, CREATE_USER, CREATE_DATE, ID_FLAG, HISTORY_FLAG, ORG_IDS, ORG_NAMES, SYS_FLAG, ADDED_CONDITION, UNIT_TYPE, STATIC_ITEM_ID, STATIC_COUNT, STATIC_MAX, STATIC_MIN, STATIC_AVG, DEFAULT_QUERY, HISTORY_SET, LINKSUPERDEPT, STATIC_SUM)
values ('queryforemp', 'queryforemp', 'queryforemp', 'Q', 'A', '-1', '2013-04-27', '0', '0', null, null, 0, null, 'ORG', null, 'checked', null, null, null, null, null, null, null);

insert into qry_static (STATIC_ID, QRY_ID, STATIC_NAME, STATIC_SEQ, QUERY_GROUP, STATIC_ITEM, STATIC_TYPE, QUERY_GROUP_SHOW)
values ('queryforemp', 'queryforemp', null, 0, '  A1   ', null, null, null);

insert into qry_condition (CONDITION_ID, STATIC_ID, GROUP_ID, SET_ID, ITEM_ID, CONDI_OPERATOR, CONDI_VALUE, CONDI_VALUE2, CONDI_TEXT, CONDI_TEXT2)
values ('queryforemp', 'queryforemp', 'A1', 'A001', 'A001021', 'equal', '011501', null, null, null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('queryforemp', 'queryforemp', 'A001', 'A001001', null, 0, null, 0, 0, '0', null);

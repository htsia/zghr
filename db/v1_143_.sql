
--修改岗位报错
delete from SYS_INFO_ITEM_REF t where t.item_id like 'C%'

--配置公司logo
执行以下语句：insert into SYS_PARAMETER (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('SYS_INTERFACE', 'images/maininterface/login_backgroud_sias.jpg,images/maininterface/logo_sias.png', null, null, null, null);
说明:PARA_VALUE值前一个为登陆页背景图片后一个为公司logo中间用逗号隔开

--添加人员报错问题
alter table wage_adjust add APPROSTATUS char(1)
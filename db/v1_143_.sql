
--�޸ĸ�λ����
delete from SYS_INFO_ITEM_REF t where t.item_id like 'C%'

--���ù�˾logo
ִ��������䣺insert into SYS_PARAMETER (PARA_KEY, PARA_VALUE, PARA_GROUP, PARA_VALUE_CN, PARA_VALUE_TW, PARA_VALUE_EN)
values ('SYS_INTERFACE', 'images/maininterface/login_backgroud_sias.jpg,images/maininterface/logo_sias.png', null, null, null, null);
˵��:PARA_VALUEֵǰһ��Ϊ��½ҳ����ͼƬ��һ��Ϊ��˾logo�м��ö��Ÿ���

--�����Ա��������
alter table wage_adjust add APPROSTATUS char(1)
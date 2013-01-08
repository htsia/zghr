
insert into SYS_DB_VERSION values('5005',sysdate);

--���ò˵�
insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1402', '��ᱣ����Ա����', '/insurace/PersonAddInfoIndex.jsf', '1', '001400010001', '1401', 'BXGL', '0', '1', '1', null, null, '1', null, null, null, null, null, null, null, null, null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1403', '��ᱣ����Ա����', '/insurace/PersonDeleteInfoIndex.jsf', '1', '001400010002', '1401', 'BXGL', '0', '1', '1', null, null, '1', null, null, null, null, null, null, null, null, null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1412', '�䶯��Ա��ѯ', '/insurace/ChangeQuery.jsf', '1', '001400010003', '1401', 'BXGL', '0', '1', '1', null, null, '1', null, null, null, null, null, null, null, null, null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1413', '�ɷѱ����趨', '/insurace/RateSet.jsf', '1', '001400020003', '1410', 'BXGL', '0', '0', '1', null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1414', '���սɷѼ���', '/custom/ins/insDataIndex.jsf', '1', '001400020004', '1410', 'BXGL', '0', '1', '1', null, null, null, null, null, null, null, null, null, null, null, null);

insert into sys_operate (OPERATE_ID, OPERATE_NAME, MENU_URL, OPERATE_TYPE, TREEID, SUPERID, MODULEID, SYS_FLAG, HAVE_REPORT, IS_USE, DLL_IMPORT, DLL_ICON, HAVE_QUERY, OPERATE_NAME_CN, OPERATE_NAME_TW, OPERATE_NAME_EN, OPERATE_DES, OPERATE_DES_CN, OPERATE_DES_TW, OPERATE_DES_EN, WEB_ICON, IN_SELF)
values ('1416', '�ɷѻ���ά��', '/custom/ins/insDataManager.jsf', '1', '001400020002', '1410', 'BXGL', '0', '1', '1', null, null, '1', null, null, null, null, null, null, null, '/images/maininterface/menu/operate.gif', null);


--���㱣���½ɷѽ��
CREATE OR REPLACE PROCEDURE proc_calc_ins(setID in varchar2, wageDate in varchar2, orgID in varchar2)
is
BEGIN
       --ɾ����������
       delete from a243 where A243211=setID and A243200=wageDate;
       --֮ǰ������Ϊ�ǵ�ǰ
       update a243 set a243000='00900' where A243215=orgID;
        --�������¼�����
        insert into a243
        (id,subid,a243000,
        A243200,--����
        A243212  ,-- ��λ
        A243213  ,-- ��������
        A243214  ,-- ��Ա���
        A243215  ,-- �ɷѵ�
        A243216  ,-- Ա���籣���
        A243217,  -- �Ƿ��Ը�
        A243211,--�������㷽��
        A243201,--�������Ͻɷ�
        A243218,--����ʧҵ
        A243202,--����ҽ�ƽɷ�
        A243203  ,--ҽ�ƴ���
        A243204  ,-- ����ס��������
        A243205  ,-- ��λ����
        A243206  ,-- ��λʧҵ
        A243207  ,-- ��λ����
        A243208  ,-- ��λҽ��
        A243209  ,-- ��λ����
        A243210  -- ��λס��������
        )
        select a.id,
        (select s.seq_step+s.cur_value-1 from sys_sequence s where s.seq_name='A243')+rownum,
        '00901',
        wageDate,--����
        a.a001701,--��λ
        a.A001239,--��������
        a.a001054,--��Ա���
        base.A754002,--�ɷѵ�
        base.A754005,--Ա���籣���
        base.A754202,-- �Ƿ��Ը�
        setID,
        case A754010 when '00901' then round(nvl(A755705*(case when a755725 is null then endowment_person else nvl(a755725,0)end)*0.01,0),precise_endowment) else 0 end,--��������
        case A754020 when '00901' then round(nvl(A770705*(case when a770718 is null then unemployment_person else nvl(a770718,0)end)*0.01,0),precise_unemployment) else 0 end,--����ʧҵ
        case A754015 when '00901' then round(nvl(A760705*(case when a760718 is null then medicare_person else nvl(a760718,0)end)*0.01,0),precise_medicare) else 0 end,--����ҽ��
        case A754200 when '00901' then cast(nvl(A786705,0) as number) else 0 end,--���ҽ�ƽ�
        case A754035 when '00901' then round(nvl(A780705*(case when a780718 is null then housing_person else nvl(a780718,0)end)*0.01,0),precise_housing) else 0 end,--���˹�����
        case A754010 when '00901' then round(nvl(A755705*(case when a755720 is null then endowment_unit else nvl(a755720,0)end)*0.01,0),precise_endowment) else 0 end,--��λ���ϡ�
        case A754020 when '00901' then round(nvl(A770705*(case when a770714 is null then unemployment_unit else nvl(a770714,0)end)*0.01,0),precise_unemployment) else 0 end,--��λʧҵ
        case A754025 when '00901' then round(nvl(A765705*(case when a765715 is null then compo_unit else nvl(a765715,0)end)*0.01,0),precise_compo) else 0 end,--����
        case A754015 when '00901' then round(nvl(A760705*(case when a760714 is null then medicare_unit else nvl(a760714,0)end)*0.01,0),precise_medicare) else 0 end,--��λҽ��
        case A754030 when '00901' then round(nvl(A775704*(case when a775708 is null then procreate_unit else nvl(a775708,0)end)*0.01,0),precise_procreate) else 0 end,--����
        case A754035 when '00901' then round(nvl(A780705*(case when a780714 is null then housing_unit else nvl(a780714,0)end)*0.01,0),precise_housing) else 0 end--��λ������
        from a754 base left join a001 a on base.id=a.id left join wage_unit w on base.A754002=w.unit_id left join a755 ylao on base.id=ylao.id and ylao.a755000='00901'
        left join a760 yliao on base.id=yliao.id and yliao.a760000='00901' left join A770 sy on base.id=sy.id and sy.a770000='00901' left join A765 gs on base.id=gs.id and gs.a765000='00901'
        left join A775 syu on base.id=syu.id and syu.a775000='00901' left join A780 gjj on base.id=gjj.id and gjj.a780000='00901' left join A786 dyliao on base.id=dyliao.id and dyliao.a786000='00901'
        where base.A754002=orgID;

        --����A243����
        update sys_sequence s set s.cur_value=(select max(cast(subid as int)) from a243);
END;


--���սɷѻ�����ѯ����
insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134001', '134', 'A001', 'A001735', null, 0, null, 0, 0, '0', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134002', '134', 'A001', 'A001001', null, 0, null, 0, 0, '1', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134003', '134', 'A001', 'A001701', null, 0, null, 0, 0, '2', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134004', '134', 'A001', 'A001239', null, 0, null, 0, 0, '3', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134005', '134', 'A001', 'A001054', null, 0, null, 0, 0, '4', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134010', '134', 'A755', 'A755715', null, 0, null, 0, 0, '5', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134011', '134', 'A770', 'A770710', null, 0, null, 0, 0, '6', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134013', '134', 'A765', 'A765705', null, 0, null, 0, 0, '8', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134014', '134', 'A760', 'A760710', null, 0, null, 0, 0, '9', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134015', '134', 'A775', 'A775704', null, 0, null, 0, 0, '10', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134016', '134', 'A786', 'A786700', null, 0, null, 0, 0, '11', null);

insert into qry_query_item (QRY_ITEM_ID, QRY_ID, SET_ID, ITEM_ID, ORDER_FLAG, DEFAULT_FLAG, DEFAULT_TYPE, SHOW_ID, SHOW_HISTORY, ORDER_SEQ, IS_HIDE)
values ('134017', '134', 'A780', 'A780708', null, 0, null, 0, 0, '12', null);

insert into qry_static (STATIC_ID, QRY_ID, STATIC_NAME, STATIC_SEQ, QUERY_GROUP, STATIC_ITEM, STATIC_TYPE)
values ('1000034', '134', null, 0, null, null, null);

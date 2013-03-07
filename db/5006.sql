
insert into SYS_DB_VERSION values('5006',sysdate);

delete from sys_info_item where item_id='A243211';

alter table a243 add status char(1);


CREATE OR REPLACE PROCEDURE proc_calc_ins(setID in varchar2, wageDate in varchar2, orgID in varchar2, userIDs in varchar2)
is
BEGIN
    if userIDs is null
    then
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
        '00900',
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
        case A754200 when '00901' then cast(nvl(A786700,0) as number) else 0 end,--���ҽ�ƽ�
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
        update sys_sequence s set s.cur_value=(select isnull(max(cast(subid as int)),0) from a243) where s.seq_name = 'A243';
    else
      --ɾ����������
       delete from a243 where A243211=setID and A243200=wageDate and instr(userIDs,','||id ||',')=0;
       --֮ǰ������Ϊ�ǵ�ǰ
       update a243 set a243000='00900' where A243215=orgID and instr(userIDs,','||id ||',')=0;
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
        '00900',
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
        case A754200 when '00901' then cast(nvl(A786700,0) as number) else 0 end,--���ҽ�ƽ�
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
        where base.A754002=orgID and instr(userIDs,','||base.id ||',')=0;

        --����A243����
        update sys_sequence s set s.cur_value=(select isnull(max(cast(subid as int)),0) from a243) where s.seq_name = 'A243';
    end if;
END;
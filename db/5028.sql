
insert into SYS_DB_VERSION values('5028',sysdate);

--修改保险计算

alter table A243 add calc_set_id varchar2(50);

update a243 set calc_set_id=A243211;

update a243 set A243211=0;

select A786700 from a786 where A786700 is not null;

delete from a786;

insert into a786(subid,id,A786000,A786700) select 10000+rownum,id,'00901',A760705 from a760 where A760705>0;

--保险缴费比例
CREATE OR REPLACE FUNCTION getinsbase (allOrgID varchar2, itemOrgID varchar2, instype varchar2, perOrUnit int, returnType int)
   RETURN varchar2   
is
   perRate varchar2(50);unitRate varchar2(50);precise varchar2(50);
BEGIN
  --allOrgID总的缴费地、itemOrgID分项缴费地
  --instype yl养老、yliao医疗、syu生育、sy失业、gjj公积金、syx医疗商业险、gs工伤
  --perOrgUnit 0个人部分、1单位部分
  --returnType 0比例、1计算精度
  if instype='yl'
  then
     select w.endowment_person,w.endowment_unit,w.precise_endowment into perRate,unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  else if instype='yliao'
  then
     select w.medicare_person,w.medicare_unit,w.precise_medicare into perRate,unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  else if instype='sy'
  then
     select w.unemployment_person,w.unemployment_unit,w.precise_unemployment into perRate,unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  else if instype='syu'
  then
     select w.procreate_unit,w.precise_procreate into unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  else if instype='gjj'
  then
     select w.housing_person,w.housing_unit,w.precise_housing into perRate,unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  else if instype='syx'
  then
     select w.ylj_person,w.ylj_unit,w.precise_ylj into perRate,unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  else if instype='gs'
  then
     select w.compo_unit,w.precise_compo into unitRate,precise from wage_unit w where w.unit_id=case when itemOrgID is not null then itemOrgID else allOrgID end;
  end if;
  end if;
  end if;
  end if;
  end if;
  end if;
  end if;
  
  if returnType=0
  then
     if perOrUnit=0
     then 
       return perRate;
     else 
       return unitRate;
     end if;
  else
    return precise;
  end if;
END;


--保险缴费计算
CREATE OR REPLACE PROCEDURE "PROC_CALC_INS" (setID in varchar2, wageDate in varchar2, userIDs in varchar2)
is
orgID varchar2(100);
BEGIN
    --yl养老、yliao医疗、syu生育、sy失业、gjj公积金、syx医疗商业险

    select i.createorgid into orgID from ins_calc_set i where i.id = setID;  
    if userIDs is null
    then
       --删除垃圾数据
       delete from a243 where calc_set_id=setID and A243200=wageDate;
       --之前数据置为非当前
       update a243 set a243000='00900' where A243215=orgID;
        --插入重新计算结果
        insert into a243
        (id,subid,a243000,
        A243200,--年月
        A243212  ,-- 单位
        A243213  ,-- 二级部门
        A243214  ,-- 人员类别
        A243215  ,-- 缴费地
        A243216  ,-- 员工社保编号
        A243217  ,-- 是否自付
        calc_set_id  ,--所属计算方案
        A243201  ,--个人养老缴费
        A243218  ,--个人失业
        A243202  ,--个人医疗缴费
        A243203  ,--个人医疗商业
        A243211  ,--单位医疗商业
        A243204  ,-- 个人住房公积金
        A243205  ,-- 单位养老
        A243206  ,-- 单位失业
        A243207  ,-- 单位工伤
        A243208  ,-- 单位医疗
        A243209  ,-- 单位生育
        A243210  -- 单位住房公积金
        )
        select a.id,
        (select s.seq_step+s.cur_value-1 from sys_sequence s where s.seq_name='A243')+rownum,
        '00901',
        wageDate,--年月
        a.a001701,--单位
        a.A001239,--二级部门
        a.a001054,--人员类别
        base.A754002,--缴费地
        base.A754005,--员工社保编号
        base.A754202,-- 是否自付
        setID,
        case A754010 when '00901' then round(nvl(A755705*(case when a755725 is null then getinsbase(base.A754002,A755200,'yl',0,0) else nvl(a755725,0)end)*0.01,0),getinsbase(base.A754002,A755200,'yl',0,1)) else 0 end,--个人养老
        case A754020 when '00901' then round(nvl(A770705*(case when a770718 is null then getinsbase(base.A754002,A770200,'sy',0,0) else nvl(a770718,0)end)*0.01,0),getinsbase(base.A754002,A770200,'sy',0,1)) else 0 end,--个人失业
        case A754015 when '00901' then round(nvl(A760705*(case when a760718 is null then getinsbase(base.A754002,A760200,'yliao',0,0) else nvl(a760718,0)end)*0.01,0),getinsbase(base.A754002,A760200,'yliao',0,1)) else 0 end,--个人医疗
        --case A754200 when '00901' then cast(nvl(A786700,0) as number) else 0 end,--大额医疗金
        case A754200 when '00901' then round(nvl(A786700*(case when A786701 is null then getinsbase(base.A754002,A786200,'syx',0,0) else nvl(A786701,0)end)*0.01,0),getinsbase(base.A754002,A786200,'syx',0,1)) else 0 end,--个人医疗商业
        case A754200 when '00901' then round(nvl(A786700*(case when A786702 is null then getinsbase(base.A754002,A786200,'syx',1,0) else nvl(A786702,0)end)*0.01,0),getinsbase(base.A754002,A786200,'syx',1,1)) else 0 end,--单位医疗商业
        case A754035 when '00901' then round(nvl(A780705*(case when a780718 is null then getinsbase(base.A754002,A780200,'gjj',0,0) else nvl(a780718,0)end)*0.01,0),getinsbase(base.A754002,A780200,'gjj',0,1)) else 0 end,--个人公积金
        case A754010 when '00901' then round(nvl(A755705*(case when a755720 is null then getinsbase(base.A754002,A755200,'yl',1,0) else nvl(a755720,0)end)*0.01,0),getinsbase(base.A754002,A755200,'yl',1,1)) else 0 end,--单位养老、
        case A754020 when '00901' then round(nvl(A770705*(case when a770714 is null then getinsbase(base.A754002,A770200,'sy',1,1) else nvl(a770714,0)end)*0.01,0),getinsbase(base.A754002,A770200,'sy',1,1)) else 0 end,--单位失业
        case A754025 when '00901' then round(nvl(A765705*(case when a765715 is null then getinsbase(base.A754002,A765200,'gs',1,0) else nvl(a765715,0)end)*0.01,0),getinsbase(base.A754002,A765200,'gs',1,1)) else 0 end,--工伤
        case A754015 when '00901' then round(nvl(A760705*(case when a760714 is null then getinsbase(base.A754002,A760200,'yliao',1,0) else nvl(a760714,0)end)*0.01,0),getinsbase(base.A754002,A760200,'yliao',1,1)) else 0 end,--单位医疗
        case A754030 when '00901' then round(nvl(A775704*(case when a775708 is null then getinsbase(base.A754002,A775200,'syu',1,0) else nvl(a775708,0)end)*0.01,0),getinsbase(base.A754002,A775200,'syu',1,1)) else 0 end,--生育
        case A754035 when '00901' then round(nvl(A780705*(case when a780714 is null then getinsbase(base.A754002,A780200,'gjj',1,0) else nvl(a780714,0)end)*0.01,0),getinsbase(base.A754002,A780200,'gjj',1,1)) else 0 end--单位公积金
        from a754 base left join a001 a on base.id=a.id left join wage_unit w on base.A754002=w.unit_id left join a755 ylao on base.id=ylao.id and ylao.a755000='00901'
        left join a760 yliao on base.id=yliao.id and yliao.a760000='00901' left join A770 sy on base.id=sy.id and sy.a770000='00901' left join A765 gs on base.id=gs.id and gs.a765000='00901'
        left join A775 syu on base.id=syu.id and syu.a775000='00901' left join A780 gjj on base.id=gjj.id and gjj.a780000='00901' left join A786 dyliao on base.id=dyliao.id and dyliao.a786000='00901'
        where a.a001701=orgID and (A754010='00901' or A754015='00901' or A754020='00901' or A754025='00901' or A754030='00901' or A754035='00901' or A754200='00901');


        --更新A243主键
        update sys_sequence s set s.cur_value=(select isnull(max(cast(subid as int)),0) from a243) where s.seq_name = 'A243';
    else
      --删除垃圾数据
       delete from a243 where calc_set_id=setID and A243200=wageDate and instr(userIDs,','||id ||',')=0;
       --之前数据置为非当前
       update a243 set a243000='00900' where A243215=orgID and instr(userIDs,','||id ||',')=0;
        --插入重新计算结果
        insert into a243
        (id,subid,a243000,
        A243200,--年月
        A243212  ,-- 单位
        A243213  ,-- 二级部门
        A243214  ,-- 人员类别
        A243215  ,-- 缴费地
        A243216  ,-- 员工社保编号
        A243217  ,-- 是否自付
        calc_set_id  ,--所属计算方案
        A243201  ,--个人养老缴费
        A243218  ,--个人失业
        A243202  ,--个人医疗缴费
        A243203  ,--个人医疗商业
        A243211  ,--单位医疗商业
        A243204  ,-- 个人住房公积金
        A243205  ,-- 单位养老
        A243206  ,-- 单位失业
        A243207  ,-- 单位工伤
        A243208  ,-- 单位医疗
        A243209  ,-- 单位生育
        A243210  -- 单位住房公积金
        )
        select a.id,
        (select s.seq_step+s.cur_value-1 from sys_sequence s where s.seq_name='A243')+rownum,
        '00901',
        wageDate,--年月
        a.a001701,--单位
        a.A001239,--二级部门
        a.a001054,--人员类别
        base.A754002,--缴费地
        base.A754005,--员工社保编号
        base.A754202,-- 是否自付
        setID,
        case A754010 when '00901' then round(nvl(A755705*(case when a755725 is null then getinsbase(base.A754002,A755200,'yl',0,0) else nvl(a755725,0)end)*0.01,0),getinsbase(base.A754002,A755200,'yl',0,1)) else 0 end,--个人养老
        case A754020 when '00901' then round(nvl(A770705*(case when a770718 is null then getinsbase(base.A754002,A770200,'sy',0,0) else nvl(a770718,0)end)*0.01,0),getinsbase(base.A754002,A770200,'sy',0,1)) else 0 end,--个人失业
        case A754015 when '00901' then round(nvl(A760705*(case when a760718 is null then getinsbase(base.A754002,A760200,'yliao',0,0) else nvl(a760718,0)end)*0.01,0),getinsbase(base.A754002,A760200,'yliao',0,1)) else 0 end,--个人医疗
        --case A754200 when '00901' then cast(nvl(A786700,0) as number) else 0 end,--大额医疗金
        case A754200 when '00901' then round(nvl(A786700*(case when A786701 is null then getinsbase(base.A754002,A786200,'syx',0,0) else nvl(A786701,0)end)*0.01,0),getinsbase(base.A754002,A786200,'syx',0,1)) else 0 end,--个人医疗商业
        case A754200 when '00901' then round(nvl(A786700*(case when A786702 is null then getinsbase(base.A754002,A786200,'syx',1,0) else nvl(A786702,0)end)*0.01,0),getinsbase(base.A754002,A786200,'syx',1,1)) else 0 end,--单位医疗商业
        case A754035 when '00901' then round(nvl(A780705*(case when a780718 is null then getinsbase(base.A754002,A780200,'gjj',0,0) else nvl(a780718,0)end)*0.01,0),getinsbase(base.A754002,A780200,'gjj',0,1)) else 0 end,--个人公积金
        case A754010 when '00901' then round(nvl(A755705*(case when a755720 is null then getinsbase(base.A754002,A755200,'yl',1,0) else nvl(a755720,0)end)*0.01,0),getinsbase(base.A754002,A755200,'yl',1,1)) else 0 end,--单位养老、
        case A754020 when '00901' then round(nvl(A770705*(case when a770714 is null then getinsbase(base.A754002,A770200,'sy',1,1) else nvl(a770714,0)end)*0.01,0),getinsbase(base.A754002,A770200,'sy',1,1)) else 0 end,--单位失业
        case A754025 when '00901' then round(nvl(A765705*(case when a765715 is null then getinsbase(base.A754002,A765200,'gs',1,0) else nvl(a765715,0)end)*0.01,0),getinsbase(base.A754002,A765200,'gs',1,1)) else 0 end,--工伤
        case A754015 when '00901' then round(nvl(A760705*(case when a760714 is null then getinsbase(base.A754002,A760200,'yliao',1,0) else nvl(a760714,0)end)*0.01,0),getinsbase(base.A754002,A760200,'yliao',1,1)) else 0 end,--单位医疗
        case A754030 when '00901' then round(nvl(A775704*(case when a775708 is null then getinsbase(base.A754002,A775200,'syu',1,0) else nvl(a775708,0)end)*0.01,0),getinsbase(base.A754002,A775200,'syu',1,1)) else 0 end,--生育
        case A754035 when '00901' then round(nvl(A780705*(case when a780714 is null then getinsbase(base.A754002,A780200,'gjj',1,0) else nvl(a780714,0)end)*0.01,0),getinsbase(base.A754002,A780200,'gjj',1,1)) else 0 end--单位公积金
        from a754 base left join a001 a on base.id=a.id left join wage_unit w on base.A754002=w.unit_id left join a755 ylao on base.id=ylao.id and ylao.a755000='00901'
        left join a760 yliao on base.id=yliao.id and yliao.a760000='00901' left join A770 sy on base.id=sy.id and sy.a770000='00901' left join A765 gs on base.id=gs.id and gs.a765000='00901'
        left join A775 syu on base.id=syu.id and syu.a775000='00901' left join A780 gjj on base.id=gjj.id and gjj.a780000='00901' left join A786 dyliao on base.id=dyliao.id and dyliao.a786000='00901'
        where a.a001701=orgID and instr(userIDs,','||base.id ||',')=0 and (A754010='00901' or A754015='00901' or A754020='00901' or A754025='00901' or A754030='00901' or A754035='00901' or A754200='00901');

        --更新A243主键
        update sys_sequence s set s.cur_value=(select isnull(max(cast(subid as int)),0) from a243) where s.seq_name = 'A243';
    end if;
END;
insert into SYS_DB_VERSION values('5003',sysdate);

CREATE OR REPLACE PROCEDURE proc_ins_calc(calcSetString in varchar2)
is
BEGIN

    ---����
    if instr(calcSetString,'A755') != 0
    then 
      update a755 ylao set (a755702,A755730,a755737)=(select precise_endowment,--���㾫��
              round((case when a755720 is null then endowment_unit else nvl(a755720,0)end)*0.01*A755705,precise_endowment), --��λ�ɷ�
              round((case when a755725 is null then endowment_person else nvl(a755725,0)end)*0.01*A755705,precise_endowment) --���˽ɷ�
             from a001 a,a754 b,wage_unit w where a.id=b.id and b.id=ylao.id and ylao.a755000='00901' and w.unit_id=a.a001701) where ylao.a755000='00901';   
    end if;
    
    ---ҽ��         
    if instr(calcSetString,'A760') != 0
    then 
      update a760 yl set (a760702,a760720,a760727)=(select precise_medicare,--���㾫��
              round((case when a760714 is null then medicare_unit else nvl(a760714,0)end)*0.01*A760705,precise_medicare), --��λ�ɷ�
              round((case when a760718 is null then medicare_person else nvl(a760718,0)end)*0.01*A760705,precise_medicare) --���˽ɷ�
             from a001 a,a754 b,wage_unit w where a.id=b.id and b.id=yl.id and yl.a760000='00901' and w.unit_id=a.a001701) where yl.a760000='00901';
    end if;

   ---ʧҵ     
    if instr(calcSetString,'A770') != 0
    then 
      update a770 sye set (a770702,a770726,a770730)=(select w.precise_unemployment,--���㾫��
              round((case when a770714 is null then unemployment_unit else nvl(a770714,0)end)*0.01*A770705,precise_unemployment), --��λ�ɷ�
              round((case when a770718 is null then unemployment_person else nvl(a770718,0)end)*0.01*A770705,precise_unemployment) --���˽ɷ�
             from a001 a,a754 b,wage_unit w where a.id=b.id and b.id=sye.id and sye.a770000='00901' and w.unit_id=a.a001701) where sye.a770000='00901';
    end if;
    
   ---����
   if instr(calcSetString,'A765') != 0
   then   
      update a765 gs set (a765702,a765720)=(select precise_compo,--���㾫��
              round((case when a765715 is null then compo_unit else nvl(a765715,0)end)*0.01*a765705,precise_compo) --��λ�ɷ�
             from a001 a,a754 b,wage_unit w where a.id=b.id and b.id=gs.id and gs.a765000='00901' and w.unit_id=a.a001701) where gs.a765000='00901';
    end if;

    ---����
    if instr(calcSetString,'A775') != 0
    then 
       update a775 sy set (a775702,a775714)=(select precise_procreate,--���㾫��
              round((case when a775708 is null then procreate_unit else nvl(a775708,0)end)*0.01*a775704,precise_procreate) --��λ�ɷ�
             from a001 a,a754 b,wage_unit w where a.id=b.id and b.id=sy.id and sy.a775000='00901' and w.unit_id=a.a001701) where sy.a775000='00901';
    end if;

    ---������
    if instr(calcSetString,'A780') != 0
    then
       update a780 zf set (a780702,a780720,a780724)=(select precise_housing,--���㾫��
              round((case when a780714 is null then housing_unit else nvl(a780714,0)end)*0.01*A780705,precise_housing), --��λ�ɷ�
              round((case when a780718 is null then housing_person else nvl(a780718,0)end)*0.01*A780705,precise_housing) --���˽ɷ�
             from a001 a,a754 b,wage_unit w where a.id=b.id and b.id=zf.id and zf.a780000='00901' and w.unit_id=a.a001701) where zf.a780000='00901';
    end if;          
END;

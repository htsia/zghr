--ɾ���ƻ���
delete from xys_eva_plan where plan_id = '5a463cb13836d6e00138372cfa770771'

---ɾ��360  ע��plan_id �滻ΪҪɾ����

delete from xys_360_sbj where obj_id in(select xys_360_obj.obj_id from xys_360_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_360_obj_score where obj_id in(select xys_360_obj.obj_id from xys_360_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_360_obj_key where obj_id in(select xys_360_obj.obj_id from xys_360_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_360_obj where plan_id='5a463cb13836d6e00138372cfa770771';

----deptkpi

delete from xys_kpi_dept_sbj where obj_id in(select xys_kpi_dept_obj.obj_id from xys_kpi_dept_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_dept_obj_score where obj_id in(select xys_kpi_dept_obj.obj_id from xys_kpi_dept_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_obj_lib where obj_id in(select xys_kpi_dept_obj.obj_id from xys_kpi_dept_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_obj_key where obj_id in(select xys_kpi_dept_obj.obj_id from xys_kpi_dept_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_dept_obj where plan_id='5a463cb13836d6e00138372cfa770771';


----����kpi

delete from xys_kpi_person_sbj where obj_id in(select xys_kpi_person_obj.obj_id from xys_kpi_person_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_person_score where obj_id in(select xys_kpi_person_obj.obj_id from xys_kpi_person_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_obj_lib where obj_id in(select xys_kpi_person_obj.obj_id from xys_kpi_person_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_obj_key where obj_id in(select xys_kpi_person_obj.obj_id from xys_kpi_person_obj where plan_id='5a463cb13836d6e00138372cfa770771');

delete from xys_kpi_person_obj where plan_id='5a463cb13836d6e00138372cfa770771';
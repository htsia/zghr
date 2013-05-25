package com.hr319wg.wage.pojo.bo;

public class WageUnitBO {
	private String name;
	private String desc;
	private String unitId;
	private String superId;
	private String treeId;
	private String order;
	private String manageFlag = "00900";
	private String endowment_unit;
	private String endowment_unit_rl;
	private String endowment_unit_al;
	private String endowment_person;
	private String endowment_person_rl;
	private String endowment_person_al;
	private String minRate_end;
	private String minRate_end_rl;
	private String minRate_end_al;
	private String maxRate_end;
	private String maxRate_end_rl;
	private String maxRate_end_al;
	private String medicare_unit;
	private String medicare_unit_rl;
	private String medicare_unit_al;
	private String medicare_person;
	private String medicare_person_rl;
	private String medicare_person_al;
	private String minRate_med;
	private String minRate_med_rl;
	private String minRate_med_al;
	private String maxRate_med;
	private String maxRate_med_rl;
	private String maxRate_med_al;
	private String compo_unit;
	private String compo_unit_rl;
	private String compo_unit_al;
	private String minRate_compo;
	private String minRate_compo_rl;
	private String minRate_compo_al;
	private String maxRate_compo;
	private String maxRate_compo_rl;
	private String maxRate_compo_al;
	private String unemployment_unit;
	private String unemployment_unit_rl;
	private String unemployment_unit_al;
	private String unemployment_person;
	private String unemployment_person_rl;
	private String unemployment_person_al;
	private String minRate_unemp;
	private String minRate_unemp_rl;
	private String minRate_unemp_al;
	private String maxRate_unemp;
	private String maxRate_unemp_rl;
	private String maxRate_unemp_al;
	private String procreate_unit;
	private String procreate_unit_rl;
	private String procreate_unit_al;
	private String minRate_proc;
	private String minRate_proc_rl;
	private String minRate_proc_al;
	private String maxRate_proc;
	private String maxRate_proc_rl;
	private String maxRate_proc_al;
	private String housing_unit;
	private String housing_unit_rl;
	private String housing_unit_al;
	private String housing_person;
	private String housing_person_rl;
	private String housing_person_al;
	private String minRate_house;
	private String minRate_house_rl;
	private String minRate_house_al;
	private String maxRate_house;
	private String maxRate_house_rl;
	private String maxRate_house_al;
	private String precise_end;
	private String precise_med;
	private String precise_compo;
	private String precise_unemployment;
	private String precise_procreate;
	private String precise_housing;
	private String precise_annuity;
	private String avgwage;
	private String annuity_Person;
	private String annuity_Unit;
	private String annuity_Unit_Person;
	private String precise_large_med;
	private String large_med_unit;
	private String precise_ylj;
	private String ylj_unit;
	private String ylj_person;
	private String maxRate_ylj;
	private String minRate_ylj;

	public String getPrecise_ylj() {
		return precise_ylj;
	}

	public void setPrecise_ylj(String precise_ylj) {
		this.precise_ylj = precise_ylj;
	}

	public String getYlj_unit() {
		return ylj_unit;
	}

	public void setYlj_unit(String ylj_unit) {
		this.ylj_unit = ylj_unit;
	}

	public String getYlj_person() {
		return ylj_person;
	}

	public void setYlj_person(String ylj_person) {
		this.ylj_person = ylj_person;
	}

	public String getMaxRate_ylj() {
		return maxRate_ylj;
	}

	public void setMaxRate_ylj(String maxRate_ylj) {
		this.maxRate_ylj = maxRate_ylj;
	}

	public String getMinRate_ylj() {
		return minRate_ylj;
	}

	public void setMinRate_ylj(String minRate_ylj) {
		this.minRate_ylj = minRate_ylj;
	}

	public String getPrecise_large_med() {
		return this.precise_large_med;
	}

	public void setPrecise_large_med(String precise_large_med) {
		this.precise_large_med = precise_large_med;
	}

	public String getLarge_med_unit() {
		return this.large_med_unit;
	}

	public void setLarge_med_unit(String large_med_unit) {
		this.large_med_unit = large_med_unit;
	}

	public String getPrecise_annuity() {
		return this.precise_annuity;
	}

	public void setPrecise_annuity(String age) {
		this.precise_annuity = age;
	}

	public String getAnnuity_Person() {
		return this.annuity_Person;
	}

	public void setAnnuity_Person(String age) {
		this.annuity_Person = age;
	}

	public String getAnnuity_Unit() {
		return this.annuity_Unit;
	}

	public void setAnnuity_Unit(String age) {
		this.annuity_Unit = age;
	}

	public String getPrecise_med() {
		return this.precise_med;
	}

	public void setPrecise_med(String age) {
		this.precise_med = age;
	}

	public String getPrecise_compo() {
		return this.precise_compo;
	}

	public void setPrecise_compo(String age) {
		this.precise_compo = age;
	}

	public String getPrecise_unemployment() {
		return this.precise_unemployment;
	}

	public void setPrecise_unemployment(String age) {
		this.precise_unemployment = age;
	}

	public String getPrecise_procreate() {
		return this.precise_procreate;
	}

	public void setPrecise_procreate(String age) {
		this.precise_procreate = age;
	}

	public String getPrecise_housing() {
		return this.precise_housing;
	}

	public void setPrecise_housing(String age) {
		this.precise_housing = age;
	}

	public String getAvgwage() {
		return this.avgwage;
	}

	public void setAvgwage(String age) {
		this.avgwage = age;
	}

	public String getPrecise_end() {
		return this.precise_end;
	}

	public void setPrecise_end(String pre) {
		this.precise_end = pre;
	}

	public String getEndowment_unit() {
		return this.endowment_unit;
	}

	public void setEndowment_unit(String unit) {
		this.endowment_unit = unit;
	}

	public String getEndowment_unit_rl() {
		return this.endowment_unit_rl;
	}

	public void setEndowment_unit_rl(String unit) {
		this.endowment_unit_rl = unit;
	}

	public String getEndowment_unit_al() {
		return this.endowment_unit_al;
	}

	public void setEndowment_unit_al(String unit) {
		this.endowment_unit_al = unit;
	}

	public String getEndowment_person() {
		return this.endowment_person;
	}

	public void setEndowment_person(String unit) {
		this.endowment_person = unit;
	}

	public String getEndowment_person_rl() {
		return this.endowment_person_rl;
	}

	public void setEndowment_person_rl(String unit) {
		this.endowment_person_rl = unit;
	}

	public String getEndowment_person_al() {
		return this.endowment_person_al;
	}

	public void setEndowment_person_al(String unit) {
		this.endowment_person_al = unit;
	}

	public String getMinRate_end() {
		return this.minRate_end;
	}

	public void setMinRate_end(String age) {
		this.minRate_end = age;
	}

	public String getMinRate_end_rl() {
		return this.minRate_end_rl;
	}

	public void setMinRate_end_rl(String age) {
		this.minRate_end_rl = age;
	}

	public String getMinRate_end_al() {
		return this.minRate_end_al;
	}

	public void setMinRate_end_al(String age) {
		this.minRate_end_al = age;
	}

	public String getMaxRate_end() {
		return this.maxRate_end;
	}

	public void setMaxRate_end(String age) {
		this.maxRate_end = age;
	}

	public String getMaxRate_end_rl() {
		return this.maxRate_end_rl;
	}

	public void setMaxRate_end_rl(String age) {
		this.maxRate_end_rl = age;
	}

	public String getMaxRate_end_al() {
		return this.maxRate_end_al;
	}

	public void setMaxRate_end_al(String age) {
		this.maxRate_end_al = age;
	}

	public String getMedicare_unit() {
		return this.medicare_unit;
	}

	public void setMedicare_unit(String unit) {
		this.medicare_unit = unit;
	}

	public String getMedicare_unit_rl() {
		return this.medicare_unit_rl;
	}

	public void setMedicare_unit_rl(String unit) {
		this.medicare_unit_rl = unit;
	}

	public String getMedicare_unit_al() {
		return this.medicare_unit_al;
	}

	public void setMedicare_unit_al(String unit) {
		this.medicare_unit_al = unit;
	}

	public String getMedicare_person() {
		return this.medicare_person;
	}

	public void setMedicare_person(String unit) {
		this.medicare_person = unit;
	}

	public String getMedicare_person_rl() {
		return this.medicare_person_rl;
	}

	public void setMedicare_person_rl(String unit) {
		this.medicare_person_rl = unit;
	}

	public String getMedicare_person_al() {
		return this.medicare_person_al;
	}

	public void setMedicare_person_al(String unit) {
		this.medicare_person_al = unit;
	}

	public String getMinRate_med() {
		return this.minRate_med;
	}

	public void setMinRate_med(String age) {
		this.minRate_med = age;
	}

	public String getMinRate_med_rl() {
		return this.minRate_med_rl;
	}

	public void setMinRate_med_rl(String age) {
		this.minRate_med_rl = age;
	}

	public String getMinRate_med_al() {
		return this.minRate_med_al;
	}

	public void setMinRate_med_al(String age) {
		this.minRate_med_al = age;
	}

	public String getMaxRate_med() {
		return this.maxRate_med;
	}

	public void setMaxRate_med(String age) {
		this.maxRate_med = age;
	}

	public String getMaxRate_med_rl() {
		return this.maxRate_med_rl;
	}

	public void setMaxRate_med_rl(String age) {
		this.maxRate_med_rl = age;
	}

	public String getMaxRate_med_al() {
		return this.maxRate_med_al;
	}

	public void setMaxRate_med_al(String age) {
		this.maxRate_med_al = age;
	}

	public String getCompo_unit() {
		return this.compo_unit;
	}

	public void setCompo_unit(String unit) {
		this.compo_unit = unit;
	}

	public String getCompo_unit_rl() {
		return this.compo_unit_rl;
	}

	public void setCompo_unit_rl(String unit) {
		this.compo_unit_rl = unit;
	}

	public String getCompo_unit_al() {
		return this.compo_unit_al;
	}

	public void setCompo_unit_al(String unit) {
		this.compo_unit_al = unit;
	}

	public String getMinRate_compo() {
		return this.minRate_compo;
	}

	public void setMinRate_compo(String age) {
		this.minRate_compo = age;
	}

	public String getMinRate_compo_rl() {
		return this.minRate_compo_rl;
	}

	public void setMinRate_compo_rl(String age) {
		this.minRate_compo_rl = age;
	}

	public String getMinRate_compo_al() {
		return this.minRate_compo_al;
	}

	public void setMinRate_compo_al(String age) {
		this.minRate_compo_al = age;
	}

	public String getMaxRate_compo() {
		return this.maxRate_compo;
	}

	public void setMaxRate_compo(String age) {
		this.maxRate_compo = age;
	}

	public String getMaxRate_compo_rl() {
		return this.maxRate_compo_rl;
	}

	public void setMaxRate_compo_rl(String age) {
		this.maxRate_compo_rl = age;
	}

	public String getMaxRate_compo_al() {
		return this.maxRate_compo_al;
	}

	public void setMaxRate_compo_al(String age) {
		this.maxRate_compo_al = age;
	}

	public String getUnemployment_unit() {
		return this.unemployment_unit;
	}

	public void setUnemployment_unit(String unit) {
		this.unemployment_unit = unit;
	}

	public String getUnemployment_unit_rl() {
		return this.unemployment_unit_rl;
	}

	public void setUnemployment_unit_rl(String unit) {
		this.unemployment_unit_rl = unit;
	}

	public String getUnemployment_unit_al() {
		return this.unemployment_unit_al;
	}

	public void setUnemployment_unit_al(String unit) {
		this.unemployment_unit_al = unit;
	}

	public String getUnemployment_person() {
		return this.unemployment_person;
	}

	public void setUnemployment_person(String unit) {
		this.unemployment_person = unit;
	}

	public String getUnemployment_person_rl() {
		return this.unemployment_person_rl;
	}

	public void setUnemployment_person_rl(String unit) {
		this.unemployment_person_rl = unit;
	}

	public String getUnemployment_person_al() {
		return this.unemployment_person_al;
	}

	public void setUnemployment_person_al(String unit) {
		this.unemployment_person_al = unit;
	}

	public String getMinRate_unemp() {
		return this.minRate_unemp;
	}

	public void setMinRate_unemp(String age) {
		this.minRate_unemp = age;
	}

	public String getMinRate_unemp_rl() {
		return this.minRate_unemp_rl;
	}

	public void setMinRate_unemp_rl(String age) {
		this.minRate_unemp_rl = age;
	}

	public String getMinRate_unemp_al() {
		return this.minRate_unemp_al;
	}

	public void setMinRate_unemp_al(String age) {
		this.minRate_unemp_al = age;
	}

	public String getMaxRate_unemp() {
		return this.maxRate_unemp;
	}

	public void setMaxRate_unemp(String age) {
		this.maxRate_unemp = age;
	}

	public String getMaxRate_unemp_rl() {
		return this.maxRate_unemp_rl;
	}

	public void setMaxRate_unemp_rl(String age) {
		this.maxRate_unemp_rl = age;
	}

	public String getMaxRate_unemp_al() {
		return this.maxRate_unemp_al;
	}

	public void setMaxRate_unemp_al(String age) {
		this.maxRate_unemp_al = age;
	}

	public String getProcreate_unit() {
		return this.procreate_unit;
	}

	public void setProcreate_unit(String unit) {
		this.procreate_unit = unit;
	}

	public String getProcreate_unit_rl() {
		return this.procreate_unit_rl;
	}

	public void setProcreate_unit_rl(String unit) {
		this.procreate_unit_rl = unit;
	}

	public String getProcreate_unit_al() {
		return this.procreate_unit_al;
	}

	public void setProcreate_unit_al(String unit) {
		this.procreate_unit_al = unit;
	}

	public String getMinRate_proc() {
		return this.minRate_proc;
	}

	public void setMinRate_proc(String age) {
		this.minRate_proc = age;
	}

	public String getMinRate_proc_rl() {
		return this.minRate_proc_rl;
	}

	public void setMinRate_proc_rl(String age) {
		this.minRate_proc_rl = age;
	}

	public String getMinRate_proc_al() {
		return this.minRate_proc_al;
	}

	public void setMinRate_proc_al(String age) {
		this.minRate_proc_al = age;
	}

	public String getMaxRate_proc() {
		return this.maxRate_proc;
	}

	public void setMaxRate_proc(String age) {
		this.maxRate_proc = age;
	}

	public String getMaxRate_proc_rl() {
		return this.maxRate_proc_rl;
	}

	public void setMaxRate_proc_rl(String age) {
		this.maxRate_proc_rl = age;
	}

	public String getMaxRate_proc_al() {
		return this.maxRate_proc_al;
	}

	public void setMaxRate_proc_al(String age) {
		this.maxRate_proc_al = age;
	}

	public String getHousing_unit() {
		return this.housing_unit;
	}

	public void setHousing_unit(String unit) {
		this.housing_unit = unit;
	}

	public String getHousing_unit_rl() {
		return this.housing_unit_rl;
	}

	public void setHousing_unit_rl(String unit) {
		this.housing_unit_rl = unit;
	}

	public String getHousing_unit_al() {
		return this.housing_unit_al;
	}

	public void setHousing_unit_al(String unit) {
		this.housing_unit_al = unit;
	}

	public String getHousing_person() {
		return this.housing_person;
	}

	public void setHousing_person(String unit) {
		this.housing_person = unit;
	}

	public String getHousing_person_rl() {
		return this.housing_person_rl;
	}

	public void setHousing_person_rl(String unit) {
		this.housing_person_rl = unit;
	}

	public String getHousing_person_al() {
		return this.housing_person_al;
	}

	public void setHousing_person_al(String unit) {
		this.housing_person_al = unit;
	}

	public String getMinRate_house() {
		return this.minRate_house;
	}

	public void setMinRate_house(String age) {
		this.minRate_house = age;
	}

	public String getMinRate_house_rl() {
		return this.minRate_house_rl;
	}

	public void setMinRate_house_rl(String age) {
		this.minRate_house_rl = age;
	}

	public String getMinRate_house_al() {
		return this.minRate_house_al;
	}

	public void setMinRate_house_al(String age) {
		this.minRate_house_al = age;
	}

	public String getMaxRate_house() {
		return this.maxRate_house;
	}

	public void setMaxRate_house(String age) {
		this.maxRate_house = age;
	}

	public String getMaxRate_house_rl() {
		return this.maxRate_house_rl;
	}

	public void setMaxRate_house_rl(String age) {
		this.maxRate_house_rl = age;
	}

	public String getMaxRate_house_al() {
		return this.maxRate_house_al;
	}

	public void setMaxRate_house_al(String age) {
		this.maxRate_house_al = age;
	}

	public String getManageFlag() {
		return this.manageFlag;
	}

	public void setManageFlag(String manageFlag) {
		this.manageFlag = manageFlag;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return this.desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getUnitId() {
		return this.unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getSuperId() {
		return this.superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getTreeId() {
		return this.treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public String getOrder() {
		return this.order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getAnnuity_Unit_Person() {
		return this.annuity_Unit_Person;
	}

	public void setAnnuity_Unit_Person(String annuity_Unit_Person) {
		this.annuity_Unit_Person = annuity_Unit_Person;
	}
}
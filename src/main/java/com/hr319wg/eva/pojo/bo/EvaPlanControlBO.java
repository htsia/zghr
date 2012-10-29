package com.hr319wg.eva.pojo.bo;

public class EvaPlanControlBO {
	private String itemId;
	private String planId;
	private String templateId;
	private String gradeItem;
	private String gradeCount;
	private String lowValue;
    private String highValue;
    private String deptItem;
    private String deptCount;
	
	public String getDeptItem() {
		return deptItem;
	}
	public void setDeptItem(String deptItem) {
		this.deptItem = deptItem;
	}
	public String getDeptCount() {
		return deptCount;
	}
	public void setDeptCount(String deptCount) {
		this.deptCount = deptCount;
	}
	public String getLowValue() {
		return lowValue;
	}
	public void setLowValue(String lowValue) {
		this.lowValue = lowValue;
	}
	public String getHighValue() {
		return highValue;
	}
	public void setHighValue(String highValue) {
		this.highValue = highValue;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String getGradeItem() {
		return gradeItem;
	}
	public void setGradeItem(String gradeItem) {
		this.gradeItem = gradeItem;
	}
	public String getGradeCount() {
		return gradeCount;
	}
	public void setGradeCount(String gradeCount) {
		this.gradeCount = gradeCount;
	}
}

package com.hr319wg.xys.eva.pojo.bo;

public class XysScoreCtrBO {
	private String ctrId;
	private String type;
	private String gradeItem;
	private String count;
	private String planId;
	
	private String gradeName;
	
	
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getCtrId() {
		return ctrId;
	}
	public void setCtrId(String ctrId) {
		this.ctrId = ctrId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getGradeItem() {
		return gradeItem;
	}
	public void setGradeItem(String gradeItem) {
		this.gradeItem = gradeItem;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
}

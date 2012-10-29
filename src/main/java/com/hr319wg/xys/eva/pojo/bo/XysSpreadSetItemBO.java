package com.hr319wg.xys.eva.pojo.bo;

public class XysSpreadSetItemBO {
	private String itemId;
	private String setId;
	private String gradeItem;
	private String ctrType;//1ÊýÄ¿2±ÈÀý
	private String ctrCount;
	private String chgGradeItem;
	
	private String gradeName;
	
	
	public String getChgGradeItem() {
		return chgGradeItem;
	}
	public void setChgGradeItem(String chgGradeItem) {
		this.chgGradeItem = chgGradeItem;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getSetId() {
		return setId;
	}
	public void setSetId(String setId) {
		this.setId = setId;
	}
	public String getGradeItem() {
		return gradeItem;
	}
	public void setGradeItem(String gradeItem) {
		this.gradeItem = gradeItem;
	}
	public String getCtrType() {
		return ctrType;
	}
	public void setCtrType(String ctrType) {
		this.ctrType = ctrType;
	}
	public String getCtrCount() {
		return ctrCount;
	}
	public void setCtrCount(String ctrCount) {
		this.ctrCount = ctrCount;
	}
	
}

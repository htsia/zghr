package com.hr319wg.eva.pojo.vo;

import java.util.List;

public class EvaObjectMasterScoreVO {
	private String objectId;
	private String objectName;
	private String deptName;
	private String orgName;
	private String score;
	private String gradeName;
	private List masterList;
	private String templateId;
	private String totalRecord;
	private String hasScoreCount;
	private String notScoreCount;
	
	public String getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(String totalRecord) {
		this.totalRecord = totalRecord;
	}
	public String getHasScoreCount() {
		return hasScoreCount;
	}
	public void setHasScoreCount(String hasScoreCount) {
		this.hasScoreCount = hasScoreCount;
	}
	public String getNotScoreCount() {
		return notScoreCount;
	}
	public void setNotScoreCount(String notScoreCount) {
		this.notScoreCount = notScoreCount;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getObjectName() {
		return objectName;
	}
	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public List getMasterList() {
		return masterList;
	}
	public void setMasterList(List masterList) {
		this.masterList = masterList;
	}
}

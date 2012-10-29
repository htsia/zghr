package com.hr319wg.xys.eva.pojo.bo;

public class Xys360ObjBO {
	private String objId;
	private String personId;
	private String planId;
	private String score;
	private String templateId;
	private String gradeStatus;
	private String scoreLeader;
    private String scorePreLeader;
    private String scoreOtherLeader;
    private String scoreVis;
    private String scoreOtherVis;
    private String scoreLower;
    private String scoreError;//分数是否异常（0否1是）
    private String postId;
	
	private String personName;
    private String deptName;
    private String postName;
    private String templateName;
    private String planName;
    private String year;
    private String allCount;//总人数
    private String signCount;//打分人数
    private String noSignCount;//未打分人数
    
    
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getScoreLeader() {
		return scoreLeader;
	}
	public void setScoreLeader(String scoreLeader) {
		this.scoreLeader = scoreLeader;
	}
	public String getScorePreLeader() {
		return scorePreLeader;
	}
	public void setScorePreLeader(String scorePreLeader) {
		this.scorePreLeader = scorePreLeader;
	}
	public String getScoreOtherLeader() {
		return scoreOtherLeader;
	}
	public void setScoreOtherLeader(String scoreOtherLeader) {
		this.scoreOtherLeader = scoreOtherLeader;
	}
	public String getScoreVis() {
		return scoreVis;
	}
	public void setScoreVis(String scoreVis) {
		this.scoreVis = scoreVis;
	}
	public String getScoreOtherVis() {
		return scoreOtherVis;
	}
	public void setScoreOtherVis(String scoreOtherVis) {
		this.scoreOtherVis = scoreOtherVis;
	}
	public String getScoreLower() {
		return scoreLower;
	}
	public void setScoreLower(String scoreLower) {
		this.scoreLower = scoreLower;
	}
	public String getScoreError() {
		return scoreError;
	}
	public void setScoreError(String scoreError) {
		this.scoreError = scoreError;
	}
	public String getGradeStatus() {
		return gradeStatus;
	}
	public void setGradeStatus(String gradeStatus) {
		this.gradeStatus = gradeStatus;
	}
	public String getAllCount() {
		return allCount;
	}
	public void setAllCount(String allCount) {
		this.allCount = allCount;
	}
	public String getSignCount() {
		return signCount;
	}
	public void setSignCount(String signCount) {
		this.signCount = signCount;
	}
	public String getNoSignCount() {
		return noSignCount;
	}
	public void setNoSignCount(String noSignCount) {
		this.noSignCount = noSignCount;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
	
}

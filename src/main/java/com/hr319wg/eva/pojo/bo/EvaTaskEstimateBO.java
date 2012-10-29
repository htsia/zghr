package com.hr319wg.eva.pojo.bo;

public class EvaTaskEstimateBO {
	private String itemId;
	private String masterId;
	private String score;
	private String selfScore;
	private String seq;
	private String taskContent;
	private String taskPlan;
	private String taskStandard;
	private String taskDate;
	private String purview;
	private String option;
	private String planBeginDate;
	private String planEndDate;
	private String actBeginDate;
	private String actEndDate;
	private String level;
	private String venture;
	private String process;
	
	public String getPlanBeginDate() {
		return planBeginDate;
	}

	public void setPlanBeginDate(String planBeginDate) {
		this.planBeginDate = planBeginDate;
	}

	public String getPlanEndDate() {
		return planEndDate;
	}

	public void setPlanEndDate(String planEndDate) {
		this.planEndDate = planEndDate;
	}

	public String getActBeginDate() {
		return actBeginDate;
	}

	public void setActBeginDate(String actBeginDate) {
		this.actBeginDate = actBeginDate;
	}

	public String getActEndDate() {
		return actEndDate;
	}

	public void setActEndDate(String actEndDate) {
		this.actEndDate = actEndDate;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getVenture() {
		return venture;
	}

	public void setVenture(String venture) {
		this.venture = venture;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public void initrow(){
		this.itemId=null;
		this.seq="";
		this.taskContent="";
		this.taskPlan="";
		this.taskStandard="";
		this.taskDate="";
		this.purview="";
		this.option="";
	}
	
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getSelfScore() {
		return selfScore;
	}
	public void setSelfScore(String selfScore) {
		this.selfScore = selfScore;
	}
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTaskContent() {
		return taskContent;
	}
	public void setTaskContent(String taskContent) {
		this.taskContent = taskContent;
	}
	public String getTaskPlan() {
		return taskPlan;
	}
	public void setTaskPlan(String taskPlan) {
		this.taskPlan = taskPlan;
	}
	public String getTaskStandard() {
		return taskStandard;
	}
	public void setTaskStandard(String taskStandard) {
		this.taskStandard = taskStandard;
	}
	public String getTaskDate() {
		return taskDate;
	}
	public void setTaskDate(String taskDate) {
		this.taskDate = taskDate;
	}
	public String getPurview() {
		return purview;
	}
	public void setPurview(String purview) {
		this.purview = purview;
	}
}

package com.hr319wg.eva.pojo.bo;

public class EvaJobContentBO {
	private String taskID;
	private String itemID;
	private String seq;
	private String preview;
	private String selfScore;
	private String leadScore;
	private String content;
	private String result;
	
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public void cleanBO(){
		content = "";
		selfScore = "";
		preview = "";
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTaskID() {
		return taskID;
	}
	public void setTaskID(String taskID) {
		this.taskID = taskID;
	}
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getPreview() {
		return preview;
	}
	public void setPreview(String preview) {
		this.preview = preview;
	}
	public String getSelfScore() {
		return selfScore;
	}
	public void setSelfScore(String selfScore) {
		this.selfScore = selfScore;
	}
	public String getLeadScore() {
		return leadScore;
	}
	public void setLeadScore(String leadScore) {
		this.leadScore = leadScore;
	}
}

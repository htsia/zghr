package com.hr319wg.eva.pojo.bo;

public class EvaTaskProcessBO {
	private String processId;
	private String itemId;
	private String reportDate;
	private String process;
	private String description;
	
	public void initrow(){
		this.processId=null;
		this.itemId="";
		this.reportDate="";
		this.process="";
		this.description="";
	}
	
	public String getProcessId() {
		return processId;
	}
	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}

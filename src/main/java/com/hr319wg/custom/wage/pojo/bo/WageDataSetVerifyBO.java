package com.hr319wg.custom.wage.pojo.bo;

public class WageDataSetVerifyBO {

	private String ID;
	private String datasetUserID;
	private String yearMonth;
	private String status="0"; //0ÍË»Ø 1 Í¨¹ý 

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getDatasetUserID() {
		return datasetUserID;
	}
	public void setDatasetUserID(String datasetUserID) {
		this.datasetUserID = datasetUserID;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	
}

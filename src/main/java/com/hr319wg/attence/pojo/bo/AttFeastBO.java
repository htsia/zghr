package com.hr319wg.attence.pojo.bo;


public class AttFeastBO {
	private String feastID;
	private String feastName;
	private String description;
	private String orgID;
	private String orgIDName;
	private String year;
    private String regTime;
    private String beginDate;
    private String endDate;
    private String feastDate;
    private String yearType;
    private String postLeiXing;

    public String getYearType() {
		return yearType;
	}

	public void setYearType(String yearType) {
		this.yearType = yearType;
	}

	public String getFeastDate() {
		return feastDate;
	}

	public void setFeastDate(String feastDate) {
		this.feastDate = feastDate;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	

	public String getPostLeiXing() {
		return postLeiXing;
	}

	public void setPostLeiXing(String postLeiXing) {
		this.postLeiXing = postLeiXing;
	}


	public String getRegTime() {
        return regTime;
    }

    public void setRegTime(String regTime) {
        this.regTime = regTime;
    }

	public String getFeastID() {
		return feastID;
	}

	public void setFeastID(String feastID) {
		this.feastID = feastID;
	}

	public String getFeastName() {
		return feastName;
	}

	public void setFeastName(String feastName) {
		this.feastName = feastName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getOrgIDName() {
		return orgIDName;
	}

	public void setOrgIDName(String orgIDName) {
		this.orgIDName = orgIDName;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

}

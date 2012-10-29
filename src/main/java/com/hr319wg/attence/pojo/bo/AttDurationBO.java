package com.hr319wg.attence.pojo.bo;

public class AttDurationBO {
	
    private String duraID;
    private String orgID;
    private String duraYear;
    private String duraMonth;
    private String duraBegin;
    private String duraEnd;
    private String createOper;
    private String createDate;
    private String createUserID;
    private String QryID;
    private String QryName;
    private String status; //0计算 发布 1审批  2查看 通过

    public String getQryName() {
		return QryName;
	}

	public void setQryName(String qryName) {
		QryName = qryName;
	}

	public String getQryID() {
		return QryID;
	}

	public void setQryID(String qryID) {
		QryID = qryID;
	}

	public String getCreateUserID() {
		return createUserID;
	}

	public void setCreateUserID(String createUserID) {
		this.createUserID = createUserID;
	}

	public String getDuraID() {
        return duraID;
    }

    public void setDuraID(String duraID) {
        this.duraID = duraID;
    }

    public String getOrgID() {
        return orgID;
    }

    public void setOrgID(String orgID) {
        this.orgID = orgID;
    }

    public String getDuraYear() {
        return duraYear;
    }

    public void setDuraYear(String duraYear) {
        this.duraYear = duraYear;
    }

    public String getDuraMonth() {
        return duraMonth;
    }

    public void setDuraMonth(String duraMonth) {
        this.duraMonth = duraMonth;
    }

    public String getDuraBegin() {
        return duraBegin;
    }

    public void setDuraBegin(String duraBegin) {
        this.duraBegin = duraBegin;
    }

    public String getDuraEnd() {
        return duraEnd;
    }

    public void setDuraEnd(String duraEnd) {
        this.duraEnd = duraEnd;
    }

    public String getCreateOper() {
        return createOper;
    }

    public void setCreateOper(String createOper) {
        this.createOper = createOper;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}

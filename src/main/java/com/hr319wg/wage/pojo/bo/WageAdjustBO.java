package com.hr319wg.wage.pojo.bo;

public class WageAdjustBO {
	public static String STATUS_APPLY = "0";
	public static String STATUS_AUDITING = "1";
	public static String STATUS_OK = "2";
	public static String STATUS_NO = "3";
	public static String STATUS_ADJUST = "4";
	private String personCode;
	private String personName;
	private String adjustDate;
	private String applyDate;
	private String status;
	private String approStatus;
	private String statusDes;
	private String itemID;
	private String orgID;
	private String adjustType;
	private String linkID;
	private String orgName;
	private String secDeptName;
	private String personID;
	private String audit1Oper;
	private String audit1OperName;
	private String audit1Date;
	private String audit1Result;
	private String audit1Reason;
	private String audit2Oper;
	private String audit2OperName;
	private String audit2Date;
	private String audit2Result;
	private String audit2Reason;
	private String audit3Oper;
	private String audit3OperName;
	private String audit3Date;
	private String audit3Result;
	private String audit3Reason;

	public String getPersonCode() {
		return personCode;
	}

	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}

	public String getSecDeptName() {
		return secDeptName;
	}

	public void setSecDeptName(String secDeptName) {
		this.secDeptName = secDeptName;
	}

	public String getApproStatus() {
		return approStatus;
	}

	public void setApproStatus(String approStatus) {
		this.approStatus = approStatus;
	}

	public String getAdjustType() {
		return this.adjustType;
	}

	public void setAdjustType(String adjustType) {
		this.adjustType = adjustType;
	}

	public String getLinkID() {
		return this.linkID;
	}

	public void setLinkID(String linkID) {
		this.linkID = linkID;
	}

	public String getOrgName() {
		return this.orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getAudit1Oper() {
		return this.audit1Oper;
	}

	public void setAudit1Oper(String audit1Oper) {
		this.audit1Oper = audit1Oper;
	}

	public String getAudit1Date() {
		return this.audit1Date;
	}

	public void setAudit1Date(String audit1Date) {
		this.audit1Date = audit1Date;
	}

	public String getAudit1Result() {
		return this.audit1Result;
	}

	public void setAudit1Result(String audit1Result) {
		this.audit1Result = audit1Result;
	}

	public String getAudit1Reason() {
		return this.audit1Reason;
	}

	public void setAudit1Reason(String audit1Reason) {
		this.audit1Reason = audit1Reason;
	}

	public String getAudit1OperName() {
		return this.audit1OperName;
	}

	public void setAudit1OperName(String audit1OperName) {
		this.audit1OperName = audit1OperName;
	}

	public String getApplyDate() {
		return this.applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusDes() {
		this.statusDes = "";
		if (STATUS_APPLY.equals(this.status)) {
			this.statusDes = "申请";
		} else if (STATUS_AUDITING.equals(this.status)) {
			this.statusDes = "审批中";
		} else if (STATUS_OK.equals(this.status)) {
			this.statusDes = "审批通过";
		} else if (STATUS_NO.equals(this.status)) {
			this.statusDes = "审批不通过";
		} else if (STATUS_ADJUST.equals(this.status)) {
			this.statusDes = "生效";
		}
		return this.statusDes;
	}

	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}

	public String getPersonName() {
		return this.personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getOrgID() {
		return this.orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getItemID() {
		return this.itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String getPersonID() {
		return this.personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
	}

	public String getAdjustDate() {
		return this.adjustDate;
	}

	public void setAdjustDate(String adjustDate) {
		this.adjustDate = adjustDate;
	}

	public String getAudit2Oper() {
		return this.audit2Oper;
	}

	public void setAudit2Oper(String audit2Oper) {
		this.audit2Oper = audit2Oper;
	}

	public String getAudit2OperName() {
		return this.audit2OperName;
	}

	public void setAudit2OperName(String audit2OperName) {
		this.audit2OperName = audit2OperName;
	}

	public String getAudit2Date() {
		return this.audit2Date;
	}

	public void setAudit2Date(String audit2Date) {
		this.audit2Date = audit2Date;
	}

	public String getAudit2Result() {
		return this.audit2Result;
	}

	public void setAudit2Result(String audit2Result) {
		this.audit2Result = audit2Result;
	}

	public String getAudit2Reason() {
		return this.audit2Reason;
	}

	public void setAudit2Reason(String audit2Reason) {
		this.audit2Reason = audit2Reason;
	}

	public String getAudit3Oper() {
		return this.audit3Oper;
	}

	public void setAudit3Oper(String audit3Oper) {
		this.audit3Oper = audit3Oper;
	}

	public String getAudit3OperName() {
		return this.audit3OperName;
	}

	public void setAudit3OperName(String audit3OperName) {
		this.audit3OperName = audit3OperName;
	}

	public String getAudit3Date() {
		return this.audit3Date;
	}

	public void setAudit3Date(String audit3Date) {
		this.audit3Date = audit3Date;
	}

	public String getAudit3Result() {
		return this.audit3Result;
	}

	public void setAudit3Result(String audit3Result) {
		this.audit3Result = audit3Result;
	}

	public String getAudit3Reason() {
		return this.audit3Reason;
	}

	public void setAudit3Reason(String audit3Reason) {
		this.audit3Reason = audit3Reason;
	}
}
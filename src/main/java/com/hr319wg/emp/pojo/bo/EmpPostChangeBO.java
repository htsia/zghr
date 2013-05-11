package com.hr319wg.emp.pojo.bo;

public class EmpPostChangeBO {
	public static String APPLY = "0";
	public static String APPROVING = "1";
	public static String APPROVED = "2";
	public static String HUMANEFFICIRNT = "3";
	public static String WAGECHANGE = "4";
	public static String REFUSE = "9";
	private String postChangeId;
	private String personId;
	private String applyDate;
	private String oldDept;
	private String oldPost;
	private String oldJob;
	private String newDept;
	private String newPost;
	private String newJob;
	private String status;
	private String statusDes;
	private String linkBeginMgr;
	private String passPost;
	private String passPostLevel;
	private String auditResult;
	private String auditDate;
	private String auditOption;
	private String auditOper;
	private boolean edit;
	private String auditResult1;
	private String auditDate1;
	private String auditOption1;
	private String auditOper1;
	private boolean edit1;
	private String auditResult2;
	private String auditDate2;
	private String auditOption2;
	private String auditOper2;
	private boolean edit2;
	private String auditResult3;
	private String auditDate3;
	private String auditOption3;
	private String auditOper3;
	private boolean edit3;
	private String auditResult4;
	private String auditDate4;
	private String auditOption4;
	private String auditOper4;
	private boolean edit4;
	private String auditResult5;
	private String auditDate5;
	private String auditOption5;
	private String auditOper5;
	private boolean edit5;
	private String auditResult6;
	private String auditDate6;
	private String auditOption6;
	private String auditOper6;
	private boolean edit6;
	private String personName;
	private String auditResultDes;
	private String auditResultDes1;
	private String auditResultDes2;
	private boolean canAduit;
	private String hrValidDate;
	private String wageValidDate;
	private String addResume;
	private String changeType;
	private String changeReason;
	private String changeReasonDes;
	private String changeBase;
	private String changeLetterNO;
	private String applyPersonID;
	private String applyPersonName;

	public String getApplyPersonID() {
		return applyPersonID;
	}

	public void setApplyPersonID(String applyPersonID) {
		this.applyPersonID = applyPersonID;
	}

	public String getApplyPersonName() {
		return applyPersonName;
	}

	public void setApplyPersonName(String applyPersonName) {
		this.applyPersonName = applyPersonName;
	}

	public String getPassPost() {
		return this.passPost;
	}

	public void setPassPost(String passPost) {
		this.passPost = passPost;
	}

	public String getPassPostLevel() {
		return this.passPostLevel;
	}

	public void setPassPostLevel(String passPostLevel) {
		this.passPostLevel = passPostLevel;
	}

	public String getLinkBeginMgr() {
		return this.linkBeginMgr;
	}

	public void setLinkBeginMgr(String linkBeginMgr) {
		this.linkBeginMgr = linkBeginMgr;
	}

	public String getAuditResult3() {
		return this.auditResult3;
	}

	public void setAuditResult3(String auditResult3) {
		this.auditResult3 = auditResult3;
	}

	public String getAuditDate3() {
		return this.auditDate3;
	}

	public void setAuditDate3(String auditDate3) {
		this.auditDate3 = auditDate3;
	}

	public String getAuditOption3() {
		return this.auditOption3;
	}

	public void setAuditOption3(String auditOption3) {
		this.auditOption3 = auditOption3;
	}

	public String getAuditOper3() {
		return this.auditOper3;
	}

	public void setAuditOper3(String auditOper3) {
		this.auditOper3 = auditOper3;
	}

	public String getAuditResult4() {
		return this.auditResult4;
	}

	public void setAuditResult4(String auditResult4) {
		this.auditResult4 = auditResult4;
	}

	public String getAuditDate4() {
		return this.auditDate4;
	}

	public void setAuditDate4(String auditDate4) {
		this.auditDate4 = auditDate4;
	}

	public String getAuditOption4() {
		return this.auditOption4;
	}

	public void setAuditOption4(String auditOption4) {
		this.auditOption4 = auditOption4;
	}

	public String getAuditOper4() {
		return this.auditOper4;
	}

	public void setAuditOper4(String auditOper4) {
		this.auditOper4 = auditOper4;
	}

	public String getAuditResult5() {
		return this.auditResult5;
	}

	public void setAuditResult5(String auditResult5) {
		this.auditResult5 = auditResult5;
	}

	public String getAuditDate5() {
		return this.auditDate5;
	}

	public void setAuditDate5(String auditDate5) {
		this.auditDate5 = auditDate5;
	}

	public String getAuditOption5() {
		return this.auditOption5;
	}

	public void setAuditOption5(String auditOption5) {
		this.auditOption5 = auditOption5;
	}

	public String getAuditOper5() {
		return this.auditOper5;
	}

	public void setAuditOper5(String auditOper5) {
		this.auditOper5 = auditOper5;
	}

	public boolean isEdit() {
		return this.edit;
	}

	public void setEdit(boolean edit) {
		this.edit = edit;
	}

	public boolean isEdit1() {
		return this.edit1;
	}

	public void setEdit1(boolean edit1) {
		this.edit1 = edit1;
	}

	public boolean isEdit2() {
		return this.edit2;
	}

	public void setEdit2(boolean edit2) {
		this.edit2 = edit2;
	}

	public boolean isEdit3() {
		return this.edit3;
	}

	public void setEdit3(boolean edit3) {
		this.edit3 = edit3;
	}

	public boolean isEdit4() {
		return this.edit4;
	}

	public void setEdit4(boolean edit4) {
		this.edit4 = edit4;
	}

	public boolean isEdit5() {
		return this.edit5;
	}

	public void setEdit5(boolean edit5) {
		this.edit5 = edit5;
	}

	public String getAuditResult6() {
		return this.auditResult6;
	}

	public void setAuditResult6(String auditResult6) {
		this.auditResult6 = auditResult6;
	}

	public String getAuditDate6() {
		return this.auditDate6;
	}

	public void setAuditDate6(String auditDate6) {
		this.auditDate6 = auditDate6;
	}

	public String getAuditOption6() {
		return this.auditOption6;
	}

	public void setAuditOption6(String auditOption6) {
		this.auditOption6 = auditOption6;
	}

	public String getAuditOper6() {
		return this.auditOper6;
	}

	public void setAuditOper6(String auditOper6) {
		this.auditOper6 = auditOper6;
	}

	public boolean isEdit6() {
		return this.edit6;
	}

	public void setEdit6(boolean edit6) {
		this.edit6 = edit6;
	}

	public String getAddResume() {
		return this.addResume;
	}

	public void setAddResume(String addResume) {
		this.addResume = addResume;
	}

	public String getChangeType() {
		return this.changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	public String getChangeReason() {
		return this.changeReason;
	}

	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	public String getChangeBase() {
		return this.changeBase;
	}

	public void setChangeBase(String changeBase) {
		this.changeBase = changeBase;
	}

	public String getChangeLetterNO() {
		return this.changeLetterNO;
	}

	public void setChangeLetterNO(String changeLetterNO) {
		this.changeLetterNO = changeLetterNO;
	}

	public String getChangeReasonDes() {
		return this.changeReasonDes;
	}

	public void setChangeReasonDes(String changeReasonDes) {
		this.changeReasonDes = changeReasonDes;
	}

	public String getHrValidDate() {
		return this.hrValidDate;
	}

	public void setHrValidDate(String hrValidDate) {
		this.hrValidDate = hrValidDate;
	}

	public String getWageValidDate() {
		return this.wageValidDate;
	}

	public void setWageValidDate(String wageValidDate) {
		this.wageValidDate = wageValidDate;
	}

	public boolean getCanAduit() {
		return this.canAduit;
	}

	public void setCanAduit(boolean canAduit) {
		this.canAduit = canAduit;
	}

	public String getAuditResultDes() {
		if ("1".equals(this.auditResult))
			this.auditResultDes = "通过";
		else if ("0".equals(this.auditResult)) {
			this.auditResultDes = "不通过";
		}
		return this.auditResultDes;
	}

	public void setAuditResultDes(String auditResultDes) {
		this.auditResultDes = auditResultDes;
	}

	public String getAuditResultDes1() {
		if ("1".equals(this.auditResult1))
			this.auditResultDes1 = "通过";
		else if ("0".equals(this.auditResult1)) {
			this.auditResultDes1 = "不通过";
		}
		return this.auditResultDes1;
	}

	public void setAuditResultDes1(String auditResultDes1) {
		this.auditResultDes1 = auditResultDes1;
	}

	public String getAuditResultDes2() {
		if ("1".equals(this.auditResult2))
			this.auditResultDes2 = "通过";
		else if ("0".equals(this.auditResult2)) {
			this.auditResultDes2 = "不通过";
		}
		return this.auditResultDes2;
	}

	public void setAuditResultDes2(String auditResultDes2) {
		this.auditResultDes2 = auditResultDes2;
	}

	public String getPersonName() {
		return this.personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPostChangeId() {
		return this.postChangeId;
	}

	public void setPostChangeId(String postChangeId) {
		this.postChangeId = postChangeId;
	}

	public String getPersonId() {
		return this.personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getApplyDate() {
		return this.applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public String getOldDept() {
		return this.oldDept;
	}

	public void setOldDept(String oldDept) {
		this.oldDept = oldDept;
	}

	public String getOldPost() {
		return this.oldPost;
	}

	public void setOldPost(String oldPost) {
		this.oldPost = oldPost;
	}

	public String getOldJob() {
		return this.oldJob;
	}

	public void setOldJob(String oldJob) {
		this.oldJob = oldJob;
	}

	public String getNewDept() {
		return this.newDept;
	}

	public void setNewDept(String newDept) {
		this.newDept = newDept;
	}

	public String getNewPost() {
		return this.newPost;
	}

	public void setNewPost(String newPost) {
		this.newPost = newPost;
	}

	public String getNewJob() {
		return this.newJob;
	}

	public void setNewJob(String newJob) {
		this.newJob = newJob;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatusDes() {
		if (APPLY.equals(this.status))
			this.statusDes = "申请";
		else if (APPROVING.equals(this.status))
			this.statusDes = "审批";
		else if (APPROVED.equals(this.status))
			this.statusDes = "批准";
		else if (HUMANEFFICIRNT.equals(this.status))
			this.statusDes = "人事生效";
		else if (WAGECHANGE.equals(this.status))
			this.statusDes = "工资调整";
		else if (REFUSE.equals(this.status)) {
			this.statusDes = "退回";
		}
		return this.statusDes;
	}

	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}

	public String getAuditResult() {
		return this.auditResult;
	}

	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}

	public String getAuditDate() {
		return this.auditDate;
	}

	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}

	public String getAuditOption() {
		return this.auditOption;
	}

	public void setAuditOption(String auditOption) {
		this.auditOption = auditOption;
	}

	public String getAuditOper() {
		return this.auditOper;
	}

	public void setAuditOper(String auditOper) {
		this.auditOper = auditOper;
	}

	public String getAuditResult1() {
		return this.auditResult1;
	}

	public void setAuditResult1(String auditResult1) {
		this.auditResult1 = auditResult1;
	}

	public String getAuditDate1() {
		return this.auditDate1;
	}

	public void setAuditDate1(String auditDate1) {
		this.auditDate1 = auditDate1;
	}

	public String getAuditOption1() {
		return this.auditOption1;
	}

	public void setAuditOption1(String auditOption1) {
		this.auditOption1 = auditOption1;
	}

	public String getAuditOper1() {
		return this.auditOper1;
	}

	public void setAuditOper1(String auditOper1) {
		this.auditOper1 = auditOper1;
	}

	public String getAuditResult2() {
		return this.auditResult2;
	}

	public void setAuditResult2(String auditResult2) {
		this.auditResult2 = auditResult2;
	}

	public String getAuditDate2() {
		return this.auditDate2;
	}

	public void setAuditDate2(String auditDate2) {
		this.auditDate2 = auditDate2;
	}

	public String getAuditOption2() {
		return this.auditOption2;
	}

	public void setAuditOption2(String auditOption2) {
		this.auditOption2 = auditOption2;
	}

	public String getAuditOper2() {
		return this.auditOper2;
	}

	public void setAuditOper2(String auditOper2) {
		this.auditOper2 = auditOper2;
	}
}
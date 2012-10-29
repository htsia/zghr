package com.hr319wg.attence.pojo.bo;

public class AttClassBO {
	// 是否零点班 1否 2 是
	public static final String DAY_SPAN_ZERO_NO = "1";
	public static final String DAY_SPAN_ZERO_YES = "2";

	// 零点班记录日期标准 1开始日期2是结束日期
	public static final String DAY_TASK_BEGIN = "1";
	public static final String DAY_TASK_END = "2";
	// 单时段 双时段
	public static final String SECTION_COUNT_ONE = "1";
	public static final String SECTION_COUNT_TWO = "2";

	private String classID;
	private String className;
	private String shortName;
	private String createDate;
	private String createUser;
	private String orgID;
	private String sectionCount;
	private String sectionCounts;
	private String isUse;
	private String orgName;
	private String IsUseName;
	private String createOrg;
	private String daySpan;
	private String dayTake;
	private String overTimeFlag; // 0 不计加班 1 自动记加班
	private String overTimeFlagName;
	private String totalWorkLong;
	private String frequencyType;
	private String frequencyTxt;
	private String applyBeginDate;
	private String applyEndDate;
	private String raleQry;
	private String raleType="0";
	
	
	public String getRaleType() {
		return raleType;
	}

	public void setRaleType(String raleType) {
		this.raleType = raleType;
	}

	public String getRaleQry() {
		return raleQry;
	}

	public void setRaleQry(String raleQry) {
		this.raleQry = raleQry;
	}

	public String getApplyBeginDate() {
		return applyBeginDate;
	}

	public void setApplyBeginDate(String applyBeginDate) {
		this.applyBeginDate = applyBeginDate;
	}

	public String getApplyEndDate() {
		return applyEndDate;
	}

	public void setApplyEndDate(String applyEndDate) {
		this.applyEndDate = applyEndDate;
	}

	public String getFrequencyType() {
		return frequencyType;
	}

	public void setFrequencyType(String frequencyType) {
		this.frequencyType = frequencyType;
	}

	public String getFrequencyTxt() {
		return frequencyTxt;
	}

	public void setFrequencyTxt(String frequencyTxt) {
		this.frequencyTxt = frequencyTxt;
	}

	public String getTotalWorkLong() {
		return totalWorkLong;
	}

	public void setTotalWorkLong(String totalWorkLong) {
		this.totalWorkLong = totalWorkLong;
	}

	public String getClassID() {
		return classID;
	}

	public void setClassID(String classID) {
		this.classID = classID;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateUser() {
		return createUser;
	}

	public String getIsUse() {
		return isUse;
	}

	public void setIsUse(String isUse) {
		this.isUse = isUse;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getSectionCount() {
		return sectionCount;
	}

	public void setSectionCount(String sectionCount) {
		this.sectionCount = sectionCount;
	}

	public String getSectionCounts() {
		return sectionCounts;
	}

	public void setSectionCounts(String sectionCounts) {
		this.sectionCounts = sectionCounts;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getIsUseName() {
		return IsUseName;
	}

	public void setIsUseName(String isUseName) {
		IsUseName = isUseName;
	}

	public String getCreateOrg() {
		return createOrg;
	}

	public void setCreateOrg(String createOrg) {
		this.createOrg = createOrg;
	}

	public String getDaySpan() {
		return daySpan;
	}

	public void setDaySpan(String daySpan) {
		this.daySpan = daySpan;
	}

	public String getDayTake() {
		return dayTake;
	}

	public void setDayTake(String dayTake) {
		this.dayTake = dayTake;
	}

	public String getOverTimeFlag() {
		return overTimeFlag;
	}

	public void setOverTimeFlag(String overTimeFlag) {
		this.overTimeFlag = overTimeFlag;
	}

	public String getOverTimeFlagName() {
		return overTimeFlagName;
	}

	public void setOverTimeFlagName(String overTimeFlagName) {
		this.overTimeFlagName = overTimeFlagName;
	}

}

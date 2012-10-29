package com.hr319wg.custom.attence.pojo.bo;

public class AttMonthBO {

	private String subID; // 子集标示
	private String personId; // 人员编号
	private String personCode;
	private String personName;
	private String personType;
	private String deptName;
	private String secDeptName;
	private String attCard;
	private String record; // 是否当前记录
	private String attenceDate; // 年月日
	private String realityTime; // 实际出勤
	private String shouldTime; // 应出勤
	private String attenceRate; // 月出勤率
	private String lateTime; // 迟到次数
	private String earlyTime; // 早退次数
	private String awayTime; // 旷工次数
	private String leaveReasons; // 事假
	private String leaveSick; // 病假
	private String leaveMaternity; // 产假
	private String leaveWedding; // 婚假
	private String leaveHome; // 探亲假
	private String leaveYear; // 年假
	private String leaveIndustrialInjury; // 工伤假
	private String leaveArrangingFuneral; // 丧假
	private String evcctionValue; // 出差
	private String outWorkValue; // 公出
	private String publicHolidayValue; // 公假
	private String timeOffValue; // 倒休
	private String workAddValue; // 加班
	private String weekAddValue; // 双休日加班
	private String feastAddValue; // 节假日加班
	private String beginShouldTime; // 变动前应出勤
	private String endShouldTime; // 变动后应出勤

	private String lateModify;
    private String awayModify;
    private String leaveReasonsModify;
    private String sickModify;
    private String maternityModify;
    private String weddingModify;
    private String homeModify;
    private String industrialInjuryModify;
    private String arrangingFuneralModify;
    private String outModify;
    private String overtimeModify;
    private String modifyDate;
    private String status; //0提交  1审批通过
    private String isDimission;//是否离职
    private String dimissionDesc;
    private String dimissionDate;//离职时间
    private String laterDeduction; //迟到扣款
    private String awayDeduction;  //旷工扣款
    private String nomalLeaveDeduction; //事假扣款
    private String illLeaveDeduction;   //病假扣款
    private String chanjiaLeaveDeduction;   //产假扣款
    private String nanchanjiaLeaveDeduction;   //难产产假扣款
    private String leaveNanchanjia;   //难产产假
    
    
	public String getSecDeptName() {
		return secDeptName;
	}

	public void setSecDeptName(String secDeptName) {
		this.secDeptName = secDeptName;
	}

	public String getChanjiaLeaveDeduction() {
		return chanjiaLeaveDeduction;
	}

	public void setChanjiaLeaveDeduction(String chanjiaLeaveDeduction) {
		this.chanjiaLeaveDeduction = chanjiaLeaveDeduction;
	}

	public String getNanchanjiaLeaveDeduction() {
		return nanchanjiaLeaveDeduction;
	}

	public void setNanchanjiaLeaveDeduction(String nanchanjiaLeaveDeduction) {
		this.nanchanjiaLeaveDeduction = nanchanjiaLeaveDeduction;
	}

	public String getLeaveNanchanjia() {
		return leaveNanchanjia;
	}

	public void setLeaveNanchanjia(String leaveNanchanjia) {
		this.leaveNanchanjia = leaveNanchanjia;
	}

	public String getLaterDeduction() {
		return laterDeduction;
	}

	public void setLaterDeduction(String laterDeduction) {
		this.laterDeduction = laterDeduction;
	}

	public String getAwayDeduction() {
		return awayDeduction;
	}

	public void setAwayDeduction(String awayDeduction) {
		this.awayDeduction = awayDeduction;
	}

	public String getNomalLeaveDeduction() {
		return nomalLeaveDeduction;
	}

	public void setNomalLeaveDeduction(String nomalLeaveDeduction) {
		this.nomalLeaveDeduction = nomalLeaveDeduction;
	}

	public String getIllLeaveDeduction() {
		return illLeaveDeduction;
	}

	public void setIllLeaveDeduction(String illLeaveDeduction) {
		this.illLeaveDeduction = illLeaveDeduction;
	}


    
	public String getDimissionDesc() {
		if("1".equals(this.isDimission)){
			return "离职";
		}
		return dimissionDesc;
	}

	public void setDimissionDesc(String dimissionDesc) {
		this.dimissionDesc = dimissionDesc;
	}

	public String getIsDimission() {
		return isDimission;
	}

	public void setIsDimission(String isDimission) {
		this.isDimission = isDimission;
	}

	public String getDimissionDate() {
		return dimissionDate;
	}

	public void setDimissionDate(String dimissionDate) {
		this.dimissionDate = dimissionDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getLateModify() {
		return lateModify;
	}

	public void setLateModify(String lateModify) {
		this.lateModify = lateModify;
	}

	public String getAwayModify() {
		return awayModify;
	}

	public void setAwayModify(String awayModify) {
		this.awayModify = awayModify;
	}

	public String getLeaveReasonsModify() {
		return leaveReasonsModify;
	}

	public void setLeaveReasonsModify(String leaveReasonsModify) {
		this.leaveReasonsModify = leaveReasonsModify;
	}

	public String getSickModify() {
		return sickModify;
	}

	public void setSickModify(String sickModify) {
		this.sickModify = sickModify;
	}

	public String getMaternityModify() {
		return maternityModify;
	}

	public void setMaternityModify(String maternityModify) {
		this.maternityModify = maternityModify;
	}

	public String getWeddingModify() {
		return weddingModify;
	}

	public void setWeddingModify(String weddingModify) {
		this.weddingModify = weddingModify;
	}

	public String getHomeModify() {
		return homeModify;
	}

	public void setHomeModify(String homeModify) {
		this.homeModify = homeModify;
	}

	public String getIndustrialInjuryModify() {
		return industrialInjuryModify;
	}

	public void setIndustrialInjuryModify(String industrialInjuryModify) {
		this.industrialInjuryModify = industrialInjuryModify;
	}

	public String getArrangingFuneralModify() {
		return arrangingFuneralModify;
	}

	public void setArrangingFuneralModify(String arrangingFuneralModify) {
		this.arrangingFuneralModify = arrangingFuneralModify;
	}

	public String getOutModify() {
		return outModify;
	}

	public void setOutModify(String outModify) {
		this.outModify = outModify;
	}

	public String getOvertimeModify() {
		return overtimeModify;
	}

	public void setOvertimeModify(String overtimeModify) {
		this.overtimeModify = overtimeModify;
	}

	public String getPersonCode() {
		return personCode;
	}

	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getSubID() {
		return subID;
	}

	public void setSubID(String subID) {
		this.subID = subID;
	}

	public String getRecord() {
		return record;
	}

	public void setRecord(String record) {
		this.record = record;
	}

	public String getAttenceDate() {
		return attenceDate;
	}

	public void setAttenceDate(String attenceDate) {
		this.attenceDate = attenceDate;
	}

	public String getRealityTime() {
		return realityTime;
	}

	public void setRealityTime(String realityTime) {
		this.realityTime = realityTime;
	}

	public String getShouldTime() {
		return shouldTime;
	}

	public void setShouldTime(String shouldTime) {
		this.shouldTime = shouldTime;
	}

	public String getAttenceRate() {
		return attenceRate;
	}

	public void setAttenceRate(String attenceRate) {
		this.attenceRate = attenceRate;
	}

	public String getLateTime() {
		return lateTime;
	}

	public void setLateTime(String lateTime) {
		this.lateTime = lateTime;
	}

	public String getEarlyTime() {
		return earlyTime;
	}

	public void setEarlyTime(String earlyTime) {
		this.earlyTime = earlyTime;
	}

	public String getAwayTime() {
		return awayTime;
	}

	public void setAwayTime(String awayTime) {
		this.awayTime = awayTime;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getAttCard() {
		return attCard;
	}

	public void setAttCard(String attCard) {
		this.attCard = attCard;
	}

	public String getLeaveReasons() {
		return leaveReasons;
	}

	public void setLeaveReasons(String leaveReasons) {
		this.leaveReasons = leaveReasons;
	}

	public String getLeaveSick() {
		return leaveSick;
	}

	public void setLeaveSick(String leaveSick) {
		this.leaveSick = leaveSick;
	}

	public String getLeaveMaternity() {
		return leaveMaternity;
	}

	public void setLeaveMaternity(String leaveMaternity) {
		this.leaveMaternity = leaveMaternity;
	}

	public String getLeaveWedding() {
		return leaveWedding;
	}

	public void setLeaveWedding(String leaveWedding) {
		this.leaveWedding = leaveWedding;
	}

	public String getLeaveHome() {
		return leaveHome;
	}

	public void setLeaveHome(String leaveHome) {
		this.leaveHome = leaveHome;
	}

	public String getLeaveYear() {
		return leaveYear;
	}

	public void setLeaveYear(String leaveYear) {
		this.leaveYear = leaveYear;
	}

	public String getLeaveIndustrialInjury() {
		return leaveIndustrialInjury;
	}

	public void setLeaveIndustrialInjury(String leaveIndustrialInjury) {
		this.leaveIndustrialInjury = leaveIndustrialInjury;
	}

	public String getLeaveArrangingFuneral() {
		return leaveArrangingFuneral;
	}

	public void setLeaveArrangingFuneral(String leaveArrangingFuneral) {
		this.leaveArrangingFuneral = leaveArrangingFuneral;
	}

	public String getEvcctionValue() {
		return evcctionValue;
	}

	public void setEvcctionValue(String evcctionValue) {
		this.evcctionValue = evcctionValue;
	}

	public String getOutWorkValue() {
		return outWorkValue;
	}

	public void setOutWorkValue(String outWorkValue) {
		this.outWorkValue = outWorkValue;
	}

	public String getPublicHolidayValue() {
		return publicHolidayValue;
	}

	public void setPublicHolidayValue(String publicHolidayValue) {
		this.publicHolidayValue = publicHolidayValue;
	}

	public String getTimeOffValue() {
		return timeOffValue;
	}

	public void setTimeOffValue(String timeOffValue) {
		this.timeOffValue = timeOffValue;
	}

	public String getWorkAddValue() {
		return workAddValue;
	}

	public void setWorkAddValue(String workAddValue) {
		this.workAddValue = workAddValue;
	}

	public String getWeekAddValue() {
		return weekAddValue;
	}

	public void setWeekAddValue(String weekAddValue) {
		this.weekAddValue = weekAddValue;
	}

	public String getFeastAddValue() {
		return feastAddValue;
	}

	public void setFeastAddValue(String feastAddValue) {
		this.feastAddValue = feastAddValue;
	}

	public String getBeginShouldTime() {
		return beginShouldTime;
	}

	public void setBeginShouldTime(String beginShouldTime) {
		this.beginShouldTime = beginShouldTime;
	}

	public String getEndShouldTime() {
		return endShouldTime;
	}

	public void setEndShouldTime(String endShouldTime) {
		this.endShouldTime = endShouldTime;
	}
}

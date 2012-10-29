package com.hr319wg.attence.pojo.bo;
/**
 * @note  年假计算结果类
 */
public class AttAnnualItemBO {
private String itemID;// 标识
private String recID;//  年假ID
private String personID;// 人员ID
private String personName; //附加字段
private String annDay;// 假期天数
private String useDay;// 已休天数
private String avaDay; // 可用天数
private String lengthService;//参加工作时间
private String enterDate;//进入本单位时间
private String yearValues;
private String statusValue;

private String workDate ;//参加工作时间
private String  calcDate ;//计算日期
private String  calcAnnDay ;//临界后已休天数
private String criticalDate ;// 临界日期
private String  criticalAnnDay ;// 临界后休假天数
private String criticalAvaDay;// 临界后可用天数





public String getWorkDate() {
	return workDate;
}
public void setWorkDate(String workDate) {
	this.workDate = workDate;
}
public String getCalcDate() {
	return calcDate;
}
public void setCalcDate(String calcDate) {
	this.calcDate = calcDate;
}
 
public String getCalcAnnDay() {
	return calcAnnDay;
}
public void setCalcAnnDay(String calcAnnDay) {
	this.calcAnnDay = calcAnnDay;
}
public String getCriticalDate() {
	return criticalDate;
}
public void setCriticalDate(String criticalDate) {
	this.criticalDate = criticalDate;
}
public String getCriticalAnnDay() {
	return criticalAnnDay;
}
public void setCriticalAnnDay(String criticalAnnDay) {
	this.criticalAnnDay = criticalAnnDay;
}
public String getItemID() {
	return itemID;
}
public void setItemID(String itemID) {
	this.itemID = itemID;
}
public String getRecID() {
	return recID;
}
public void setRecID(String recID) {
	this.recID = recID;
}
public String getPersonID() {
	return personID;
}
public void setPersonID(String personID) {
	this.personID = personID;
}

public String getPersonName() {
	return personName;
}
public void setPersonName(String personName) {
	this.personName = personName;
}
public String getAnnDay() {
	return annDay;
}
public void setAnnDay(String annDay) {
	this.annDay = annDay;
}
public String getUseDay() {
	return useDay;
}
public void setUseDay(String useDay) {
	this.useDay = useDay;
}
public String getAvaDay() {
	return avaDay;
}
public void setAvaDay(String avaDay) {
	this.avaDay = avaDay;
}
public String getLengthService() {
	return lengthService;
}
public void setLengthService(String lengthService) {
	this.lengthService = lengthService;
}
public String getEnterDate() {
	return enterDate;
}
public void setEnterDate(String enterDate) {
	this.enterDate = enterDate;
}
public String getYearValues() {
	return yearValues;
}
public void setYearValues(String yearValues) {
	this.yearValues = yearValues;
}
public String getStatusValue() {
	return statusValue;
}
public void setStatusValue(String statusValue) {
	this.statusValue = statusValue;
}
public String getCriticalAvaDay() {
	return criticalAvaDay;
}
public void setCriticalAvaDay(String criticalAvaDay) {
	this.criticalAvaDay = criticalAvaDay;
}

}

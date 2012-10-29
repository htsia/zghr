package com.hr319wg.custom.eva.pojo.bo;

public class EvaWageBO {
	
	private String subID;
	private String userID;
	private String status;
	private String unitID;
	private String secDeptID;
	private String secDeptDesc;
	private String deptID;
	private String deptDesc;
	private String name;
	private String personCode;
	private String personType;
	private String evaName;
	private String evaType;
	private String beginDate;
	private String endDate;
	private String result;
	private String resultLevel;
	private String sort;
	private String xishu;
	private String chuqinlv;
	private String evaWage;
	private String evaReduceWage;
	private String evaRealWage;
	private String come;
	private String comeDesc;
	
	public String getEvaRealWage() {
		return evaRealWage;
	}
	public void setEvaRealWage(String evaRealWage) {
		this.evaRealWage = evaRealWage;
	}
	public String getComeDesc() {
		if("1".equals(this.come)){
			return "手动添加";
		}
		return "绩效考核";
	}
	public void setComeDesc(String comeDesc) {
		this.comeDesc = comeDesc;
	}
	public String getCome() {
		return come;
	}
	public void setCome(String come) {
		this.come = come;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSecDeptID() {
		return secDeptID;
	}
	public void setSecDeptID(String secDeptID) {
		this.secDeptID = secDeptID;
	}
	public String getSecDeptDesc() {
		return secDeptDesc;
	}
	public void setSecDeptDesc(String secDeptDesc) {
		this.secDeptDesc = secDeptDesc;
	}
	public String getDeptDesc() {
		return deptDesc;
	}
	public void setDeptDesc(String deptDesc) {
		this.deptDesc = deptDesc;
	}
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
	public String getSubID() {
		return subID;
	}
	public void setSubID(String subID) {
		this.subID = subID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUnitID() {
		return unitID;
	}
	public void setUnitID(String unitID) {
		this.unitID = unitID;
	}
	public String getDeptID() {
		return deptID;
	}
	public void setDeptID(String deptID) {
		this.deptID = deptID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getEvaName() {
		return evaName;
	}
	public void setEvaName(String evaName) {
		this.evaName = evaName;
	}
	public String getEvaType() {
		return evaType;
	}
	public void setEvaType(String evaType) {
		this.evaType = evaType;
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
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getResultLevel() {
		return resultLevel;
	}
	public void setResultLevel(String resultLevel) {
		this.resultLevel = resultLevel;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getXishu() {
		return xishu;
	}
	public void setXishu(String xishu) {
		this.xishu = xishu;
	}
	public String getChuqinlv() {
		return chuqinlv;
	}
	public void setChuqinlv(String chuqinlv) {
		this.chuqinlv = chuqinlv;
	}
	public String getEvaWage() {
		return evaWage;
	}
	public void setEvaWage(String evaWage) {
		this.evaWage = evaWage;
	}
	public String getEvaReduceWage() {
		return evaReduceWage;
	}
	public void setEvaReduceWage(String evaReduceWage) {
		this.evaReduceWage = evaReduceWage;
	}
	
}

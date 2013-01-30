package com.hr319wg.custom.pojo.bo;

public class UserBO {
	private String id;
	private String name;
	private String shortName;
	private String userID;
	private String personSeq;
	private String orgId;
	private String deptId;
	private String secDeptID;
	private String postId;
	private String cardNO;
	private String bankNO;
	private String personType;
	private String ssDeptID;
	private String sDeptID;
	private String deptSort;
	private String selfSort;
	private String comeDate;
	private String xueli;
	private String xuewei;
	private String zhicheng;
	private String zhichengLevel;
	private String zhichengXulie;
	private String mainDeptSort;
	private String a001730="00900";
	private String a001753="00900";
	private String leixing;
	private String hasCashStr;
	private String OAName;
	private boolean hasCash;
	
	public String getSelfSort() {
		return selfSort;
	}
	public void setSelfSort(String selfSort) {
		this.selfSort = selfSort;
	}
	public String getOAName() {
		return OAName;
	}
	public void setOAName(String oAName) {
		OAName = oAName;
	}
	public String getHasCashStr() {
		return hasCashStr;
	}
	public void setHasCashStr(String hasCashStr) {
		this.hasCashStr = hasCashStr;
	}
	public boolean isHasCash() {
		if("1".equals(hasCashStr)){
			return true;
		}
		return false;
	}
	public void setHasCash(boolean hasCash) {
		this.hasCash = hasCash;
	}
	public String getLeixing() {
		return leixing;
	}
	public void setLeixing(String leixing) {
		this.leixing = leixing;
	}
	public String getBankNO() {
		return bankNO;
	}
	public void setBankNO(String bankNO) {
		this.bankNO = bankNO;
	}
	public String getMainDeptSort() {
		return mainDeptSort;
	}
	public void setMainDeptSort(String mainDeptSort) {
		this.mainDeptSort = mainDeptSort;
	}
	public String getA001730() {
		return a001730;
	}
	public void setA001730(String a001730) {
		this.a001730 = a001730;
	}
	public String getA001753() {
		return a001753;
	}
	public void setA001753(String a001753) {
		this.a001753 = a001753;
	}
	private String orgName;
	private String deptName;
	private String secondDeptName;
	private String xueliDesc;
	private String xueweiDesc;
	private String zhichengDesc;
	private String zhichengLevelDesc;
	private String zhichengXulieDesc;
	
	public String getXueli() {
		return xueli;
	}
	public void setXueli(String xueli) {
		this.xueli = xueli;
	}
	public String getXuewei() {
		return xuewei;
	}
	public void setXuewei(String xuewei) {
		this.xuewei = xuewei;
	}
	public String getZhicheng() {
		return zhicheng;
	}
	public void setZhicheng(String zhicheng) {
		this.zhicheng = zhicheng;
	}
	public String getZhichengLevel() {
		return zhichengLevel;
	}
	public void setZhichengLevel(String zhichengLevel) {
		this.zhichengLevel = zhichengLevel;
	}
	public String getZhichengXulie() {
		return zhichengXulie;
	}
	public void setZhichengXulie(String zhichengXulie) {
		this.zhichengXulie = zhichengXulie;
	}
	public String getSecondDeptName() {
		return secondDeptName;
	}
	public void setSecondDeptName(String secondDeptName) {
		this.secondDeptName = secondDeptName;
	}
	public String getXueliDesc() {
		return xueliDesc;
	}
	public void setXueliDesc(String xueliDesc) {
		this.xueliDesc = xueliDesc;
	}
	public String getXueweiDesc() {
		return xueweiDesc;
	}
	public void setXueweiDesc(String xueweiDesc) {
		this.xueweiDesc = xueweiDesc;
	}
	public String getZhichengDesc() {
		return zhichengDesc;
	}
	public void setZhichengDesc(String zhichengDesc) {
		this.zhichengDesc = zhichengDesc;
	}
	public String getZhichengLevelDesc() {
		return zhichengLevelDesc;
	}
	public void setZhichengLevelDesc(String zhichengLevelDesc) {
		this.zhichengLevelDesc = zhichengLevelDesc;
	}
	public String getZhichengXulieDesc() {
		return zhichengXulieDesc;
	}
	public void setZhichengXulieDesc(String zhichengXulieDesc) {
		this.zhichengXulieDesc = zhichengXulieDesc;
	}
	public String getComeDate() {
		return comeDate;
	}
	public void setComeDate(String comeDate) {
		this.comeDate = comeDate;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getDeptSort() {
		return deptSort;
	}
	public void setDeptSort(String deptSort) {
		this.deptSort = deptSort;
	}
	public String getSecDeptID() {
		return secDeptID;
	}
	public void setSecDeptID(String secDeptID) {
		this.secDeptID = secDeptID;
	}
	public String getCardNO() {
		return cardNO;
	}
	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPersonSeq() {
		return personSeq;
	}
	public void setPersonSeq(String personSeq) {
		this.personSeq = personSeq;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getSsDeptID() {
		return ssDeptID;
	}
	public void setSsDeptID(String ssDeptID) {
		this.ssDeptID = ssDeptID;
	}
	public String getsDeptID() {
		return sDeptID;
	}
	public void setsDeptID(String sDeptID) {
		this.sDeptID = sDeptID;
	}

}

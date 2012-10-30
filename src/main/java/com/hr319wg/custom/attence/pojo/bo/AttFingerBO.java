package com.hr319wg.custom.attence.pojo.bo;

public class AttFingerBO {
	
	private String ID;
	private String name;
	private String sex;
	private String personCode;
	private String personTypeName;
	private String deptName;
	private String secDeptName;
	private String finger0;
	private String finger1;
	private String finger2;
	private String finger3;
	private String finger4;
	private String finger5;
	private String finger6;
	private String finger7;
	private String finger8;
	private String finger9;
	private String privilege;
	private String password;
	private String passwordDesc;
	private String fingerCount;
	private String hasFingerDesc;
	private String isManagerDesc;
	
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getSecDeptName() {
		return secDeptName;
	}
	public void setSecDeptName(String secDeptName) {
		this.secDeptName = secDeptName;
	}
	public String getPasswordDesc() {
		if(this.password!=null && !"".equals(this.password)){
			return "有";
		}
		return "无";
	}
	public void setPasswordDesc(String passwordDesc) {
		this.passwordDesc = passwordDesc;
	}
	public String getIsManagerDesc() {
		if("3".equals(this.privilege)){
			return "是";
		}
		return "否";
	}
	public void setIsManagerDesc(String isManagerDesc) {
		this.isManagerDesc = isManagerDesc;
	}
	public String getPrivilege() {
		return privilege;
	}
	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFingerCount() {
		return fingerCount;
	}
	public void setFingerCount(String fingerCount) {
		this.fingerCount = fingerCount;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getHasFingerDesc() {
		if(finger0!=null || finger1!=null || finger2!=null || finger3!=null || finger4!=null || finger5!=null || 
				finger6!=null || finger7!=null || finger8!=null || finger9!=null){
			return "有";
		}
		return "无";
	}
	public void setHasFingerDesc(String hasFingerDesc) {
		this.hasFingerDesc = hasFingerDesc;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPersonCode() {
		return personCode;
	}
	public void setPersonCode(String personCode) {
		this.personCode = personCode;
	}
	public String getPersonTypeName() {
		return personTypeName;
	}
	public void setPersonTypeName(String personTypeName) {
		this.personTypeName = personTypeName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getFinger0() {
		return finger0;
	}
	public void setFinger0(String finger0) {
		this.finger0 = finger0;
	}
	public String getFinger1() {
		return finger1;
	}
	public void setFinger1(String finger1) {
		this.finger1 = finger1;
	}
	public String getFinger2() {
		return finger2;
	}
	public void setFinger2(String finger2) {
		this.finger2 = finger2;
	}
	public String getFinger3() {
		return finger3;
	}
	public void setFinger3(String finger3) {
		this.finger3 = finger3;
	}
	public String getFinger4() {
		return finger4;
	}
	public void setFinger4(String finger4) {
		this.finger4 = finger4;
	}
	public String getFinger5() {
		return finger5;
	}
	public void setFinger5(String finger5) {
		this.finger5 = finger5;
	}
	public String getFinger6() {
		return finger6;
	}
	public void setFinger6(String finger6) {
		this.finger6 = finger6;
	}
	public String getFinger7() {
		return finger7;
	}
	public void setFinger7(String finger7) {
		this.finger7 = finger7;
	}
	public String getFinger8() {
		return finger8;
	}
	public void setFinger8(String finger8) {
		this.finger8 = finger8;
	}
	public String getFinger9() {
		return finger9;
	}
	public void setFinger9(String finger9) {
		this.finger9 = finger9;
	}
	
}

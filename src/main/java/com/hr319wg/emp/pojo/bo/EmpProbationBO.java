package com.hr319wg.emp.pojo.bo;

public class EmpProbationBO
{
  public static String PROBATION = "0";
  public static String PROBATIONADUIT = "1";
  public static String PASS = "2";
  public static String EFFICIRNT = "3";
  public static String HAVENOTPASS = "4";
  public static String JIANXI = "5";
  private String personId;
  private String personName;
  private String planPassDate;
  private String status;
  private String name;
  private String sex;
  private String birthday;
  private String orgName;
  private String deptName;
  private String postName;
  private String postLevel;
  private String personType;
  private String haveDays;
  private String statusDes;
  private String auditResult;
  private String auditDate;
  private String auditOption;
  private String auditOper;
  private boolean edit;
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
  private String canAduit;
  private String unitTime;
  private boolean canAudit;
  private String workResume;
  private String advices;

  public boolean isEdit()
  {
    return this.edit;
  }
  public void setEdit(boolean edit) {
    this.edit = edit;
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

  public boolean isEdit6() {
    return this.edit6;
  }

  public void setEdit6(boolean edit6) {
    this.edit6 = edit6;
  }

  public String getUnitTime()
  {
    return this.unitTime;
  }
  public void setUnitTime(String unitTime) {
    this.unitTime = unitTime;
  }
  public String getCanAduit() {
    return this.canAduit;
  }
  public void setCanAduit(String canAduit) {
    this.canAduit = canAduit;
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
  public String getName() {
    return this.name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getSex() {
    return this.sex;
  }
  public void setSex(String sex) {
    this.sex = sex;
  }
  public String getBirthday() {
    return this.birthday;
  }
  public void setBirthday(String birthday) {
    this.birthday = birthday;
  }
  public String getOrgName() {
    return this.orgName;
  }
  public void setOrgName(String orgName) {
    this.orgName = orgName;
  }
  public String getDeptName() {
    return this.deptName;
  }
  public void setDeptName(String deptName) {
    this.deptName = deptName;
  }
  public String getPersonType() {
    return this.personType;
  }
  public void setPersonType(String personType) {
    this.personType = personType;
  }
  public String getHaveDays() {
    return this.haveDays;
  }
  public void setHaveDays(String haveDays) {
    this.haveDays = haveDays;
  }
  public String getStatusDes() {
    if (PROBATION.equals(this.status))
      this.statusDes = "试用";
    else if (PROBATIONADUIT.equals(this.status))
      this.statusDes = "待审批";
    else if (PASS.equals(this.status))
      this.statusDes = "批准";
    else if (HAVENOTPASS.equals(this.status))
      this.statusDes = "辞退";
    else if (EFFICIRNT.equals(this.status))
      this.statusDes = "生效";
    else if (JIANXI.equals(this.status)) {
    	this.statusDes = "见习";
    }
    return this.statusDes;
  }
  public void setStatusDes(String statusDes) {
    this.statusDes = statusDes;
  }
  public String getPersonId() {
    return this.personId;
  }
  public void setPersonId(String personId) {
    this.personId = personId;
  }
  public String getPlanPassDate() {
    return this.planPassDate;
  }
  public void setPlanPassDate(String planPassDate) {
    this.planPassDate = planPassDate;
  }
  public String getStatus() {
    return this.status;
  }
  public void setStatus(String status) {
    this.status = status;
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
  public String getPostName() {
    return this.postName;
  }
  public void setPostName(String postName) {
    this.postName = postName;
  }

  public String getPostLevel() {
    return this.postLevel;
  }
  public void setPostLevel(String postLevel) {
    this.postLevel = postLevel;
  }

  public boolean isCanAudit() {
    return this.canAudit;
  }

  public void setCanAudit(boolean canAudit) {
    this.canAudit = canAudit;
  }

  public String getWorkResume()
  {
    return this.workResume;
  }
  public void setWorkResume(String workResume) {
    this.workResume = workResume;
  }

  public String getAdvices() {
    return this.advices;
  }
  public void setAdvices(String advices) {
    this.advices = advices;
  }

  public String getPersonName() {
    return this.personName;
  }
  public void setPersonName(String personName) {
    this.personName = personName;
  }
}
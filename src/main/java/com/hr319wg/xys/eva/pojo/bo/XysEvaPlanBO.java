package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-26
 * Time: 下午4:44
 * To change this template use File | Settings | File Templates.
 */
public class XysEvaPlanBO {
    //0起草1指标构建3执行4结果报批5结果审批6结果发布7结束
    public static final String STATUS_QICAO="0";
    public static final String STATUS_ZBGJ="1";
    public static final String STATUS_ZHIXING="2";
    public static final String STATUS_JGBP="3";
    public static final String STATUS_JGSP="4";
    public static final String STATUS_JGFB="5";
    public static final String STATUS_JIESHU="6";

    private String planId;
    private String planName;
    private String beginTime;
    private String endTime;
    private String status;
    private String planType;
    private String planGrade;
    private String scorePers;
    private String year;
    private String deptKpiStatus; //1开始打分2结束打分
    private String personKpiStatus;//1开始打分2结束打分
    private String person360Status;//1开始打分2结束打分
    private String createOrg;

    private String statusDes;
    private String planGradeName;

    public void initRow(){
        this.planId=null;
        this.planName="";
        this.beginTime="";
        this.endTime="";
        this.status="";
        this.planType="";
        this.planGrade="";
        this.scorePers="";
        this.year="";
        this.createOrg="";
    }


	public String getCreateOrg() {
		return createOrg;
	}


	public void setCreateOrg(String createOrg) {
		this.createOrg = createOrg;
	}


	public String getDeptKpiStatus() {
        return deptKpiStatus;
    }

    public void setDeptKpiStatus(String deptKpiStatus) {
        this.deptKpiStatus = deptKpiStatus;
    }

    public String getPersonKpiStatus() {
        return personKpiStatus;
    }

    public void setPersonKpiStatus(String personKpiStatus) {
        this.personKpiStatus = personKpiStatus;
    }

    public String getPerson360Status() {
        return person360Status;
    }

    public void setPerson360Status(String person360Status) {
        this.person360Status = person360Status;
    }

    public String getPlanGradeName() {
        return planGradeName;
    }

    public void setPlanGradeName(String planGradeName) {
        this.planGradeName = planGradeName;
    }

    public String getStatusDes() {
        if(status.equals(STATUS_QICAO)){
             statusDes="起草";
        }else if(status.equals(STATUS_JGBP)){
             statusDes="结果报批";
        }else if(status.equals(STATUS_JGFB)){
             statusDes="结果发布";
        }else if(status.equals(STATUS_JGSP)){
             statusDes="结果审批";
        }else if(status.equals(STATUS_ZBGJ)){
             statusDes="指标构建";
        }else if(status.equals(STATUS_ZHIXING)){
             statusDes="执行";
        }else if(status.equals(STATUS_JIESHU)){
             statusDes="结束";
        }
        return statusDes;
    }

    public void setStatusDes(String statusDes) {
        this.statusDes = statusDes;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPlanType() {
        return planType;
    }

    public void setPlanType(String planType) {
        this.planType = planType;
    }

    public String getPlanGrade() {
        return planGrade;
    }

    public void setPlanGrade(String planGrade) {
        this.planGrade = planGrade;
    }

    public String getScorePers() {
        return scorePers;
    }

    public void setScorePers(String scorePers) {
        this.scorePers = scorePers;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }
}

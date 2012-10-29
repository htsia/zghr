package com.hr319wg.eva.pojo.bo;

public class EvaTaskMasterBO {
	public final static String EVA_TaskMaster_SCRIPT = "0";
    public final static String EVA_TaskMaster_APPROVING = "1";
    public final static String EVA_TaskMaster_APPROVED = "2";
    public final static String EVA_TaskMaster_APPLAYMOD = "3";
    public final static String EVA_TaskMaster_APPROVEDMOD = "4";
    
	private String masterId;
	private String planId;
	private String personId;
	private String score;
	private String status;
	private String statusDes;
	private String personName;
	private String orgName;
	private String deptName;
	private String postId;
	private String postName;
	private String gradeItem;
	private String gradeName;//等级
    private String sortId;//排名
    private String sumScore;//虚拟总分
    private String sumSort;//虚拟排名
    private String sumGrade;//虚拟等级
    private String personNum;
	
	public String getPersonNum() {
		return personNum;
	}
	public void setPersonNum(String personNum) {
		this.personNum = personNum;
	}
	public String getSumGrade() {
		return sumGrade;
	}
	public void setSumGrade(String sumGrade) {
		this.sumGrade = sumGrade;
	}
	public String getSumSort() {
		return sumSort;
	}
	public void setSumSort(String sumSort) {
		this.sumSort = sumSort;
	}
	public String getSumScore() {
		return sumScore;
	}
	public void setSumScore(String sumScore) {
		this.sumScore = sumScore;
	}
	public String getGradeItem() {
		return gradeItem;
	}
	public void setGradeItem(String gradeItem) {
		this.gradeItem = gradeItem;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getSortId() {
		return sortId;
	}
	public void setSortId(String sortId) {
		this.sortId = sortId;
	}
	public String getStatusDes() {
		if(EvaTaskMasterBO.EVA_TaskMaster_SCRIPT.equals(status)){
			statusDes="起草";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPROVING.equals(status)){
			statusDes="报批";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPROVED.equals(status)){
			statusDes="批准";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPLAYMOD.equals(status)){
			statusDes="申请修改";
		}else if(EvaTaskMasterBO.EVA_TaskMaster_APPROVEDMOD.equals(status)){
			statusDes="修改";
		}
		return statusDes;
	}
	public void setStatusDes(String statusDes) {
		this.statusDes = statusDes;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
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
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
}

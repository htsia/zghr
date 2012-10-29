package com.hr319wg.eva.pojo.bo;

public class EvaJobEstimateBO {
	public static final String DRAFT = "0";//起草
	public static final String APPROVAL = "1";//报批
	public static final String APPROVE = "2";//批准
	public static final String APPLICATION_MODIFY = "3";//申请修改
	public static final String MODIFY = "4";//修改
	public static final String APPLYMODCONTENT="5";
	public static final String APPROVEDMODCONTENT="6";
	public static final String INPUTSCORE="7";
	public static final String FINISH="8";
	
	private String itemID;
	private String planID;
	private String personID;
	private String score;
	private String allowModi;
	private String c008001;//责任1
	private String c008005;//工作任务1
	private String c008010;//权重1
	private String c008015;//考核要点1
	private String c008701;//责任2
	private String c008702;//工作任务2
	private String c008703;//权重2
	private String c008704;//考核要点2
	private String c008705;//责任3
	private String c008706;//工作任务3
	private String c008707;//权重3
	private String c008708;//考核要点3
	private String c008709;//责任4
	private String c008710;//工作任务4
	private String c008711;//权重4
	private String c008712;//考核要点4
	private String c008713;//责任5
	private String c008714;//工作任务5
	private String c008715;//权重5
	private String c008716;//考核要点5
	private String c008717;//责任6
	private String c008718;//工作任务6
	private String c008719;//权重6
	private String c008720;//考核要点6
	private String c008721;//责任7
	private String c008722;//工作任务7
	private String c008723;//权重7
	private String c008724;//考核要点7
	private String c008725;//责任8
	private String c008726;//工作任务8
	private String c008727;//权重8
	private String c008728;//考核要点8
	private String c008729;//责任9
	private String c008730;//工作任务9
	private String c008731;//权重9
	private String c008732;//考核要点9
	private String c008733;//责任10
	private String c008734;//工作任务10
	private String c008735;//权重10
	private String c008736;//考核要点10
	private String status;
	private String statusDes;
	private String personName;
	private String gradeItem;
	private String gradeName;//等级
    private String sortId;//排名
    private String sumScore;//虚拟总分
    private String sumSort;//虚拟排名
    private String sumGrade;//虚拟等级
    private String orgName;
    private String deptName;
    private String personNum;
	
	public String getPersonNum() {
		return personNum;
	}
	public void setPersonNum(String personNum) {
		this.personNum = personNum;
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
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getStatusDes(){
		if(DRAFT.equals(status)){
			statusDes="起草";
		}else if(APPROVAL.equals(status)){
			statusDes="职责报批";
		}else if(APPROVE.equals(status)){
			statusDes="职责审批批准";
		}else if(APPLICATION_MODIFY.equals(status)){
			statusDes="申请修改";
		}else if(MODIFY.equals(status)){
			statusDes="修改";
		}else if(APPLYMODCONTENT.equals(status)){
			statusDes="申请修改内容";
		}else if(APPROVEDMODCONTENT.equals(status)){
			statusDes="同意修改内容";
		}else if(INPUTSCORE.equals(status)){
			statusDes="打分";
		}else if(FINISH.equals(status)){
			statusDes="打分结束";
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
	public String getAllowModi() {
		return allowModi;
	}
	public void setAllowModi(String allowModi) {
		this.allowModi = allowModi;
	}
	public String getSeqQZ(String seq) {
		if(seq.equals("1")){
			return c008010;
		}else if(seq.equals("2")){
			return c008703;
		}else if(seq.equals("3")){
			return c008707;
		}else if(seq.equals("4")){
			return c008711;
		}else if(seq.equals("5")){
			return c008715;	
		}else if(seq.equals("6")){
			return c008719;
		}else if(seq.equals("7")){
			return c008723;
		}else if(seq.equals("8")){
			return c008727;
		}else if(seq.equals("9")){
			return c008731;
		}else if(seq.equals("10")){
			return c008735;
		}else{
			return "";
		}
		
	}
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public String getPlanID() {
		return planID;
	}
	public void setPlanID(String planID) {
		this.planID = planID;
	}
	public String getPersonID() {
		return personID;
	}
	public void setPersonID(String personID) {
		this.personID = personID;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getC008001() {
		return c008001;
	}
	public void setC008001(String c008001) {
		this.c008001 = c008001;
	}
	public String getC008005() {
		return c008005;
	}
	public void setC008005(String c008005) {
		this.c008005 = c008005;
	}
	public String getC008010() {
		return c008010;
	}
	public void setC008010(String c008010) {
		this.c008010 = c008010;
	}
	public String getC008015() {
		return c008015;
	}
	public void setC008015(String c008015) {
		this.c008015 = c008015;
	}
	public String getC008701() {
		return c008701;
	}
	public void setC008701(String c008701) {
		this.c008701 = c008701;
	}
	public String getC008702() {
		return c008702;
	}
	public void setC008702(String c008702) {
		this.c008702 = c008702;
	}
	public String getC008703() {
		return c008703;
	}
	public void setC008703(String c008703) {
		this.c008703 = c008703;
	}
	public String getC008704() {
		return c008704;
	}
	public void setC008704(String c008704) {
		this.c008704 = c008704;
	}
	public String getC008705() {
		return c008705;
	}
	public void setC008705(String c008705) {
		this.c008705 = c008705;
	}
	public String getC008706() {
		return c008706;
	}
	public void setC008706(String c008706) {
		this.c008706 = c008706;
	}
	public String getC008707() {
		return c008707;
	}
	public void setC008707(String c008707) {
		this.c008707 = c008707;
	}
	public String getC008708() {
		return c008708;
	}
	public void setC008708(String c008708) {
		this.c008708 = c008708;
	}
	public String getC008709() {
		return c008709;
	}
	public void setC008709(String c008709) {
		this.c008709 = c008709;
	}
	public String getC008710() {
		return c008710;
	}
	public void setC008710(String c008710) {
		this.c008710 = c008710;
	}
	public String getC008711() {
		return c008711;
	}
	public void setC008711(String c008711) {
		this.c008711 = c008711;
	}
	public String getC008712() {
		return c008712;
	}
	public void setC008712(String c008712) {
		this.c008712 = c008712;
	}
	public String getC008713() {
		return c008713;
	}
	public void setC008713(String c008713) {
		this.c008713 = c008713;
	}
	public String getC008714() {
		return c008714;
	}
	public void setC008714(String c008714) {
		this.c008714 = c008714;
	}
	public String getC008715() {
		return c008715;
	}
	public void setC008715(String c008715) {
		this.c008715 = c008715;
	}
	public String getC008716() {
		return c008716;
	}
	public void setC008716(String c008716) {
		this.c008716 = c008716;
	}
	public String getC008717() {
		return c008717;
	}
	public void setC008717(String c008717) {
		this.c008717 = c008717;
	}
	public String getC008718() {
		return c008718;
	}
	public void setC008718(String c008718) {
		this.c008718 = c008718;
	}
	public String getC008719() {
		return c008719;
	}
	public void setC008719(String c008719) {
		this.c008719 = c008719;
	}
	public String getC008720() {
		return c008720;
	}
	public void setC008720(String c008720) {
		this.c008720 = c008720;
	}
	public String getC008721() {
		return c008721;
	}
	public void setC008721(String c008721) {
		this.c008721 = c008721;
	}
	public String getC008722() {
		return c008722;
	}
	public void setC008722(String c008722) {
		this.c008722 = c008722;
	}
	public String getC008723() {
		return c008723;
	}
	public void setC008723(String c008723) {
		this.c008723 = c008723;
	}
	public String getC008724() {
		return c008724;
	}
	public void setC008724(String c008724) {
		this.c008724 = c008724;
	}
	public String getC008725() {
		return c008725;
	}
	public void setC008725(String c008725) {
		this.c008725 = c008725;
	}
	public String getC008726() {
		return c008726;
	}
	public void setC008726(String c008726) {
		this.c008726 = c008726;
	}
	public String getC008727() {
		return c008727;
	}
	public void setC008727(String c008727) {
		this.c008727 = c008727;
	}
	public String getC008728() {
		return c008728;
	}
	public void setC008728(String c008728) {
		this.c008728 = c008728;
	}
	public String getC008729() {
		return c008729;
	}
	public void setC008729(String c008729) {
		this.c008729 = c008729;
	}
	public String getC008730() {
		return c008730;
	}
	public void setC008730(String c008730) {
		this.c008730 = c008730;
	}
	public String getC008731() {
		return c008731;
	}
	public void setC008731(String c008731) {
		this.c008731 = c008731;
	}
	public String getC008732() {
		return c008732;
	}
	public void setC008732(String c008732) {
		this.c008732 = c008732;
	}
	public String getC008733() {
		return c008733;
	}
	public void setC008733(String c008733) {
		this.c008733 = c008733;
	}
	public String getC008734() {
		return c008734;
	}
	public void setC008734(String c008734) {
		this.c008734 = c008734;
	}
	public String getC008735() {
		return c008735;
	}
	public void setC008735(String c008735) {
		this.c008735 = c008735;
	}
	public String getC008736() {
		return c008736;
	}
	public void setC008736(String c008736) {
		this.c008736 = c008736;
	}

}

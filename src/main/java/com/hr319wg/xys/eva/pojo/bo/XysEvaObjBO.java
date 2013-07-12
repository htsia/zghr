package com.hr319wg.xys.eva.pojo.bo;

public class XysEvaObjBO  implements Comparable<XysEvaObjBO>{
	private String objId;
	private String planId;
	private String personId;
	private String scoreKpi;
	private String score360;
	private String scoreXspj;
	private String totalScore;
	
	private String scoreDeptAvg;
	private String scoreDeptKpi;
	private String scoreDeptKpiRecover;
	private String adjustTotalScore;
	
	
	private String natureSort;
	private String natureGrade;
	private String forceSort;
	private String forceGrade;
	
	private String personName;
	private String deptName;
	private String postName;
	
	
	public String getNatureSort() {
		return natureSort;
	}
	public void setNatureSort(String natureSort) {
		this.natureSort = natureSort;
	}
	public String getNatureGrade() {
		return natureGrade;
	}
	public void setNatureGrade(String natureGrade) {
		this.natureGrade = natureGrade;
	}
	public String getForceSort() {
		return forceSort;
	}
	public void setForceSort(String forceSort) {
		this.forceSort = forceSort;
	}
	public String getForceGrade() {
		return forceGrade;
	}
	public void setForceGrade(String forceGrade) {
		this.forceGrade = forceGrade;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
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
	public String getScoreKpi() {
		return scoreKpi;
	}
	public void setScoreKpi(String scoreKpi) {
		this.scoreKpi = scoreKpi;
	}
	public String getScore360() {
		return score360;
	}
	public void setScore360(String score360) {
		this.score360 = score360;
	}
	public String getScoreXspj() {
		return scoreXspj;
	}
	public void setScoreXspj(String scoreXspj) {
		this.scoreXspj = scoreXspj;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getScoreDeptAvg() {
		return scoreDeptAvg;
	}
	public void setScoreDeptAvg(String scoreDeptAvg) {
		this.scoreDeptAvg = scoreDeptAvg;
	}
	public String getScoreDeptKpi() {
		return scoreDeptKpi;
	}
	public void setScoreDeptKpi(String scoreDeptKpi) {
		this.scoreDeptKpi = scoreDeptKpi;
	}
	public String getScoreDeptKpiRecover() {
		return scoreDeptKpiRecover;
	}
	public void setScoreDeptKpiRecover(String scoreDeptKpiRecover) {
		this.scoreDeptKpiRecover = scoreDeptKpiRecover;
	}
	public String getAdjustTotalScore() {
		return adjustTotalScore;
	}
	public void setAdjustTotalScore(String adjustTotalScore) {
		this.adjustTotalScore = adjustTotalScore;
	}
	@Override
	public String toString() {
		return "XysEvaObjBO [personName=" + personName + ", adjustTotalScore="
				+ adjustTotalScore + "]";
	}
	@Override
	public int compareTo(XysEvaObjBO o) {
		if(o == null) return 0;
		return (o.getDeptName()+o.getAdjustTotalScore())
				.compareTo(this.deptName+this.adjustTotalScore);
	}
	
	
}

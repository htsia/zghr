package com.hr319wg.eva.pojo.bo;

public class EvaSelectionResultSetBO {
	private String setId;
	private String setName;
	private String gradeItems;
	private String isCacl;
	private String isSel;
	private String planId;
	private String gradeItemsDes;
	private String caclDes;
	private String selDes;
	
	public String getCaclDes() {
		if(isCacl.equals("1")){
			caclDes="ÊÇ";
		}else if(isCacl.equals("0")){
			caclDes="·ñ";
		}
		return caclDes;
	}
	public void setCaclDes(String caclDes) {
		this.caclDes = caclDes;
	}
	public String getSelDes() {
		if(isSel.equals("1")){
			selDes="ÊÇ";
		}else if(isSel.equals("0")){
			selDes="·ñ";
		}
		return selDes;
	}
	public void setSelDes(String selDes) {
		this.selDes = selDes;
	}
	public String getGradeItemsDes() {
		return gradeItemsDes;
	}
	public void setGradeItemsDes(String gradeItemsDes) {
		this.gradeItemsDes = gradeItemsDes;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getSetId() {
		return setId;
	}
	public void setSetId(String setId) {
		this.setId = setId;
	}
	public String getSetName() {
		return setName;
	}
	public void setSetName(String setName) {
		this.setName = setName;
	}
	public String getGradeItems() {
		return gradeItems;
	}
	public void setGradeItems(String gradeItems) {
		this.gradeItems = gradeItems;
	}
	public String getIsCacl() {
		return isCacl;
	}
	public void setIsCacl(String isCacl) {
		this.isCacl = isCacl;
	}
	public String getIsSel() {
		return isSel;
	}
	public void setIsSel(String isSel) {
		this.isSel = isSel;
	}
}

package com.hr319wg.eva.pojo.bo;

public class EvaMasterBO {
    private String masterID;
    private String objectID;
    private String personID;
    private String personName;
    private String deptName;
    private String purview;
    private String score;
    private String masterType;
    private String gradeId;
    private String isMark;
    private String isCacl;

    public String getIsCacl() {
        return isCacl;
    }

    public void setIsCacl(String cacl) {
        isCacl = cacl;
    }

    public String getIsMark() {
		return isMark;
	}
	public void setIsMark(String isMark) {
		this.isMark = isMark;
	}
	public String getGradeId() {
		return gradeId;
	}
	public void setGradeId(String gradeId) {
		this.gradeId = gradeId;
	}
	public String getScore() {

        return score;
    }
    public void setScore(String score) {
        this.score = score;
    }

    public void initPara(){
        masterID=null;
        objectID="";
        personID="";
        personName="";
        deptName="";
        purview="";
    }

    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getPersonName() {
        return personName;
    }
    public void setPersonName(String personName) {
        this.personName = personName;
    }
    
    public String getMasterID() {
        return masterID;
    }
    public void setMasterID(String masterID) {
        this.masterID = masterID;
    }

    public String getPurview() {
        return purview;
    }
    public void setPurview(String pruview) {
        this.purview = pruview;
    }

    public String getObjectID() {
        return objectID;
    }
    public void setObjectID(String objectID) {
        this.objectID = objectID;
    }


    public String getPersonID() {
        return personID;
    }
    public void setPersonID(String personID) {
        this.personID = personID;
    }
	public String getMasterType() {
		return masterType;
	}
	public void setMasterType(String masterType) {
		this.masterType = masterType;
	}
    

}

package com.hr319wg.eva.pojo.vo;

public class EvaObjectsVO {
    private String objectID;
    private String planID;
    private String personID;
    private String templateID;
    private String templatename;
    private String score;
    private String gradeItemId;
    private String sortId;
    //--------------A001--------------
    private String personName; // A001001
    private String orgid; // A001701
    private String deptid; // A001705
    private String depttree; // A001738
    private String isSetMaster;//是否设置主体 
    private String shortName;
    private String orgName;
    private String deptName;
    private String teamName;
    private String masterId;
    private String gradeName;
    
    public String getSortId() {
		return sortId;
	}
	public void setSortId(String sortId) {
		this.sortId = sortId;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
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
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getGradeItemId() {
		return gradeItemId;
	}
	public void setGradeItemId(String gradeItemId) {
		this.gradeItemId = gradeItemId;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getIsSetMaster() {
		return isSetMaster;
	}
	public void setIsSetMaster(String isSetMaster) {
		this.isSetMaster = isSetMaster;
	}

    public String getTemplatename() {
        return templatename;
    }
    public void setTemplatename(String templatename) {
        this.templatename = templatename;
    }

    public String getDepttree() {
        return depttree;
    }
    public void setDepttree(String depttree) {
        this.depttree = depttree;
    }

    public String getOrgid() {
        return orgid;
    }
    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getDeptid() {
        return deptid;
    }
    public void setDeptid(String deptid) {
        this.deptid = deptid;
    }


    public String getPersonName() {
        return personName;
    }
    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getTemplateID() {
        return templateID;
    }
    public void setTemplateID(String templateID) {
        this.templateID = templateID;
    }

    public String getObjectID() {
        return objectID;
    }
    public void setObjectID(String objectID) {
        this.objectID = objectID;
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

}

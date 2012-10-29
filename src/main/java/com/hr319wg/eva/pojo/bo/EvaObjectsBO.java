package com.hr319wg.eva.pojo.bo;

public class EvaObjectsBO {
    private String objectID;
    private String planID;
    private String personID;
    private String templateID;
    private String score;
    private String summaryFile;
    private String summaryText;
    private String gradeItem;
    private String orgName;
    private String deptName;
    private String masterId;
    private String templateName;
    private String teamName;
    private String teamCreateDate;
    private String personName;
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
	public String getSummaryText() {
		return summaryText;
	}
	public void setSummaryText(String summaryText) {
		this.summaryText = summaryText;
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
	public String getSortId() {
		return sortId;
	}
	public void setSortId(String sortId) {
		this.sortId = sortId;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getTeamCreateDate() {
		return teamCreateDate;
	}
	public void setTeamCreateDate(String teamCreateDate) {
		this.teamCreateDate = teamCreateDate;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
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
	public String getSummaryFile() {
		return summaryFile;
	}
	public void setSummaryFile(String summaryFile) {
		this.summaryFile = summaryFile;
	}
	public String getScore() {
        return score;
    }
    public void setScore(String score) {
        this.score = score;
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
	public EvaObjectsBO(String objectID, String personID) {
		super();
		this.objectID = objectID;
		this.personID = personID;
	}
	public EvaObjectsBO() {
		super();
		
	}

}
